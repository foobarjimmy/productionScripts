#!/bin/bash
# written in shell
# written by jim.li
PATH="${PATH}:/Users/student/Desktop"
export PATH
if [ $1 ]&&[ $1 != "one" ];then
	echo -e "jim's first shell script with arguments:$1"
	exit 0
elif [[ $1 == "one" ]];then
	echo -e "The argument you input is one\n"
	exit 0
else
	echo "No argument detected,EXIT!"
	exit 1
fi
