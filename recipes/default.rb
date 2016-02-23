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

letsencrypt_selfsigned 'cyul.duckdns.org' do
  crt     '/etc/ssl/cyulduck.crt'
  key     '/etc/ssl/cyulduck.key'
end

rabbitmq_plugin "rabbitmq_mqtt" do
  action :enable
end