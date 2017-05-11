#!/bin/bash
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
fi
done

case ${1} in
enable)
        echo -e "\033[032mcreating symbolic link & downloading essential files\033[0m"
        wget --no-check-certificate -P . https://wavejs.com/ssautoupdate.sh
        sed -i "s/WEBROOT/\\$webroot/i" ./ssautoupdate.sh
;;
*)
	echo -e "\033[32mscript ended successfully!\033[0m"
;;
esac
