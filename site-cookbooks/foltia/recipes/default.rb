#
# Cookbook Name:: foltia
# Recipe:: default
#
# Copyright 2015, Hiroyuki Nagata
#
# All rights reserved - Do Not Redistribute
#

# start httpd
service "httpd" do
   action [ :enable, :start ]
end

# need to install
package ['perl-ExtUtils-Manifest',
         'perl-ExtUtils-ParseXS',
         'perl-Module-Build']

include_recipe 'cpan::bootstrap'

%w{
  Time::HiRes
  LWP
  DBI
  Schedule::At
}.each do |mod|
   cpan_client "#{mod}" do
    action 'install'
    install_type 'cpan_module'
    user 'root'
    group 'root'
   end
end
