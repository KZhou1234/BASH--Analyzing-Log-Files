#!/bin/bash
#the path to analyzing script to catch suspicious activities
SCRIPT_PATH="~/bash_analyzing/analyzing.sh"

#list all previous cron jobs to a file
crontab -l > CRONTAB_NEW

#create a cronjob if cronjob does not exist
#run daily. everyday at 00:00
CRON_JOB="* * * * * $SCRIPT_PATH"

#check the temp file for cron jobs
grep -F "$CRON_JOB" ./CRONTAB_NEW > /dev/null

if [ $? -eq 0 ]
then
	echo "This job exists."
else
	echo "$CRON_JOB" >> CRONTAB_NEW #append new job
	crontab CRONTAB_NEW #execute
fi
#remove temp file
rm CRONTAB_NEW



