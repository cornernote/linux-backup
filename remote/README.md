# Remote Backup

Perform a Remote Backup!


## Installation


### Test the Scripts

```
/usr/local/linux-backup/remote/daily.sh
```


### Setup Cron Tasks

`crontab -e`

```
0 4 * * * /usr/local/linux-backup/remote/daily.sh
```


### Notes

If you get `stdin: is not a tty` then you need to add the following to the beginig of `.bashrc` that is located in the home dir of the remote user.

```
[ -z "$PS1" ] && return
```


## Support

- Does this README need improvement?  Go ahead and [suggest a change](https://github.com/cornernote/linux-backup/edit/master/remote/README.md).
- Found a bug, or need help using this project?  Check the [open issues](https://github.com/cornernote/linux-backup/issues) or [create an issue](https://github.com/cornernote/linux-backup/issues/new).


## License

[BSD-3-Clause](https://raw.github.com/cornernote/linux-backup/master/LICENSE), Copyright © 2013-2014 [Mr PHP](mailto:info@mrphp.com.au)