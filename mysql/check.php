#!/usr/bin/php -q
<?php

################################################################################
# MySQL Backup Check
################################################################################
# Copyright (c) 2013 Mr PHP <info@mrphp.com.au>
# Source Code: https://github.com/cornernote/linux-backup
# License: BSD-3-Clause
################################################################################

define('OK', 0);
define('WARNING', 1);
define('CRITICAL', 2);
define('UNKNOWN', 3);

// config
$backupPath = '/backup/mysql/';
$s3Bucket = 's3://bucket-name/mysql/';
$weeklyBackupDay = 'sunday';

// do some checks
$errors = $warnings = array();

// check daily file count
$count = count(glob($backupPath . date('Y-m-d', strtotime('yesterday')) . '/*'));
if (!$count) {
    $errors[] = 'backup has no files';
}

// check file count in s3
ob_start();
system('s3cmd ls ' . $s3Bucket . 'daily/');
$s3List = explode("\n", trim(ob_get_clean()));
f (count($s3List) != $count) {
    $warnings[] = 's3 daily count does not match local count';
}

// check file age in s3
foreach ($s3List as $s3File) {
    $s3File = explode(' ', preg_replace('/\s+/', ' ',$s3File));
    if (strtotime($s3File[0]) < strtotime('yesterday')) {
        $warnings[] = $s3File[3] . ' is too old (' . $s3File[0] . ')';
    }
}

// check weekly files in s3
ob_start();
system('s3cmd ls ' . $s3Bucket . 'weekly/' . date('Y-m-d', strtotime('last ' . $weeklyBackupDay)) . '/ | wc -l');
$s3CountWeekly = ob_get_clean();
if (!$s3CountWeekly) {
    $warnings[] = 's3 weekly backup has no files';
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
