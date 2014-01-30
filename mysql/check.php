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

// get the path
$path = '/backup/mysql';

// do some checks
$errors = array();
$warnings = array();

// check daily file count
$count = count(glob($path . '/' . date('Y-m-d') . '/*'));
if (!$count) {
    $errors[] = 'backup has no files';
}

// check file age in s3
ob_start();
system('s3cmd ls s3://factoryfast-backup/mysql/daily/');
$s3List = explode("\n", trim(ob_get_clean()));
foreach ($s3List as $s3File) {
    $s3File = explode(' ', preg_replace('/\s+/', ' ',$s3File));
    if (strtotime($s3File[0]) < strtotime('yesterday')) {
        $warnings[] = $s3File[3] . ' is too old (' . $s3File[0] . ')';
    }
}

// check file count in s3
if (count($s3List) != $count) {
    $warnings[] = 's3 daily count does not match local count';
}

// check weekly files in s3
ob_start();
system('s3cmd ls s3://factoryfast-backup/mysql/weekly/' . date('Y-m-d', strtotime('last sunday')) . '/ | wc -l');
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
