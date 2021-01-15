
#Make sure to Install AWS CLI on EC2

#!/bin/bash

BACKUP_DIR=/backup/mysql/daily

$BACKUP_DIR < aws s3 cp s3://shraddhas3bucket/newdb${CURRENT_DATE}_bkp.sql.gz

gunzip $BACKUP_DIR | mysql -u backupuser -pAdmin123 newdb