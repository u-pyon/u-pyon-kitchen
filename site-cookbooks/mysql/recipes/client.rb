#
# Cookbook Name:: mysql
# Recipe:: client
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#
%w(mysql mysql-client mysql-devel).each do |pkg|
  package pkg do
    action :install
  end
end
