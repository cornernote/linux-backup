# SVN Backup


## Installation


### Create the Backup Folders

```
mkdir -p /backup/svn
```


### Allow Execution

```
chmod a+x /usr/local/linux-backup/svn/daily.sh /usr/local/linux-backup/svn/weekly.sh
```


### Test the Scripts

```
/usr/local/linux-backup/svn/daily.sh
/usr/local/linux-backup/svn/weekly.sh
```


### Setup Cron Tasks

`crontab -e`

```
0 2 * * * /usr/local/linux-backup/svn/daily
30 3 * * 1 /usr/local/linux-backup/svn/weekly
```


## Support

- Does this README need improvement?  Go ahead and [suggest a change](https://github.com/cornernote/linux-backup/edit/master/svn/README.md).
- Found a bug, or need help using this project?  Check the [open issues](https://github.com/cornernote/linux-backup/issues) or [create an issue](https://github.com/cornernote/linux-backup/issues/new).


## License

[BSD-3-Clause](https://raw.github.com/cornernote/linux-backup/master/LICENSE), Copyright © 2013-2014 [Mr PHP](mailto:info@mrphp.com.au)