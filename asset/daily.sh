#!/bin/sh

################################################################################
# Asset Backup Daily
################################################################################
# Copyright (c) 2013 Mr PHP <info@mrphp.com.au>
# Source Code: https://github.com/cornernote/linux-backup
# License: BSD-3-Clause
################################################################################

# create daily increment
${RDIFFBACKUP} ${SOURCE} ${BACKUPDIR}

# remove old increments
${RDIFFBACKUP} -v2 --force --remove-older-than ${BACKUPDAYS}D ${BACKUPDIR}

# upload to s3
${S3CMD} put -r --delete-removed --multipart-chunk-size-mb=50 ${BACKUPDIR} ${S3BUCKET}daily/
