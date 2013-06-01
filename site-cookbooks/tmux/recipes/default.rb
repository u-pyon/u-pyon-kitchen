#
# Cookbook Name:: tmux
# Recipe:: default
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#
%w{mercurial ncurses-devel make gcc wget}.each do |pkg|
  package pkg do
    action :install
  end
end

src = '/tmp'
conf = "/root/.tmux.conf"

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
  command <<-EOH
    yum -y install ./#{node[:tmux][:rpm]}
  EOH
  if File.exists?('/root/.tmux.conf')
    ignore_failure true
  end
  action :nothing
end

template conf do
 notifies :run, 'execute[wget-tmux]', :immediately
 notifies :run, 'execute[install-tmux]', :immediately
 source "tmux.conf.erb"
end

file conf do
  owner node[:tmux][:user]
end


base_dir = node[:tmux][:base_dir]
plconf = '/root/.tmux-powerlinerc'
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


