#!/bin/sh

################################################################################
# MySQL Backup Daily
################################################################################
# Copyright (c) 2013 Mr PHP <info@mrphp.com.au>
# Source Code: https://github.com/cornernote/linux-backup
# License: BSD-3-Clause
################################################################################

# latest daily backup
${MYDUMPER} -t 4 -o ${BACKUPDIR}${BACKUPFOLDER} -c

# delete old backups
${FIND} ${BACKUPDIR} -mtime +${BACKUPDAYS} -delete
${FIND} ${BACKUPDIR} -type d -empty -delete

# upload to s3
${S3CMD} sync -r --delete-removed --multipart-chunk-size-mb=50 ${BACKUPDIR}${BACKUPNAME}/ ${S3BUCKET}daily/

