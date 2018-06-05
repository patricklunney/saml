# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  #config.vm.box = "bento/ubuntu-16.04-i386"
  config.vm.box = "centos/7"
  config.vm.box_version = "1708.01"

  ## PORT FORWARDING

  ## FILES

  config.vm.provision "file", source: "./testappsaml.conf", destination: "/home/vagrant/testappsaml.conf"
  config.vm.provision "file", source: "./shibboleth2.xml", destination: "/home/vagrant/shibboleth2.xml"
  config.vm.provision "file", source: "./fss_gecompany_com_IDP.xml", destination: "/home/vagrant/fss_gecompany_com_IDP.xml"
  config.vm.provision "file", source: "./index.php", destination: "/home/vagrant/index.php"
  config.vm.provision "file", source: "./allowHttpd2Shib/allowHttpd2Shib.pp", destination: "/home/vagrant/allowHttpd2Shib.pp"
  config.vm.provision "file", source: "./shibboleth.repo", destination: "/home/vagrant/shibboleth.repo"


  config.vm.provider "virtualbox" do |vb|
  #  Customize the amount of memory on the VM:
    vb.memory = "2048"
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.

  config.vm.provision "shell", inline: <<-SHELL
    yum update -y
    yum install httpd -y
    yum install php -y
    yum install libxml2 -y
    sudo mv /home/vagrant/shibboleth.repo /etc/yum.repos.d
    yum install shibboleth -y
    systemctl start httpd.service
    systemctl enable httpd.service
    systemctl start shibd.service
    touch /var/www/html/index.php
    echo "Hello World" > /var/www/html/index.php
    firewall-cmd --permanent --zone=public --add-service=http
    firewall-cmd --permanent --zone=public --add-service=https
    firewall-cmd --reload
    semodule -i /etc/shibboleth/allowHttpd2Shib.pp
  SHELL

end
