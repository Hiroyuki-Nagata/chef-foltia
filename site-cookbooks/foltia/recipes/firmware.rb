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

# modprobe from template
template "blacklist.conf" do
  path "/etc/modprobe.d/blacklist.conf"
  source "blacklist.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

# driver
git "/usr/local/src/pt3" do
   repository "https://github.com/m-tsudo/pt3.git"
   reference "master"
   action :sync
   user "root"
end

bash 'install_driver' do
  user 'root'

  code <<-EOC
    cd /usr/local/src/pt3
    make clean && make && sudo make install
  EOC
end

bash 'install_pt3' do
  user 'root'

  code <<-EOC
    cd /tmp
    wget http://hg.honeyplanet.jp/pt1/archive/c44e16dbb0e2.zip
    unzip c44e16dbb0e2.zip
    cd pt1-c44e16dbb0e2/arib25
    make clean && make && make install
     
    cd /tmp
    wget http://hg.honeyplanet.jp/pt1/archive/tip.tar.bz2
     
    tar -jxvf tip.tar.bz2
    cd /tmp/pt1-c8688d7d6382/recpt1
     
    # PT2/3混在環境の場合にはpt1_dev.hの/dev/pt1video**を
    # 必要個数、pt3video**のようにPT3用に書き換えます。
    # PT1/PT2のみの場合には、pt1_dev.hの書き換えの必要は無い。
     
    # pt3のみの環境の場合には、sedで一括置換でOKです。
    sed -i 's/pt1video/pt3video/g' pt1_dev.h
     
    ./autogen.sh
    ./configure --enable-b25 && make && make install
  EOC
end
