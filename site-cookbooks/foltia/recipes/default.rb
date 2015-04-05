#
# Cookbook Name:: foltia
# Recipe:: default
#
# Copyright 2015, Hiroyuki Nagata
#
# All rights reserved - Do Not Redistribute
#

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

# clone from github
include_recipe 'git::default'

# chef git won't checkout foltia if 
# 'git "/home/foltia/" do'
git "/home/foltia/foltia" do
   repository "https://github.com/Hiroyuki-Nagata/foltia.git"
   reference "master"
   action :sync
   user "foltia"
end

# start httpd
service "httpd" do
   action [ :enable, :start ]
end
