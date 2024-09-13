<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ebook: Login</title>
    <%@ include file="allcomponents/allCss.jsp" %>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .sp {
            color: red; /* Style for mandatory field indicator */
        }
        .modal-content {
            position: relative;
            padding: 1.25rem;
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: .3rem;
        }
        .modal-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid #dee2e6;
        }
        .btn-close {
            background: none;
            border: none;
            font-size: 1.5rem;
            line-height: 1;
            color: #000;
            opacity: .5;
        }
    </style>
</head>
<body>

<%@ include file="allcomponents/navbar.jsp" %>

<!-- Login Form -->
<div class="container d-flex justify-content-center align-items-center ">
    <div class="card p-4 shadow-sm" style="max-width: 400px; margin-top: 25px; width: 100%;">
        <h2 class="card-title text-center mb-4">Login</h2>
        <form method="post" action="login">
            <div class="mb-3">
                <label for="email" class="form-label">Email<span class="sp">*</span></label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password<span class="sp">*</span></label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
            </div>
            <div class="form-check mb-3">
                <input type="checkbox" class="form-check-input" id="showPassword" onclick="togglePassword()">
                <label class="form-check-label" for="showPassword">Show Password</label>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
            <p class="text-center mt-3">
                <a href="forgotPassword.jsp" class="d-block">Forgot Password?</a>
                <a href="register.jsp" class="d-block">New User? Register Here</a>
            </p>
        </form>
    </div>
</div>

<!-- Include Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    // Function to toggle password visibility
    function togglePassword() {
        var passwordField = document.getElementById('password');
        if (passwordField.type === 'password') {
            passwordField.type = 'text';
        } else {
            passwordField.type = 'password';
        }
    }

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
</script>

<%@ include file="allcomponents/footer.jsp" %>
</body>
</html>
