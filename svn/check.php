#!/usr/bin/php -q
<?php

################################################################################
# SVN Backup Check
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
$path = '/backup/svn';

// do some checks
$errors = array();

// check file count
$count = count(glob($path . '/*'));
if (!$count) {
    $errors[] = 'backup has no files';
}

// compile a message
$message = "files:{$count}";

// some errors
if ($errors) {
    echo 'CRITICAL: ' . implode(', ', $errors) . ' - ' . $message;
    die(CRITICAL);
}

// checks pass, sweet!
echo 'OK: ' . $message;
die(OK);