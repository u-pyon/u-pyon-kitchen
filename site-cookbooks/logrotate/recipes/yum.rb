#
# Cookbook Name:: logrotate
# Recipe:: default
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#
#
cookbook_file '/etc/logrotate.d/yum' do
  owner 'root'
  group 'root'
  source 'yum'
  mode 0755
  backup false
  action :create
end
