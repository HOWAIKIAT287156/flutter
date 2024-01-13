<?php
// error_reporting(0);

if (!isset($_POST['buyer_id']) || !isset($_POST['seller_id']) || !isset($_POST['book_id']) || !isset($_POST['quantity'])) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$buyer_id = $_POST['buyer_id'];
$seller_id = $_POST['seller_id'];
$book_id = $_POST['book_id'];
$quantity = $_POST['quantity'];

// Check if the same cart already exists
$sqlCheckCart = "SELECT * FROM `tbl_carts` WHERE `buyer_id` = '$buyer_id' AND `seller_id` = '$seller_id' AND `book_id` = '$book_id'";
$resultCheckCart = $conn->query($sqlCheckCart);

if ($resultCheckCart->num_rows > 0) {
    // If the same cart exists, update cart_qty
    $row = $resultCheckCart->fetch_assoc();
    $currentCartQty = $row['cart_qty'];

    // Calculate the total quantity after adding the new quantity
    $totalQuantity = $currentCartQty + $quantity;

    // Check if the total quantity exceeds book_qty in tbl_books
    $sqlCheckBookQty = "SELECT `book_qty` FROM `tbl_books` WHERE `book_id` = '$book_id'";
    $resultCheckBookQty = $conn->query($sqlCheckBookQty);

    if ($resultCheckBookQty->num_rows > 0) {
        $rowBookQty = $resultCheckBookQty->fetch_assoc();
        $bookQty = $rowBookQty['book_qty'];

        if ($totalQuantity > $bookQty) {
            $response = array('status' => 'failed', 'data' => null, 'error' => 'Total quantity exceeds available stock.');
            sendJsonResponse($response);
            die();
        }
    }

    // Update cart_qty in tbl_carts
    $newCartQty = $currentCartQty + $quantity;
    $sqlUpdateCart = "UPDATE `tbl_carts` SET `cart_qty` = '$newCartQty' WHERE `buyer_id` = '$buyer_id' AND `seller_id` = '$seller_id' AND `book_id` = '$book_id'";

    if ($conn->query($sqlUpdateCart) === TRUE) {
        $response = array('status' => 'success', 'data' => $sqlUpdateCart);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'data' => $sqlUpdateCart, 'error' => mysqli_error($conn));
        sendJsonResponse($response);
    }

} else if ($quantity > 1){
    $cart_status = "New";

        $sqlInsertCart = "INSERT INTO `tbl_carts`(`buyer_id`, `seller_id`, `book_id`, `cart_qty`, `cart_status`) VALUES ('$buyer_id','$seller_id','$book_id','$quantity','$cart_status')";

        if ($conn->query($sqlInsertCart) === TRUE) {
            $response = array('status' => 'success', 'data' => $sqlInsertCart);
            sendJsonResponse($response);
        } else {
            $response = array('status' => 'failed', 'data' => $sqlInsertCart, 'error' => mysqli_error($conn));
            sendJsonResponse($response);
        }


    }else {
        // If the same cart does not exist, insert a new cart
        $cart_qty = 1;
        $cart_status = "New";

        $sqlInsertCart = "INSERT INTO `tbl_carts`(`buyer_id`, `seller_id`, `book_id`, `cart_qty`, `cart_status`) VALUES ('$buyer_id','$seller_id','$book_id','$cart_qty','$cart_status')";

        if ($conn->query($sqlInsertCart) === TRUE) {
            $response = array('status' => 'success', 'data' => $sqlInsertCart);
            sendJsonResponse($response);
        } else {
            $response = array('status' => 'failed', 'data' => $sqlInsertCart, 'error' => mysqli_error($conn));
            sendJsonResponse($response);
        }
    }

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>


