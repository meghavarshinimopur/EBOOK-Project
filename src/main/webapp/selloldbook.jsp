<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Book</title>
<!-- Include Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<!-- Include your custom CSS -->
<%@ include file="allcomponents/allCss.jsp"%>
<style>
    .required:after {
        content: "*";
        color: red;
        margin-left: 5px;
    }
    .card {
        max-width: 600px;
        margin: 0 auto;
    }
    .form-control-file {
        border: 1px solid #ced4da;
        border-radius: 0.25rem;
        padding: 0.375rem 0.75rem;
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
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header" style="background-color:#ffffff; padding-top:15px;">
                    <h4 class="card-title text-center">Sell Old Book</h4>
                </div>
                <div class="card-body">
                    <form action="add_old_book" method="post" enctype="multipart/form-data">
                        <input type="hidden" value="${userobj.email}" name="user">
                        <div class="form-group">
                            <label for="bookName" class="required">Book Name</label>
                            <input type="text" class="form-control" id="bookName" name="bookName" placeholder="Enter the name of the book" required>
                        </div>
                        <div class="form-group">
                            <label for="authorName" class="required">Author Name</label>
                            <input type="text" class="form-control" id="authorName" name="authorName" placeholder="Enter the author's name" required>
                        </div>
                        <div class="form-group">
                            <label for="price" class="required">Price ($)</label>
                            <input type="number" step="0.01" class="form-control" id="price" name="price" placeholder="Enter the price of the book" required>
                        </div>
                        <div class="form-group">
                            <label for="bookImage" class="required">Book Image</label>
                            <input type="file" class="form-control-file" id="bookImage" name="bookImage" accept="image/*" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Sell Book</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        <% 
            String msg = (String) session.getAttribute("msg");
            String msgType = (String) session.getAttribute("msgType");
            if (msg != null && msgType != null) {
        %>
        Swal.fire({
            icon: '<%= msgType %>',
            title: '<%= msgType.equals("success") ? "Success" : "Error" %>',
            text: '<%= msg %>',
            confirmButtonText: 'OK'
        });
        <% 
                // Clear message attributes to avoid showing the popup again on refresh
                session.removeAttribute("msg");
                session.removeAttribute("msgType");
            }
        %>
    });
</script>

<!-- Include Footer -->
<%@ include file="allcomponents/footer.jsp"%>
<!-- Include Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
