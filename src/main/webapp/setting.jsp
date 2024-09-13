<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<!-- Include Bootstrap CSS -->

<!-- Include your custom CSS -->
<%@ include file="allcomponents/allCss.jsp"%>
<style>
    .card-link {
        text-decoration: none;
        color: #333;
    }
    .card-link:hover {
        color: #007bff;
        text-decoration: none;
    }
    .card {
        transition: background-color 0.3s ease;
    }
    .card.custom-color {
        background-color: #f8f9fa; /* Example color, adjust as needed */
    }  
</style>
</head>
<body>

<!-- Include Navbar -->
<%@ include file="allcomponents/navbar.jsp"%>
 <c:if test="${ empty userobj}">
            <c:redirect url="login.jsp"/>
        </c:if >  
        


<div class="container mt-5">
    <!-- Welcome Message -->
    <div class="jumbotron">
    
        <h1 class="display-4">Welcome, ${userobj.name  }</h1>
        <p class="lead">Here is your dashboard with quick access to important sections.</p>
    </div>
    
    <!-- Bootstrap Cards -->
    <div class="row">
        <div class="col-md-4 mb-4">
            <a href="selloldbook.jsp" class="card-link">
                <div class="card custom-color">
                    <div class="card-body text-center">
                        <i class="fas fa-book fa-2x mb-3"></i>
                        <h5 class="card-title">Sell Old Book</h5>
                         <p class="small text-muted">Sell Old Book</p>
                    </div>
                </div>
            </a>
        </div>
          <div class="col-md-4 mb-4">
            <a href="old_book.jsp" class="card-link">
                <div class="card custom-color">
                    <div class="card-body text-center">
                        <i class="fas fa-book fa-2x mb-3"></i>
                        <h5 class="card-title"> Old Book</h5>
                         <p class="small text-muted">Old Book</p>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-4 mb-4">
            <a href="editprofile.jsp" class="card-link">
                <div class="card custom-color">
                    <div class="card-body text-center">
                        <i class="fas fa-user-edit fa-2x mb-3"></i>
                        <h5 class="card-title">Login & Security</h5>
                        <p class="small text-muted">Edit Profile</p>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-4 mb-4">
            <a href="address.jsp" class="card-link">
                <div class="card custom-color">
                    <div class="card-body text-center">
                        <i class="fas fa-map-marker-alt fa-2x mb-3"></i>
                        <h5 class="card-title">Your Address</h5>
                        <p class="small text-muted">Edit Address</p>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-4 mb-4">
            <a href="orders.jsp" class="card-link">
                <div class="card custom-color">
                    <div class="card-body text-center">
                        <i class="fas fa-box fa-2x mb-3"></i>
                        <h5 class="card-title">My Order</h5>
                        <p class="small text-muted">Track Your Order</p>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-4 mb-4">
            <a href="help.jsp" class="card-link">
                <div class="card custom-color">
                    <div class="card-body text-center">
                        <i class="fas fa-life-ring fa-2x mb-3"></i>
                        <h5 class="card-title">Help Center</h5>
                        <p class="small text-muted">24/7 Service</p>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>

<!-- Include Footer -->
<%@ include file="allcomponents/footer.jsp"%>

<!-- Include Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- Include FontAwesome for icons -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js"></script>
</body>
</html>
