<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin: Home</title>
<%@include file="allCss.jsp"%>
<style>
.card-icon {
    font-size: 2rem;
    margin-bottom: 1rem;
}

.card-container {
    margin: 10px;
}

.card {
    cursor: pointer;
    transition: transform 0.3s ease;
    border: none; /* Remove default border */
}

.card:hover {
    transform: scale(1.05);
}

.card-link {
    text-decoration: none;
    color: inherit;
}

.centered-cards {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 60vh;
    padding: 20px;
}

.card-wrapper {
    margin: 15px;
}
</style>
</head>
<body>

<script>
    function getGreeting() {
        const now = new Date();
        const hours = now.getHours();
        let greeting = '';

        if (hours >= 5 && hours < 12) {
            greeting = 'Good Morning ';
        } else if (hours >= 12 && hours < 17) {
            greeting = 'Good Afternoon';
        } else if (hours >= 17 && hours < 21) {
            greeting = 'Good Evening';
        } else {
            greeting = 'Good Night';
        }

        return greeting;
    }

    window.onload = function() {
        const greeting = getGreeting();
        document.getElementById('greeting').textContent = greeting;
    }
</script>

<%@include file="navbar.jsp" %>

<div class="container">
    <div class="row centered-cards">
        <h1 id="greeting">Welcome! </h1>
        
        <!-- Add Book Card -->
        <div class="col-md-3 card-wrapper">
            <a href="addbook.jsp" class="card-link">
                <div class="card bg-primary text-white">
                    <div class="card-body text-center">
                        <i class="fas fa-book card-icon"></i>
                        <h5 class="card-title">Add Book</h5>
                    </div>
                </div>
            </a>
        </div>
        <!-- All Books Card -->
        <div class="col-md-3 card-wrapper">
            <a href="allBooks.jsp" class="card-link">
                <div class="card bg-success text-white">
                    <div class="card-body text-center">
                        <i class="fas fa-list card-icon"></i>
                        <h5 class="card-title">All Books</h5>
                    </div>
                </div>
            </a>
        </div>
        <!-- Orders Card -->
        <div class="col-md-3 card-wrapper">
            <a href="orders.jsp" class="card-link">
                <div class="card bg-warning text-white">
                    <div class="card-body text-center">
                        <i class="fas fa-shopping-cart card-icon"></i>
                        <h5 class="card-title">Orders</h5>
                    </div>
                </div>
            </a>
        </div>
        <!-- Logout Card -->
        <div class="col-md-3 card-wrapper">
            <a href="../logout"  id="redlogoutButton" class="card-link">
                <div class="card bg-danger text-white">
                    <div class="card-body text-center">
                        <i class="fas fa-sign-out-alt card-icon"></i>
                        <h5 class="card-title">Logout</h5>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('redlogoutButton').addEventListener('click', function(event) {
        event.preventDefault(); // Prevent the default action (navigation)

        Swal.fire({
            title: 'Are you sure?',
            text: 'Do you really want to log out?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, log out!',
            cancelButtonText: 'No, cancel!'
        }).then((result) => {
            if (result.isConfirmed) {
                // Redirect to logout URL
                window.location.href = '../logout'; // Adjust URL as needed
            }
        });
    });
});
</script>


<%@include file="footer.jsp"%>
</body>
</html>
