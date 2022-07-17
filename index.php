<?php

require_once("config.php");

$pageTitle = "Main";


//check if user is logged in
//if not, don't let them access this page
if ($auth->isLoggedIn() === false) {
    header("location: login.php");
}

define("USER_ID", $auth->getUserId());
define("USERNAME", $auth->getUsername());


//User tring to add contacts from General to their Personal list
if (isset($_GET['cid'])) {

    $cid = $_GET['cid'];

    //validate if proper contact ID
    if (is_numeric($cid)) {

        //check if contact ID exist on General Contacts
        $stmt = $db->query("SELECT count(1) FROM contacts WHERE id = $cid")->fetchColumn();

        if ($stmt) {

            $dateAdded = date('Y-m-d H:i:s');

            //save to Personal Contacts
            $sql = "INSERT INTO contacts_personal(contactsID, userID, dateAdded) VALUES($cid, " . USER_ID . ", '$dateAdded')";

            try {
                $db->prepare($sql)->execute();
            } catch (PDOException $e) {
                $existingkey = "Integrity constraint violation: 1062 Duplicate entry";
                if (strpos($e->getMessage(), $existingkey) !== FALSE) {
                } else {
                    throw $e;
                }
            }
        }
    }
}


//User tring to remove contacts from their Personal list
if (isset($_GET['remove'])) {

    $cid = $_GET['remove'];

    //validate if proper contact ID
    if (is_numeric($cid)) {

        //remove from Personal Contacts
        $sql = "DELETE FROM contacts_personal WHERE contactsID=$cid AND userID=" . USER_ID;

        try {
            $db->prepare($sql)->execute();
        } catch (PDOException $e) {
        }
    }
}



//get list of Personal Contacts
$stmt = $db->query("SELECT c.* FROM contacts_personal cp LEFT JOIN contacts c ON c.id = cp.contactsID WHERE cp.userID = " . USER_ID)->fetchAll();

$i = 1;
$tr_general = $tr_personal = "";
$personalList = array();

if (is_array($stmt)) {

    foreach ($stmt as $row) {

        array_push($personalList, $row['id']);

        $tr_personal .= '<tr>
                <th scope="row">' . $i . '</th>
                <td>' . $row['name'] . '</td>
                <td>' . $row['email'] . '</td>
                <td class="text-center"><a href="?remove=' . $row['id'] . '" class="nav-link link-danger">&#8722;</a></td>
            </tr>';

        $i++;
    }
}



//get list of General Contacts
$stmt = $db->query("SELECT * FROM contacts");

$i = 1;

foreach ($stmt as $row) {

    $addButton = in_array($row['id'], $personalList) ? "" : '<a href="?cid=' . $row['id'] . '" class="nav-link link-primary">&#10010;</a>';

    $tr_general .= '<tr>
            <th scope="row">' . $i . '</th>
            <td>' . $row['name'] . '</td>
            <td>' . $row['email'] . '</td>
            <td class="text-center">' . $addButton . '</td>
        </tr>';

    $i++;
}





require_once("header.php");
?>
<div class="container bg-light">
    <ul class="nav justify-content-end">
        <li class="nav-item">
            <a class="nav-link disabled"><?= USERNAME ?></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="logout.php">Logout</a>
        </li>
    </ul>
</div>
<div class="container p-5">

    <div class="row">
        <div class="col-md-5 pb-5">
            <h2 class="pb-3">General Contacts</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Add</th>
                    </tr>
                </thead>
                <tbody>
                    <?= $tr_general ?>
                </tbody>
            </table>
        </div>
        <div class="col-md-2"></div>
        <div class="col-md-5">
            <h2 class="pb-3">Personal Contacts</h2>
            <?php if ($tr_personal) { ?>
                <div id="app">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Name</th>
                                <th scope="col">Email</th>
                                <th scope="col">Remove</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?= $tr_personal ?>
                        </tbody>
                    </table>
                </div>
            <?php } else {
                echo '<div id="app"><p>List is empty. Click the add button on General Contacts list to add on your personal list.</p></div>';
            } ?>
        </div>
    </div>
</div>
<?php
require_once("footer.php");
?>