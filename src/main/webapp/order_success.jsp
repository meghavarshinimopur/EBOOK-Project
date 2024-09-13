<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Success</title>
    <%@ include file="allcomponents/allCss.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        #thankYouContent {
            display: none; /* Initially hide the thank you content */
        }
        .btn-outline-primary:hover {
            background-color: #007bff;
            color: #fff;
        }
        .btn-outline-danger:hover {
            background-color: #dc3545;
            color: #fff;
        }
        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }
    </style>
</head>
<body>
    <%@ include file="allcomponents/navbar.jsp"%>
 <c:if test="${ empty userobj}">
            <c:redirect url="login.jsp"/>
        </c:if > 
    <!-- SweetAlert Success Message -->
    <script>
        Swal.fire({
            icon: 'success',
            title: 'Thank You!',
            text: 'Your order has been placed successfully. It will be delivered within 7 days.',
            confirmButtonText: 'Ok',
            timer: 3000, // Set timer to 3 seconds
            timerProgressBar: true, // Show progress bar
            didOpen: () => {
                Swal.showLoading() // Show loading animation
            }
        }).then((result) => {
            // When the SweetAlert is closed, display the thank you content
            document.getElementById("thankYouContent").style.display = "block";
        });
    </script>

    <!-- Hidden Thank You Content -->
   <div id="thankYouContent" class="container text-center mt-5">
        <div class="jumbotron py-5 px-4 shadow-lg rounded-lg bg-light" style="border: 2px solid #e6e6e6; background-image: linear-gradient(135deg, #f9f9f9, #e6e6e6);">
            <h1 class="display-4" style="color: #5a5a5a;">Thank You!</h1>
            <p class="lead" style="color: #4a4a4a;">Your order has been successfully placed!</p>
            <hr class="my-4">
            <p class="h5" style="color: #777;">Your product will be delivered within 7 days.</p>
            
            <div class="mt-4 d-flex justify-content-center">
                <a href="index.jsp" class="btn btn-outline-primary btn-lg mx-2" style="transition: 0.3s ease;">Home</a>
                <a href="orders.jsp" class="btn btn-outline-danger btn-lg mx-2" style="transition: 0.3s ease;">View Orders</a>
            </div>
        </div>
    </div>

    <%@ include file="allcomponents/footer.jsp"%>
</body>
</html>
