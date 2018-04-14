# function check_cpu_core
check_cpu_core () {
    CPU_Core=$(grep -c name "/prc/cpuinfo" > /dev/null )
    if (( $CPU_Core < 4 ));then 
        echo "you have $CPU_Core core(s).This program requires at least 4 cores"    
        exit 1
    else 
        echo "core number check succeeded"
        exit 0
    fi
}
