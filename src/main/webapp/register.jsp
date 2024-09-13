<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ebook: Register</title>
    <%@ include file="allcomponents/allCss.jsp"%>
   
    <!-- Include SweetAlert2 CSS and JS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        .sp {
            color: red;
        }
        /* Modal styles */
        .modal-content {
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width:80%;
            height:30vh;
            color:#303f9f;
        }
        .modal-header {
            border-bottom: none;
        }
        .modal-body {
            text-align: center;
        }
        .modal-title {
            font-size: 22px;
            color: #333;
            color:#303f9f;
        }
        .modal-footer {
            border-top: none;
        }
        .btn-close {
           color:#303f9f;
        }
        .btn-close:hover {
            color: #0056b3;
        }
    </style>
</head>
<body>
    <%@ include file="allcomponents/navbar.jsp"%>
    <div class="container d-flex justify-content-center align-items-center mt-4 vh-100">
        <div class="card p-4 shadow-sm" style="max-width: 500px; width: 100%;">
            <h2 class="card-title text-center mb-4">Register</h2>
            
            <!-- Display the form -->
            <form method="post" action="register">
                <div class="mb-3">
                    <label for="name" class="form-label">Name<span class="sp">*</span></label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email address<span class="sp">*</span></label>
                    <input type="email" class="form-control" name="email" id="email" placeholder="Enter your email" required>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone<span class="sp">*</span></label>
                    <input type="number" class="form-control" id="phone" name="phone" placeholder="Enter your number" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password<span class="sp">*</span></label>
                    <input type="password" class="form-control" name="password" id="password" placeholder="Enter your password" required>
                </div>
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">Confirm Password<span class="sp">*</span></label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                </div>
                <div class="form-check mb-3">
                    <input type="checkbox" class="form-check-input" id="showPassword" name="checkbox1" onclick="togglePassword()">
                    <label class="form-check-label" for="showPassword">Show Password</label>
                </div>
                <div class="form-check mb-3">
                    <input type="checkbox" class="form-check-input" id="checkbox" name="checkbox">
                    <label class="form-check-label" for="checkbox">Agree to Terms & Conditions</label>
                </div>
                <button type="submit" class="btn btn-primary w-100">Register</button>
            </form>
        </div>
    </div>

    <script>
        // Display SweetAlert2 popup if there's a message
        document.addEventListener('DOMContentLoaded', function() {
            <% 
                String msg = (String) request.getAttribute("msg");
                String messageType = (String) request.getAttribute("messageType");
                if (msg != null && messageType != null) {
            %>
            Swal.fire({
                icon: '<%= messageType %>',
                title: '<%= messageType.equals("success") ? "Success" : "Error" %>',
                text: '<%= msg %>',
                confirmButtonText: 'OK'
            });
            <% 
                    // Clear message attributes
                    request.removeAttribute("msg");
                    request.removeAttribute("messageType");
                }
            %>
        });
        
        // Function to toggle password visibility
        function togglePassword() {
            var password = document.getElementById("password");
            var confirmPassword = document.getElementById("confirmPassword");
            if (document.getElementById("showPassword").checked) {
                password.type = "text";
                confirmPassword.type = "text";
            } else {
                password.type = "password";
                confirmPassword.type = "password";
            }
        }
    </script>
    <%@ include file="allcomponents/footer.jsp"%>
</body>
</html>
