# -*- coding: utf-8 -*-
#
# Cookbook Name:: foltia
# Recipe:: iptables
#
# Copyright 2015, Hiroyuki Nagata
#
# All rights reserved - Do Not Redistribute
#

# Reject packets other than those explicitly allowed
simple_iptables_policy "INPUT" do
  policy "DROP"
end

# The following rules define a "system" chain; chains
# are used as a convenient way of grouping rules together,
# for logical organization.

# Allow all traffic on the loopback device
simple_iptables_rule "loopback" do
  chain "system"
  rule "--in-interface lo"
  jump "ACCEPT"
end

# Allow any established connections to continue, even
# if they would be in violation of other rules.
simple_iptables_rule "established" do
  chain "system"
  rule "-m conntrack --ctstate ESTABLISHED,RELATED"
  jump "ACCEPT"
end

# Allow SSH
simple_iptables_rule "ssh" do
  chain "system"
  rule "--proto tcp --dport 22"
  jump "ACCEPT"
end

# For Apache2
simple_iptables_rule "apache2" do
  rule "--proto tcp --dport 80"
  jump "ACCEPT"
end
