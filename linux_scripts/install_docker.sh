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

source /etc/os-release


curl -fsSL https://download.docker.com/linux/${ID}/gpg | apt-key add -

apt -y install net-tools

echo "deb [arch=amd64] https://download.docker.com/linux/${ID} ${VERSION_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/docker.list
apt -y update

#Install official Docker release
apt -y install docker-ce docker-ce-cli containerd.io

#Add user to docker group
groupadd docker
usermod -aG docker $1

#Expose docker externally on port 2375
if grep -qi WSL /proc/sys/kernel/osrelease; then
    #WSL Ubuntu variant does not use systemd in its init system
    touch /etc/docker/daemon.json
	echo "{ \"hosts\": [\"unix:///var/run/docker.sock\", \"tcp://0.0.0.0:2375\"] }" | tee -a /etc/docker/daemon.json > /dev/null
	#fix for daemon not starting on WSL
	update-alternatives --set iptables /usr/sbin/iptables-legacy
    update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
else
    cp /lib/systemd/system/docker.service /etc/systemd/system/
    sed -i '/ExecStart/s/$/ -H tcp:\/\/0.0.0.0:2375/' /etc/systemd/system/docker.service
    systemctl daemon-reload
fi

#running docker as a service
service docker restart
#have docker startup after reboot
update-rc.d docker enable


#compose
mkdir -p /usr/local/lib/docker/cli-plugins/
curl -L https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-`uname -s`-`uname -m` -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
