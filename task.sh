#! /bin/bash

dbname="task"
table_layout="(id int not null auto_increment primary key,name varchar(255),description text)"
action=$1
list_name=$2
name=$3
id=$4
desc=$5

if [ $# -lt 1 ]
then

echo "*************************************"
echo "Task application by jim li"
echo "*************************************"
echo ""
echo "  Usage:"
echo "  task (new-list|del-list|add|del|ls)"
echo "  new-list: Create a new list"
echo "  del-list: Delete a list and all tasks in the list"
echo "  add: task add list_name task_name task_description - creates a enw task"
echo "  del: task del list_name task_id - deletes a working task"
echo "  ls: task ls - lists tasks,task ls list_name - lists tasks in a list"
echo ""
echo ""
echo ""
fi

function create_list {
	echo "CREATE TABLE ${list_name}${table_layout};" |mysql $dbname
}

function delete_list {
	echo "DROP TABLE ${list_name};" |mysql $dbname
}

function add_task {
	echo "INSERT INTO ${list_name} (name,description) VALUES ('$name','$desc');" | mysql $dbname
}

function del_task {
	echo "DELETE FROM ${list_name} WHERE name='$name';" | mysql $dbname
}

function list_task {
	if [ "$list_name" == "" ]
	then
		echo "SHOW TABLES;" | mysql $dbname
	else 
		echo "SELECT * FROM $list_name;" | mysql $dbname
	fi
}

case $action in
	new-list)
		create_list
	;;
	del-list)
		delete_list
	;;
	add)
		add_task
	;;
	del)
		del_task
	;;
	ls)
		list_task
	;;
	*)
		exit 1
#		echo "Usage:$0 [new-list|del-list|add|del|ls] [list_name]"
	;;
esac
