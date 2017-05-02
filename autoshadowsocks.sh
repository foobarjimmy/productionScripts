#! /bin/bash
### Program: Shadowsocks&Netspeeder Auto Installer
#
### Author: Lisheng2016
#
### Contact: admin@wavejs.com
#
###script start:
if [ "$#" -lt "1" ];then
	echo -e "\033[31mProvide single parameter for port number,Exiting!\033[0m"
	exit 1
elif [ "$#" -gt "1" ];then
	echo -e "\033[31mThis program only accept one parameter,Exiting\033[0m"
	exit 1
else 
	echo -e "\033[32mPassed parameter checking,proceeding!\033[0m"
fi
#parameter amount checking

if [ -e "${HOME}/install" ];then
	rm -rf "${HOME}/install"
	mkdir "${HOME}/install"
else 
	mkdir "${HOME}/install"
fi
#creating install tmp file and log file directory

if [ `which wget` == "" ];then
	yum install -y wget
fi

if [ `which iptables` == "" ];then
	yum install -y iptables
fi
#install wget&iptables if not exist

firewalld_status=$(systemctl status firewalld | grep "Active" |awk -F " " '{print $2}')
if [ "${firewalld_status}" == "active" ];then
	systemctl stop firewalld
	systemctl disable firewalld
	echo "firewalld.service current active and now be disabled and stopped" >> "${HOME}/install/install.log"
else 
	echo "firewalld.service already disabled or not installed" >> "${HOME}/install/install.log"
fi
##disabled firewalld on Centos7

yum install -y python-setuptools m2crypto && easy_install pip
pip install shadowsocks

#install shadowsocks
port_num=${1}
for current_port in $(seq 1 ${port_num});do
        read -p "Password for port ${current_port} : (example:mypassword) " password[current_port]
        read -p "Specify port ${current_port} :(example:8388) " port[current_port]
done
#read port number and password for each port

ipaddr=$(`which ip` addr |grep -a1 "eth0" |grep "inet" |awk -F " " '{print $2}' |cut -d "/" -f1)
echo "${ipaddr}" >> "${HOME}/install/install.log"
#get ip address
if [ -f "/etc/shadowsocks.json" ];then
        rm -f /etc/shadowsocks.json
fi
touch /etc/shadowsocks.json
echo -e "{\n\"server\":\"${ipaddr}\",\n
        \"port_password\":{\n" >> /etc/shadowsocks.json
if [ "${port_num}" -gt "1" ];then
        for port in $(seq 1 ${port_num});do
                if [ "${port}" == "${port_num}" ];then
                        echo -e "\"${port[port]}\":\"${password[port]}\"\n},\n" >> /etc/shadowsocks.json
                else
                        echo -e "\"${port[port]}\":\"${password[port]}\",\n" >> /etc/shadowsocks.json
                fi
        done
elif [ "${port_num}" == "1" ];then
                echo -e "\"${port[1]}\":\"${password[1]}\"\n},\n" >> /etc/shadowsocks.json
else
        echo -e "\033[32mconfig file ready!\033[0m"
fi
echo -e "\"timeout\":400,\n
        \"method\":\"rc4-md5\",\n
        \"fast_open\":false\n 
        }" >> /etc/shadowsocks.json
#create config file for starting shadowsocks
easy_install supervisor
if [ ! -e "/etc/supervisord.d" ];then
	mkdir "/etc/supervisord.d"
fi
#install supervisor

wget -O /etc/supervisord.d/shadowsocks.conf  https://wavejs.com/shadowsocks.conf --no-check-certificate
echo_supervisord_conf > /etc/supervisord.conf
echo -e "[include]\nfiles = /etc/supervisord.d/*.conf" >> /etc/supervisord.conf
#download config file for supervisor on shadowsocks

wget -O /usr/lib/systemd/system/supervisord.service https://wavejs.com/supervisord.service --no-check-certificate
systemctl enable supervisord.service
systemctl start supervisord.service
#enable supervisor to start with system

supervisord
supervisorctl reload
#reload config file for supervisor on shadowsocks

ulimit -n 51200
echo -e "root soft nofile 51200\nroot hard nofile 51200" >> /etc/security/limits.conf
wget -O /etc/sysctl.conf.example https://wavejs.com/sysctl.conf.example --no-check-certificate
cat /etc/sysctl.conf.example >> /etc/sysctl.conf
modprobe tcp_hybla
sed -i 's/tcp_congestion_control = htcp/tcp_congestion_control = hybla/g' /etc/sysctl.conf
sysctl -p
#optimize kernel parameters

yum groupinstall -y "Development Tools"
wget -O "${HOME}/install/LATEST.tar.gz" https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
cd "${HOME}/install"
tar zxf LATEST.tar.gz
cd libsodium*
./configure
make&&make install
echo "/usr/local/lib" > /etc/ld.so.conf.d/usr_local_lib.conf
ldconfig
#switch to chacha20

sed -i 's/method\":\".*\"/method\":\"chacha20\"/' /etc/shadowsocks.json
sed -i "s/false/true/i" /etc/shadowsocks.json

supervisorctl start shadowsocks
 
for port in $(seq 1 ${port_num});do
	iptables -A INPUT -p tcp -dport ${port[port]} -j ACCEPT 
done
systemctl restart iptables

iptables -L -n |grep -a5 "INPUT" >> "${HOME}/install/install.log"

echo -e "\033[32mShadowsocks Installation Succeeded!"
