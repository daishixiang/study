#!/bin/bash


function diskspace {
	clear
	df -k
}

function whoseon {
	clear
	who
}

function menuage {
	clear
	cat /proc/meminfo
}



function menu {
	clear
	echo
    	echo -e "\t\t\tSys Admin Menu\n"
	echo -e "\t1.Display disk space"
	echo -e "\t2.Display logged on users"
	echo -e "\t3.Display memory usage"
	echo -e "\t0.Exit program\n\n"
	echo -en "\t\tEnter option: "
	read -n 1 option

}


#while [ 1 ]
#do
#menu
#case $option in
#	0)
#		break ;;
#	1)
#		diskspace ;;
#	2)
#		whoseon ;;
#	3)
#		menuage ;;
#	*)
#		clear
#		echo "Sorry , wrong selection" ;;
#esac
#echo -en "\n\n\t\tHit any key to continue"
#read -n 1 line
#done
#clear



PS3="Enter option: "
select option in "Display disk space" "Display logged on users" "Display memory usage" "Exit program"
do
	case $option in 
		"Exit program") break;;
		"Display disk space") diskspace ;;
		"Display logged on users") whoseon ;;
		"Display memory usage") menuage ;;
		*) clear
			echo "Sorry, wrong selection" ;;
	esac
done
clear






