#! /bin/bash
# This program is used to add mysql user with a file containing user name
if [ "$#" == "0" ];then
	echo "Commands for the script"
	echo "showdb - lists databases on the mysql system"
	echo "create - creates user and databses based off namefile"
	echo "delete - drops and deletes users/databses"
	echo "showusers - shows listed user in database"
	exit 0 
fi

function create_mysql_users {
	for user in $filelist
	do
		echo "CREATE DATABASE $user;"|mysql
		echo "CREATE USER '$user'@'localhost' IDENTIFIED BY 'expo2010';"|mysql
	done
}

function delete_mysql_users {
	for user in $filelist
	do 
		echo "DROP DATABASE $user;"|mysql
		echo "DROP USER '$user'@'localhost';" | mysql
	done	
} 

function show_db {
	echo "SHOW DATABASES;"|mysql
}

function show_users {
	echo "SELECT user,host FROM mysql.user;"|mysql
}

file=$1
action=$2

if [ -f "$file" ];then
	filelist=`cat $file`
else 
	echo "failed to read name file!"
fi

case $action in 
	showdb)
		show_db
	;;
	showusers)
		show_users
	;;
	create)
		create_mysql_users
	;;
	delete)
		delete_mysql_users
	;;
	*)
		echo "Usage $0 [file-path] [create|delete|showdb|showusers] "
		exit 1
	;;
esac

	
