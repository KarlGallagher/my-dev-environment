# My personal minimal dev setup

This repository stores package lists and install scripts used to configure a minimal dev environment for general development.

## Supported OS platforms
- macOS (10.14+)
- Ubuntu 20.04 LTS

## Supported dev platforms
- python (3.8)
- .Net Core (5)
- Vagrant
- Docker
- Minikube
- Helm

---
## Running setup

>`git clone https://github.com/KarlGallagher/my-dev-environment`

>`cd my-dev-environment/`

>`sudo bash setup.sh $(whoami)`

**Do not use sudo on macOS!**

>Note: Linux platforms will require some manual installation of advanced tools (docker, minikube..etc).
See 'linux_scripts' folder for details
  ---
  
## Post setup
macOS users may wish to uncomment the following line from the installed bash profile (`vi ~/.profile`)
>#alias vi="mvim -v"

### IDE setup
By default, vim/macvim text editor is setup with basic syntax highlighting support

You are free to install any other IDE of your choosing,

Recommend: [Visual Studio Code](https://code.visualstudio.com/download)