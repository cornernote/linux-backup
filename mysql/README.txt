----------------------------------
Linux Backup
----------------------------------

Copyright (c) 2013 Brett O'Donnell <brett@mrphp.com.au>

Source Code: https://github.com/cornernote/linux-backup

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


----------------------------------
Description
----------------------------------

Backup your MySQL!


----------------------------------
Installation
----------------------------------


Create the Backup Folders
----------------------------------

mkdir /backup
mkdir /backup/mysql
mkdir /backup/mysql/daily
mkdir /backup/mysql/weekly
mkdir /backup/mysql/monthly


Allow MySQL to Auto-Connect
----------------------------------

vi ~/.my.cnf
---
[client]
user="backup_user"
pass="the_pass"
---


Allow Execution
----------------------------------

chmod a+x /usr/local/linux-backup/mysql/daily
chmod a+x /usr/local/linux-backup/mysql/weekly
chmod a+x /usr/local/linux-backup/mysql/monthly


Test the Scripts
----------------------------------

/usr/local/linux-backup/mysql/daily
/usr/local/linux-backup/mysql/weekly
/usr/local/linux-backup/mysql/monthly


Setup Cron Tasks
----------------------------------

crontab -e
---
0 1 * * * /usr/local/linux-backup/mysql/daily
30 2 * * 1 /usr/local/linux-backup/mysql/weekly
45 2 2 * * /usr/local/linux-backup/mysql/monthly
---



Restoring Data
----------------------------------

single thread:
---
zcat /backup/mysql/daily/2009-04-08-00/* | mysql dbname
---

multi thread:
---
echo *.sql.gz | xargs -n1 -P 16 -I % sh -c 'zcat % | mysql dbname'
---
