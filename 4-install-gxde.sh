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
#安装gxde源
expect "root@localhost"
send {wget https://mirrors.sdu.edu.cn/spark-store/GXDE-OS/gxde-os/bixie/g/gxde-source/gxde-source_1.1.6_all.deb}
send "\r"
expect "root@localhost"
send {apt install ./gxde-source_1.1.6_all.deb -y}
send "\r"
expect "root@localhost"
send {rm gxde-source_1.1.6_all.deb}
send "\r"
expect "root@localhost"
send "apt update\r"
expect "root@localhost"
send "apt upgrade -y\r"
#更新两次，防止源有更新
expect "root@localhost"
send "apt update\r"
expect "root@localhost"
send "apt upgrade -y\r"
#安装xdg-utils（星火需要）
expect "root@localhost"
send "apt install xdg-utils -y\r"
#正式安装
expect "root@localhost"
send "apt install gxde-desktop-android --no-install-recommends -y\r"
#PAM配置
expect "PAM 配置"
sleep 1
send "\r"

#更改vnc安装脚本
expect "root@localhost"
send {sed -i 's/gui_main "\$@"/configure_vnc_xstartup/' /usr/local/etc/tmoe-linux/git/share/old-version/tools/gui/gui}
send "\r"
#进入tmoe工具
expect "root@localhost"
send "tmoe t\r"
#按4次下键回车进入vnc安装
expect "Welcome to tmoe linux tools"
sleep 1
send "\x0e\x0e\x0e\x0e\r"
#选择vnc客户端，tiger
expect "尽管tight可能更加流畅"
sleep 1
send "\r"
#密码12345678
expect "Please type the password"
sleep 1
send "12345678\r"
#端口随便选
expect "Please choose a vnc port"
sleep 1
send "\r"
#确认安装
expect "then you only need to remember 4 commands"
sleep 1
send "\r"
#安装x11vnc
expect "Do you want to configure x11vnc"
sleep 1
send "\r"
#安装novnc
expect "Do you want to configure novnc"
sleep 1
send "\r"
#纸张大小选择
expect "Please select the default paper"
sleep 1
send "\r"
#关闭提示
expect "You can type startvnc"
sleep 1
send "\r"
expect "回车键"
sleep 1
send "\r"
#按4次下键回车进入vnc设置
expect "Welcome to tmoe linux tools"
sleep 1
send "\x0e\x0e\x0e\x0e\r"
#修改tigervnc配置
expect "Which remote desktop config"
sleep 1
send "\r"
#修改其他配置，右键回车
expect "Which configuration do you want to modify"
sleep 1
send "\x06\r"
#按9次下键回车进入显示端口设置
expect "Type startvnc to start"
sleep 1
send "\x0e\x0e\x0e\x0e\x0e\x0e\x0e\x0e\x0e\r"
#输入编号4（5904）确定
expect "Please type the display"
sleep 1
send "4\r"
expect "回车键"
sleep 1
send "\r"
#按2次右键回车返回
expect "Type startvnc to start"
sleep 1
send "\x06\x06\r"
#修改novnc配置，3次下键回车
expect "Which remote desktop config"
sleep 1
send "\x0e\x0e\x0e\r"
#修改端口
expect "Type novnc to start novnc"
sleep 1
send "\r"
#输入端口，36082
expect "Please type the novnc port"
sleep 1
send "36082\r"
expect "回车键"
sleep 1
send "\r"
#按2次右键回车返回
expect "Type novnc to start novnc"
sleep 1
send "\x06\x06\r"
expect "Which remote desktop config"
sleep 1
send "\x06\x06\r"
expect "Welcome to tmoe linux tools"
sleep 1
send "\x06\x06\r"
#回滚对脚本的修改
expect "root@localhost"
send {sed -i '/^[[:space:]]*configure_vnc_xstartup[[:space:]]*$/s/configure_vnc_xstartup/gui_main "\$@"/' /usr/local/etc/tmoe-linux/git/share/old-version/tools/gui/gui}
send "\r"
#设置gxde启动脚本
expect "root@localhost"
send "cat <<EOF > /etc/X11/xinit/Xsession
rm -rf /run/dbus/pid
sudo dbus-daemon --system
export \$(dbus-launch)
startgxde_android
EOF\r"
expect "root@localhost"
send "exit\r"
expect "tiny@localhost"
send "exit\r"
expect eof
EOF

#todo startnovnc修复 xsession失效 拼音、火狐、vscode