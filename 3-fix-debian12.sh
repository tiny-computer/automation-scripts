#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 <name_of_container>"
    exit 1
fi
/usr/bin/expect <<EOF
set timeout 65535
spawn tmoe p "debian-$1"
expect "tiny@localhost"
#伪装root用户（主要是避免tiny@localhost有颜色）
send "sudo su\n"
expect "root@localhost"
#修复语言
send "sed -i 's/\^#\\\\s\\*\\\\(zh_CN\.UTF-8 UTF-8\\\\)/\\\\1/' /etc/locale.gen\r"
#切换清华源
expect "root@localhost"
send "cat <<EOF > /etc/apt/sources.list
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware
deb https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
EOF\r"
#更新软件包
expect "root@localhost"
send "apt update\r"
expect "root@localhost"
send "apt upgrade -y\r"
#修补libtiff5（WPS）
expect "root@localhost"
send {wget http://security.debian.org/debian-security/pool/updates/main/t/tiff/libtiff5_4.2.0-1+deb11u6_arm64.deb}
send "\r"
expect "root@localhost"
send {wget http://ftp.cn.debian.org/debian/pool/main/libw/libwebp/libwebp6_0.6.1-2.1+deb11u2_arm64.deb}
send "\r"
expect "root@localhost"
send {apt install ./libtiff5_4.2.0-1+deb11u6_arm64.deb ./libwebp6_0.6.1-2.1+deb11u2_arm64.deb -y}
send "\r"
expect "root@localhost"
send {rm libtiff5_4.2.0-1+deb11u6_arm64.deb libwebp6_0.6.1-2.1+deb11u2_arm64.deb}
send "\r"
#预装ttf-mscorefonts-installer（WPS）
expect "root@localhost"
send {apt install ttf-mscorefonts-installer -y}
send "\r"
expect "Configuring ttf"
sleep 1
send "\r"
expect "Directory holding MS fonts"
sleep 1
send "\r"
expect "HTTP proxy to use"
sleep 1
send "\r"
expect "Where should these files be archived"
sleep 1
send "\r"
expect "Mirror to download from"
sleep 1
send "\r"
#修复tmoe
expect "root@localhost"
send {find "/usr/local/etc/tmoe-linux/git/share/old-version" -type f -exec sed -i "s/aria2c --console-log-level/aria2c --async-dns=false --console-log-level/g" {} +}
send "\r"

expect "root@localhost"
send "exit\r"
expect "tiny@localhost"
send "exit\r"

expect eof
EOF