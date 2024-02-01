<?php
// Include your database connection file
include_once("dbconnect.php");

// Check if the required parameters are set
if (isset($_POST['cart_id'])) {
    // Sanitize the input to prevent SQL injection
    $cartId = mysqli_real_escape_string($conn, $_POST['cart_id']);

    // Perform the deletion query
    $query = "DELETE FROM tbl_carts WHERE cart_id = '$cartId'";
    $result = mysqli_query($conn, $query);

    if ($result) {
        // Deletion successful
        $response['status'] = "success";
        $response['message'] = "Item deleted from cart.";
    } else {
        // Deletion failed
        $response['status'] = "error";
        $response['message'] = "Failed to delete item from cart.";
    }

    // Return the JSON response
    echo json_encode($response);

    // Close the database connection
    mysqli_close($conn);

    // Stop further execution
    exit;
} else {
    // Invalid or missing parameters
    $response['status'] = "error";
    $response['message'] = "Invalid parameters.";
    
    // Return the JSON response
    echo json_encode($response);

    // Close the database connection
    mysqli_close($conn);

    // Stop further execution
    exit;
}
?>