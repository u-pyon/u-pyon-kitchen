#
# Cookbook Name:: mysql
# Recipe:: server
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#
%w(mysql mysql-server mysql-devel).each do |pkg|
  package pkg do
    action :install
  end
end

execute 'mysql-install-db' do
  command 'mysql_install_db'
  action :run
  not_if { File.exists?('/var/lib/mysql/mysql/user.frm') }
end

execute 'mysql_chown' do
  command "chown -Rf #{node[:mysql][:mysqld][:user]}:#{node[:mysql][:mysqld][:user]} #{node[:mysql][:mysqld][:basedir]}"
  only_if { File.exists?(node[:mysql][:mysqld][:basedir]) }
end


template File.join(node[:mysql][:ini_dir], 'my.cnf') do
  source 'my.cnf.erb'
  owner node[:mysql][:mysqld][:user]
  group node[:mysql][:mysqld][:user]
end

[
  node[:mysql][:mysqld][:innodb_log_group_home_dir],
  node[:mysql][:mysqld][:innodb_data_home_dir]
].each do |dir|
  directory dir do
    action :create
    owner node[:mysql][:mysqld][:user]
    group node[:mysql][:mysqld][:user]
    only_if { !File.exists?(dir) }
  end
end

[
  node[:mysql][:mysqld][:pid_file],
  node[:mysql][:mysqld_safe][:pid_file]
].each do |d|
  directory File.dirname(d) do
    action :create
    owner node[:mysql][:mysqld][:user]
    group node[:mysql][:mysqld][:user]
    only_if { !File.exists?(d) }
  end
end

service "mysql" do
  supports status: true, restart: true, reload: true
  action [ :enable, :start ]
end
