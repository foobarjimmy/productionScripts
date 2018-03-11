#! /bin/bash
for user in "$*";do
   useradd "$user"
   echo "$user:PASSWORD1" | chpasswd
   passwd -e "$user"
done
