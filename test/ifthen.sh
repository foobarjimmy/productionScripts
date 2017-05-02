#! /bin/bash
# written by jim.li@20170424
read -p "Input Y/y or N/n to get an answer:" yn
if [ "${yn}" == "Y" -o "${yn}" == "y" ];then
	echo "You have input a yes sign!"
	exit 0
fi
if [ "${yn}" == "N" -o "${yn}" == "n" ];then
	echo "Interrupt!"
	exit 1
fi
