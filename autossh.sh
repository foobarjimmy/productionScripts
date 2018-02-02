#! /bin/bash
read -p "SSH username : " username
read -p "SSH host : " host
read -s -p "SSH password : " password

ssh $username@$host -p 22 
