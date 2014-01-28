# Linux Backup

Backup your linux!


## Notes


### S3

IAM Permissions

```
{
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": "arn:aws:s3:::bucket-name",
      "Condition": {}
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": "arn:aws:s3:::bucket-name/*",
      "Condition": {}
    }
  ]
}
```

Sydney Endpoints

`vi ~/.s3cfg`

```
host_base = s3-ap-southeast-2.amazonaws.com
host_bucket = %(bucket)s.s3-ap-southeast-2.amazonaws.com
```

[other region endpoints](http://docs.aws.amazon.com/general/latest/gr/rande.html)

[stackoverflow s3cmd failed too many times](http://stackoverflow.com/questions/5774808/s3cmd-failed-too-many-times)


## Support

- Does this README need improvement?  Go ahead and [suggest a change](https://github.com/cornernote/linux-backup/edit/master/README.md).
- Found a bug, or need help using this project?  Check the [open issues](https://github.com/cornernote/linux-backup/issues) or [create an issue](https://github.com/cornernote/linux-backup/issues/new).


## License

[BSD-3-Clause](https://raw.github.com/cornernote/linux-backup/master/LICENSE), Copyright © 2013-2014 [Mr PHP](mailto:info@mrphp.com.au)