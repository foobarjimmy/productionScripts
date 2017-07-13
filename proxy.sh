#! /bin/bash
function menu {
	echo ""
	echo "++++++++++++++++++++++++++++++++++++++++++++"
	echo "+++++proxychain applications version1.0+++++"
	echo "++++++++++++++++++++++++++++++++++++++++++++"
	echo "[1] Add Proxychain"
	echo "[2] Start Proxychains" 
	echo "[3] Exit"
	read -p "Please select an option : " option
}

function input {
	read -p "Input Type of Proxy : " type
        read -p "Input Proxy IP Address : " ip_addr
        read -p "Inport Proxy Port : " port
        if [ ! -z "${type}" ]&&[ ! -z "${ip_addr}" ]&&[ ! -z "${port}" ]
	then
		echo -e "${type}\t${ip_addr}\t${port}" >>proxychains.conf
	else
		input	
	fi
}

function start {
	echo "proxychains firefox"
}

function terminate {
 	if [ -z "$(pgrep firefox)" ]
	then
		echo -e "Goodbye\n"
		sleep 1
		end_script=1
		exit 0
	else
		echo -e "Terminating firefox!\n"
		pkill firefox
		echo "Goodbye"
		end_script=1
		exit 0
	fi
}

end_script=0
while [ "${end_script}" != 1 ];do
	menu
	current_stage=${option}
	case ${option} in
		1)
			input
		;;
		
		2) 
			start
		;;

		3) 
			terminate
			exit 0
		;;
					
		*)
			echo "unknown usage!"
		;;
	esac
done
