<?php
// error_reporting(0);

if (!isset($_POST['buyer_id']) || !isset($_POST['seller_id']) || !isset($_POST['book_id'])) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$buyer_id = $_POST['buyer_id'];
$seller_id = $_POST['seller_id'];
$book_id = $_POST['book_id'];

// Check if the combination already exists
$sqlCheck = "SELECT * FROM `tbl_carts` WHERE `buyer_id` = '$buyer_id' AND `seller_id` = '$seller_id' AND `book_id` = '$book_id'";
$resultCheck = $conn->query($sqlCheck);

if ($resultCheck->num_rows > 0) {
    // If the combination exists, update cart_qty by incrementing it by 1
    $row = $resultCheck->fetch_assoc();
    $newCartQty = $row['cart_qty'] + 1;
    $sqlUpdate = "UPDATE `tbl_carts` SET `cart_qty` = '$newCartQty' WHERE `buyer_id` = '$buyer_id' AND `seller_id` = '$seller_id' AND `book_id` = '$book_id'";

    if ($conn->query($sqlUpdate) === TRUE) {
        $response = array('status' => 'success', 'data' => $sqlUpdate);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'data' => $sqlUpdate, 'error' => mysqli_error($conn));
        sendJsonResponse($response);
    }
} else {
    $cart_qty = 1;
    $cart_status = "New";

    $sqlInsert = "INSERT INTO `tbl_carts`(`buyer_id`, `seller_id`, `book_id`, `cart_qty`, `cart_status`) VALUES ('$buyer_id','$seller_id','$book_id','$cart_qty','$cart_status')";

    if ($conn->query($sqlInsert) === TRUE) {
        $response = array('status' => 'success', 'data' => $sqlInsert);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'data' => $sqlInsert, 'error' => mysqli_error($conn));
        sendJsonResponse($response);
    }
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
