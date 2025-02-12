apt update
apt upgrade -y
apt install -y expect
curl -LO https://l.tmoe.me/2.awk
/usr/bin/expect << EOF
set timeout 65535
spawn awk -f 2.awk
#同意使用协议
#不把匹配的句子写完整是因为单词颜色不同，中间被颜色字符断开，写上去比较麻烦
expect "Do you want to"
send "Y\r"
expect "Do you want to"
send "Y\r"
#切换github/gitee
expect "Do you want to"
send "Y\r"
#安装whiptail
expect "Do you want to install"
send "Y\r"
#安装完成，大约5秒后对话框应该能显示出来，然后再输入方向键。立刻输入可能被吞
#因为匹配不了对话框的字符所以只能以等待5秒作为替代条件了
expect "Setting up whiptail"
sleep 5
#语言选择对话框，按两次下键选择中文然后确定
send "\x0e\x0e\r"
#tmoe对话框，直接确定（选择proot容器），进入初始化
sleep 5
send "\r"
#安装依赖
expect "Do you want to"
send "Y\r"
expect "Resolving deltas"
#安装完毕会回到tmoe对话框，直接确定（选择proot容器），继续初始化
sleep 20
send "\r"
#颜色选择对话框，无所谓，直接确认（neon）
sleep 5
send "\r"
#字体选择对话框，无所谓，直接确认（Inconsolata-go）
sleep 5
send "\r"
#是否修改小键盘对话框，无所谓，但我不想修改，按一下右键选no然后回车
sleep 5
send "\x06\r"
#DNS选择对话框，保持默认直接回车
sleep 5
send "\r"
#“按回车键返回”
expect "回车键"
send "\r"
#是否启用一言，无所谓，但我不想安装，按一下右键选no然后回车
sleep 5
send "\x06\r"
#确认时区Asia/Shanghai，直接回车
sleep 5
send "\r"
#共享sd，我选择共享整个sd目录（3），按两次下键然后回车
sleep 5
send "\x0e\x0e\r"
#是否共享/storage，我选是，直接回车
sleep 5
send "\r"
#“按回车键返回”
expect "回车键"
send "\r"
#共享HOME，我选择共享整个目录（3），按两次下键然后回车
sleep 5
send "\x0e\x0e\r"
#“按回车键返回”
expect "回车键"
send "\r"
#“同意许可协议”
expect "回车键"
send "\r"
#初始化配置完成。现在先不装容器，退出即可完成tmoe安装
#容器选择界面，按两下右键选cancel然后回车退出
sleep 5
send "\x06\x06\r"
#tmoe界面，按两下右键选cancel然后回车退出
sleep 5
send "\x06\x06\r"
expect eof
EOF
#安装完成。启动脚本在./.local/share/tmoe-linux/git/debian.sh