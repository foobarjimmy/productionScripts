#!/bin/bash
echo -e "This program will show you detail of the input"
read -p "input after :" result
test -e "${result}"&&echo "file/directory exists"||echo "file/directory doesn't exist" 
if [ -r "${result}" ];then
	isRead="Yes"
else
	isRead="No"
fi
if [ -w "${result}" ];then
	isWrite="Yes"
else
	isWrite="No"
fi
if [ -x "${result}" ];then
	isExec="Yes"
else
	isExec="No"
fi
echo -e "Premission is show below:\nRead:${isRead} \nWrite:${isWrite}\nExecutable:${isExec}"
