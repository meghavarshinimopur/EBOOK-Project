<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Entity.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f8f9fa;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }

        .profile-card {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
            padding: 20px;
            width: 100%;
            max-width: 600px;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .emoji-display {
            font-size: 100px;
            cursor: pointer;
            margin-bottom: 20px;
        }

        .user-name {
            font-size: 24px;
            margin-bottom: 10px;
            color: #007bff;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile-card">
            <% 
            User u = (User) session.getAttribute("userobj");
            if (u != null) {
                String profileEmoji = u.getProfileImage() != null ? u.getProfileImage() : "😊"; // Default emoji
            %>
            <!-- Display Emoji Instead of Image -->
            <div class="emoji-display" id="profileEmoji"><%= profileEmoji %></div>
            <h3 class="user-name">Welcome, <%= u.getName() %>!</h3>
            
            <script>
            $(document).ready(function() {
                $('#profileEmoji').on('click', function() {
                    // Show SweetAlert with emoji on top
                    Swal.fire({
                        title: '<%= u.getName() %>',
                        html: `
                            <div style="text-align: center;">
                                <div style="font-size: 100px; margin-bottom: 20px;"><%= profileEmoji %></div>
                                <p><strong>Email:</strong> <%= u.getEmail() %></p>
                                <p><strong>Phone:</strong> <%= u.getPhno() %></p>
                                <p><strong>Address:</strong> <%= u.getAddress() %></p>
                                <p><strong>Landmark:</strong> <%= u.getLandmark() %></p>
                                <p><strong>City:</strong> <%= u.getCity() %></p>
                                <p><strong>State:</strong> <%= u.getState() %></p>
                                <p><strong>Pincode:</strong> <%= u.getPincode() %></p>
                            </div>
                        `,
                       
                        confirmButtonText: 'Close'
                    });
                });
            });
            </script>
            <% } else { %>
            <p>Please log in to view your profile details.</p>
            <script>
                setTimeout(function(){
                    window.location.href = 'login.jsp';
                }, 3000);
            </script>
            <% } %>
        </div>
    </div>
</body>
</html>
