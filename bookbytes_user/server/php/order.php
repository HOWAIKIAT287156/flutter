<?php

include_once("dbconnect.php");

// Retrieve user ID and total price from URL query parameters
$userId = $_GET['userid'];
$totalPrice = $_GET['totalprice'];

// Convert user ID and total price to integers
$userId = intval($userId);
$totalPrice = intval($totalPrice);

// Prepare SQL statement
$stmt = $conn->prepare("INSERT INTO tbl_orders (buyer_id, order_total) VALUES (?, ?)");

// Bind parameters
$stmt->bind_param("ii", $userId, $totalPrice);

// Execute statement
if ($stmt->execute() === TRUE) {
    // Close connection
    $stmt->close();
    $conn->close();

    // Redirect to payment2.php with userid and totalprice as query parameters
    header("Location: payment2.php?userid=$userId&totalprice=$totalPrice");
    exit(); // Stop further execution of the script
} else {
    echo "Error: " . $stmt->error;
    // Close connection
    $stmt->close();
    $conn->close();
}
?>
