<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>
<%@ include file="allcomponents/allCss.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<body>

<%@ include file="allcomponents/navbar.jsp" %>

<div class="container d-flex justify-content-center align-items-center mt-4 vh-100">
    <div class="card p-4 shadow-sm" style="max-width: 500px; width: 100%;">
        <h2 class="card-title text-center mb-4">Edit Profile</h2>

        <!-- Display the form -->
        <form method="post" action="update_profile">
            <input type="hidden" value="${userobj.id}" name="id">
            <div class="mb-3">
                <label for="name" class="form-label">Name<span class="sp">*</span></label>
                <input type="text" class="form-control" id="name" name="name" value="${userobj.name}" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email address<span class="sp">*</span></label>
                <input type="email" class="form-control" name="email" id="email" value="${userobj.email}" required>
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">Phone<span class="sp">*</span></label>
                <input type="number" class="form-control" id="phone" name="phone" value="${userobj.phno}" required>
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

            <button type="submit" class="btn btn-primary w-100">Update Profile</button>
        </form>
    </div>
</div>

<script type="text/javascript">
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

    // SweetAlert notifications for success and error messages
    <% if (session.getAttribute("successMessage") != null) { %>
        Swal.fire({
            icon: 'success',
            title: 'Success',
            text: '<%= session.getAttribute("successMessage") %>'
        });
        <% session.removeAttribute("successMessage"); %>
    <% } else if (session.getAttribute("errorMessage") != null) { %>
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: '<%= session.getAttribute("errorMessage") %>'
        });
        <% session.removeAttribute("errorMessage"); %>
    <% } %>
</script>

<%@ include file="allcomponents/footer.jsp" %>
</body>
</html>
