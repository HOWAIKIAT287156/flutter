<!DOCTYPE html>
<html>
<head>
    <title>Payment Confirmation</title>
    <style>
        body {
            font-size: 36px;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 80%;
            background-color: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        
        h1 {
            font-size: 60px;
            margin: 20px 0;
        }

        p {
            font-size: 48px;
            margin: 10px 0;
        }

        .total {
            margin-top: 40px;
            font-size: 72px;
        }

        .button-row {
            display: flex;
            justify-content: center;
            margin-top: 60px;
        }

        .button {
            padding: 20px 40px;
            font-size: 36px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            margin: 0 20px;
            width: 200px; /* Adjust the width of the buttons as needed */
        }

        .button.cancel {
            background-color: #f44336;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Payment Confirmation</h1>
        <div class="total">
            <p>Total: RM<?php echo $_GET['totalprice']; ?></p>
        </div>
        <div class="button-row">
            <button class="button pay" onclick="pay()">Pay</button>
            <button class="button cancel" onclick="cancel()">Cancel</button>
        </div>
    </div>

    <script>
        function pay() {
            // Get parameters from URL
            var userId = '<?php echo $_GET['userid']; ?>';
            var userName = '<?php echo $_GET['username']; ?>';
            var userEmail = '<?php echo $_GET['useremail']; ?>';
            var userContact = '<?php echo $_GET['usercontact']; ?>';
            var totalPrice = '<?php echo $_GET['totalprice']; ?>';
            var orderStatus = 'true';

            // Redirect to orderUpdate.php with parameters
            window.location.href = 'orderUpdate.php?userid=' + userId + '&username=' + userName 
            + '&useremail=' + userEmail + '&usercontact=' + userContact 
            + '&totalprice=' + totalPrice + '&orderStatus=' + orderStatus;
        }

        function cancel() {
            // Get parameters from URL
            var userId = '<?php echo $_GET['userid']; ?>';
            var userName = '<?php echo $_GET['username']; ?>';
            var userEmail = '<?php echo $_GET['useremail']; ?>';
            var userContact = '<?php echo $_GET['usercontact']; ?>';
            var totalPrice = '<?php echo $_GET['totalprice']; ?>';
            var orderStatus = 'false';

            // Redirect to orderUpdate.php with parameters
            window.location.href = 'orderUpdate.php?userid=' + userId + '&username=' + userName 
            + '&useremail=' + userEmail + '&usercontact=' + userContact 
            + '&totalprice=' + totalPrice + '&orderStatus=' + orderStatus;
        }
    </script>

</body>
</html>


