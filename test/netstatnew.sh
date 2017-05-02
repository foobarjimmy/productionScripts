#! /bin/bash
# written by jim.li
PATH="${PATH}:/root/Shell-Script"
export PATH
testfile=/root/Shell-Script/result.txt
echo "`netstat -tuln`" >> ${testfile}
if [ "`grep ":80" ${testfile}`" ];then
	echo "webserver is running!"
else 
	echo "webserver has stopped!"
fi
if [ "`grep ":25" ${testfile}`" ];then
	echo "mailserver is running!"
else 
	echo "mailserver has stopped!"
fi
if [ "`grep ":22" ${testfile}`" ];then
	echo "secure shell is running!"
else 
	echo "secure shell has stopped!"
fi
if [ "`grep ":21" ${testfile}`" ];then
	echo "ftp is running!"
else 
	echo "ftp has stopped!"
fi
