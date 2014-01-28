# Nagios Check Backup

Check your backups using Nagios!


## Installation


### Allow Execution

```
chmod a+x /usr/local/linux-backup/_nagios_plugins/check_backup_asset /usr/local/linux-backup/_nagios_plugins/check_backup_mysql /usr/local/linux-backup/_nagios_plugins/check_backup_svn
```


### Test the Scripts

```
/usr/local/linux-backup/_nagios_plugins/check_backup_asset.sh
/usr/local/linux-backup/_nagios_plugins/check_backup_mysql.sh
/usr/local/linux-backup/_nagios_plugins/check_backup_svn.sh
```

### Add to Nagios Client

`vi /etc/nagios/nrpe_local.cfg`

```
command[check_backup_mysql]=/usr/local/linux-backup/_nagios_plugins/check_backup_mysql.sh
command[check_backup_asset]=/usr/local/linux-backup/_nagios_plugins/check_backup_asset.sh
command[check_backup_svn]=/usr/local/linux-backup/_nagios_plugins/check_backup_svn.sh
```

### Add to Nagios Server

`vi /etc/nagios3/conf.d/yourhost.cfg`

```
define host{
        use                     generic-host
        host_name               yourhost
        alias                   your host
        address                 host.local
        }

# check_backup_mysql
define service{
        use                     generic-service
        host_name               yourhost
        service_description     MySQL Backup
        check_command           check_nrpe_1arg!check_backup_mysql
        normal_check_interval   720
        }
              
# check_backup_asset
define service{
        use                     generic-service
        host_name               yourhost
        service_description     Asset Backup
        check_command           check_nrpe_1arg!check_backup_asset
        normal_check_interval   720
        }
              
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

- Does this README need improvement?  Go ahead and [suggest a change](https://github.com/cornernote/linux-backup/edit/master/_nagios_plugins/README.md).
- Found a bug, or need help using this project?  Check the [open issues](https://github.com/cornernote/linux-backup/issues) or [create an issue](https://github.com/cornernote/linux-backup/issues/new).


## License

[BSD-3-Clause](https://raw.github.com/cornernote/linux-backup/master/LICENSE), Copyright © 2013-2014 [Mr PHP](mailto:info@mrphp.com.au)