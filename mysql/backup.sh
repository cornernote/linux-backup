#!/bin/sh

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
BACKUPLAST=`date -d 'yesterday' +"%Y-%m-%d"`
BACKUPDAYS=14
S3BUCKET=s3://bucket-name/mysql/
FULLBACKUPDAY=Sun

# binary paths
MYSQLDUMP=`which mysqldump`
MYDUMPER=`which mydumper`
FIND=`which find`
S3CMD=`which s3cmd`

# dump mysql databases
${MYDUMPER} -t 4 -o ${BACKUPDIR}${BACKUPFOLDER} -c

# delete old backups
${FIND} ${BACKUPDIR} -mtime +${BACKUPDAYS} -delete
${FIND} ${BACKUPDIR} -type d -empty -delete

# upload changed files to s3
${S3CMD} sync -r --delete-removed --multipart-chunk-size-mb=50 ${BACKUPDIR}${BACKUPNAME}/ ${S3BUCKET}daily/

# do a full remote backup on Sunday
if [[ "date '+%a'" == ${FULLBACKUPDAY} ]]; then

	# upload full backup to s3
	${S3CMD} put -r --multipart-chunk-size-mb=50 ${BACKUPDIR}${BACKUPLAST} ${S3BUCKET}weekly/

fi