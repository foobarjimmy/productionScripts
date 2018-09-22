#! /bin/bash

# Color definitions
GREEN="\033[032m"
RESET="\033[0m"
RED="\033[031m"
ALERT="\033[033m"

# Command alias
ECHO="echo -e"

# Funtion definitions
function echo_green () {
	$ECHO "${GREEN}$1${RESET}"
}

function echo_red () {
	$ECHO "${RED}$1${RESET}"
}

function echo_alert () {
	$ECHO "${ALERT}$1${RESET}"
}
# Distribution type && version
function dist_ver_check () {
	echo_green "System Info:"
	echo $(cat /etc/*-release)
	echo 
}

# Kernel version
function kernel_ver_check () {
	echo_green "Kernel Version:"
	cat /proc/version
	echo
	echo_green "Platform Info:"
	uname -a
	echo
	echo_green "Currently Installed Kernel:"
	rpm -q kernel
	echo
	echo_green "Dmesg Info:"
	dmesg | grep Linux
	echo
	echo_green "Kernel Boot Info:"
	ls /boot | grep vmlinuz- | grep -v rescue
}
# Information in environmental variables
function env_check () {
	echo_green "Environmental Variables:"
	cat /etc/profile
	cat /etc/bashrc
	cat ~/.bash_profile
	cat ~/.bashrc
	cat ~/.bash_logout
	env
	set
	echo
}

# Check if there is a printer 
function lpstat_check () {
	ifprinter=$(lpstat -a | grep "accepting requests")
	if [ "${ifprinter}" != "" ]
	then
		echo_green "Found Printers:"
		for printer in $(echo $ifprinter | cut -d" " -f1)
		do	
			echo $printer
		done
	else
		echo_red "No Printers Found!"
	fi
	echo 
}

# Running services with root privileges
function ps_check () {
	ps -ef | grep root
	# or ps aux | grep root
}

# Find installed applications,state and version 
function serv_check () {
	echo_green "Applications && States Check:"
	PKGMGR=$(which yum;which apt)
	if [[ 'echo "$PKGMGR" | grep yum' ]];then
		rpm -qa
		ls -alh /var/cache/yum/
	elif [[ 'echo "$PKGMGR" | grep apt' ]]; then
		dpkg -l
		ls -alh /var/cache/apt/archivesO
	else 
		echo_alert "Not supported yet!"
	ls -alh /usr/bin/
	ls -alh /sbin/
	echo
	fi
}

# Cron check
function cron_check () {
	echo_green "Cron States Check:"
	crontab -l
	ls -alh /var/spool/cron
	ls -al /etc/ | grep cron
	ls -al /etc/cron*
	cat /etc/cron*
	cat /etc/at.allow
	cat /etc/at.deny
	cat /etc/cron.allow
	cat /etc/cron.deny
	cat /etc/crontab
	cat /etc/anacrontab
	cat /var/spool/cron/crontabs/root
	echo
}

# Plain text username/password
function plaintext_check () {
	echo_green "Plain Text Username&Password:"
	grep -i user $1
	grep -i pass $1
	grep -C 5 "password" $1
	find . -name "*.php" -print0 | xargs -0 grep -i -n "var $password"
	echo
}

# Communications & Networking
# Nic Info
function ifdev_check () {
	echo_green "If Device(s) Info:"
	/sbin/ifconfig -a
	cat /etc/network/interfaces
	cat /etc/sysconfig/network
	echo
}

# Network configuration settings
function net_info_check () {
	echo_green "Network configuration settings:"
	cat /etc/resolv.conf
	cat /etc/sysconfig/network
	cat /etc/networks
	iptables -L -n
	hostname
	dnsdomainname
	echo
}

# Users & hosts communicating with the system
function comm_inter_check () { 
	echo_green "Users & Hosts Communicating with the System:"
	lsof -i
	lsof -i :80
	grep 80 /etc/services
	netstat -antup
	netstat -antpx
	netstat -tulpn
	chkconfig --list
	chkconfig --list | grep 3:on
	last
	w
}

# Cached IP and/or MAC addresses
function arp_check () {
	arp -e
	route
	/sbin/route -nee
}

# Confidential Information & Users
function user_can_do_check () {
	echo_green "Users and Their Privileges:"
	id
	who
	w
	last
	cat /etc/passwd | cut -d: -f1    # List of users
	grep -v -E "^#" /etc/passwd | awk -F: '$3 == 0 { print $1}'   # List of super users
	awk -F: '($3 == "0") {print}' /etc/passwd   # List of super users
	cat /etc/sudoers
	sudo -l
}

# Sensitive files
function sensi_file_check () {
	echo_green "Sensitive File Check:"
	cat /etc/passwd
	cat /etc/group
	cat /etc/shadow
	ls -alh /var/mail/
}

# History check 
function hist_check () {
	echo_green "Current User's History:"
	cat ~/.bash_history
	cat ~/.nano_history
	cat ~/.atftp_history
	cat ~/.mysql_history
	cat ~/.php_history
}

# Private-key information

function priv_key_check () {
	echo_alert "Priv Key File(s) Can be Read/Written:"
	hssh="~/.ssh/"
	gssh="/etc/ssh/"
	for file in $(ls $1)
	do
		if [ -f "$file" -a ( -w "$file" -o -r "$file" ) ]
		do
			echo_alert "${1}$file"
			cat "${1}$file"
		fi
	done
}	

# File Systems
# Configuration files can be written in /etc/?
# Able to reconfigure a service?
function conf_check () {
	echo_alert "Possible Exploit in Config Files:"
	ls -aRl /etc/ | awk '$1 ~ /^.*w.*/' 2>/dev/null     # Anyone
	ls -aRl /etc/ | awk '$1 ~ /^..w/' 2>/dev/null       # Owner
	ls -aRl /etc/ | awk '$1 ~ /^.....w/' 2>/dev/null    # Group
	ls -aRl /etc/ | awk '$1 ~ /w.$/' 2>/dev/null        # Other
	echo_alert "Readable by Everyone:"
	find /etc/ -readable -type f 2>/dev/null               # Anyone
	find /etc/ -readable -type f -maxdepth 1 2>/dev/null   # Anyone
}


function log_check () {
	echo_alert "Log File Readability:"
	list="
 /etc/httpd/logs/access_log
 /etc/httpd/logs/access.log
 /etc/httpd/logs/error_log
 /etc/httpd/logs/error.log
 /var/log/apache2/access_log
 /var/log/apache2/access.log
 /var/log/apache2/error_log
 /var/log/apache2/error.log
 /var/log/apache/access_log
 /var/log/apache/access.log
 /var/log/auth.log
 /var/log/chttp.log
 /var/log/cups/error_log
 /var/log/dpkg.log
 /var/log/faillog
 /var/log/httpd/access_log
 /var/log/httpd/access.log
 /var/log/httpd/error_log
 /var/log/httpd/error.log
 /var/log/lastlog
 /var/log/lighttpd/access.log
 /var/log/lighttpd/error.log
 /var/log/lighttpd/lighttpd.access.log
 /var/log/lighttpd/lighttpd.error.log
 /var/log/messages
 /var/log/secure
 /var/log/syslog
 /var/log/wtmp
 /var/log/xferlog
 /var/log/yum.log
 /var/run/utmp
 /var/webmin/miniserv.log
 /var/www/logs/access_log
 /var/www/logs/access.log
 /var/lib/dhcp3/
 /var/log/postgresql/
 /var/log/proftpd/
 /var/log/samba/
"
	if [[ -e "$target" ]]; do
		if [[ -f "$target" ]];do
			cat "$target"
		elif [[ -d "$target" ]]; then
			ls -alh "$target"
		else
			echo_alert "Error!"
		fi
	done
}

# File system check
function filesys_check () {
	echo_green "Filesystem Info:"
	mount
	df -hm
	cat /etc/fstab
}

# Advanced Linux File Permissions 
# Sticky bits, SUID & GUID
function fd_permission_check () {
	echo_alert "Sticky Bit Folders:"
	find / -perm -1000 -type d -exec ls -alt {} \; 2>/dev/null   # Sticky bit - Only the owner of the directory or the owner of a file can delete or rename here.
	echo_alert "SGID Programmes:"
	find / -perm -g=s -type f -exec ls -alt {} \; 2>/dev/null    # SGID (chmod 2000) - run as the group, not the user who started it.
	echo_alert "SUID Programmes:"
	find / -perm -u=s -type f -exec ls -alt {} \; 2>/dev/null   # SUID (chmod 4000) - run as the owner, not the user who started it.

	# find / -perm -g=s -o -perm -u=s -type f 2>/dev/null -exec ls -alt {} \;   # SGID or SUID
	echo_alert "Quick Search for Common bin locations for SUID/SGID executables:"
	for i in `locate -r "bin$"`; do find $i \( -perm -4000 -o -perm -2000 \) -type f 2>/dev/null; done    # Looks in 'common' places: /bin, /sbin, /usr/bin, /usr/sbin, /usr/local/bin, /usr/local/sbin and any other *bin, for SGID or SUID (Quicker search)

	# find starting at root (/), SGID or SUID, not Symbolic links, only 3 folders deep, list with more detail and hide any errors (e.g. permission denied)
	# find / -perm -g=s -o -perm -4000 ! -type l -maxdepth 3 -exec ls -ld {} \; 2>/dev/null
	echo_alert "Problematic Permissions:"
	find / -writable -type d -exec ls -alt {} \; 2>/dev/null      # world-writeable folders
	find / -perm -222 -type d -exec ls -alt {} \; 2>/dev/null     # world-writeable folders
	find / -perm -o w -type d -exec ls -alt {} \; 2>/dev/null     # world-writeable folders

	find / -perm -o x -type d -exec ls -alt {} \; 2>/dev/null     # world-executable folders

	find / \( -perm -o w -perm -o x \) -type d -exec ls -alt {} \; 2>/dev/null   # world-writeable & executable folders
	find / -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -print   # world-writeable files
	find /dir -xdev \( -nouser -o -nogroup \) -print   # Noowner files
}
