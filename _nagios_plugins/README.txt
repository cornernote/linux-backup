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
command[check_backup_asset]=/usr/local/linux-backup/_nagios_plugins/check_backup_asset
command[check_backup_svn]=/usr/local/linux-backup/_nagios_plugins/check_backup_svn


Add to Nagios Server
----------------------------------

edit /etc/nagios3/conf.d/yourhost.cfg

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
              
