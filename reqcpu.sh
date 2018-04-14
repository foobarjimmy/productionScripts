#! /bin/bash
CPU_CORE=$(grep -c name /proc/cpuinfo )
if (( $CPU_CORE < 4 ));then
    echo "At least four core in needed for further job"
    echo "You have a cpu of $CPU_CORE core(s)!"
    exit 1
else 
    echo "You have reached the minimum requirement!"
    exit 0
fi
     
