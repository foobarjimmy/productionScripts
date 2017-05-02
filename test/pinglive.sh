#! /bin/bash
# written by jim.li@20160425
echo -e "This is a program used for ping hosts"
sec1=192.168.1
for sec2 in {1..10}
do
	ipaddr="${sec1}.${sec2}"
	ping -c 1 -w 1 "${ipaddr}" &> /dev/null && result=0 || result=1
if [ "${result}" == "0" ];then
	echo "Server ${ipaddr} is alive!"
else 
	echo -e "\033[1;31mServer ${ipaddr} is down!\033[0m"
fi
done
