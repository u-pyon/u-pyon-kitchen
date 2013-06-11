#
# Cookbook Name:: daemontools
# Recipe:: default
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#
['/service/mysql', '/usr/local/mysql'].each do |d|
  directory d do
    action :create
    owner 'root'
    group 'root'
    only_if { !File.exists?(d) }
  end
end

template '/usr/local/mysql/run' do
  source 'mysql.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

# Uncomment below for running svscan
execute 'ln_mysql_run' do
  command 'ln -s /usr/local/mysql/run /service/mysql/run'
  only_if { !File.exists?('/service/mysql/run') }
end

