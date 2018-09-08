#! /usr/bin/env bash
# used for upload public ip address to master proxy server

# find public ip address of local network
telcom_ip=$(curl --retry 10 -m 1 ipinfo.io/ip)

ssh root@10.0.1.1 "cat /tmp/ff" > /tmp/chmobi.ip
chmobi_ip=$(cat /tmp/chmobi.ip)

ssh admin@wavejs.com "touch /tmp/uploadip &> /dev/null"

for ip in $telcom_ip $chmobi_ip
    # upload via ssh
    do 
        echo $ip
        ssh admin@wavejs.com "echo $ip >> /tmp/uploadip"
done
