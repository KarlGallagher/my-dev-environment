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

if [ ${kernel} == "Darwin" ]
then
    #install homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"  
    brew tap hashicorp/tap
    xargs brew install < brew_packages.txt
    xargs brew install < brew_casks.txt
    vagrant box add --provider virtualbox --no-tty generic/ubuntu2004
    vagrant box add --provider virtualbox --no-tty cdaf/WindowsServer
else
    distro=$(awk -F'=' '/^ID=/ {print tolower($2)}' /etc/os-release)
    echo DISTRO=${distro}
    if [[ ${distro} == +(ubuntu|debian) ]]
    then
        apt -y update
        apt -y upgrade
        xargs apt-get -y install < apt_packages.txt

        bash linux_scripts/install_docker.sh $1
        bash linux_scripts/install_helm.sh
        bash linux_scripts/install_minikube.sh
        bash linux_scripts/install_vscode.sh
        bash linux_scripts/install_dotnet.sh

    else
        echo "Unsupported distribution, try Ubuntu"
        exit -1
    fi
fi

echo "Setting bash and vim profiles..."
cat profile >> /home/$1/.profile
cp vimrc /home/$1/.vimrc

