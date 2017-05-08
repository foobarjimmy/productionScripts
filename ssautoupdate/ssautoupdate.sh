#! /bin/bash
# Porgram:starting autoupdate
cd /tmp
[ -e /tmp/autodownload ]&&rm -rf /tmp/autodownload
mkdir /tmp/autodownload
cd /tmp/autodownload

`which curl` -o release.html https://github.com/shadowsocks/shadowsocks-windows/releases
cat release.html | grep -a2 "release-downloads"|grep "shadowsocks"|sed "s/<a href=\"\(.*zip\)\".*\">/\1/" |sed "s/ //g"|sed "s/^\//http:\/\/github.com\//g">downloadlist.txt
filelist=$(cat downloadlist.txt)
for link in ${filelist};do
	wget "${link}";
done
zip "Shadowsocks_wavejs_$(date +20%y%m%d).zip" /tmp/autodownload/*.zip
mv /tmp/autodownload/Shadowsocks_wavejs.zip "WEBROOT"
