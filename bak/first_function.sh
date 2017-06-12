#! /bin/bash
input=$1
input2=$2

function first_function {
	echo "This is the first function"
}

function second_function {
	echo "This is the second function"
}

function input_function {
	echo "This is the parameter you input $1"
}

input_function input
input_function "$input"
