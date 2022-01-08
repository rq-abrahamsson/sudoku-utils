#!/bin/bash

function validate_input() {
	oldIFS=IFS
	IFS='.'
	read -ra newarr <<< "$1"
	IFS=oldIFS
	if [ ${#newarr[@]} == 3 ] && [ ${newarr[0]} -gt -1 ] && [ ${newarr[1]} -gt -1 ] && [ ${newarr[2]} -gt -1 ]
	then
		return
	else
		echo "Error: Version should be in the format x.y.z where x, y and z are numbers"
		exit 1
	fi
}

function step_one() {
	echo "1. Set version in 'pack.pl' file to $1, row to use:"
	echo ""
	echo "version('$1')."
	echo ""
	read -n 1
}


function step_two() {
	echo "2. commit the file 'pack.pl'"
	echo ""
	echo "git add pack.pl"
	echo "git commit -m 'New version: $1'"
	echo ""
	read -n 1
}

function step_three() {
	echo "3. Tag the commit"
	echo ""
	echo "git tag -a $1"
	echo ""
	read -n 1
}


function step_four() {
	echo "3. Push commit with tag"
	echo ""
	echo "git push --tags"
	echo ""
}

validate_input $1
step_one $1
step_two $1
step_three $1
step_four $1
echo "Done"
