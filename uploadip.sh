#! /usr/bin/env bash
# used for upload public ip address to master proxy server

# find public ip address of local network
public_ip=$(curl --retry 10 -m 1 ipinfo.io/ip)

# upload via ssh
ssh admin@wavejs.com "echo $public_ip > /tmp/trustedip"
