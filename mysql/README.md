# MySQL Backup

Backup your MySQL!


## Installation


### Create the Backup Folders

mkdir -p /backup/mysql


## Allow MySQL to Auto-Connect

`vi ~/.my.cnf`

```
[client]
user="backup_user"
pass="the_pass"
```


### Allow Execution

```
chmod a+x /usr/local/linux-backup/mysql/daily.sh /usr/local/linux-backup/mysql/weekly.sh
```


### Test the Scripts

```
/usr/local/linux-backup/mysql/daily
/usr/local/linux-backup/mysql/weekly
/usr/local/linux-backup/mysql/archive
```


### Setup Cron Tasks

`crontab -e`

```
LINUXBACKUP=/usr/local/linux-backup
LOCKRUN=lockrun --idempotent --lockfile=/var/lockrun/
0 1 * * * ${LINUXBACKUP}/mysql/daily
0 2 * * * ${LOCKRUN}linux-backup-mysql-archive -- ${LINUXBACKUP}/mysql/archive
30 2 * * 1 ${LINUXBACKUP}/mysql/weekly
```


## Restoring Data

single thread:

```
zcat /backup/mysql/YYYY-MM-DD/* | mysql dbname
```

multi thread:

```
echo /backup/mysql/YYYY-MM-DD/*.sql.gz | xargs -n1 -P 16 -I % sh -c 'zcat % | mysql dbname'
```

using myloader:

```
myloader -d /backup/mysql/YYYY-MM-DD/ -B dbname
```


## Support

- Does this README need improvement?  Go ahead and [suggest a change](https://github.com/cornernote/linux-backup/edit/master/mysql/README.md).
- Found a bug, or need help using this project?  Check the [open issues](https://github.com/cornernote/linux-backup/issues) or [create an issue](https://github.com/cornernote/linux-backup/issues/new).


## License

[BSD-3-Clause](https://raw.github.com/cornernote/linux-backup/master/LICENSE), Copyright © 2013-2014 [Mr PHP](mailto:info@mrphp.com.au)