#!/bin/sh

################################################################################
# MySQL Archive
################################################################################
# Copyright (c) 2013 Mr PHP <info@mrphp.com.au>
# Source Code: https://github.com/cornernote/linux-backup
# License: BSD-3-Clause
################################################################################

# config
SOURCE=h=localhost,D=source_database
DEST=h=backup_host,D=backup_database,u=backup_user,p=backup_pass
TABLES="audit audit_trail email_spool log"
WHERE="created < '`date +"%Y-%m-%d" --date="-14days"`'"
LIMIT=100

# for each table
for TABLE in ${TABLES}
do

	# archive to remote mysql server
	pt-archiver \
		--source ${SOURCE},t=${TABLE} \
		--dest ${DEST},t=${TABLE} \
		--where "${WHERE}" \
		--limit ${LIMIT} \
		--commit-each \
		--progress ${LIMIT} \
		--no-check-charset

done
