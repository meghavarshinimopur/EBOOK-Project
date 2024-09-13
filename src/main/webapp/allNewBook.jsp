<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.DAO.BookDAOImpl"%>
<%@ page import="com.Entity.BookDtls"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="java.util.List"%>
<%@ page import="com.Entity.User"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>user : New Book</title>
<%@ include file="allcomponents/allCss.jsp"%>
<!-- Bootstrap CSS -->
<link
    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
    rel="stylesheet">
<!-- Font Awesome -->
<link
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
    rel="stylesheet">
<!-- SweetAlert CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<style type="text/css">
#backgroundAudio {
    display: none;
}

.back-img {
    background: url("image/book.avif") no-repeat center center;
    height: 50vh;
    width: 100%;
    background-size: cover;
}

h2 {
    padding: 15px 0;
}

.book-card {
    margin-bottom: 20px;
    position: relative;
}

.status-label {
    position: absolute;
    top: 10px;
    left: 10px;
    padding: 5px 10px;
    color: white;
    font-weight: bold;
    border-radius: 5px;
}

.available {
    background-color: #28a745; /* Green for available */
}

.out-of-stock {
    background-color: #dc3545; /* Red for out of stock */
}

.btn-icon {
    display: flex;
    align-items: center;
    justify-content: center;
}

.btn-icon i {
    margin-right: 5px;
}

.btn-container {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
}

.view-all {
    color: white;
    background-color: #D32F2F; /* Dark red color */
    border: none;
    font-size: 1rem; /* Smaller font size */
    padding: 8px 10px; /* Smaller padding */
    text-align: center;
    display: inline-block;
    margin: 20px auto; /* Centering */
    text-decoration: none;
}
.btn-disabled {
    cursor: not-allowed;
    opacity: 0.6;
}
.view-all:hover {
    background-color: #B71C1C;
}
</style>
</head>
<body>

<%@ include file="allcomponents/navbar.jsp"%>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script
    src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script
    src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- SweetAlert JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

<%

	User u = (User)session.getAttribute("userobj");
    // Initialize DAO and fetch books by category and status
    BookDAOImpl dao = new BookDAOImpl(DBConnect.getConnection());

    List<BookDtls> newAvailableBooks = dao.getBooksByCategoryAndStatus("New", "Available");
    List<BookDtls> newOutOfStockBooks = dao.getBooksByCategoryAndStatus("New", "Out of Stock");

    String cartMessage = (String) session.getAttribute("cartMessage");
    String cartMessageType = (String) session.getAttribute("cartMessageType");
    session.removeAttribute("cartMessage");
    session.removeAttribute("cartMessageType");
%>

<!-- New Books Section -->
<h3 class="text-center mt-5 mb-4">New Books</h3>
<div class="container">
    <div class="row">
        <%
        // Display Available Books
        for (BookDtls book : newAvailableBooks) {
        %>
        <div class="col-md-3 book-card">
            <div class="card">
                <div class="card-body text-center">
                    <!-- Status Label -->
                    <span class="status-label available">Available</span>
                    <img src="books/<%=book.getPhotoName()%>"
                        alt="<%=book.getBookName()%>"
                        style="width: 150px; height: 200px" class="img-thumbnail">
                    <p><%=book.getBookName()%></p>
                    <p><%=book.getAuthor()%></p>
                    <p>
                        Categories: <%=book.getBookCategory()%>
                    </p>
                    <div class="btn-container mt-2">
                    
                    <%
							if (u == null) {
								%>
								<a href="login.jsp" class="btn btn-danger btn-sm btn-icon"> <i class="fas fa-cart-plus"></i>Cart</a>
								<% } else {
								%>
								
							  <a href="cart?bid=<%= book.getBookId() %>&&uid=<%=u.getId() %>" class="btn btn-danger btn-sm btn-icon">
                            <i class="fas fa-cart-plus"></i> Cart
                        </a>
							
							<% } %>
                    
                    
                        <a href="viewBooks.jsp?Bookid=<%= book.getBookId() %>" class="btn btn-success btn-sm btn-icon">
                            <i class="fas fa-eye"></i> View
                        </a>
                    </div>
                    <p class="mt-2">
                        <b><span>₹ </span><%=book.getPrice()%></b>
                    </p>
                </div>
            </div>
        </div>
        <%
        }
        // Display Out of Stock Books
        for (BookDtls book : newOutOfStockBooks) {
        %>
        <div class="col-md-3 book-card">
            <div class="card">
                <div class="card-body text-center">
                    <!-- Status Label -->
                    <span class="status-label out-of-stock">Out of Stock</span>
                    <img src="books/<%=book.getPhotoName()%>"
                        alt="<%=book.getBookName()%>"
                        style="width: 150px; height: 200px" class="img-thumbnail">
                    <p><%=book.getBookName()%></p>
                    <p><%=book.getAuthor()%></p>
                    <p>
                        Categories: <%=book.getBookCategory()%>
                    </p>
                    <div class="btn-container mt-2">
                        <a href="#" class="btn btn-danger btn-sm btn-icon btn-disabled" aria-disabled="true">
                            <i class="fas fa-cart-plus"></i> Cart
                        </a>
                        <a href="viewBooks.jsp?Bookid=<%= book.getBookId() %>" class="btn btn-success btn-sm btn-icon">
                            <i class="fas fa-eye"></i> View
                        </a>
                    </div>
                    <p class="mt-2">
                        <b><span>₹ </span><%=book.getPrice()%></b>
                    </p>
                </div>
            </div>
        </div>
        <%
        }
        %>
    </div>
</div>

<%@ include file="allcomponents/footer.jsp"%>

<script>
document.addEventListener('DOMContentLoaded', (event) => {
    <% 
    if (cartMessage != null) {
    %>
        Swal.fire({
            title: '<%= cartMessage %>',
            icon: '<%= cartMessageType %>',
            confirmButtonText: 'OK'
        });
    <% } %>
});
</script>
</body>
</html>