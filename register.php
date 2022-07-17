<?php

require_once("config.php");

$pageTitle = "Register";

//check if user is logged in
if ($auth->isLoggedIn()) {
    header("location: index.php");
}

if (isset($_POST['submit'])) {

    try {
        $userId = $auth->register($_POST['email'], $_POST['password'], $_POST['username'], function ($selector, $token) {
            header("location: email-verify.php?selector=$selector&token=$token");

            //echo 'Send ' . $selector . ' and ' . $token . ' to the user (e.g. via email)';
        });
    } catch (\Delight\Auth\InvalidEmailException $e) {
        $msg = 'Invalid email address';
    } catch (\Delight\Auth\InvalidPasswordException $e) {
        $msg = 'Invalid password';
    } catch (\Delight\Auth\UserAlreadyExistsException $e) {
        $msg = 'User already exists';
    } catch (\Delight\Auth\TooManyRequestsException $e) {
        $msg = 'Too many requests';
    }
}

require_once("header.php");
?>

<div class="container p-5" style="max-width: 500px;">
    <h1 class="pb-4"><?= $pageTitle ?></h1>
    <?php if (isset($msg)) {
        echo "<p class='text-warning bg-dark text-center'>$msg</p>";
    } ?>
    <form class="row g-3 needs-validation" novalidate method="post">
        <div class="mb-3">
            <div class="input-group has-validation">
                <input type="text" name="username" class="form-control" id="validationCustomUsername" placeholder="Username" required>
                <div class="invalid-feedback">
                    Please type valid username.
                </div>
            </div>
        </div>
        <div class="mb-3">
            <div class="input-group has-validation">
                <input type="email" name="email" class="form-control" id="validationCustomEmail" placeholder="Email" required>
                <div class="invalid-feedback">
                    Please type valid email.
                </div>
            </div>
        </div>
        <div class="mb-3">
            <input type="password" name="password" class="form-control" id="validationCustomPassword" placeholder="Password" required>
            <div class="invalid-feedback">
                Please type your password.
            </div>
        </div>
        <div class="mb-3">
            <button class="btn btn-primary" name="submit" type="submit">Register</button>
            <a href="login.php" class="p-4">Login</a>
        </div>
    </form>
</div>
<?php
require_once("footer.php");
?>