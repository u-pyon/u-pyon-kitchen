#
# Cookbook Name:: vim
# Recipe:: default
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#
package "vim" do
  action :install
end

rcfile = File.join(node[:vim][:dir], ".vimrc")
template rcfile do
  source "vimrc.erb"
end

file rcfile do
  owner node[:vim][:user]
end

