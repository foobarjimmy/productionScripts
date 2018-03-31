#! /bin/bash
usage="Usage:$0 file(fullpath) string operation(c|p|v)"

if [ ! $# = 3 ];then
    echo $usage
fi

[ ! -f "$1" ] && exit 1

case $3 in
    [cC])
        echo "exporting counts of $2 in $1"
        opt="-c"
    ;;
    [pP])
        echo "exporting exact finding of $2 in $1"
        opt=""
    ;;
    [vV])
        echo "exporting all lines but those of $2 in $1"
        opt="-v"
    ;;
    *)
        echo "Wrong format!"
        echo $usage
    ;;
esac

#echo $opt
grep "$opt" $2 "$1"
