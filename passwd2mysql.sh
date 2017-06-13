#! /bin/bash
# add mysql user from passwd file
file=/etc/passwd
filelist=$(cat "$file" | cut -d: -f1)
for user in ${filelist}
do
	echo "DROP USER '$user'@'localhost';"|mysql
done

echo "SELECT user,host FROM mysql.user;"|mysql
