#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, SRE Inc.
#
# All rights reserved - Yuichi Oikawa
#
%w{zsh git wget make gcc}.each do |pkg|
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

data_bag('admins').each do |login|
  u = data_bag_item('admins', login)

=begin
  # Adding role, add system key with an array has roles to data_bag.
  act = false

  for role in node['roles']
    for system in u['system']
      if role == system
        act = true
        break
      end
    end
    break if act
  end

  next unless act
=end

  user_act = u['active'] ? 'create' : 'remove'
  home_dir = '/home/' + u['name']

  user u['name'] do
    uid u['uid'] if u.key?('uid')
    shell u.key?('shell') ? u['shell'] : '/bin/base'
    home home_dir
    action user_act
  end

  next unless u['active']

  ssh_dir = File.join(home_dir, '.ssh')
  directory ssh_dir do
    action :create
    owner u['name']
    group u['name']
    mode 0700
    only_if { !File.exist?(ssh_dir) }
  end

  if u['key']
    authorized_keys = File.join(ssh_dir, 'authorized_keys')
    file authorized_keys do
      action :create
      owner u['name']
      mode 0700
      content u['key'] + ' ' + u['name']
    end
  end
end
