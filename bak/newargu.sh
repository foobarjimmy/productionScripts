#! /bin/bash
# written by jim.li
# initialized in version1.0 @20170424
PATH="${PATH}:/Users/student/Desktop"
export PATH
if [ "${1}" == "hello" ];then
	echo -e "Hello,how are you ?"
elif [ "${1}" != "hello" ];then
	echo -e "Only accept \"Hello\" as argument"
else
	echo -e "Argument not found!EXIT!"
fi
