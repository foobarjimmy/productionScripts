#! /bin/bash
# written by jim.li
echo "This program calculates the summary from 1 to the num you input : "
read -p "Input the num after : " number
sum=0
i=0
while [[ "${i}" < "${number}" ]]
do
i=$((${i}+1))
sum=$((${i}+${sum}))
done
echo "${sum}"
