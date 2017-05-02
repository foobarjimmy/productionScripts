port_num=${1}
for current_port in $(seq 1 ${port_num});do
        read -p "Password for port ${current_port} : (example:mypassword) " password[current_port]
        read -p "Specify port ${current_port} :(example:8388) " port[current_port]
done
#read port number and password for each port

ipaddr=$(`which ip` addr |grep -a1 "eth0" |grep "inet" |awk -F " " '{print $2}' |cut -d "/" -f1)
echo "${ipaddr}" >> "${HOME}/install/install.log"
#get ip address
if [ -f "/etc/shadowsocks.json" ];then
        rm -f /etc/shadowsocks.json
fi
touch /etc/shadowsocks.json
echo -e "{\n\"server\":\"${ipaddr}\",\n
        \"port_password\":{\n" >> /etc/shadowsocks.json
if [ "${port_num}" -gt "1" ];then
        for port in $(seq 1 ${port_num});do
                if [ "${port}" == "${port_num}" ];then
                        echo -e "\"${port[port]}\":\"${password[port]}\"\n},\n" >> /etc/shadowsocks.json
                else
                        echo -e "\"${port[port]}\":\"${password[port]}\",\n" >> /etc/shadowsocks.json
                fi
        done
elif [ "${port_num}" == "1" ];then
                echo -e "\"${port[1]}\":\"${password[1]}\"\n},\n" >> /etc/shadowsocks.json
else
        echo -e "\033[32mconfig file ready!\033[0m"
fi
echo -e "\"timeout\":400,\n
        \"method\":\"rc4-md5\",\n
        \"fast_open\":false\n 
        }" >> /etc/shadowsocks.json
#create config file for starting shadowsocks
