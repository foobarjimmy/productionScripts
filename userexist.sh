#! /bin/bash
read -sp "Username: " user
if ( grep "$user" /etc/passwd > /dev/null ) ;then
    echo "The user $user exists!"
    exit 0
else 
    echo "The user $user does not exist!"
    exit 1
fi  
