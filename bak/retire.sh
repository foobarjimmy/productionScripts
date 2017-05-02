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
declare -i longsec=$(date --date="${year}${month}${day}" +%s)
declare -i shortsec=$(date +%s)
declare -i time=$((${longsec}-${shortsec}))
declare -i time_day=$((${time}/60/60/24))
if [ "$time" -lt "0" ];then
	declare -i time_day_pos=$((${time_day}*-1))
	echo "you have retired for ${time_day_pos} days"
	exit 0
else 
	declare -i time_h=$((${time}/60/60-${time_day}*24))
	echo "You will be retired within ${time_day} days and ${time_h} hours!"
fi
