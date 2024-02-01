<?php
include_once("dbconnect.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $cartId = $_POST['cart_id'];

    // Get current cart quantity
    $getCurrentQtySql = "SELECT cart_qty, book_id FROM tbl_carts WHERE cart_id = ?";
    $stmtGetQty = $conn->prepare($getCurrentQtySql);
    $stmtGetQty->bind_param('s', $cartId);
    $stmtGetQty->execute();
    $stmtGetQty->bind_result($currentQty, $bookId);
    $stmtGetQty->fetch();
    $stmtGetQty->close();

    // Get book quantity
    $getBookQtySql = "SELECT book_qty FROM tbl_books WHERE book_id = ?";
    $stmtGetBookQty = $conn->prepare($getBookQtySql);
    $stmtGetBookQty->bind_param('s', $bookId);
    $stmtGetBookQty->execute();
    $stmtGetBookQty->bind_result($bookQty);
    $stmtGetBookQty->fetch();
    $stmtGetBookQty->close();

    // Increase cart quantity
    $newQty = $currentQty + 1;

    // Check if the new quantity is smaller than or equal to book quantity
    if ($newQty <= $bookQty) {
        // Update cart quantity in tbl_carts
        $updateCartSql = "UPDATE tbl_carts SET cart_qty = ? WHERE cart_id = ?";
        $stmtUpdateCart = $conn->prepare($updateCartSql);
        $stmtUpdateCart->bind_param('ss', $newQty, $cartId);
        
        if ($stmtUpdateCart->execute()) {
            echo json_encode(['status' => 'success', 'message' => 'Cart updated successfully']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Failed to update cart']);
        }
        $stmtUpdateCart->close();
    } else {
        echo json_encode(['status' => 'failed', 'message' => 'Quantity exceeds available stock,Wait for owner to restock!']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method']);
}

$conn->close();
?>
