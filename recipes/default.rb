#
# Cookbook Name:: homeOS
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "fail2ban"
include_recipe "influxdb"
include_recipe "grafana"
include_recipe "letsencrypt"
include_recipe "rabbitmq"
include_recipe "firewall"


letsencrypt_selfsigned 'cyul.duckdns.org' do
  crt     '/etc/keys/cyulduck.crt'
  key     '/etc/keys/cyulduck.key'
end

rabbitmq_plugin "rabbitmq_mqtt" do
  action :enable
end

firewall_rule 'allow rabbitmq ssh' do
  port ['rabbitmq']['ssl_port']
  source '0.0.0.0/0'
  only_if { node['rabbitmq']['ssl'] }
end

