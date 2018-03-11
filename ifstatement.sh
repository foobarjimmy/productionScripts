#! /bin/bash
if [ $# = 0 -o $# -gt 1 ];then
    echo "Usage: $0 <name>"
    exit 1
else
    echo "your name is $1"
    exit 0
fi
