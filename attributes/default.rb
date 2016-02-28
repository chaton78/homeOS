default['domain'] = 'duckdns.org'
default['hostname_cookbook']['use_node_ip']=true
default['set_fqdn'] = '*.' +  node['domain']

default['letsencrypt']['contact']     = []
default['letsencrypt']['endpoint']    = 'https://acme-staging.api.letsencrypt.org'
default['letsencrypt']['renew']       = 30

default['influxdb']['ssl_cert_file_path'] = '/etc/keys/cyulduck.crt'
default['grafana']['version'] = 'latest'
default['erlang']['install_method']   = 'esl'


default['rabbitmq']['use_distro_version']=false

default['rabbitmq']['ssl'] = true
default['rabbitmq']['ssl_cacert']= '/etc/keys/ca.crt'
default['rabbitmq']['ssl_cert']= '/etc/keys/server.crt'
default['rabbitmq']['ssl_key']= '/etc/keys/server.key'
default['rabbitmq']['ssl_verify'] = 'verify_none'
default['rabbitmq']['ssl_fail_if_no_peer_cert'] = false
default['rabbitmq']['default_user'] = 'controller'
default['rabbitmq']['default_pass'] = '12qwaszx'
default['rabbitmq']['loopback_users'] = []
default['rabbitmq']['enabled_plugins'] = ["rabbitmq_mqtt"]
default['firewall']['allow_ssh'] = true
default['firewall']['firewalld']['permanent'] = true
default['rabbitmq']['conf'] = {'rabbitmq_mqtt' => '[{ssl_listeners,    [8883]},{tcp_listeners,    [1883]}]'}
default['fail2ban']['services'] = {
  'ssh' => {
    'enabled' => 'true',
    'port' => 'ssh',
    'filter' => 'sshd',
    'findtime' => '600',
    'bantime' => '3600',
    'logpath' => node['fail2ban']['auth_log'],
    'maxretry' => '5'
  }
}
                  
default['influxdb']['config'] = {
  'reporting-disabled' => false,
  'meta' => {
    'enabled' => true,
    'dir' => node['influxdb']['meta_file_path'],
    'bind-address' => ':8088',
    'retention-autocreate' => true,
    'election-timeout' => '1s',
    'heartbeat-timeout' => '1s',
    'leader-lease-timeout' => '500ms',
    'commit-timeout' => '50ms',
    'cluster-tracing' => false
  },
  'data' => {
    'enabled' => true,
    'dir' => node['influxdb']['data_file_path'],
    'engine' => 'tsm1',
    # applies only to 0.9.2
    'max-wal-size' => 104_857_600,
    'wal-flush-interval' => '10m0s',
    'wal-partition-flush-delay' => '2s',
    # applies only to >= 0.9.3
    'wal-dir' => node['influxdb']['wal_file_path'],
    'wal-enable-logging' => true,
    'data-logging-enabled' => true
  },
  'hinted-handoff' => {
    'enabled' => true,
    'dir' => node['influxdb']['hinted-handoff_file_path'],
    'max-size' => 1_073_741_824,
    'max-age' => '168h0m0s',
    'retry-rate-limit' => 0,
    'retry-interval' => '1s',
    'retry-max-interval' => '1m0s',
    'purge-interval' => '1h0m0s'
  },
  'cluster' => {
    'write-timeout' => '10s',
    'shard-writer-timeout' => '5s'
  },
  'retention' => {
    'enabled' => true,
    'check-interval' => '30m0s'
  },
  'shard-precreation' => {
    'enabled' => true,
    'check-interval' => '10m0s',
    'advance-period' => '30m0s'
  },
  'monitor' => {
    'store-enabled' => true,
    'store-database' => '_internal',
    'store-interval' => '10s'
  },
  'admin' => {
    'enabled' => true,
    'bind-address' => ':8083',
    'https-enabled' => true,
    'https-certificate' => node['influxdb']['ssl_cert_file_path']
  },
  'http' => {
    'enabled' => true,
    'bind-address' => ':8086',
    'auth-enabled' => false,
    'log-enabled' => true,
    'write-tracing' => false,
    'pprof-enabled' => false,
    'https-enabled' => true,
    'https-certificate' => node['influxdb']['ssl_cert_file_path']
  },
  'graphite' => [
    {
      'enabled' => false
    }
  ],
  'collectd' => {
    'enabled' => true
  },
  'opentsdb' => {
    'enabled' => false
  },
  'udp' => [
    {
      'enabled' => false
    }
  ],
  'continuous_queries' => {
    'log-enabled' => true,
    'enabled' => true,
    'run-interval' => '1s'
  },
  'subscriber' => {
    'enabled' => true
  }
}
