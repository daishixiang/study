#!/bin/bash

#array(){
#local newarr
#newarr=($(echo "$@"))
#echo "new : ${newarr[*]}"
#}

#oldarr=(1 2 3 4 5 6)
#echo "old : ${oldarr[*]}"
#array ${oldarr[*]}


function fact {
if [ $1 -eq 1 ]
then
	echo 1
else
	local temp=$[ $1 - 1 ]
	local result=$(fact $temp)
	echo $[ $result * $1 ]
fi
}
read -p "Enter value :" value
result=$(fact $value)
echo "$result"


