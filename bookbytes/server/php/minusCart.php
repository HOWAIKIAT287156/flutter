<?php
include_once("dbconnect.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $cartId = $_POST['cart_id'];

    // Update cart_qty in tbl_carts
    $sql = "UPDATE tbl_carts SET cart_qty = cart_qty - 1 WHERE cart_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('s', $cartId);
    
    if ($stmt->execute()) {
        // Check if cart_qty is zero, and delete the cart if needed
        $sql = "DELETE FROM tbl_carts WHERE cart_id = ? AND cart_qty = 0";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('s', $cartId);
        $stmt->execute();

        echo json_encode(['status' => 'success', 'message' => 'Cart updated successfully']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Failed to update cart']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method']);
}

$conn->close();
?>