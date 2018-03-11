<<<<<<< HEAD
#! /bin/bash 
if [ ! -r "$1" ];then
    echo "\033[31mUsage: $0 server_list.txt\033[0m"
fi

while read server;do
    ping -c1 "$server" && "$server is alive" || "$server is down!"done
=======
#! /bin/bash
read -p "Please provide server address: " server_addr
echo
ping $server_addr -c3 2>&1 > /dev/null || echo "server is dead!"

>>>>>>> e665b9df0398747ad3a73d078bd961175e71b245
