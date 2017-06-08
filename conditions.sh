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

empty="hello world"
if [ -z "${empty}" ]
then 
	echo "variable is empty"
else 
	echo "variable is set to ${empty}"
fi

if [ "${empty}" == "" ]
then
	echo "Our variable is empty"
else 	
	echo "Our variable is set to ${empty}"
fi

if [ "2" -lt "1" ]
then 
	echo "2 is greater than 1"
else 
	echo "I'm the second option"
fi

mystring="jim li"
# bash double [
if [[ $mystring == "jim li" ]]
then
	echo "My string is $mystring"
else 	
	echo "This is not gonna happen!"
fi
# old linux [
if [ $mystring == "" ]
then 
	echo "This is not gonna happen! It would error out brefre"
fi

if [[ "$mystring" == *im* ]]
then 
	echo "I am still jimmy"
else 
	echo "I am not jimmy anymore"
fi

if [[ "$mystring" == [Jj]im* ]]
then 
	echo "globbing and wildcard is working as expected!"
else 
	echo "globbing is not  working"
fi

if [ -a *.txt ]
then
	echo "do something"
fi

if [[ -a *.txt ]]
then
	echo "This is a second test for -a flag"
else 
	echo "No file named *.txt!"
fi

if [[ 2 == 1 && 2 == 2 ]]
then 
	echo "This condition is true"
else 
	echo "This condition is false"
fi

