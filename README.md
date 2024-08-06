# Log Analyze
## Overview
Aiming to identify, search, and output suspicious activities in the log file using scripts, and automatically run these scripts daily, I have created a script to filter out and record suspicious activities, as well as to create a cron job for it.
## Steps
1. Identify keywords: "error," "Unauthorized," and "Fail" are keywords present in logs of suspicious activities.
2. Search keywords from log: use ```sed```can get the matched entries and ```/keyword/p``` will print the entry. The command is:```sed -n '/error/p; /Failed/p; /Unauthorized/p' /var/log/auth_log.log > /home/ubuntu/bash_analyzing/suspicious_daily.log```
3. Write this commond into a script.
4. Create a cron job for it.  
   A.  Using user tab:
   ```crontab -e```
   However, considering automatization, I've also created a script to create cron jobs.  
   B. Script for adding the job to user crontab
   ```
    #!/bin/bash
    #the path to analyzing script which is to catch suspicious activities
    SCRIPT_PATH="~/bash_analyzing/analyzing.sh"
    
    #list all previous cron jobs to a file
    crontab -l > CRONTAB_NEW
    
    #create a cronjob if cronjob does not exist
    #run daily. everyday at 00:00
    CRON_JOB="0 0 * * * $SCRIPT_PATH"
    
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
    ```
## Results
> **Note**  
>The outputs below are for the scripts running per minute. The final scripts run in daily.
* Daily Suspicious Activities  
  <img width="1032" alt="image" src="https://github.com/user-attachments/assets/1575b53a-4734-4dc0-b79f-6d325079ce56">  
* Total Suspicious Activities  
  <img width="1064" alt="image" src="https://github.com/user-attachments/assets/76b21045-ce9b-4df3-a264-a1ce92cd9a1d">
## Conclusion
This exercise allows us to practice how to match text and create a cron job. 
Both ```grep``` and ```sed``` can help search for and print matched text. I've selected ```sed``` since it offers additional text transformation commands compared to ```grep```.
