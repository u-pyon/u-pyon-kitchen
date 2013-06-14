#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#
%w(php php-mysql php-mysqli php-mbstring php-pear php-gd php-cgi php-devel php-pecl-memcache php-xml php-imap php-pecl-apc php-pecl-apc-devel).each do |pkg|
  yum_package pkg do
    action :install
  end
end

template '/etc/php.ini' do
  action :create
end

