#!/bin/bash
# Retrieve new messages from S3 and save to tmpemails/ directory:
aws s3 cp \
   --recursive \
   s3://bucket-name/ \
   /home/david/s3-emails/tmpemails/ \
   --profile myaccount

# Set location variables:
tmp_file_location=/home/david/s3-emails/tmpemails/*
base_location=/home/david/s3-emails/emails/

# Create new directory to store today's messages:
today=$(date +"%m_%d_%Y")
[[ -d ${base_location}/"$today" ]] || mkdir ${base_location}/"$today"

# Update Logger
logger Restored logs on `date` -t DBLogger

# Generate Alerts
echo -e "Hello, \nDatabase was unsuccessful on `date`. \nPlease check. \nThank you." on 'hostname -i' | mail -s "DB Backup Status" -aFrom:support\<support@lokalise.com\> shraddha@lokalise.com

# Give the message files readable names:
for FILE in $tmp_file_location
do
   mv $FILE ${base_location}/${today}/email$(rand)
done

# Open new files in Gedit:
for NEWFILE in ${base_location}/${today}/*
do
   gedit $NEWFILE
done
