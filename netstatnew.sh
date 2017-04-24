#! /bin/bash
# written by jim.li
testfile=/root/Shell-Script/result.txt
echo "`netstat -tuln`" >> ${testfile}
if [ `grep ":80" "${testfile}"`]
