#!/bin/bash -eux
apt -y update
apt -y upgrade
apt -y upgrade libruby
apt -y upgrade ruby
apt -y upgrade gem
apt -y install qemu libvirt-daemon-system libvirt-clients libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev ruby-libvirt ebtables dnsmasq-base
apt -y install build-essential
curl -O https://releases.hashicorp.com/vagrant/2.2.16/vagrant_2.2.16_x86_64.deb
apt -y install ./vagrant_2.2.16_x86_64.deb

vagrant plugin install yaml
vagrant plugin install vagrant-libvirt

vagrant box add --provider libvirt --no-tty generic/ubuntu2004