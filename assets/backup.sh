#!/bin/bash

################################################################################
# Assets Backup
################################################################################
# Copyright (c) 2013 Mr PHP <info@mrphp.com.au>
# Source Code: https://github.com/cornernote/linux-backup
# License: BSD-3-Clause
################################################################################

# config
SOURCE=/home/you/assets/
DESTINATION=/backup/assets/
BACKUPDAYS=14
S3BUCKET=s3://bucket-name/assets/
FULLBACKUPDAY=Sun
DAILYNAME=/backup/assets.tgz
WEEKLYNAME=${S3BUCKET}weekly/assets-`date +"%Y-%m-%d"`.tgz

# binary paths
TAR=`which tar`
FIND=`which find`
S3CMD=`which s3cmd`
RDIFFBACKUP=`which rdiff-backup`
RM=/bin/rm
CP=/bin/cp

# create daily increment
${RDIFFBACKUP} ${SOURCE} ${DESTINATION}

# remove old increments
${RDIFFBACKUP} -v2 --force --remove-older-than ${BACKUPDAYS}D ${DESTINATION}

# delete compressed backup
${RM} -f ${DAILYNAME}

# compress latest daily backup
${TAR} cfzP ${DAILYNAME} ${DESTINATION}

# upload changed files to s3
${S3CMD} put ${DAILYNAME} ${S3BUCKET}

# check if we do a full remote backup today
if [[ `date '+%a'` == ${FULLBACKUPDAY} ]]; then

	# upload compressed backup to s3
	${S3CMD} put ${DAILYNAME} ${WEEKLYNAME}

fi
