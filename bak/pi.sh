#!/bin/bash
echo -e "This program will calculate the value of pi\n"
echo -e "Please input number of pi\n"
read -p "The scale is better lower than 100,(1,100)" calcnum
num=${calcnum:-"10"}
time echo "scale=${num};4*a(1)"|bc -lq
