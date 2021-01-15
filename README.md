# Lokalise_DBBackup

## Project Description: 
This document give a very efficient way to taking backups of MySQL DB and store it to Amazon S3 bucket and then restore the backup file to your MySQL DB.


## Technologies

-bash

-MySQL

-Amazon S3

-Amazon CLI


## Setup

1. Launch an EC2 instance-EC2a.
2. Enable Amazon Simple Email Service (SES) to send alert emails.
3. Install MySQL Client on EC2 instance to connect to your MySQL instance.
4. Launch another EC2 instance-EC2b.
    
    *Install MySQL server
     
     yum install mysql-server -y

    *Start the MySQL
     
     service mysqld start

    *Update password on your local MySQL server
     
     mysqladmin -u root password [your_new_pwd]

    *Login to the mysql server.
     
     mysql -uroot -p

    *CREATE DATABASE db_name
    
5. On first EC2 instance-EC2a, 
    
    *get DB_Backup_Script.sh & Restore_Script.sh
    
    *change mod of both the scripts to make them executable
     
     chmod 755 DB_Backup_Script.sh
     
     chmod 755 Restore_Script.sh
    
    *execute the scripts

## Features

*Automated backup for your MySQL DB to your Amazon S3 bucket.

*Easy restoration of latest backup from S3 bucket.

*Email alerts for backup status information.

*Easily modifiable script with small changes in the variables.
  

## Status

Project is Complete.


## Inspiration
[Congifure Email] {https://docs.aws.amazon.com/ses/latest/DeveloperGuide/monitor-sending-activity-using-notifications-email.html}

[Backup to S3]    {https://aws.amazon.com/getting-started/hands-on/backup-to-s3-cli/}

[Install AWS CLI] {https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html}
