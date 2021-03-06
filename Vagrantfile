# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

   # Every Vagrant virtual environment requires a box to build off of.
   config.vm.box     = "fedora-20"
   config.vm.box_url = "https://dl.dropboxusercontent.com/u/15733306/vagrant/fedora-20-netinst-2014_01_05-minimal-puppet-guestadditions.box"
   config.vm.network "private_network", ip: "192.168.33.10"
   config.omnibus.chef_version = :latest
   config.berkshelf.enabled = true

   # use chef_solo
   config.vm.provision "chef_solo" do |chef|
      chef.cookbooks_path = ["./cookbooks", "./site-cookbooks"]
      chef.run_list = [
                       "recipe[selinux::disabled]",
                       "recipe[simple_iptables]",
                       "recipe[yum]",
                       "recipe[apache2]",
                       "recipe[apache2::mod_php5]",
                       "recipe[php]",
                       "recipe[cpan]",
                       "recipe[git]",
                       "recipe[sqlite]"
                      ]

      # apache2
      chef.json = {
         :apache => {
            :default_site_enabled => true
         }
      }

      # original cookbook
      chef.add_recipe "foltia::iptables"
      chef.add_recipe "foltia::default"
      chef.add_recipe "foltia::foltia"
      chef.add_recipe "foltia::firmware"
   end
end
