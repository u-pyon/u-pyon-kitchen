#
# Cookbook Name:: logrotate
# Recipe:: default
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'logrotate::nginx'
include_recipe 'logrotate::httpd'
include_recipe 'logrotate::yum'
