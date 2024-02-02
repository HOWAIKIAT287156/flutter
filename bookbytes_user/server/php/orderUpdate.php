<?php

include_once("dbconnect.php");
// Check if all necessary parameters are present
if(isset($_GET['userid'], $_GET['username'], $_GET['useremail'], $_GET['usercontact'], $_GET['totalprice'], $_GET['orderStatus'])) {
    // Retrieve parameters
    $userId = $_GET['userid'];
    $userName = $_GET['username'];
    $userEmail = $_GET['useremail'];
    $userContact = $_GET['usercontact'];
    $totalPrice = $_GET['totalprice'];
    $orderStatus = $_GET['orderStatus'];
    $receiptId = str_pad(rand(100000, 999999), 6, '0', STR_PAD_LEFT);

}

if ($orderStatus=="true"){
    $orderStatus = "Success";
}else{
    $orderStatus = "Failed";
}

if ($orderStatus == "Success"){ //payment success
     
    $sqlcart = "SELECT * FROM `tbl_carts` WHERE `cart_status`='New' AND `buyer_id` = '$userId' ORDER BY `seller_id`;";
    $result = $conn->query($sqlcart);
    $seller = "0";
    $total = 0;
    $rows = $result->num_rows;
    if ($rows > 0) {
        $cartslist["carts"] = array();
        $i = 0;
        while ($row = $result->fetch_assoc()) {
            $i++;
            $cartarray = array();
            $cartarray['cart_id'] = $row['cart_id'];
            $cartarray['buyer_id'] = $row['buyer_id'];
            $cartarray['seller_id'] = $row['seller_id'];
            $cartarray['book_id'] = $row['book_id'];
            $cartarray['cart_qty'] = $row['cart_qty'];
            $cartarray['cart_status'] = $row['cart_status'];  
           // print_r($cartarray);
            array_push($cartslist["carts"],$cartarray);
            // if ($rows == 1){
                $status = "New";
                $seller = $cartarray['seller_id'];
                $bookID = $cartarray['book_id'];
                $qty = $cartarray['cart_qty'];
                $sqlinsertorder = "INSERT INTO `tbl_orders`(`buyer_id`, `seller_id`, `book_id`, `book_qty`, `order_status`, `receipt_id`) VALUES ('$userId','$seller','$bookID','$qty','$status','$receiptId')";
                $conn->query($sqlinsertorder);   


                $sqlGetBookQty = "SELECT `book_qty` FROM `tbl_books` WHERE `book_id` = '$bookID'";
                $resultBookQty = $conn->query($sqlGetBookQty);

                if ($resultBookQty->num_rows > 0) {
                    
                    $row = $resultBookQty->fetch_assoc();
                    $currentBookQty = $row['book_qty'];

                    $newBookQty = $currentBookQty - $qty;

                    $sqlupdatebook = "UPDATE `tbl_books` SET `book_qty`='$newBookQty' WHERE `book_id` = '$bookID'";
                    $conn->query($sqlupdatebook);
                }
            // }else{
            //     if ($i == 1 ){
            //         $seller = $row['seller_id'];
            //         $total = $total + ($cartarray['cart_qty'] * $cartarray['book_price']); 
            //     }else{
            //         if ($seller == $row['seller_id']){
            //             $total = $total+ $cartarray['cart_qty'] * $cartarray['book_price'];
            //             if ($i == $rows){
            //              $status = "New";
            //              $sqlinsertorder = "INSERT INTO `tbl_orders`(`buyer_id`, `seller_id`, `order_total`, `order_status`) VALUES ('$userId','$seller','$total','$status')";
            //              $conn->query($sqlinsertorder);   
            //             }
            //         }else{
            //              $status = "New";
            //              $sqlinsertorder = "INSERT INTO `tbl_orders`(`buyer_id`, `seller_id`, `order_total`, `order_status`) VALUES ('$userId','$seller','$total','$status')";
            //              $conn->query($sqlinsertorder);
            //              $seller = $row['seller_id'];
            //              $total = 0;
            //         }    
            //     } 
            // }
        }
    }
    
    //update cart paid status
    $sqlupdatecart = "UPDATE `tbl_carts` SET `cart_status`='Paid' WHERE `buyer_id` = '$userId' AND `cart_status` = 'New'";
    $conn->query($sqlupdatecart);

    $sqlinsertreceipt = "INSERT INTO `tbl_receipts` (`receipt_id`, `receipt_total`) VALUES ('$receiptId','$totalPrice')";
    $conn->query($sqlinsertreceipt);
    
    //print receipt for success transaction
    echo "
    <html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
    <link rel=\"stylesheet\" href=\"https://www.w3schools.com/w3css/4/w3.css\">
    <body>
    <center><h4>Receipt</h4></center>
    <table class='w3-table w3-striped'>
    <th>Item</th><th>Description</th>
    <tr><td>Receipt</td><td>$receiptId</td></tr>
    <tr><td>Name</td><td>$userName</td></tr>
    <tr><td>Email</td><td>$userEmail</td></tr>
    <tr><td>Phone</td><td>$userContact</td></tr>
    <tr><td>Paid Amount</td><td>RM$totalPrice</td></tr>
    <tr><td>Paid Status</td><td class='w3-text-green'>$orderStatus</td></tr>
    </table><br>
    </body>
    </html>";
}
else 
{
    //print receipt for failed transaction
     echo "
    <html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
    <link rel=\"stylesheet\" href=\"https://www.w3schools.com/w3css/4/w3.css\">
    <body>
    <center><h4>Receipt</h4></center>
    <table class='w3-table w3-striped'>
    <th>Item</th><th>Description</th>
    <tr><td>Receipt</td><td>$receiptId</td></tr>
    <tr><td>Name</td><td>$userName</td></tr>
    <tr><td>Email</td><td>$userEmail</td></tr>
    <tr><td>Phone</td><td>$userContact</td></tr>
    <tr><td>Paid Amount</td><td>RM$totalPrice</td></tr>
    <tr><td>Paid Status</td><td class='w3-text-red'>$orderStatus</td></tr>
    </table><br>
    
    </body>
    </html>";
}

?>