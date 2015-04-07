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
execute "make sqlite3 table" do
   command "echo 'make sqlite3 table'; sqlite3 /home/foltia/foltia.sqlite < /home/foltia/foltia/install/mktable.sqlite.txt"
end

# fetch calendar
execute "fetch calendar" do
   command "echo 'fetch calendar'; perl /home/foltia/foltia/install/perl/getxml2db.pl long"
end
