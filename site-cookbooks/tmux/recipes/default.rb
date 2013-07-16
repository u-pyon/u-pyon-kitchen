#
# Cookbook Name:: tmux
# Recipe:: default
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#

# Warning: locked timeout error occrus, if wget, make and gcc wasn't installed before installing mercurial and ncurses-devel.
# I solved this problem that changing 'base' recipe installing wget, make and gcc.
%w{wget make gcc mercurial ncurses-devel}.each do |pkg|
  package pkg do
    action :install
  end
end
=begin
package 'wget' do
  action :install
  notifies :run, 'package[make]', :immediately
end
package 'make' do
  action :install
  notifies :run, 'package[gcc]', :immediately
end
package 'gcc' do
  action :install
  notifies :run, 'package[mercurial]', :immediately
end
package 'mercurial' do
  action :install
  notifies :run, 'package[ncurses-devel]', :immediately
end
package 'ncurses-devel' do
  action :install
  notifies :run, 'package[ncurses-devel]', :immediately
end
=end


src = '/tmp'
conf = "#{node[:tmux][:dir]}/.tmux.conf"

execute "wget-tmux" do
  cwd src
  command <<-EOH
    wget #{node[:tmux][:repository]}
  EOH
  notifies :run, 'execute[install-tmux]', :immediately
  action :nothing
end

execute "install-tmux" do
  cwd src
  command "yum -y install ./#{node[:tmux][:rpm]}"
  if File.exists?(conf)
    ignore_failure true
  end
  action :nothing
end

template conf do
  owner node[:tmux][:user]
  group node[:tmux][:user]
  notifies :run, 'execute[wget-tmux]', :immediately
  notifies :run, 'execute[install-tmux]', :immediately
  source "tmux.conf.erb"
end

file conf do
  owner node[:tmux][:user]
end


base_dir = node[:tmux][:base_dir]
plconf = File.join(node[:tmux][:dir], '.tmux-powerlinerc')
tmux_dir = File.join(node[:tmux][:dir], '.tmux')
mytheme = File.join(base_dir, node[:tmux][:powerline][:name], 'themes/mythme.sh')
execute "install-powerline" do
  cwd tmux_dir
  command <<-EOH
    git clone #{node[:tmux][:powerline][:repository]}
  EOH
  action :nothing
end

directory base_dir do
  action :create
  owner node[:tmux][:user]
  only_if { !File.exists?(base_dir) }
end

template plconf do
  notifies :run, 'execute[install-powerline]', :immediately
  source "tmux-powerlinerc.erb"
end
file plconf do
  owner node[:tmux][:user]
end

template mytheme do
  source 'mytheme.sh.erb'
end
file mytheme do
  owner node[:tmux][:user]
end


