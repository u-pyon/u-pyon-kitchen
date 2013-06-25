#
# Cookbook Name:: logrotate
# Recipe:: default
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#
cookbook_file '/etc/logrotate.d/nginx' do
  owner 'root'
  group 'root'
  source 'nginx'
  mode 0755
  backup false
  action :create
end

directory '/var/log/nginx' do
  action :create
  owner 'root'
  group 'root'
  only_if { !File.exist?('/var/log/nginx') }
end
