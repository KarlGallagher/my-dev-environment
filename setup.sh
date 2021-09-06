#!/bin/bash -eux

kernel=`uname`

if [ ${kernel} == "Darwin" ]
then
    #install homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"  
    brew tap hashicorp/tap
    xargs apt-get -y install < brew_packages.txt
     xargs apt-get -y install < brew_casks.txt
    vagrant box add --provider virtualbox --no-tty generic/ubuntu2004
    vagrant box add --provider virtualbox --no-tty cdaf/WindowsServer
else
    distro=$(awk -F'=' '/^ID=/ {print tolower($2)}' /etc/*-release)
    
    if [ ${distro} == "ubuntu" ]
    then
        apt -y update
        apt -y upgrade
        xargs apt-get -y install < apt_packages.txt

        wget https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        dpkg -i packages-microsoft-prod.deb
        rm packages-microsoft-prod.deb

        apt-get install -y apt-transport-https &&  apt-get update && apt-get install -y dotnet-sdk-5.0
        
        apt-get install -y apt-transport-https &&  apt-get update &&  apt-get install -y aspnetcore-runtime-5.0
    else
        echo "Unsupported distribution, try Ubuntu"
        exit -1
    fi
fi

echo "Setting bash and vim profiles..."
cat profile >> /home/$1/.profile
cp vimrc /home/$1/.vimrc

