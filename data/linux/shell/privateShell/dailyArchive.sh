#!/bin/bash

#gather current date

YEAR=$(date +%Y)
MONTH=$(date +%m)
DAY=$(date +%d)
TIME=$(date +%H%M%S)

#set archive file name 

FILE=archive$TIME.tar.gz

#create archive directory

BASEDEST=/home/daisx/resource/shellscript/archive/backup

mkdir -p $BASEDEST/$YEAR/$MONTH/$DAY
#set configuration and destination file

CONFIG_FILE=/home/daisx/resource/shellscript/archive/tar.config
DESTINATION=$BASEDEST/$YEAR/$MONTH/$DAY/$FILE

############################### main script ##############################

#check backup config file exist

#make sure the config file still exists
if [ -f $CONFIG_FILE -o -d $CONFIG_FILE ] 
then
	echo
else 
	echo
	echo "$CONFIG_FILE does not exist"
	echo "backup not completed due to missing configuration file"
	echo
	exit
fi

#build  the names of all the files to backup

#start on line 1 of config file 
FILE_NO=1

#redirect std input to name of config file
exec < $CONFIG_FILE

#read 1st record
read FILE_NAME

#create list of files to backup
while [ $? -eq 0 ]
do 
	#make sure the file or directory exists
	if [ -f $FILE_NAME -o -d $FILE_NAME ]
	then 
		#if file exists, add its name to the list
		FILE_LIST="$FILE_LIST $FILE_NAME"
        else
		 #if file doesn't exist, issue warning
		 echo
		 echo "$FILE_NAME, doesn't exist"
		 echo "obviously, I will no include it in this archive"
		 echo "It is listed on line $FILE_NO of config file"
		 echo "continuing to build archive list"
		 echo 
	 fi

	 #increase line/file number by one 
	 FILE_NO=$[$FILE_NO + 1]
	 #read next record
	 read FILE_NAME
done

################## backup the files and compress archive #################

echo "starting archive..."
echo 

tar -czf $DESTINATION $FILE_LIST 2> /dev/null

echo "archive completed"
echo "resulting archive file is : $DESTINATION"
echo

exit







