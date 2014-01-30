#!/usr/bin/php -q
<?php

################################################################################
# MySQL Backup Check
################################################################################
# Copyright (c) 2013 Mr PHP <info@mrphp.com.au>
# Source Code: https://github.com/cornernote/linux-backup
# License: BSD-3-Clause
################################################################################

// config
$backupPath = '/backup/mysql/';
$s3Bucket = 's3://bucket-name/mysql/';
$weeklyBackupDay = 'sunday';
$s3cmd = '/usr/local/bin/s3cmd -c /var/lib/nagios/.s3cfg';

// defines
define('OK', 0);
define('WARNING', 1);
define('CRITICAL', 2);
define('UNKNOWN', 3);

// checks
$errors = $warnings = array();

// check daily file count
$dailyPath = $backupPath . date('Y-m-d', strtotime('yesterday')) . '/';
$count = count(glob($dailyPath . '*'));
if (!$count) {
    $errors[] = 'backup has no files in ' . $dailyPath;
}

// check file count in s3
ob_start();
system($s3cmd . ' ls ' . $s3Bucket . 'daily/');
$s3List = explode("\n", trim(ob_get_clean()));
f (count($s3List) != $count) {
    $warnings[] = 's3 daily count does not match local count';
}

// check file age in s3
foreach ($s3List as $s3File) {
    $s3File = explode(' ', preg_replace('/\s+/', ' ', $s3File));
    if (strtotime($s3File[0]) < strtotime('yesterday')) {
        $warnings[] = $s3File[3] . ' is too old (' . $s3File[0] . ')';
    }
}

// check weekly files in s3
$weeklyPath = $s3Bucket . 'weekly/' . date('Y-m-d', strtotime('last ' . $weeklyBackupDay)) . '/';
ob_start();
system($s3cmd . ' ls ' . $weeklyPath . ' | wc -l');
$s3CountWeekly = ob_get_clean();
if (!$s3CountWeekly) {
    $warnings[] = 's3 weekly backup has no files in ' . $weeklyPath;
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
