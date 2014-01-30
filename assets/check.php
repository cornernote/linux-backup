#!/usr/bin/php -q
<?php

################################################################################
# Assets Backup Check
################################################################################
# Copyright (c) 2013 Mr PHP <info@mrphp.com.au>
# Source Code: https://github.com/cornernote/linux-backup
# License: BSD-3-Clause
################################################################################

// config
$backupPath = '/backup/assets/';
$s3Bucket = 's3://bucket-name/assets/';
$weeklyBackupDay = 'sunday';
$s3cmd = '/usr/local/bin/s3cmd -c /var/lib/nagios/.s3cfg';

// defines
define('OK', 0);
define('WARNING', 1);
define('CRITICAL', 2);
define('UNKNOWN', 3);

// checks
$errors = $warnings = array();

// check file count
$count = count(glob($backupPath . '*'));
if (!$count) {
    $errors[] = 'backup has no files';
}

// check daily increment
ob_start();
system('rdiff-backup -l ' . $backupPath);
$system = ob_get_clean();
if (!strpos($system, date('Y-m-d', strtotime('-1 day')))) {
    $errors[] = 'missing daily increment: ' . preg_replace('/\s+/', ' ', str_replace("\n", ' -- ', $system));
}

// check file age in s3
$s3DailyExists = false;
ob_start();
system($s3cmd . ' ls ' . $s3Bucket . 'daily/rdiff-backup-data/');
$s3List = trim(ob_get_clean());
if (!$s3List) {
    $warnings[] = 's3 daily backup does not exist at ' . $s3Bucket . 'daily/rdiff-backup-data/';
}
else {
    foreach (explode("\n", $s3List) as $s3File) {
        $s3File = explode(' ', preg_replace('/\s+/', ' ', $s3File));
        if (strtotime($s3File[0]) < strtotime('yesterday')) {
            $s3DailyExists = true;
            break;
        }
    }
    if (!$s3DailyExists) {
        $warnings[] = 's3 daily is too old - ' . preg_replace('/\s+/', ' ', str_replace("\n", ' -- ', $s3List));
    }
}

// check weekly files in s3
$s3WeeklyFile = $s3Bucket . 'weekly/' . date('Y-m-d', strtotime('last ' . $weeklyBackupDay)) . '.tgz';
ob_start();
system($s3cmd . ' ls ' . $s3WeeklyFile);
$s3Weekly = ob_get_clean();
if (!$s3Weekly) {
    $warnings[] = 's3 weekly backup does not exist at ' . $s3WeeklyFile;
}

// some errors
if ($errors) {
    echo 'CRITICAL: ' . implode(', ', $errors);
    die(CRITICAL);
}

// some warnings
if ($warnings) {
    echo 'WARNING: ' . implode(', ', $warnings);
    die(WARNING);
}

// checks pass, sweet!
echo 'OK: files:' . $count;
die(OK);
