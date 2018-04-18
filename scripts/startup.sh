#!/bin/bash
echo "startup running" > /tmp/startup.log
apt-get update >> /tmp/startup.log
mkdir -p /opt/docker-compose
mkdir -p /opt/nomad/bin
mkdir -p /opt/nomad/jobs
mkdir -p /opt/nomad/tmp
mkdir -p /opt/nomad/conf
apt-get install -y unzip zip >> /tmp/startup.log
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
apt-get update >> /tmp/startup.log
apt-get -y install docker-ce >> /tmp/startup.log
systemctl enable "docker" >> /tmp/startup.log
systemctl start "docker" >> /tmp/startup.log
cd /opt/nomad/bin && wget https://releases.hashicorp.com/nomad/0.8.1/nomad_0.8.1_linux_amd64.zip >> /tmp/startup.log
cd /opt/nomad/bin && unzip nomad_0.8.1_linux_amd64.zip >> /tmp/startup.log
ln -s /opt/nomad/bin/nomad /usr/bin/nomad
cd /opt/nomad/bin && rm -rf nomad_0.8.1_linux_amd64.zip
systemctl restart nomad
ufw allow 5656
ufw allow 4647
ufw allow 4646
echo "\n \n ****** all done \n">> /tmp/startup.log