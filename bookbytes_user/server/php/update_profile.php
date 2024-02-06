<?php 
if (!isset($_POST)) { 
    $response = array('status' => 'failed', 'data' => null); 
    sendJsonResponse($response); 
    die(); 
} 
 

 
if (isset($_POST['phone'])) { 
    $phone = $_POST['phone']; 
    $userid = $_POST['userid']; 
    $sqlupdate = "UPDATE tbl_users SET contact ='$phone' WHERE id = '$userid'"; 
    databaseUpdate($sqlupdate); 
    die(); 
} 
 
if (isset($_POST['password'])) { 
    $password = sha1($_POST['password']); 
    $userid = $_POST['userid']; 
    $sqlupdate = "UPDATE tbl_users SET password ='$password' WHERE id = '$userid'"; 
    databaseUpdate($sqlupdate); 
    die(); 
} 
 
if (isset($_POST['name'])) { 
    $name = $_POST['name']; 
    $userid = $_POST['userid']; 
    $sqlupdate = "UPDATE tbl_users SET username ='$name' WHERE id = '$userid'"; 
    databaseUpdate($sqlupdate); 
    die(); 
} 
function databaseUpdate($sql){ 
    include_once("dbconnect.php"); 
    if ($conn->query($sql) === TRUE) { 
    $response = array('status' => 'success', 'data' => null); 
    sendJsonResponse($response); 
    } else { 
    $response = array('status' => 'failed', 'data' => null); 
    sendJsonResponse($response); 
    } 
    }  
    
function sendJsonResponse($sentArray)
    {
        header('Content-Type: application/json');
        echo json_encode($sentArray);
    }
?>
