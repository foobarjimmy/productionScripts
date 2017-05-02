#! /bin/bash
# written by jim.li
echo -e "\033[1;31mThis program will decide what game to play today!\033[0m"
list[1]="賣噹噹漢堡"       # 收集到的店家！
list[2]="肯爺爺炸雞"
list[3]="彩虹日式便當"
list[4]="越油越好吃大雅"
list[5]="想不出吃啥學餐"
list[6]="太師父便當"
list[7]="池上便當"
list[8]="懷念火車便當"
list[9]="一起吃泡麵"
for ((i=1;i<=3;i++));do
	while [ "${shop[${i}]}" == "" ];do
		declare -i random=$((${RANDOM}*9/32767+1))
		shop[${i}]=${list[${random}]}
		list[${random}]=""
	done
	echo "${shop[${i}]}"
done
