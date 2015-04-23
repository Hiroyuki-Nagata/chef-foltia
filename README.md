# chef-foltia
  
アニメ録画用ソフトウェアfoltiaのインストール用cookbook  
  
# Install with Vagrant
```
$ vagrant plugin install vagrant-berkshelf  
$ vagrant plugin install vagrant-omnibus
$ cd chef-foltia  
$ vagrant up  
```

# Install with chef-solo
- First, you should install `chef-dk` from `https://downloads.chef.io/chef-dk/`
```
$ berks install
$ berks update
$ berks vendor cookbooks
$ sudo chef-solo -c solo.rb -j ./nodes/localhost.json
```
  
vagrant環境の場合 `http://192.168.33.10/foltia/index.php` からfoltiaが動作していることが確認できます
