#
# Cookbook Name:: daemontools
# Recipe:: default
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#
package 'patch' do
  action :install
end

directory '/usr/local/src' do
  action :create
  owner 'root'
  group 'root'
  only_if { !File.exists?('/usr/local/src') }
end

execute 'install_daemontools' do
  command <<-EOH
    cd /usr/local/src
    wget http://cr.yp.to/daemontools/daemontools-0.76.tar.gz
    tar zxf daemontools-0.76.tar.gz
    cd admin/daemontools-0.76/
    wget http://qmail.org/moni.csi.hu/pub/glibc-2.3.1/daemontools-0.76.errno.patch
    patch -s -p1 < ./daemontools-0.76.errno.patch
    ./package/compile
    ./package/install
  EOH
  only_if { !File.exists?('/usr/local/src/daemontools-0.76.tar.gz') }
end

directory '/service' do
  action :create
  owner 'root'
  group 'root'
  only_if { !File.exists?('/service') }
end

template '/etc/init/svscan.conf' do
  source 'svscan.conf.erb'
  owner 'root'
  group 'root'
end

#include_recipe 'daemontools::mysql'
#include_recipe 'daemontools::nginx'
#include_recipe 'daemontools::php-fastcgi'


execute 'start-svscan' do
  command <<-EOH
    initctl reload-configuration
  EOH
end
