#!/bin/bash -eux

# Copyright (c) 2021 Karl Gallagher
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

kernel=`uname`
home="home"

if [ ${kernel} == "Darwin" ]
then
    home="Users"
    #install homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"  
    brew tap hashicorp/tap
    brew tap homebrew/cask-fonts
    xargs brew install < brew_packages.txt
    xargs brew install --cask < brew_casks.txt

    #oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    omz update

    #vagrant boxes
    vagrant box add --provider virtualbox --no-tty generic/ubuntu2204
    vagrant box add --provider virtualbox --no-tty cdaf/WindowsServer

    cat zshrc >> /${home}/$1/.zshrc
else
    distro=$(awk -F'=' '/^ID=/ {print tolower($2)}' /etc/os-release)
    version=$(awk -F'=' '/^VERSION_ID=/ {print $2}' /etc/os-release)
    echo DISTRO=${distro}
    echo VERSION=${version}

    if [ ${distro} = "ubuntu" ] || [ ${distro} = "debian" ]
    then
        apt -y update
        apt -y upgrade

        xargs apt -y install < apt_packages.txt

        bash linux_scripts/install_docker.sh $1
        bash linux_scripts/install_lazydocker.sh
        bash linux_scripts/install_helm.sh
        bash linux_scripts/install_minikube.sh
        if grep -qi WSL /proc/sys/kernel/osrelease; then
            echo "WSL detected... skipping vscode install"
        else
            bash linux_scripts/install_vscode.sh
        fi

        if [ ${version} != "22.04" ]; then
            bash linux_scripts/install_dotnet.sh
        fi
        
        bash linux_scripts/install_starship.sh
        bash linux_scripts/install_k6.sh
        bash linux_scripts/install_powershell.sh 

        cat profile >> /${home}/$1/.profile

    else
        echo "Unsupported distribution, try Ubuntu or Debian"
        exit -1
    fi
fi

echo "Setting vim profile..."
cp vimrc /${home}/$1/.vimrc
