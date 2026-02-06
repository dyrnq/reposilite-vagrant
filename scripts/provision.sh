#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd -P)

echo "root:vagrant" | sudo chpasswd
timedatectl set-timezone "Asia/Shanghai"


if command -v apt ; then
    if grep ubuntu /etc/os-release; then
        
        if [ -e /etc/apt/sources.list ]; then
        sed -i \
        -e 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' \
        -e 's@security.ubuntu.com@mirrors.ustc.edu.cn@g' /etc/apt/sources.list
        fi

        if [ -e /etc/apt/sources.list.d/ubuntu.sources ]; then
        sed -i \
        -e 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' \
        -e 's@security.ubuntu.com@mirrors.ustc.edu.cn@g' /etc/apt/sources.list.d/ubuntu.sources
        fi
    elif grep debian /etc/os-release; then
        if [ -e /etc/apt/sources.list ]; then
        sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
        sed -i -e 's|security.debian.org/\? |security.debian.org/debian-security |g' \
                    -e 's|security.debian.org|mirrors.ustc.edu.cn|g' \
                    -e 's|deb.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' \
                    /etc/apt/sources.list
        fi

        if [ -e /etc/apt/sources.list.d/ubuntu.sources ]; then
        sed -i \
        -e 's/deb.debian.org/mirrors.ustc.edu.cn/g' \
        -e 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources
        fi
    fi
fi


echo "${HOSTNAME}"


bash /vagrant/scripts/install-docker.sh
usermod -aG docker vagrant



apt update;
apt install -y jq wget curl vim git net-tools netcat-openbsd gosu;




if [ -f "/etc/ssh/sshd_config.d/60-cloudimg-settings.conf" ]; then
    sed -i "s|^PasswordAuthentication.*|PasswordAuthentication yes|g" /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
    systemctl restart sshd
fi

sysctl -w vm.max_map_count=2000000
echo madvise > /sys/kernel/mm/transparent_hugepage/enabled