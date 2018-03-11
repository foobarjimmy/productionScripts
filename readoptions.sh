#! /bin/bash
echo "Username and password"

read -n4 -p "Username : " username
read -n1 -p "Password : " password
echo
echo "Your username is : $username , your password is : $password" 
exit 0
