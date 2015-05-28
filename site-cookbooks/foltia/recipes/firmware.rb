# -*- coding: utf-8 -*-
#
# Cookbook Name:: foltia
# Recipe:: firmware
#
# Copyright 2015, Hiroyuki Nagata
#
# All rights reserved - Do Not Redistribute
#

# for firmware & card
%w{
   gcc
   gcc-c++
   make
   mercurial
   kernel-devel
   pcsc-lite-ccid
   pcsc-lite
   pcsc-lite-devel
   pcsc-tools
}.each do |p|
  package p do
    action :install
  end
end

service 'pcscd' do
  action [:enable, :start]
end

# recpt1
git "/usr/local/src/recpt1" do
   repository "https://github.com/stz2012/recpt1.git"
   reference "master"
   action :sync
   user "root"
end
# arib25
git "/usr/local/src/libarib25" do
   repository "https://github.com/stz2012/libarib25.git"
   reference "master"
   action :sync
   user "root"
end
# driver
mercurial "/usr/local/src/pt1_driver" do
   repository "http://hg.honeyplanet.jp/pt1/"
   reference "default"
   action :sync
   owner "root"
end

bash 'install_pt2' do
  user 'root'

  code <<-EOC
    cd /usr/local/src/pt1_driver/driver
    make clean all
    make install
    cd /usr/local/src/libarib25
    make clean all
    make install
    cd /usr/local/src/recpt1/recpt1
    ./autogen.sh
    LDFLAGS=-L/usr/local/lib CFLAGS=-I/usr/local/include ./configure --enable-b25
    make clean all
    make install
    modprobe pt1_drv
    echo "blacklist earth-pt1" >> /etc/modprobe.d/blacklist.conf                         
    echo "" >> /home/foltia/.bashrc                                                      
    echo "export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH" >> /home/foltia/.bashrc
  EOC
end
