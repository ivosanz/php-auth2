<?php

require_once("config.php");

$pageTitle = "Email Verification";

try {
    $auth->confirmEmail($_GET['selector'], $_GET['token']);

    $msg = 'Email address has been verified';
} catch (\Delight\Auth\InvalidSelectorTokenPairException $e) {
    $msg = 'Invalid token';
} catch (\Delight\Auth\TokenExpiredException $e) {
    $msg = 'Token expired';
} catch (\Delight\Auth\UserAlreadyExistsException $e) {
    $msg = 'Email address already exists';
} catch (\Delight\Auth\TooManyRequestsException $e) {
    $msg = 'Too many requests';
}

require_once("header.php");


?>

<div class="row text-center align-items-center" style=" background:#eee; min-height: 100vh;">
    <div class="col">
        <p><strong><?= $pageTitle ?>: </strong><?= $msg ?>
            <span class="p-4">|</span>
            <a href="login.php" class="pe-4">Login</a>
            <a href="register.php">Register</a>
        </p>
        <p><i>Note: This is demo only. The email address is automatically verified upon registration.</i></p>

    </div>

</div>

<?php
require_once("footer.php");
?>