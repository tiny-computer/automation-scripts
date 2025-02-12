#!/bin/bash

#容器命名不要包含下划线，否则无法删除

if [ -z "$1" ]; then
    echo "Usage: $0 <name_of_container>"
    exit 1
fi

/usr/bin/expect <<EOF
set timeout 65535
spawn bash ./.local/share/tmoe-linux/git/debian.sh
#tmoe页面
expect "请使用方向键"
sleep 1
send "\r"
#架构选择页面
expect "您是想要运行"
sleep 1
send "\r"
#系统选择页面，选第一个（debian），直接回车即可
expect "您想要安装哪个容器"
sleep 1
send "\r"
#版本选择页面，选择第二个（debian 12），下键然后回车
expect "请选择您需要安装"
sleep 1
send "\x0e\r"
#容器设置页面，选择第九个（新建容器），这是为了给新容器换一个名称以做区分。下键8次然后回车
expect "容器路径"
sleep 1
send "\x0e\x0e\x0e\x0e\x0e\x0e\x0e\x0e\r"
#输入容器名，方便之后访问
expect "Please"
sleep 1
send "$1\r"
#确认安装
expect "即将为您安装"
send "\r"
#是否新建sudo用户，确定
expect "请问您是否想要新建"
sleep 1
send "\r"
#新建名为tiny的用户
expect "请输入用户名"
sleep 1
send "tiny\r"
#密码也输入为tiny
expect "password"
sleep 1
send "tiny\r"
#将tiny设置为默认用户，选yes，即方向键右键然后回车
expect "请问您是否想要将"
sleep 1
send "\x06\r"
#是否配置zsh，选no，方向键右键然后回车
expect "是否需要为"
sleep 1
send "\x06\r"
#是否删除zsh配置脚本。选yes，直接回车
expect "delete"
sleep 1
send "\r"
#是否启用tmoe。选yes，直接回车
expect "是否需要启动"
sleep 1
send "\r"
#配置fontconfig-config，全部保持默认，直接4次回车
expect "Configuring fontconfig-config"
sleep 1
send "\r"
expect "Configuring fontconfig-config"
sleep 1
send "\r"
expect "Configuring fontconfig-config"
sleep 1
send "\r"
expect "Configuring fontconfig-config"
sleep 1
send "\r"
#安装后再次需要配置fontconfig-config，直接回车
expect "Configuring fontconfig-config"
sleep 1
send "\r"
#来到tmoe tools界面，先退出，两次右键然后回车
expect "图形界面"
sleep 1
send "\x06\x06\r"
#退出，完成安装
expect "root@localhost"
send "exit\r"
#继续退出，完成安装
expect "root@localhost"
send "exit\r"
#继续退出，完成安装
expect "tiny@localhost"
send "exit\r"
#“按回车键返回”
expect "回车键"
send "\r"
#退出容器设置页面。方向键右键2次然后回车
expect "容器路径"
sleep 1
send "\x06\x06\r"
#退出容器安装页面。方向键右键2次然后回车
expect "您想要安装哪个容器"
sleep 1
send "\x06\x06\r"
#退出架构选择页面。方向键右键2次然后回车
expect "您是想要运行"
sleep 1
send "\x06\x06\r"
#退出tmoe页面。方向键右键2次然后回车
expect "请使用方向键"
sleep 1
send "\x06\x06\r"
expect eof
EOF
echo "安装完成！之后可以通过tmoe p debian-$1进入容器了。"