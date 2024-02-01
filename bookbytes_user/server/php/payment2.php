<!DOCTYPE html>
<html>
<head>
    <title>Payment Page</title>
    <style>
        body {
            font-size: 24px;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }

        .container {
            width: 80%;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: left;
            margin: 20px auto;
        }
        
        h1{
            font-size: 50px;
            margin: 10px 0;
        }

        p {
            font-size: 38px;
            margin: 10px 0;
        }

        .row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .total {
            margin-top: 20px;
            font-size: 60px;
        }

        .button-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-gap: 10px;
            margin-top: 20px;
        }

        .button {
            text-align: center;
            padding: 60px;
            background-color: #ddd;
            border: 2px solid transparent;
            border-radius: 5px;
            cursor: pointer;
        }

        .button img {
            max-width: 100px;
            max-height: 100px;
        }

        .button p {
            margin-top: 120px; /* Add space between image and text */
        }

        .accept {
            font-size: 50px;
            width: 80%;
            margin: 0 auto;
            text-align: left;
        }

        .accept input[type="checkbox"] {
            transform: scale(2); /* Increase checkbox size */
            margin-right: 20px; /* Add space between checkbox and label */
        }

        .accept label {
            display: inline-block;
            vertical-align: middle;
            font-size: 40px;
            text-decoration: underline;
            cursor: pointer;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 9999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }

        /* Modal Content */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 10px;
        }

        /* The Close Button */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .pay-button {
            background-color: #607d8b;
            color: #fff;
            padding: 30px 60px;
            border: none;
            border-radius: 5px;
            font-size: 36px;
            margin-top: 20px;
            cursor: pointer;
            width: 80%;
            display: block;
            margin: 20px auto;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Payment Details</h1>
        <div class="row">
            <p>Bill ID: <?php echo rand(1000,9999); ?></p>
            <p>Date: <?php echo date('Y-m-d H:i'); ?></p>
        </div>
        <p>User ID: <?php echo  $_GET['userid']; ?></p>
        <p>User Email: <?php echo  $_GET['useremail']; ?></p>
        <p>User Name: <?php echo  $_GET['username']; ?></p>
        <p>Contact: <?php echo $_GET['usercontact']; ?></p>
        <!-- Add your payment form or content here -->
    </div>
    <div class="total">
        <p style="font-size: 48px;">Total: RM<?php echo $_GET['totalprice']; ?></p>
    </div>

    <div class="button-container">
        <div class="button" onclick="toggleButton(this)">
            <img src="" alt="Image 1">
            <p>Bank 1</p>
        </div>
        <div class="button" onclick="toggleButton(this)">
            <img src="" alt="Image 2">
            <p>Bank 2</p>
        </div>
        <div class="button" onclick="toggleButton(this)">
            <img src="" alt="Image 1">
            <p>Bank 3</p>
        </div>
        <div class="button" onclick="toggleButton(this)">
            <img src="" alt="Image 2">
            <p>Bank 4</p>
        </div>
        <div class="button" onclick="toggleButton(this)">
            <img src="" alt="Image 1">
            <p>Bank 5</p>
        </div>
        <div class="button" onclick="toggleButton(this)">
            <img src="" alt="Image 2">
            <p>Bank 6</p>
        </div>
        <div class="button" onclick="toggleButton(this)">
            <img src="" alt="Image 1">
            <p>Bank 7</p>
        </div>
        <div class="button" onclick="toggleButton(this)">
            <img src="" alt="Image 2">
            <p>Bank 8</p>
        </div>
        <div class="button" onclick="toggleButton(this)">
            <img src="" alt="Image 1">
            <p>Bank 9</p>
        </div>
        
    </div>

    <div class="accept">
    <input type="checkbox" id="acceptCheckbox" onclick="toggleAccept()">
    <label for="acceptCheckbox" onclick="openModal(event)">I accept the terms and conditions</label>
</div>

    <div id="myModal" class="modal">
      <div class="modal-content">
        <span class="close">&times;</span>
        <p>Payment is due within fourteen (14) days from the date of the invoice. 
          A late fee applies if payment is not made by the due date. When making 
          your payment, please reference the invoice number. Discrepancies should 
          be reported within seven (7) days of receipt.</p>
      </div>
    </div>

    <button class="pay-button" onclick="pay()">Pay</button>

    

    <script>
        let selectedButton = null;

        function toggleButton(button) {
            if (button === selectedButton) {
                // Deselect button
                button.style.borderColor = 'transparent';
                selectedButton = null;
            } else {
                // Deselect previously selected button if any
                if (selectedButton) {
                    selectedButton.style.borderColor = 'transparent';
                }
                // Select new button
                button.style.borderColor = 'blue';
                selectedButton = button;
            }
        }

        // Function to handle the opening of the modal dialog
        function openModal(event) {
        // Prevent the default behavior of the checkbox
        event.preventDefault();

        var modal = document.getElementById("myModal");
        modal.style.display = "block";
    }

        // Function to handle the toggling of the accept checkbox
        function toggleAccept() {
            let acceptCheckbox = document.getElementById("acceptCheckbox");
            if (acceptCheckbox.checked) {
                acceptCheckbox.setCustomValidity('');
            } else {
                acceptCheckbox.setCustomValidity('Please accept the terms and conditions');
            }
        }

        // Function to handle the payment process
        function pay() {
            let acceptCheckbox = document.getElementById("acceptCheckbox");
            if (!selectedButton) {
                alert("Please select a bank.");
            } else if (!acceptCheckbox.checked) {
                alert("Please accept the terms and conditions.");
            } else {
                // Get the user ID and total price from the URL query parameters
                const urlParams = new URLSearchParams(window.location.search);
                const userId = urlParams.get('userid');
                const totalPrice = urlParams.get('totalprice');
                
                // Construct the URL for order.php with the user ID and total price as query parameters
                const orderUrl = `order.php?userid=${userId}&totalprice=${totalPrice}`;

                window.location.href = payment2Url;
            }
        }
    </script>

    <script>
        // Get the modal
        var modal = document.getElementById("myModal");

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        // When the user clicks on <span> (x), close the modal
        span.onclick = function() {
        modal.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
        }
    </script>


</body>
</html>