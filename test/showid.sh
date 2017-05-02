#! /bin/bash
### Program:display user's id info 
for info in $(cat /etc/passwd|cut -d":" -f1)
do
	echo "`id "${info}"`"
done
