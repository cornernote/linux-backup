#!/usr/bin/php -q
<?php

################################################################################
# Linux Backup
################################################################################
# Copyright (c) 2013 Mr PHP <info@mrphp.com.au>
# Source Code: https://github.com/cornernote/linux-backup
# License: BSD-3-Clause
################################################################################

#
# Nagios Check MySQL Backup
#

define('OK', 0);
define('WARNING', 1);
define('CRITICAL', 2);
define('UNKNOWN', 3);

// get the path
$path = '/backup/mysql';

// get the counts
$count = array(
    'daily' => count_files($path . '/daily/' . date('Y-m-d', strtotime('-1day'))),
    'weekly' => count_files($path . '/weekly/' . date('Y-m-d', strtotime('last sunday'))),
    'monthly' => count_files($path . '/monthly/' . date('Y-m-01', strtotime('-1day'))),
);

// do some checks
$errors = array();

// check daily
if (!$count['daily']) {
    $errors[] = 'daily has no files';
}

// check weekly
if (!$count['weekly']) {
    $errors[] = 'weekly has no files';
}

// check monthly
if (!$count['monthly']) {
    $errors[] = 'monthly has no files';
}

// compile a message
$message = "daily:{$count['daily']} | weekly:{$count['weekly']} | monthly:{$count['monthly']}";

// checks pass, sweet!
if (!$errors) {
    echo 'OK: ' . $message;
    die(OK);
}

// some errors
else {
    echo 'CRITICAL: ' . implode(', ', $errors) . ' - ' . $message;
    die(CRITICAL);
}


/**
 * @param $path
 * @return int
 */
function count_files($path)
{
    return count(glob($path . '/*'));
}