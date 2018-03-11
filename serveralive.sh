#! /bin/bash 
if [ ! -r "$1" ];then
    echo "\033[31mUsage: $0 server_list.txt\033[0m"
fi

while read server;do
    ping -c1 "$server" && "$server is alive" || "$server is down!"done
