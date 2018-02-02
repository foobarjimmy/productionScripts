#! /bin/bash
read -p "Please provide server address: " server_addr
echo
ping $server_addr -c3 2>&1 > /dev/null || echo "server is dead!"

