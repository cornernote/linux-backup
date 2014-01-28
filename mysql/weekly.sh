#!/bin/sh

################################################################################
# MySQL Backup Weekly
################################################################################
# Copyright (c) 2013 Mr PHP <info@mrphp.com.au>
# Source Code: https://github.com/cornernote/linux-backup
# License: BSD-3-Clause
################################################################################

# upload to s3
${S3CMD} put -r --multipart-chunk-size-mb=50 ${BACKUPDIR}${BACKUPLAST} ${S3BUCKET}weekly/
