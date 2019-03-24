#!/bin/bash


#if-then语句
var=9
if [ $var -lt 0 ]
then echo "$var小于0"
else echo "$var大于0"
fi >> test.out

#for语句
for file in /home/daisx/downloads/*
do
	if [ -d $file ] 
	then
		echo "$file is  a directory"
        elif [ -f $file ]
	then
		echo "$file is a file"
	fi	
done

#c-for语句
for (( i=1 , j =9 ; i<10 ; i++,j--))
do
	echo "This is part$i || part $j"
done

#while语句
var=3
while echo $var
	[ $var -gt 0 ]
do
	var=$[ $var -1 ]
	echo "test$var"
done

#until语句 
var=3
until [ $var -eq 0 ]
do
	var=$[ $var -1 ]
	echo $var
done

#while和until嵌套语句
var=0
while [ $[ $var - 9 ] -lt 5 ]
do
	echo "while的第$var次循环"
	until [ $[ $var - 9 ] -gt 5 ]
	do 
		echo "until的第$var次循环"
		var=$[ $var + 1 ]
	done
done >> test.out






