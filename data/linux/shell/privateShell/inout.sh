#!/bin/bash
#count=1
#for var in "$@"
#do
#	echo param$count= $var
#	count=$[ $count + 1 ]
#done
#c=1
#for v in "$*"
#do
#	echo para$c= $v
#	c=$[ $c + 1 ]
#done

#echo ${!#}


#while [ -n "$1" ]
#do
#	case "$1" in 
#		-a) echo "found the -a option";;
#		-b) echo "found the -b option";;
#               -c) echo "found the -c option";;
#                 *) echo "$1 not a option";;
#	 esac
#	 shift
# done

#echo
# while getopts ab:c opt
# do 
#	 case "$opt" in 
#		 a) echo "-a option";;
#		 b) echo "-b option";;
#		 c) echo "-c option";;
#		 *) echo "not found";;
#	 esac
# done


echo -n "Enter your name : "
read -t 10 name;
echo "Hello! $name"

read -p -t 5 "Enter your name :" dai
echo "$name love $dai"


