# -*- mode: ruby -*-
# vi: set ft=ruby :

require "yaml"

# Load the vagrant_config.yaml
settings = YAML.load(File.open(File.join(File.dirname(__FILE__),
                    "vagrant_config.yaml"), File::RDONLY).read)

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "generic/debian11"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  #config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  config.vm.network "forwarded_port", guest: 80, host: 5000, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/vagrant_data", disabled: false

  #Basic VM settings (Global)
  config.vm.hostname = settings['vm_host_name']
  config.vm.define settings['vm_machine_name']

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |machine, override|
    #Allow copy/paste between host<-->guest 
    vb.customize ["modifyvm", :id, "--clipboard-mode", "bidirectional"]
    vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
    
    #USB mount/filter
    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ["modifyvm", :id, "--usbehci", "on"]
    # Display the VirtualBox GUI when booting the machine?
    machine.gui = false
    # Customize the amount of memory on the VM:
    machine.memory = settings["ram"]
    # Customised number of cpu cores assigned to the VM:
    machine.cpus = settings["cpu_num"]
    # Virtualbox specific shared folder:
    override.vm.synced_folder ".", "/home/vagrant/shared", type: "virtualbox", disabled: false
    # Name the VM instance:
    machine.name = settings['vm_name']
  end
  # Example for Hyper-V:
  #
  config.vm.provider "hyperv" do |machine, override|
    # Enable extensions
    machine.enable_virtualization_extensions = true
    # Customize the amount of memory on the VM:
    machine.memory = settings["ram"]
    # Customised number of cpu cores assigned to the VM:
    machine.cpus = settings["cpu_num"]
    # Name the VM instance:
    machine.name = settings['vm_name']
  end
  # Example for libvirt(KVM):
  #
  config.vm.provider "libvirt" do |machine, override|
    # Customize the amount of memory on the VM:
    machine.memory = settings["ram"]
    # Customised number of cpu cores assigned to the VM:
    machine.cpus = settings["cpu_num"]
    # Name the VM instance:
    machine.name = settings['vm_name']
  end
  
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.

  # Copy setup and env files to guest
  config.vm.provision :file, source: "vimrc", destination: "/home/vagrant/.vimrc"
  config.vm.provision :file, source: "apt_packages.txt", destination: "/tmp/"
  config.vm.provision :file, source: "profile", destination: "/tmp/" 

  # Append custom bash profile settings
  config.vm.provision :shell, inline: "cat /tmp/profile >> /home/vagrant/.profile"

  # Install required packages (as defined in package list)
  config.vm.provision "shell", inline: <<-SHELL
     apt-get -y update
     apt-get -y upgrade
     echo "Installing Packages..."
     xargs apt-get -y install < /tmp/apt_packages.txt
  SHELL

  # Install tools
  config.vm.provision :shell, path: "linux_scripts/install_docker.sh", args: "vagrant"
  config.vm.provision :shell, path: "linux_scripts/install_dotnet.sh"
  config.vm.provision :shell, path: "linux_scripts/install_vscode.sh"
  config.vm.provision :shell, path: "linux_scripts/install_minikube.sh"
  config.vm.provision :shell, path: "linux_scripts/install_helm.sh"
end
