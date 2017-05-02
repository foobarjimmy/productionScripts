#! /bin/bash
# written by jim.li @ 20170424
if [ "`netstat -tuln | grep ":80"`" != "" ];then
	echo "webserver is alive now:port 80 listening!"
else 
	echo "webserver is not active now" 
fi
if [ "`netstat -tuln | grep ":21"`" != "" ];then
	echo "ftp is alive now:port 21 listening!"
else 
	echo "ftp is not active now" 
fi
if [ "`netstat -tuln | grep ":25"`" != "" ];then
	echo "mailserver is alive now:port 25 listening!"
else 
	echo "mailserver is not active now" 
fi
if [ "`netstat -tuln | grep ":22"`" != "" ];then
	echo "ssh is alive now:port 22 listening!"
else 
	echo "Secure shell is not active now" 
fi
