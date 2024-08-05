#!/bin/bash

#identify the keyword for suspicious activities: "error", "Unauthorized", "Failed"
#use sed to get the whole entry and write into a daily file. This will be over write daily
sed -n '/error/p; /Failed/p; /Unauthorized/p' /var/log/auth_log.log > /home/ubuntu/bash_analyzing/suspicious_daily.log

#keep all daily logs into a new file that contains old suspicious activities
echo "$(date)" >> /home/ubuntu/bash_analyzing/suspicious_activity.log
cat /home/ubuntu/bash_analyzing/suspicious_daily.log >> /home/ubuntu/bash_analyzing/suspicious_activity.log
