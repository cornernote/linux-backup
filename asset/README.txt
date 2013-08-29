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

Backup your Asset!


----------------------------------
Installation
----------------------------------


Create the Backup Folders
----------------------------------

mkdir /backup
mkdir /backup/asset
mkdir /backup/asset/daily
mkdir /backup/asset/weekly
mkdir /backup/asset/monthly


Setup Cron Tasks
----------------------------------

crontab -e
---
0 0 * * * /usr/local/linux-backup/asset/daily
30 1 * * 1 /usr/local/linux-backup/asset/weekly
45 1 2 * * /usr/local/linux-backup/asset/monthly
---


Test the Scripts
----------------------------------

/usr/local/linux-backup/asset/daily
/usr/local/linux-backup/asset/weekly
/usr/local/linux-backup/asset/monthly


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
