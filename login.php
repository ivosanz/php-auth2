<?php

require_once("config.php");

$pageTitle = "Login";

//check if user is logged in
//if yes, don't let them access this page
if ($auth->isLoggedIn()) {
    header("location: index.php");
}


if (isset($_POST['submit'])) {

    try {
        $auth->login($_POST['email'], $_POST['password']);
        header("location: index.php");
        //echo 'User is logged in';
    } catch (\Delight\Auth\InvalidEmailException $e) {
        $msg = 'Wrong email address';
    } catch (\Delight\Auth\InvalidPasswordException $e) {
        $msg = 'Wrong password';
    } catch (\Delight\Auth\EmailNotVerifiedException $e) {
        $msg = 'Email not verified';
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
            <button class="btn btn-primary" name="submit" type="submit">Login</button>
            <a href="register.php" class="p-4">Register</a>
        </div>
    </form>
</div>
<?php
require_once("footer.php");
?>