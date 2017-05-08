#! /bin/bash
# Program: Used for updating shadowsocks client to the lastest version
if [ "$#" != "1" ];then
	echo -e "\033[31mOnly accept one parameter[enable|disable]\033[0m"
	exit 1
fi
echo -e "\033[32mShadowsocks autoupdate utility\033[0m"
webroot="/root/notgonnaexist"
isexist=0
while [ "$isexist" != "1" ];do
if [ -d "${webroot}" ];then
        echo -e "\033[32mWeb root directory exists!Proceed\033[0m"
        isexist=1
else
        read -p "Please provide your website root directory : " webroot
        isexist=0
	echo "${webroot}">/tmp/webroot.txt
fi
done

case $1 in
enable)
	for exec in wget curl zip;do
		yum -y install ${exec};
	done
	echo -e "\033[032mcreating symbolic link & downloading essential files\033[0m"
	wget --no-check-certificate -P /usr/lib/systemd/system/ https://wavejs.com/ssautoupdate.service
	wget --no-check-certificate -P /usr/lib/systemd/system/ https://wavejs.com/ssautoupdate.timer
	wget --no-check-certificate -P /root/ https://wavejs.com/ssautoupdate.sh
	webroot=
	sed -i "s/WEBROOT/\\$webroot/i" /root/ssautoupdate.sh
	systemctl enable ssautoupdate.service
	systemctl start ssautoupdate.service

	systemctl enable ssautoupdate.timer
	systemctl start ssautoupdate.timer
;;
disable)
	echo -e "\033[32mremoving symbolic link & deleting files\033[0m"
	systemctl stop ssautoupdate.service
	systemctl disable ssautoupdate.service
	systemctl stop ssautoupdate.timer
	systemctl disable ssautoupdate.timer
	rm -f /usr/lib/systemd/system/ssautoupdate.service /usr/lib/systemd/system/ssautoupdate.timer
	rm -f /root/ssautoupdate.sh
;;
*)
	echo -e "\033[31mInvalid option! Try [${0} enable|disable]\033[0m"
esac
