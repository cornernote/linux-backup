#!/bin/bash

################################################################################
# MySQL Backup
################################################################################
# Copyright (c) 2013 Mr PHP <info@mrphp.com.au>
# Source Code: https://github.com/cornernote/linux-backup
# License: BSD-3-Clause
################################################################################

# config
BACKUPDIR=/backup/mysql/
BACKUPNAME=`date +"%Y-%m-%d"`
BACKUPDAYS=14
S3BUCKET=s3://bucket-name/mysql/
FULLBACKUPDAY=Sun

# binary paths
MYSQLDUMP=`which mysqldump`
MYDUMPER=`which mydumper`
FIND=`which find`
S3CMD=`which s3cmd`
MKDIR=`which mkdir`

# dump mysql databases
${MKDIR} ${BACKUPDIR}${BACKUPNAME}
${MYDUMPER} -t 4 -o ${BACKUPDIR}${BACKUPNAME} -c

# delete old backups
${FIND} ${BACKUPDIR} -mtime +${BACKUPDAYS} -delete
${FIND} ${BACKUPDIR} -type d -empty -delete

# upload changed files to s3
${S3CMD} sync --recursive --delete-removed ${BACKUPDIR}${BACKUPNAME}/ ${S3BUCKET}daily/

# check if we do a full remote backup today
if [[ `date '+%a'` == ${FULLBACKUPDAY} ]]; then

	# upload full backup to s3
	${S3CMD} put --recursive ${BACKUPDIR}${BACKUPNAME} ${S3BUCKET}weekly/

fi
