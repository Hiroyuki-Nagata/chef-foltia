# -*- coding: utf-8 -*-
#
# Cookbook Name:: foltia
# Recipe:: default
#
# Copyright 2015, Hiroyuki Nagata
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apache2'
include_recipe 'git::default'

# add user 'foltia', password is also 'foltia'
user "foltia" do
  password "$1$wboElf8A$467sbApDxc2i.p6bpWYK3."
  supports :manage_home => true
  action :create
end

group "wheel" do
  action [:modify]
  members ["foltia"]
  append true
end

# Perl/PHP need to install
package ['perl-ExtUtils-Manifest',
         'perl-ExtUtils-ParseXS',
         'perl-Module-Build',
         'php-pear', 
         'php-mbstring', 
         'php-pdo']

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

# stop unused service
%w{
  firewalld
}.each do |serv|
service "#{serv}" do
   action [ :enable, :stop ]
   end
end

# chef git won't checkout foltia if 
# 'git "/home/foltia/" do'
git "/home/foltia/foltia" do
   repository "https://github.com/Hiroyuki-Nagata/foltia.git"
   reference "master"
   action :sync
   user "foltia"
end

# PHP/Perl need permission FIXME: nasty permission
execute "chmod_for_/home/foltia/" do
   command "echo 'chmod & chown'; chmod -R 755 /home/foltia/; chown -R foltia. /home/foltia/"
end
execute "simlink_for_/home/foltia/" do
   command "echo 'create simlink'; ln -s /home/foltia/foltia/install/php /var/www/html/foltia"
end

# add config
web_app "foltia" do
   server_port "80"
   docroot "/var/www/html"
   template "foltia.conf.erb"
   allow_override "All"
   server_name node[:fqdn]
   server_aliases [node[:hostname], "foltia"]
end

# start httpd
service "httpd" do
   action [ :enable, :start ]
end
