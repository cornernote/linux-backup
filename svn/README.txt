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

Backup your SVN!


----------------------------------
Installation
----------------------------------


Create the Backup Folders
----------------------------------

mkdir /backup
mkdir /backup/svn
mkdir /backup/svn/daily
mkdir /backup/svn/weekly
mkdir /backup/svn/monthly


Allow Execution
----------------------------------

chmod a+x /usr/local/linux-backup/svn/daily
chmod a+x /usr/local/linux-backup/svn/weekly
chmod a+x /usr/local/linux-backup/svn/monthly


Test the Scripts
----------------------------------

/usr/local/linux-backup/svn/daily
/usr/local/linux-backup/svn/weekly
/usr/local/linux-backup/svn/monthly


Setup Cron Tasks
----------------------------------

crontab -e
---
0 2 * * * /usr/local/linux-backup/svn/daily
30 3 * * 1 /usr/local/linux-backup/svn/weekly
45 3 2 * * /usr/local/linux-backup/svn/monthly
---
