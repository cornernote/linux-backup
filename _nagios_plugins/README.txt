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

Check your backups using Nagios!


----------------------------------
Installation
----------------------------------


Allow Execution
----------------------------------

chmod a+x /usr/local/linux-backup/_nagios_plugins/check_backup_asset
chmod a+x /usr/local/linux-backup/_nagios_plugins/check_backup_mysql
chmod a+x /usr/local/linux-backup/_nagios_plugins/check_backup_svn


Test the Scripts
----------------------------------

/usr/local/linux-backup/_nagios_plugins/check_backup_asset
/usr/local/linux-backup/_nagios_plugins/check_backup_mysql
/usr/local/linux-backup/_nagios_plugins/check_backup_svn


Add to Nagios Client
----------------------------------

edit /etc/nagios/nrpe_local.cfg

command[check_backup_mysql]=/usr/local/linux-backup/_nagios_plugins/check_backup_mysql
command[check_backup_redmine]=/usr/local/linux-backup/_nagios_plugins/check_backup_redmine
command[check_backup_vhosts]=/usr/local/linux-backup/_nagios_plugins/check_backup_vhosts
command[check_backup_svn]=/usr/local/linux-backup/_nagios_plugins/check_backup_svn

