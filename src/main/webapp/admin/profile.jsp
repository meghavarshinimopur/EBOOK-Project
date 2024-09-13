<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Profile</title>
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

        .admin-profile {
            text-align: center;
        }

        .admin-profile-img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            cursor: pointer;
            border: 3px solid #007bff;
        }

        .admin-name {
            margin-top: 20px;
            font-size: 1.5rem;
            color: #007bff;
        }
    </style>
</head>
<body>
    <div class="admin-profile">
        <% 
            // Retrieve the user's email and name from the session
            String userEmail = (String) session.getAttribute("userEmail");
            String userName = (String) session.getAttribute("userName");

            // Profile images for different admins
            String profileImage = "../image/default_admin.png"; // Default image path

            // Specific profile details based on email
            String randomDOB = "N/A";
            String randomInstagram = "N/A";
            String randomGitHub = "N/A";
            String randomTask = "N/A";

            // Generate random tasks
            String[] tasks = {
                "Completed 12 tasks today.",
                "Reviewed 15 new book entries.",
                "Approved 5 new user registrations.",
                "Updated the product catalog.",
                "Handled 8 support tickets.",
                "Reviewed 20 customer feedbacks.",
                "Created a new promotion campaign.",
                "Managed 10 new user registrations."
            };

            // Get current day of the year
            java.util.Calendar calendar = java.util.Calendar.getInstance();
            int dayOfYear = calendar.get(java.util.Calendar.DAY_OF_YEAR);

            // Select task based on the day of the year
            randomTask = tasks[dayOfYear % tasks.length];

            if ("gajendrakawre540@gmail.com".equals(userEmail)) {
                profileImage = "../image/kawre.jpeg"; // Path to Gajendra Kawre profile image
                randomDOB = "December 20, 2001";
                randomInstagram = "@_Kawre540_";
                randomGitHub = "@gkawre";
            } else if ("mopurmeghavarshini@gmail.com".equals(userEmail)) {
                profileImage = "../image/mopur.png"; // Path to Meghavarshini Mopur profile image
                randomDOB = "March 15, 2001";
                randomInstagram = "@megha_mopur";
                randomGitHub = "@mopur_twitter";
            } else if ("admin@example1.com".equals(userEmail)) {
                profileImage = "../image/admin.png"; // Path to generic admin profile image
                randomDOB = "July 22, 1988";
                randomInstagram = "@admin_generic";
                randomGitHub = "@admin_tw";
            }

            // Check if the user is logged in
            if (userEmail != null && userName != null) {
        %>
        <img src="<%= profileImage %>" alt="<%= userName %>" class="admin-profile-img" id="adminProfileImg">
        <div class="admin-name">Welcome, <%= userName %>!</div>
        <% } else { %>
        <div class="admin-name">Please log in to see your profile details.</div>
        <p>Please log in to see your email and name. Redirecting to login page in 3 seconds...</p>
        <script type="text/javascript">
            setTimeout(function(){
                window.location.href = '../login.jsp'; // Adjust the path if necessary
            }, 3000);
        </script>
        <% } %>
    </div>

    <script>
        $(document).ready(function() {
            $('#adminProfileImg').on('click', function() {
                <% if (userEmail != null && userName != null) { %>
                    Swal.fire({
                        title: '<%= userName %>',
                        html: `
                            <p><strong>Email:</strong> <%= userEmail %></p>
                            <p><strong>Date of Birth:</strong> <%= randomDOB %></p>
                            <p><strong>Instagram:</strong> <a href="https://instagram.com/<%= randomInstagram.substring(1) %>" target="_blank"><%= randomInstagram %></a></p>
                            <p><strong>GitHub:</strong> <a href="https://github.com/<%= randomGitHub.substring(1) %>" target="_blank"><%= randomGitHub %></a></p>
                            <p><strong>Last Login:</strong> <%= new java.util.Date() %></p>
                            <p><strong>Task:</strong> <%= randomTask %></p>
                        `,
                        imageUrl: '<%= profileImage %>',
                        imageWidth: 150,
                        imageHeight: 150,
                        imageAlt: '<%= userName %>',
                        confirmButtonText: 'Close'
                    });
                <% } else { %>
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'You are not logged in. Please log in to view your details.'
                    });
                <% } %>
            });
        });
    </script>
</body>
</html>
