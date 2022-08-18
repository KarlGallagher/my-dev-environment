# My personal minimal dev setup

This repository stores package lists and install scripts used to configure a minimal dev environment for general development.

## Supported OS platforms
- macOS (10.14+)
- Ubuntu 22.04 LTS

## Supported development tools
- python (3.x)
- .Net Core (6)
- Vagrant
- Docker
- Minikube
- Helm
- Visual Studio Code

---
## Running setup

### Local Install (MacOS or Unbuntu)

>`git clone https://github.com/KarlGallagher/my-dev-environment`

>`cd my-dev-environment/`

>`sudo bash setup.sh $(whoami)`

**Do not use sudo on macOS!**

>Note: Linux platform setup will NOT install/configure vagrant by default. Run `sudo bash linux_scripts/vagrant_setup` if required.

### Vagrant option
If you require or need to run the development environment on a VM, a vagrant setup based on [Ubuntu 22.04](https://releases.ubuntu.com/22.04) is also provided.

`vagrant box add --provider virtualbox --no-tty generic/ubuntu2204`

`vagrant plugin install yaml`

`vagrant up`

>The base box also supports 'hyperv'(Windows) and 'libvirt'(Linux/KVM) providers. 
You may need to install/enable the correct provider beforehand.

  ---

### IDE setup
By default, vim/macvim text editor is setup with basic syntax highlighting support.

And also: [Visual Studio Code](https://code.visualstudio.com/download)

>You are free to install any other IDE of your choosing.