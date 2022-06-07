#!/bin/bash -eux

# DPkg::Lock::Timeout should work around apt lock race condition at startup ...
# (see https://blog.sinjakli.co.uk/2021/10/25/waiting-for-apt-locks-without-the-hacky-bash-scripts/)
apt_opts="-o DPkg::Lock::Timeout=60 -qq"
# ... but this hack still seems necessary
sleep 10

export DEBIAN_FRONTEND=noninteractive
echo "debconf debconf/frontend select Noninteractive" | sudo debconf-set-selections

sudo apt-get update $apt_opts
sudo apt-get install $apt_opts apt-utils software-properties-common

sudo apt-get dist-upgrade $apt_opts

curl --silent https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo add-apt-repository "deb https://artifacts.elastic.co/packages/8.x/apt stable main"

sudo apt-get update $apt_opts
sudo apt-get install $apt_opts --no-install-recommends logstash

sudo /usr/share/logstash/bin/logstash-plugin install logstash-output-swift
(cd / && sudo patch -p0 -i /tmp/logstash.patch)

sudo apt-get remove $apt_opts unattended-upgrades
sudo apt-get clean $apt_opts
