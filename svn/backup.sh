#!/bin/sh

################################################################################
# SVN Backup
################################################################################
# Copyright (c) 2013 Mr PHP <info@mrphp.com.au>
# Source Code: https://github.com/cornernote/linux-backup
# License: BSD-3-Clause
################################################################################

# config
SOURCE=/var/svn/
BACKUPDIR=/backup/svn/
S3BUCKET=s3://bucket-name/svn/

# binary paths
S3CMD=`which s3cmd`

# search repository folder to find all the repository names
ls -Al --time-style=long-iso ${SOURCE} | grep '^d' | awk '{print $8}' | while read line
do
	# create the backup repository folder if we don't have it.
	if [ ! -d ${BACKUPDIR}${line} ]; then
		mkdir -p ${BACKUPDIR}${line}
	fi
	# dump svn 1 revision per dump
	svn-backup-dumps --deltas -q -z -c 1 ${SOURCE}${line} ${BACKUPDIR}${line}
done

# upload changed files to s3
${S3CMD} sync -r --multipart-chunk-size-mb=50 ${BACKUPDIR} ${S3BUCKET}