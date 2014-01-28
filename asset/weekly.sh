#!/bin/sh

################################################################################
# Asset Backup Weekly
################################################################################
# Copyright (c) 2013 Mr PHP <info@mrphp.com.au>
# Source Code: https://github.com/cornernote/linux-backup
# License: BSD-3-Clause
################################################################################

# latest daily backup
${TAR} cfzP ${BACKUPNAME} ${BACKUPDIR}

# upload to s3
${S3CMD} put --multipart-chunk-size-mb=50 ${BACKUPNAME} ${S3BUCKET}weekly/

# delete local backup
${RM} -f ${BACKUPNAME}
