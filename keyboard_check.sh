#! /bin/bash
# Author : admin@wavejs.com 
# Purpose : check keyboard functionality
while true
do 
    time=1
    while (( $time <= 3 ))
    do 
        read -n1 -sp "Type in the key you want to test: "
        echo 
        echo -e "The input key is: $REPLY"
        is_set="not_set"
        while [ "$is_set" == "not_set" ]
        do
            read -sp "Is this correct? [yes|no]: " is_correct
            case "$is_correct" in
                no|NO)
                    is_correct="no"
                    is_set="set"
                ;;
                yes|YES)
                    is_correct="yes"
                    is_set="set"
                ;;
                *)
                    echo
                    echo -e "Usage: input must be yes or no all in lower case! \n"
                ;;
            esac
        done
        if [ "$is_correct" == "no" ]
        then
            echo -e "${time}th test for key $REPLY failed,please retry!\n"
            time=$(echo "$time + 1 " | bc)
            continue
        else 
            break
        fi
    
        if [ "$time" == 3 ]
        then
            echo -e "The key : $REPLY is not functioning correctly,please contact help!\n"
        else
            echo
            echo -e "Key check completed!"
        fi
        echo "=============================================="
        echo 
        echo
    done
done         
