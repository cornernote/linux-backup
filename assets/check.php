#!/usr/bin/php -q
<?php

################################################################################
# Assets Backup Check
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
$backupPath = '/backup/assets/';
$s3Bucket = 's3://bucket-name/assets/';

// do some checks
$errors = $warnings = array();

// check file count
$count = count(glob($backupPath . '*'));
if (!$count) {
    $errors[] = 'backup has no files';
}

// check increments
ob_start();
system('rdiff-backup -l ' . $backupPath);
$system = ob_get_clean();
if (!strpos($system, date('Y-m-d', strtotime('-1 day')))) {
    $errors[] = 'missing daily increment: ' . preg_replace('/\s+/', ' ', str_replace("\n", ' -- ', $system));
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
