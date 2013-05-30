#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, SRE Inc. 
#
# All rights reserved - Yuichi Oikawa 
#
%w{zsh}.each do |pkg|
  package pkg do
    action :install
  end
end

rcfile = File.join(node[:zsh][:dir], ".zshrc")
template rcfile do
  source "zshrc.erb"
end
file rcfile do
  owner node[:zsh][:user]
end
