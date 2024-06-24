#!/bin/bash

UBUNTU_CODENAME=$(lsb_release -c -s)
echo $UBUNTU_CODENAME

arch="$(dpkg --print-architecture)"
if [ "$arch" = "arm64" ]; then
    # Add architecture amd64
    sudo dpkg --add-architecture amd64

    echo "deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu ${UBUNTU_CODENAME} main restricted
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu ${UBUNTU_CODENAME}-updates main restricted
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu ${UBUNTU_CODENAME} universe
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu ${UBUNTU_CODENAME}-updates universe
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu ${UBUNTU_CODENAME} multiverse
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu ${UBUNTU_CODENAME}-updates multiverse
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu ${UBUNTU_CODENAME}-backports main restricted universe multiverse" \
    | sudo tee /etc/apt/sources.list.d/cross-source.list
    
    # Add default architecture to sources.list, otherwise the 'apt update' command will occurs error
    sudo sed -i "s/deb/deb [arch=$arch]/g" /etc/apt/sources.list

    # Install libc6:amd64
    sudo apt update
    sudo apt install libc6:amd64 -y
fi