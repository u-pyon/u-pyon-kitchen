#
# Cookbook Name:: phpfastcgi
# Recipe:: default
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#
%w(php-cgi spawn-fcgi).each do |pkg|
  package pkg do
    action :install
  end
end

template '/etc/init.d/php-fastcgi' do
  source 'php-fastcgi.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

service 'php-fastcgi' do
  supports status: true, restart: true, start: true, stop: true
  action [ :enable, :restart ]
end
