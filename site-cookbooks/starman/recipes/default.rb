#
# Cookbook Name:: starman
# Recipe:: default
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#
execute 'install-starman' do
  command <<-EOH
    cpanm Plack
    cpanm Task::Plack
    cpanm XMLRPC::Transport::HTTP::Plack
    cpanm CGI::Parse::PSGI
    cpanm CGI::PSGI
  EOH
end

directory '/var/log/starman' do
  action :create
  owner node[:starman][:user]
  group node[:starman][:group]
  mode 0755
  only_if { !File.exists?('/var/log/starman') }
end

