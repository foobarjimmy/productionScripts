#! /bin/bash
# written by jim.li@20170425
read -p "Input one word from one|two|three :" word
case ${word} in 
"one")
	echo "Your word is ONE!"
;;
"two")
	echo "Your word is TWO!"
;;
"three")
	echo "Your word is THREE!"
;;
*)
	echo "Usage: one|two|three"
;;
esac
