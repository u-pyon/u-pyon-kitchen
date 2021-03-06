#
# Cookbook Name:: vim
# Recipe:: default
#
# Copyright 2013, Yuichi Oikawa
#
# All rights reserved - Do Not Redistribute
#
require 'fileutils'

def plugin_install_dir(plugin)
  File.join(node[:vim][:dir], ".vim", node[:vim][plugin.to_sym][:dir])
end

def plugin_path(plugin)
  File.join(node[:vim][:dir], ".vim", node[:vim][plugin.to_sym][:dir], plugin + '.vim')
end

%w(neobundle pathogen).each do |plugin|
  install_dir = plugin_install_dir(plugin)
  directory install_dir do
    action :create
    owner node[:vim][:user]
    group node[:vim][:user]
    only_if { !File.exists?(install_dir) }
  end
  path = plugin_path(plugin)
  unless File.exists?(path)
    execute "Install " + plugin + ".vim" do
      cwd install_dir
      command "git clone #{node[:vim][plugin.to_sym][:repository]}"
      notifies :run, 'ruby_block[move_pathogen.vim]', :immediately \
        if plugin == 'pathogen'
    end
  end
end

ruby_block "move_pathogen.vim" do
  block do
    install_dir = File.join(node[:vim][:dir], ".vim", node[:vim][:pathogen][:dir])
    path = File.join(node[:vim][:dir], ".vim", node[:vim][:pathogen][:dir], 'pathogen.vim')

    cloned_dir = File.join(install_dir, 'vim-pathogen')
    raise "Couldn't load pathogen" \
      unless File.directory?(cloned_dir)
    vim_file = File.join(cloned_dir, 'autoload', 'pathogen.vim')
    FileUtils.cp(File.join(cloned_dir, 'autoload', 'pathogen.vim'), path) \
      unless File.exists? File.join(install_dir, 'pathogen.vim')
    dirlist = Dir::glob(cloned_dir + "/**/", File::FNM_DOTMATCH).sort {
        |a,b| b.split('/').size <=> a.split('/').size
    }
    dirlist.each {|d|
      Dir::foreach(d) {|f|
        File::delete(d+f) unless File.directory?(f)
      }
      Dir::rmdir(d)
    }
  end
  action :nothing
end

