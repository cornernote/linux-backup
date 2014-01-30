# SVN Backup


## Installation


### Create the Backup Folders

```
mkdir -p /backup/svn
```


### Allow Execution

```
chmod a+x /usr/local/linux-backup/svn/backup.sh
```


### Test the Scripts

```
/usr/local/linux-backup/svn/backup.sh
```


### Setup Cron Tasks

`crontab -e`

```
0 2 * * * /usr/local/linux-backup/svn/backup.sh
```


## Nagios Checks


### Client

`vi /etc/nagios/nrpe_local.cfg`

```
command[check_backup_svn]=/usr/local/linux-backup/svn/check.php
```


### Server

`vi /etc/nagios3/conf.d/yourhost.cfg`

```
# check_backup_svn
define service{
        use                     generic-service
        host_name               yourhost
        service_description     SVN Backup
        check_command           check_nrpe_1arg!check_backup_svn
        normal_check_interval   720
        }
```


## Support

- Does this README need improvement?  Go ahead and [suggest a change](https://github.com/cornernote/linux-backup/edit/master/svn/README.md).
- Found a bug, or need help using this project?  Check the [open issues](https://github.com/cornernote/linux-backup/issues) or [create an issue](https://github.com/cornernote/linux-backup/issues/new).


## License

[BSD-3-Clause](https://raw.github.com/cornernote/linux-backup/master/LICENSE), Copyright � 2013-2014 [Mr PHP](mailto:info@mrphp.com.au)
