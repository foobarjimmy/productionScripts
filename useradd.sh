#! /bin/bash
# This program is used to add a list of users
file=$1
action=$2

if [ "$#" != "2" ]
then
  echo "\033[31mUsage:$0 [file-path] [add|del]\033[0m"
  exit 1
fi

if [ -e "$file" ]
then
  if [ ! -d "$file" ]
  then
    case $action in
      add)
        for line in `cat "$file"`
	  do useradd "${line}"
	done
      ;;
      del)
        for line in `cat "$file"`  
	  do userdel -r "${line}"
	done
      ;;
      *)
	 echo "Second parameter should be add/del"
    esac
  else
    echo "\033[31mThis file is a directory!\033[0m"
  fi
else
 echo "file do not exist!"
fi    

