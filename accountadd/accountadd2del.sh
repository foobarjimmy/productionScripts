#! /bin/bash 
# Program:Creating users using accountadd.txt 
# Author: Jim.li
# Time: Fri 11:29 0505-2017
# Write for zabbix server account adding

if [ "${#}" == "0" ];then
	echo -e "Usage: ${0} add list.txt]"
