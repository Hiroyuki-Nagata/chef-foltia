#
# Cookbook Name:: foltia
# Recipe:: default
#
# Copyright 2015, Hiroyuki Nagata
#
# All rights reserved - Do Not Redistribute
#

service "httpd" do
   action [ :enable, :start ]
end
