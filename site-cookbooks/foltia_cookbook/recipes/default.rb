#
# Cookbook Name:: foltia_cookbook
# Recipe:: default
#
# Copyright 2015, Hiroyuki Nagata
#
# All rights reserved - Do Not Redistribute
#

package "httpd" do
   action :install
end
 
service "httpd" do
   action [ :enable, :start ]
end
