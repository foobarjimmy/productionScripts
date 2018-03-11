#! /bin/bash
read -p "Database username : " username
read -s -p "Database password : " password 
read -p "Database execute commands : (end with ;)" cmd

mysql -u $username -p$password -e "$cmd" 
