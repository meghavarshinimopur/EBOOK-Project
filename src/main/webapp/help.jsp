<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Help - eBook Website</title>
    <%@ include file="allcomponents/allCss.jsp"%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .jumbotron {
            background-color: #f8f9fa;
            padding: 2rem 1rem;
            border-radius: 8px;
            text-align: center;
        }
        .icon-section {
            margin-top: 20px;
        }
        .icon-box {
            padding: 15px;
            text-align: center;
        }
        .icon-box i {
            font-size: 40px;
            color: #007bff;
            margin-bottom: 10px;
        }
        .icon-box p {
            margin-top: 10px;
            font-size: 16px;
            font-weight: 500;
        }
        .helpline {
            margin-top: 30px;
        }
        .helpline p {
            font-size: 18px;
            font-weight: bold;
            color: #28a745;
        }
        .home-button {
            margin-top: 20px;
        }
        .home-button a {
            font-size: 18px;
            padding: 10px 20px;
        }
        .support-info {
            margin-top: 15px;
            font-size: 16px;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <%@ include file="allcomponents/navbar.jsp"%>

    <div class="container vh-100 d-flex justify-content-center align-items-center">
        <div class="jumbotron">
            <h1 class="display-4">Help & Support</h1>
            <p class="lead">Find the answers to all your questions regarding our eBook website.</p>
            <hr class="my-4">
            <p>If you need further assistance, please explore the sections below or contact our support team.</p>
            
            <!-- Icon Section -->
            <div class="row icon-section">
                <div class="col-md-4 icon-box">
                    <i class="fas fa-book-open"></i>
                    <p>How to Access eBooks</p>
                </div>
                <div class="col-md-4 icon-box">
                    <i class="fas fa-shopping-cart"></i>
                    <p>Buying eBooks</p>
                </div>
                <div class="col-md-4 icon-box">
                    <i class="fas fa-user-circle"></i>
                    <p>Account Management</p>
                </div>
            </div>
            
            <!-- Helpline Number -->
            <div class="helpline">
                <p>Helpline Number: <i class="fas fa-phone-alt"></i> +1-800-123-4567</p>
            </div>

            <!-- 24/7 Support Message -->
            <div class="support-info">
                <p>Our support team is available <strong>24/7</strong> to assist you.</p>
            </div>

            <!-- Home Button -->
            <div class="home-button">
                <a href="index.jsp" class="btn btn-primary">
                    <i class="fas fa-home"></i> Home
                </a>
            </div>
        </div>
    </div>

    <%@ include file="allcomponents/footer.jsp"%>
</body>
</html>
