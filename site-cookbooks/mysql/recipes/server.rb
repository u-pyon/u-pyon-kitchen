#
# Cookbook Name:: mysql
# Recipe:: server
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#
mods = %w(server client devel shared_compat)

directory '/usr/local/src' do
  action :create
  owner 'root'
  group 'root'
  only_if { !File.exists?('/usr/local/src') }
end

src = '/usr/local/src/mysql'
directory src do
  action :create
  owner 'root'
  group 'root'
  only_if { !File.exists?('/usr/local/src/mysql') }
end

mods.each do |mod|
  k = 'rpm_' + mod + '_name'
  f = File.join(src, node[:mysql][k.to_sym])
  cookbook_file f do
    source node[:mysql][k.to_sym]
    mode 0755
    owner 'root'
    group 'root'
    path f
  end
end


execute 'mysql-install' do
  cwd src
  %w(client devel server).each do |mod|
    k = 'rpm_' + mod + '_name'
    command <<-EOH
      yum -y install #{node[:mysql][k.to_sym]}
    EOH
  end
  only_if { !File.exists?(File.join('/usr/local/src/mysql', node[:mysql][:rpm_server_name])) }
  notifies :run, 'execute[mysql-shared-install]'
end

execute 'mysql-shared-install' do
  command <<-EOH
    cd /usr/local/mysql
    yum install #{node[:mysql][:rpm_shared_compat_name]}
  EOH
  only_if { !File.exists?(File.join('/usr/local/src/mysql', node[:mysql][:rpm_shared_compat_name])) }
  action :nothing
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

service "mysqld" do
  supports status: true, restart: true, reload: true
  action [ :enable ]
end

mods.each do |mod|
  k = 'rpm_' + mod + '_name'
  rpm = File.join(src, node[:mysql][k.to_sym])
  file rpm do
    action :delete
    only_if { File.exists?(rpm) }
  end
end
