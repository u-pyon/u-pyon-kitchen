#
# Cookbook Name:: cpanm
# Recipe:: default
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
package 'curl' do
  action :install
  notifies :run, 'package[perl-ExtUtils-MakeMaker]', :immediately
end

package 'perl-ExtUtils-MakeMaker' do
  action :install
  notifies :run, 'execute[install-cpanm]', :immediately
end

execute 'install-cpanm' do
  command 'curl -L http://cpanmin.us | perl - --sudo App::cpanminus'
  only_if { !File.exists?('/usr/local/bin/cpanm') }
end
