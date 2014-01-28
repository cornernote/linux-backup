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
# Nagios Check SVN Backup
#

define('OK', 0);
define('WARNING', 1);
define('CRITICAL', 2);
define('UNKNOWN', 3);

// get the path
$path = '/backup/svn';

// get the counts
$count = array(
    'daily' => count_files($path . '/daily'),
    'weekly' => count_files($path . '/weekly'),
    'monthly' => count_files($path . '/monthly'),
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