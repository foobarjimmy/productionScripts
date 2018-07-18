#! /bin/bash
[ -f /tmp/seaf_report ]&&rm -f /tmp/seaf_report

# variables
rep_file=/tmp/seaf_report
is_active=$(systemctl status seafile -l | grep -o active)
is_mount=$(mount | grep seafile-data)

# online check
if [ "${is_active}" = "active" ]
then 
    cgroup=$(systemctl status seafile -l | grep -A4 CGroup)
    echo -e "Seafile-server is running: Status Active\n" >> $rep_file
    echo -e "#==================================================#\n" >> $rep_file
    echo "CGroup status :" >> $rep_file
    echo -e "$cgroup\n">> $rep_file
    echo -e "#==================================================#\n" >> $rep_file
else 
    echo "seafile-server is not running: Status Dead" >> $rep_file
    echo -e "seafile-server is offline or stopped by accident or errror\n" >> $rep_file
    echo -e "#==================================================#\n" >> $rep_file
fi
# disk usage report

if [ "${is_mount}" != "" ] 
then
    for field in $(seq 1 6)
    do
        cmd="df -h | tr -s ' '| grep seafile-data | cut -d' ' -f${field}" 
        case $field in
            1)     
                file_system=$(eval $cmd)
            ;;  
            
            2)
                total_size=$(eval $cmd)
            ;;
            
            3)
                used_size=$(eval $cmd)
            ;;
            
            4)
                available=$(eval $cmd)
            ;;
            
            5) 
                percentage=$(eval $cmd)
            ;;
            
            6)
                mount_point=$(eval $cmd)
            ;;
            
            *)
                echo "unexpected option!"
                exit 1
            ;;
        esac
    done
    echo "file_system ==========> $file_system" >> $rep_file
    echo "total_size ==========> $total_size" >> $rep_file
    echo "used_size ==========> $used_size" >> $rep_file
    echo "available_size ==========> $available" >> $rep_file
    echo "percentage ==========> $percentage" >> $rep_file
    echo -e "mount_point ==========> $mount_point\n" >> $rep_file
    echo -e "#==================================================#\n" >> $rep_file
else 
    echo "seafile server data storage is off-line now!" >> $rep_file
    echo -e "#==================================================#\n" >> $rep_file
fi

# display the last ten lines of seafile log
tail -n 10 /opt/seafile/logs/seafile.log >> $rep_file

# send an email of status to root
mail -r slireg2014@126.com -s "Seafile Server Daily Report" -q $rep_file wavejsctl@outlook.com << EOF
^D
EOF
