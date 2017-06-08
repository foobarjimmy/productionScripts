#! /bin/bash
# this is a test file for bash conditions
file=./masterfile
if test -f $file 
then 
	echo "$file is a actual file"
	ls -l $file
fi

[ -f $file ] && echo "This is a file!"|| echo "This is not a file!"

if [ -f $file ]
then 
	echo "[ read as test! Third option is also a file"
fi
