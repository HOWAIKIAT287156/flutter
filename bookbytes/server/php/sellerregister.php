<?php
//error_reporting(0);
if (!isset($_POST['email']) && !isset($_POST['contact']) && !isset($_POST['username']) && !isset($_POST['password'])) {
    $response = array('status' => 'failed', 'data' => null,);
    sendJsonResponse($response);
    die();
}


include_once("dbconnect.php");

$email = $_POST['email'];
$contact = $_POST['contact'];
$username = $_POST['username'];
$password = sha1($_POST['password']);
$address = addslashes($_POST['address']);
$seller = "Seller";
$sqlinsert = "INSERT INTO `tbl_users`(`email`, `username`, `contact`, `password`, `address`,`type`) VALUES ('$email','$username','$contact','$password', '$address', '$seller')";


if ($conn->query($sqlinsert) === TRUE) {
	$response = array('status' => 'success', 'data' => null);
    sendJsonResponse($response);
}else{
	$response = array('status' => 'failed', 'data' => null,);
	sendJsonResponse($response);
}


function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>