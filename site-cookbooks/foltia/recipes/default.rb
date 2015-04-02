#
# Cookbook Name:: foltia
# Recipe:: default
#
# Copyright 2015, Hiroyuki Nagata
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'cpan'

service "httpd" do
   action [ :enable, :start ]
end

#cpan_client 'Time::HiRes' do
#    action 'install'
#    install_type 'cpan_module'
#    user 'root'
#    group 'root'
#end
