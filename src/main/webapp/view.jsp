<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.DAO.BookDAOImpl"%>
<%@ page import="com.Entity.BookDtls"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Details</title>
    <%@ include file="allcomponents/allCss.jsp"%>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style type="text/css">
        .book-detail-img {
            width: 100%;
            height: auto;
            object-fit: cover;
        }
        .card {
            margin-top: 20px;
            border: none;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .book-details {
            margin-top: 20px;
        }
        .btn-container {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <% 
        Connection connection = DBConnect.getConnection();
        BookDAOImpl dao = new BookDAOImpl(connection);
        BookDtls book = null;
        int bookId = Integer.parseInt(request.getParameter("Bookid"));
        
        try {
            book = dao.getBookById(bookId);
            if (book == null) {
                out.println("<p>Book not found</p>");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error retrieving book details</p>");
            return;
        }
    %>

    <%@ include file="allcomponents/navbar.jsp"%>

    <div class="container book-details">
        <div class="card">
            <div class="row no-gutters">
                <div class="col-md-4 text-center">
                    <img src="books/<%= book.getPhotoName() %>" alt="<%= book.getBookName() %>" class="book-detail-img">
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h2 class="card-title"><%= book.getBookName() %></h2>
                        <p class="card-text"><strong>Author:</strong> <%= book.getAuthor() %></p>
                        <p class="card-text"><strong>Price:</strong> ₹ <%= book.getPrice() %></p>
                        <p class="card-text"><strong>Category:</strong> <%= book.getBookCategory() %></p>
                        <p class="card-text"><strong>Status:</strong> <%= book.getStatus() %></p>
                        <p class="card-text"><strong>Email:</strong> <%= book.getEmail() %></p>
                        <div class="btn-container">
                            <button id="addToCart" class="btn btn-danger btn-sm btn-icon">
                                <i class="fas fa-cart-plus"></i> Add to Cart
                            </button>
                            <button id="buyNow" class="btn btn-success btn-sm btn-icon">
                                <i class="fas fa-credit-card"></i> Buy Now
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="allcomponents/footer.jsp"%>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- SweetAlert2 for actions -->
    <script>
        document.getElementById('addToCart').addEventListener('click', function() {
            Swal.fire({
                title: 'Added to Cart',
                text: 'The book has been added to your cart.',
                icon: 'success',
                confirmButtonText: 'OK'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'cart.jsp?Bookid=<%= book.getBookId() %>';
                }
            });
        });

        document.getElementById('buyNow').addEventListener('click', function() {
            Swal.fire({
                title: 'Purchase Confirmed',
                text: 'Proceeding to payment.',
                icon: 'info',
                confirmButtonText: 'Proceed'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'purchase.jsp?Bookid=<%= book.getBookId() %>';
                }
            });
        });
    </script>
</body>
</html>
