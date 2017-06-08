#! /bin/bash
# do loop with sql statement
for file in `ls`
do 
	echo "The filename is $file"
done
for db in `echo "show databases"|mysql`
do 	
	for table in `echo "use $db;show tables"|mysql`
	do
		echo "${db} contains ${table}"
	done
done
