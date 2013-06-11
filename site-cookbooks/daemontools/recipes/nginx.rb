#
# Cookbook Name:: daemontools
# Recipe:: default
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#
['/service/nginx', '/usr/local/nginx'].each do |d|
  directory d do
    action :create
    owner 'root'
    group 'root'
    only_if { !File.exists?(d) }
  end
end

template '/usr/local/nginx/run' do
  source 'nginx.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

# Uncomment below for running svscan
execute 'ln_nginx_run' do
  command 'ln -s /usr/local/nginx/run /service/nginx/run'
  only_if { !File.exists?('/service/nginx/run') }
end

