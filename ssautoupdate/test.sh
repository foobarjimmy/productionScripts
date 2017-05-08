#!/bin/bash
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
echo ${webroot}
