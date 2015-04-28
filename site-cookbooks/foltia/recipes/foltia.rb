# -*- coding: utf-8 -*-
#
# Cookbook Name:: foltia
# Recipe:: foltia
#
# Copyright 2015, Hiroyuki Nagata
#
# All rights reserved - Do Not Redistribute
#

# edit foltia config file / FIXME: make a .erb file
execute "edit foltia config file" do
   command "echo 'edit foltia config file'; cp /home/foltia/foltia/install/perl/foltia_conf1.pl.template /home/foltia/foltia/install/perl/foltia_conf1.pl"
end
execute "edit foltia config file" do
   command "echo 'edit foltia config file'; cp /home/foltia/foltia/install/php/foltia_config2.php.template /home/foltia/foltia/install/php/foltia_config2.php"
end

# make sqlite3 table
execute "make sqlite3 table #1" do
   command "echo 'make sqlite3 table'; sqlite3 /home/foltia/foltia.sqlite < /home/foltia/foltia/install/mktable.sqlite.sql"
end
execute "make sqlite3 table #2" do
   command "echo 'make sqlite3 table'; sqlite3 /home/foltia/foltia.sqlite < /home/foltia/foltia/install/mktable_foltia_station.sql"
end

# fetch calendar
execute "fetch calendar" do
   command "echo 'fetch calendar'; perl /home/foltia/foltia/install/perl/getxml2db.pl long"
end

# install npm & bower
include_recipe "nodejs::nodejs_from_package"
nodejs_npm "bower"

# install bower
execute "update bower" do
   command "cd /home/foltia/foltia/install && bower install"
end
