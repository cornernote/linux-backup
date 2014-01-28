# Asset Backup

Backup your Asset!


## Installation


### Create the Backup Folders

```
mkdir -p /backup/asset
```


### Allow Execution

```
chmod a+x /usr/local/linux-backup/asset/daily.sh /usr/local/linux-backup/asset/weekly.sh
```


### Configuration

Change path in `/usr/local/linux-backup/asset/config.cfg`


### Test the Scripts

```
/usr/local/linux-backup/asset/daily
/usr/local/linux-backup/asset/weekly
```


### Setup Cron Tasks

`crontab -e`

```
0 0 * * * /usr/local/linux-backup/asset/daily
30 1 * * 1 /usr/local/linux-backup/asset/weekly
```


## Restoring Data


### Example restore commands

```
mkdir /backup/restore
rdiff-backup --force --restore-as-of "2013-10-05T00:00:00" /backup/asset/ /backup/restore/
rsync -rav /backup/restore/ /home/you/asset/
```


## Support

- Does this README need improvement?  Go ahead and [suggest a change](https://github.com/cornernote/linux-backup/edit/master/asset/README.md).
- Found a bug, or need help using this project?  Check the [open issues](https://github.com/cornernote/linux-backup/issues) or [create an issue](https://github.com/cornernote/linux-backup/issues/new).


## License

[BSD-3-Clause](https://raw.github.com/cornernote/linux-backup/master/LICENSE), Copyright © 2013-2014 [Mr PHP](mailto:info@mrphp.com.au)