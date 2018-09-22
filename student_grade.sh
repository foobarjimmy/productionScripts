#! /bin/bash
if [ ! $# -eq 2 ];then
    echo "Usage:$0 <student><grade>"
    exit 2
fi

case $2 in
    [A-C]|[a-c])
        echo "$1 did a great job this  year!"
    ;;

    [Dd])
        echo "$1 need to be a little harder"
    ;;

    [E-F]|[e-f])
        echo "$1 failed this exam!"
    ;;
esac
