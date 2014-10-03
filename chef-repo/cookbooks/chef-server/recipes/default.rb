#
# Cookbook Name:: bc_chef-server
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


# set host name
ENV['chef_host'] = "#{node[:chef_hostname]}"

bash "set_hostname" do
  user "root"
  code <<-EOH
    iptables --flush
    echo ${chef_host} > /etc/hostname
    hostname ${chef_host}
    echo "127.0.0.1 ${chef_host}" >> /etc/hosts
  EOH
end

# check depot if chef-server 11 's rpm is exsit .
# This script works for only workstation cloud
# install chef-server 
# reconfigure chef-server

ENV['chefserver'] = "#{node[:chefserver]}"
bash "install_chef-server" do
  user "root"
  code <<-EOH
    if [ -d /vagrant/depot ]
    then
      cd /vagrant/depot/
      rpm -iUv ${chefserver}
    fi

    chef-server-ctl reconfigure
  EOH
end
