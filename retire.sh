#! /bin/bash
# written by jim.li
echo -e "This program will show you how mang days left before you retire."
echo -e "####################################"
read -p "Input retire year:" year
read -p "Input retire month:" month
read -p "Input retire day:" day
if [ "`printf ${day} | wc -c `" -lt 2 ];then
	day="0${day}"
fi
if [ "`printf ${month} | wc -c `" -lt 2 ];then
	month="0${month}"
fi
echo -e "${year}${month}${day}\n"
