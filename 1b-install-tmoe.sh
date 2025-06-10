apt update
apt install -y expect
/usr/bin/expect << EOF
set timeout 65535
spawn apt upgrade -y
#不替换bash.bashrc
expect "What would you like to do about it"
send "\r"
expect eof
EOF
curl -LO https://l.tmoe.me/2.awk
/usr/bin/expect << EOF
set timeout 65535
spawn awk -f 2.awk
#同意使用协议
#不把匹配的句子写完整是因为单词颜色不同，中间被颜色字符断开，写上去比较麻烦
expect "继续吗"
send "Y\r"
expect "继续吗"
send "Y\r"
#切换github/gitee
expect "Do you want to"
send "Y\r"
#安装whiptail
expect "Do you want to install"
send "Y\r"
#语言选择对话框，按两次下键选择中文然后确定
expect "语言_区域"
sleep 1
send "\x0e\x0e\r"
#tmoe对话框，直接确定（选择proot容器），进入初始化
expect "请使用方向键"
sleep 1
send "\r"
#安装依赖
expect "Do you want to"
send "Y\r"
#安装完毕会回到tmoe对话框，直接确定（选择proot容器），继续初始化
expect "请使用方向键"
sleep 1
send "\r"
#颜色选择对话框，无所谓，直接确认（neon）
expect "请选择终端配色"
sleep 1
send "\r"
#字体选择对话框，无所谓，直接确认（Inconsolata-go）
expect "请选择终端字体"
sleep 1
send "\r"
#是否修改小键盘对话框，无所谓，但我不想修改，按一下右键选no然后回车
expect "是否需要创建"
sleep 1
send "\x06\r"
#DNS选择对话框，保持默认直接回车
expect "主要用于域名解析"
sleep 1
send "\r"
#“按回车键返回”
expect "回车键"
send "\r"
#是否启用一言，无所谓，但我不想安装，按一下右键选no然后回车
expect "是否需要启用一言"
sleep 1
send "\x06\r"
#确认时区Asia/Shanghai，直接回车
expect "Is your timezone Asia"
sleep 1
send "\r"
#共享sd，我选择共享整个sd目录（3），按两次下键然后回车
expect "否则不建议您挂载整个内置"
sleep 1
send "\x0e\x0e\r"
#是否共享/storage，我选是，直接回车
expect "Do you want to share"
sleep 1
send "\r"
#“按回车键返回”
expect "回车键"
send "\r"
#共享HOME，我选择共享整个目录（3），按两次下键然后回车
expect "将宿主的主目录挂载至容器内部"
sleep 1
send "\x0e\x0e\r"
#“按回车键返回”
expect "回车键"
send "\r"
#“同意许可协议”
expect "回车键"
send "\r"
#初始化配置完成。现在先不装容器，退出即可完成tmoe安装
#容器选择界面，按两下右键选cancel然后回车退出
expect "您是想要运行"
sleep 1
send "\x06\x06\r"
#tmoe界面，按两下右键选cancel然后回车退出
expect "请使用方向键"
sleep 1
send "\x06\x06\r"
expect eof
EOF
#安装完成。启动脚本在./.local/share/tmoe-linux/git/debian.sh