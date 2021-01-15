#!/bin/bash

BACKUP_DIR=/backup/mysql/daily

CURRENT_DATE= 'date + '%y%m%d''

while :

do

        tm=$(date '+%H%M')

        if [ ${tm} -gt 0208 -a ${tm} -le 0210 ]

        then

                #login to the sql db from the EC2 instance and execute backup

                mysql -h shraddhadbinstance1.cxfyibiokz8s.us-east-2.rds.amazonaws.com -P 3306 -u backupuser -pAdmin123 "mysqldump -u backupuser | gzip > ${BACKUP_DIR}/ newdb${CURRENT_DATE}_bkp.sql.gz

                #copy backup to EC2

                scp backupuser@shraddhadbinstance1.cxfyibiokz8s.us-east-2.rds.amazonaws.com:${BACKUP_DIR}/ newdb${CURRENT_DATE}_bkp.sql.gz .

                #push backup to S3 bucket

                aws s3 cp ${BACKUP_DIR}/newdb${CURRENT_DATE}_bkp.sql.gz s3://shraddhas3bucket

                logger "Successfully Backedup" -t DBLogger

				#Use Amazon Simple Email Service (SES) to send alert emails.

                echo -e "Hello, \nBackup was successful on `date` \nThank you." on 'hostname -i' | mail -s "DB Backup Status" -aFrom:support\<support@lokalise.com\> shraddha@lokalise.com

                #Updting logs   

				logger "Successfully Backedup" -t DBLogger

                find ${BACKUP_DIR}/*.sql.gz -mtime +5 -type f -delete

                sleep 3300

        else

                logger "Failed to Back up" -t DBLogger

                echo -e "Hello, \nBackup was unsuccessful on `date`. \nPlease check. \nThank you." on 'hostname -i' | mail -s "DB Backup Status" -aFrom:support\<support@lokalise.com\> shraddha@lokalise.com

                sleep 1h

        fi

done