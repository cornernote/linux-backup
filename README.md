# Linux Backup

- [S3 Configutation](#s3-configutation)
	- [Create AWS S3 Bucket](#create-aws-s3-bucket)
	- [Create AWS IAM User](#create-aws-iam-user)
	- [Install s3cmd](#install-s3cmd)
	- [Setup S3 Endpoints](#setup-s3-endpoints)
- [Nagios Configutation](#nagios-configutation)
- [Support](#support)
- [License](#license)
	 
	
## S3 Configutation


### Create AWS S3 Bucket

Login to [AWS](https://console.aws.amazon.com)

Click **Services**, then click **S3**.

Click **Create Bucket**.

Enter a **Bucket Name** and choose the **Region**, then click **Create**.


### Create AWS IAM User

Login to [AWS](https://console.aws.amazon.com)

Click the **username dropdown** (top right), then click **Security Credentials**.

Click **Users** (left menu).

Click **Create New Users**.

Enter a **Username** then click **Create**.

Save your access keys somewhere safe.

Click the user, then click **Permissions** (tab in the bottom pane), then click **Attach User Policy**.

Click **Custom Policy**, then click **Select**.

Enter a **Policy Name** (can be the same as the username), then paste in the following into the **Policy Document** to give access to all s3 buckets.

```
{
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:*"],
      "Resource": "*"
    }
  ]
}
```

Note: this gives full permissions to all S3 buckets, which is required when verifying the s3cmd configuration (see steps below).

After s3cmd has been configured, you may want to change the permissions to restrict to a single bucket.

Click the user, then click **Permissions** (tab in the bottom pane), then click **Manage Policy**.

Paste the following into the **Policy Document**, then click **Apply Policy**.

```
{
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:*"],
      "Resource": "arn:aws:s3:::bucket-name"
    },
    {
      "Effect": "Allow",
      "Action": ["s3:*"],
      "Resource": "arn:aws:s3:::bucket-name/*"
    }
  ]
}
```


### Install s3cmd

Download and configure s3cmd:

```
wget https://github.com/s3tools/s3cmd/archive/v1.1.0-beta3.tar.gz -O s3cmd-1.1.0-beta3.tar.gz
tar xvfz s3cmd-1.1.0-beta3.tar.gz
cd s3cmd-1.1.0-beta3/
python setup.py install
s3cmd --configure
```


### Setup S3 Endpoints

This step is optional, however it may reduce initial connection time.

`vi ~/.s3cfg`

```
host_base = s3-ap-southeast-2.amazonaws.com
host_bucket = %(bucket)s.s3-ap-southeast-2.amazonaws.com
```

Sydney uses `s3-ap-southeast-2`, or check [other region endpoints](http://docs.aws.amazon.com/general/latest/gr/rande.html).


## Nagios Configutation

Configure s3cmd for the nagios user:

```
cp ~/.s3cfg /var/lib/nagios/
chown nagios:nagios /var/lib/nagios/.s3cfg
```

It is **highly** recommended to setup a read-only AWS IAM user and insert the credentials into `/var/lib/nagios/.s3cfg` instead of using your backup user.  Use the following AWS Policy Document to allow readonly access:

```
{
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:Get*","s3:List*"],
      "Resource": "arn:aws:s3:::factoryfast-backup"
    }
  ]
}
```

Test the commands by running as the nagios user:

```
sudo -u nagios /usr/local/linux-backup/assets/check.php
```

If you are still having trouble and need to debug the check.php script, you may find it useful to [see stderr from php](http://stackoverflow.com/questions/2320608/php-stderr-after-exec).


## Support

- Does this README need improvement?  Go ahead and [suggest a change](https://github.com/cornernote/linux-backup/edit/master/README.md).
- Found a bug, or need help using this project?  Check the [open issues](https://github.com/cornernote/linux-backup/issues) or [create an issue](https://github.com/cornernote/linux-backup/issues/new).


## License

[BSD-3-Clause](https://raw.github.com/cornernote/linux-backup/master/LICENSE), Copyright © 2013-2014 [Mr PHP](mailto:info@mrphp.com.au)
