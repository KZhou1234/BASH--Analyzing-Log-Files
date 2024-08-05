#!/bin/bash

sed -n '/error/p; /Failed/p; /Unauthorized/p' /var/log/auth_log.log >> /home/ubuntu/bash_analyzing/suspicious.log
echo "executed" 
