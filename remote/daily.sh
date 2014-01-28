#!/bin/sh

################################################################################
# Remote Backup
################################################################################
# Copyright (c) 2013 Mr PHP <info@mrphp.com.au>
# Source Code: https://github.com/cornernote/linux-backup
# License: BSD-3-Clause
################################################################################

# backup mysql
/usr/bin/rsync -az -e ssh /backup/mysql/`date +"%Y-%m-%d"`/ backup@backup.example.com:~/backup/mysql

# backup asset
/usr/bin/rsync -az -e ssh /backup/asset/ backup@backup.example.com:~/backup/asset