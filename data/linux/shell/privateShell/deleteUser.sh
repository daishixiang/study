#!/bin/bash

###################### define function ####################
function get_answer {

	unset ANSWER
	ASK_COUNT=0

	#while no answer is given, keep asking
	while [ -z "$ANSWER" ]
	do
		ASK_COUNT=$[ $ASK_COUNT + 1 ]

		#id user gives no answer in time allotted
		case $ASK_COUNT in
			2)
				echo
				echo "please answer the question. "
				echo
				;;
			3)
				echo 
				echo "One last try... please answer the question. "
				echo
				;;
			4)
				echo
				echo "since you refuse to answer the question... "
				echo "exiting program"
				exit
				;;
		esac
		echo

		if [ -n "LINE2" ]
		then
			echo $LINE1
			echo -e $LINE2" \c"
		else
			echo -e $LINE1" \c"
		fi
		read -t 60 ANSWER
	done

# do a little variable clean up
unset LINE1
unset LINE2

}


function process_answer {
case $ANSWER in 
	y|Y|yes|Yes|yEs|yeS|YEs|YeS|yES|YES)	 ;;
	*)
		#if user answers anything but "yes", exit script
		echo
		echo $EXIT_LINE1
		echo $EXIT_LINE2
		echo
		exit
		;;
esac

unset EXIT_LINE1
unset EXIT_LINE2

}


############################ main script #############################

#get name of user account to check
echo "Step #1 - determine user account name to delete "
echo
LINE1="Please enter the username of the user "
LINE2="account you wish to delete from system: "
get_answer
USER_ACCOUNT=$ANSWER

#double check with script user that this is the correct user account
LINE1="Is $USER_ACCOUNT the user account "
LINE2="you wish to delete from the system? [y/n]"
get_answer
EXIT_LINE1="Because the account, $USER_ACCOUNT, is not "
EXIT_LINE2="the one you wish to delete, we are leaving the script..."
process_answer

## check that user account is really an account on the system
USER_ACCOUNT_RECORD=$(cat /etc/passwd | grep -w $USER_ACCOUNT)

#if the account is not found, exit script
if [ $? -eq 1 ]
then
	echo
	echo "Account:$USER_ACCOUNT, not found. "
	echo "Leaving the script... "
	echo 
	exit
fi

echo
echo "I found this record: $USER_ACCOUNT_RECORD"

LINE1="Is this the correct user account? [y/n]"
get_answer

EXIT_LINE1="Because the account, $USER_ACCOUNT, is not"
EXIT_LINE2="the one you wish to delete, we are leaving the script... "
process_answer


echo
echo "Step #2 - Find process on System belonging to user account"
echo

#are user processes running?
ps -u $USER_ACCOUNT >/dev/null 
case $? in
	1)
		echo "There are no processes for this account currently running. "
		echo
		;;
	0)
		echo "$USER_ACCOUNT has the following processes running: "
		echo
		ps -u $USER_ACCOUNT

		LINE1="would you like me to kill the process(es)? [y/n]"
		get_answer
		case $ANSWER in 
			y|Y|yes|Yes|yEs|yeS|YEs|Yes|yES|YES)
				echo
				echo "killing off process(es)..."
				
				#list user processes running code in variable
				COMMAND_1='ps -u $USER_ACCOUNT --no-heading'

				#create command to kill process in variable
				COMMAND_3='xargs -d \\n /use/bin/sudo /bin/kill -9'

				#kill processes via piping commands together
				$COMMAND_1 | gawk '{print $1}' | $COMMAND_3

				echo
				echo "Process(es) killed"
				;;
			*)
				echo
				echo "will not kill the process(es)"
				echo
				;;
		esac
		;;
esac


##create a report of all files owned by user account

echo
echo "Step #3 - Find files on system belonging to user account"
echo
echo "Creating a report of all files owned by $USER_ACCOUNT"
echo
echo "It is recommended that you backup/archive these files,"
echo "and then do one of two things"
echo " 1) Delete the files "
echo " 2) Change the files' ownership to a current user account. "
echo
echo "Please wait, This may take a while... "

REPORT_DATE=$(date +%Y%m%d)
REPORT_FILE=$USER_ACCOUNT"_Files_"$REPORT_DATE".rpt"
find / -user $USER_ACCOUNT > $REPORT_FILE 2>/dev/null
echo
echo "Report is completee."
echo "Name of report:   $REPORT_FILE"
echo "Location of report: ${pwd}"
echo

################# remove user account #############################
echo
echo "Step #4 - Remove user account"
echo

LINE1="remove $USER_ACCOUUNT's account from system? [y/n]"
get_answer

EXIT_LINE1="since you do not wish to remove the user account,"
EXIT_LINE2="$USER_ACCOUNT at this time, exiting the script..."
process_answer

#delete user account
userdel $USER_ACCOUNT
echo
echo "user account, $USER_ACCOUNT, has been removed"
echo
exit


