<?php

require_once("config.php");

try {
    $auth->logOut();

    header("location: login.php");
} catch (\Delight\Auth\NotLoggedInException $e) {
    die('Not logged in');
}
