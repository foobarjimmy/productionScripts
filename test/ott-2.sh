#! /bin/bash
# written by jim.li@20170425

function printit() {
	echo -n "Your Choice is:"
}


read -p "Input one word from one|two|three :" word
case ${word} in 
"one")
	printit;echo "one!"|tr 'a-z' 'A-Z'
;;
"two")

	printit;echo "two!"|tr 'a-z' 'A-Z'
;;
"three")
	printit;echo "three!"|tr 'a-z' 'A-Z'
;;
*)
	echo "Usage: one|two|three"
;;
esac
