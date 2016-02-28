include_recipe "fail2ban"
include_recipe "influxdb"
include_recipe "grafana"
include_recipe "letsencrypt"
include_recipe "firewall"
include_recipe "selinux_policy"
include_recipe "collectd"
include_recipe "hostnames"

selinux_policy_boolean 'httpd_can_network_connect' do
    value true
    # Make sure nginx is started if this value was modified
    notifies :start,'service[nginx]', :immediate
end

selinux_policy_port 8883 do
action :addormodify
    protocol 'tcp'
    secontext 'rabbitmq_port_t'
end

selinux_policy_port 1883 do
action :addormodify
    protocol 'tcp'
    secontext 'rabbitmq_port_t'
end

selinux_policy_boolean 'httpd_can_network_connect' do
    value true
    # Make sure nginx is started if this value was modified
    notifies :start,'service[nginx]', :immediate
end

firewall 'default' do
    action :flush
end

firewall_rule 'allow rabbitmq ssl' do
  port 8883
  source '0.0.0.0/0'
end

firewall_rule 'allow nginx http' do
  port 80
  source '0.0.0.0/0'
end

firewall_rule 'allow nginx https' do
  port 443
  source '0.0.0.0/0'
end





firewall 'default' do
  action    :save
end
letsencrypt_selfsigned node['name']+'.'+node['domain'] do
  crt     '/etc/keys/'+node['name']+'.crt'
  key     '/etc/keys/'+node['name']+'.key'
end

influxdb_database 'controller_db' do
  action :create
end

influxdb_user 'controller' do
  password '12qwaszx'
  databases ['controller_db','collectd']
  action :create
end

influxdb_admin 'admin' do
  password '12qwaszx'
  action :create
end

grafana_datasource 'controller_db' do
  source(
    type: 'influxdb_09',
    url: 'http://localhost:8086',
    access: 'proxy',
    database: 'controller_db',
    user: 'controller',
    password: '12qwaszx',
    isdefault: true
  )


  action :create_if_missing
end

  grafana_datasource 'collectd_db' do
  source(
    type: 'influxdb_09',
    url: 'http://localhost:8086',
    access: 'proxy',
    database: 'collectd',
    user: 'controller',
    password: '12qwaszx',
    isdefault: true
  )
    action :create_if_missing
end



grafana_organization 'homeOS' do
  user 'pascal'
  passwd '12qwaszx'
  action :create_if_missing
end

http_request 'GET https://www.duckdns.org/update' do
  message ''
  url 'https://www.duckdns.org/update?domains=' + node['name'] + '&token='+node['duckdns_token']+'&ip='
  action :get
end