#!/bin/sh

################################################################################
# Assets Backup
################################################################################
# Copyright (c) 2013 Mr PHP <info@mrphp.com.au>
# Source Code: https://github.com/cornernote/linux-backup
# License: BSD-3-Clause
################################################################################

# config
SOURCE=/home/you/assets/
BACKUPDIR=/backup/assets/
BACKUPDAYS=14
BACKUPNAME=/backup/`date +"%Y-%m-%d"`.tgz
S3BUCKET=s3://bucket-name/assets/
FULLBACKUPDAY=Sun

# binary paths
TAR=`which tar`
FIND=`which find`
S3CMD=`which s3cmd`
RDIFFBACKUP=`which rdiff-backup`
RM=/bin/rm

# create daily increment
${RDIFFBACKUP} ${SOURCE} ${BACKUPDIR}

# remove old increments
${RDIFFBACKUP} -v2 --force --remove-older-than ${BACKUPDAYS}D ${BACKUPDIR}

# upload changed files to s3
${S3CMD} sync -r --delete-removed ${BACKUPDIR} ${S3BUCKET}daily/

# check if we do a full remote backup today
if [[ "date '+%a'" == ${FULLBACKUPDAY} ]]; then

	# compress latest daily backup
	${TAR} cfzP ${BACKUPNAME} ${BACKUPDIR}

	# upload compressed backup to s3
	${S3CMD} put ${BACKUPNAME} ${S3BUCKET}weekly/

	# delete compressed backup
	${RM} -f ${BACKUPNAME}

fi