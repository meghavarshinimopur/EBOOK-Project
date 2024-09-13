<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.DAO.BookDAOImpl"%>
<%@ page import="com.Entity.BookDtls"%>
<%@ page import="com.Entity.User"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="javax.servlet.http.HttpSession"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Display</title>
<%@ include file="allcomponents/allCss.jsp"%>
<!-- Bootstrap CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
	rel="stylesheet">
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

.card {
	position: relative;
}

.availability-label {
	position: absolute;
	top: 10px;
	left: 10px;
	background-color: #4CAF50; /* Green color */
	color: white;
	padding: 5px 10px;
	border-radius: 3px;
	font-size: 0.9rem;
	font-weight: bold;
}

.view-all:hover {
	background-color: #B71C1C;
}
</style>
</head>
<body>
	<%
	User u = (User)session.getAttribute("userobj");
	
	Connection connection = DBConnect.getConnection();
	// Initialize DAO and fetch books by category and status
	BookDAOImpl dao = new BookDAOImpl(connection);
	List<BookDtls> recentBooks = dao.getBooksByCategoryAndStatus("Recent", "Available");
	List<BookDtls> newBooks = dao.getBooksByCategoryAndStatus("New", "Available");
	List<BookDtls> oldBooks = dao.getBooksByCategoryAndStatus("Old", "Available");
	%>

	<%@ include file="allcomponents/navbar.jsp"%>

	<div class="container-fluid back-img">
		<h2 class="text-white text-center">
			<i class="fas fa-book"></i> EBook Management System
		</h2>
	</div>
	<audio id="backgroundAudio" controls autoplay src="image/welcome.mp3"></audio>

	<!-- Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<!-- Recent Books Section -->
	<h3 class="text-center mt-5 mb-4">Recent Books</h3>
	<div class="container">
		<div class="row">
			<%
			int limit = 4; // Limit number of books displayed
			for (int i = 0; i < Math.min(limit, recentBooks.size()); i++) {
				BookDtls book = recentBooks.get(i);
			%>
			<div class="col-md-3 book-card">
				<div class="card">
					<div class="card-body text-center">
						<div class="availability-label">Available</div>
						<img src="books/<%=book.getPhotoName()%>"
							alt="<%=book.getBookName()%>" style="width: 150px; height: 200px"
							class="img-thumbnail">
						<p><%=book.getBookName()%></p>
						<p><%=book.getAuthor()%></p>
						<p>
							Categories:
							<%=book.getBookCategory()%></p>
						<div class="btn-container">
							<%
							if (u == null) {
								%>
								<a href="login.jsp" class="btn btn-danger btn-sm btn-icon"> <i class="fas fa-cart-plus"></i>Cart</a>
								<% } else {
								%>
								
							<a href="cart?bid=<%= book.getBookId() %>&&uid=<%=u.getId() %>" class="btn btn-danger btn-sm btn-icon"> <i class="fas fa-cart-plus"></i> Cart </a>
							
							<% } %>
						

						 <a href="viewBooks.jsp?Bookid=<%=book.getBookId()%>"
								class="btn btn-success btn-sm btn-icon"> <i
								class="fas fa-eye"></i> View
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
		<a href="allRecentBook.jsp" class="btn btn-primary view-all">View
			All</a>
	</div>

	<!-- New Books Section -->
	<h3 class="text-center mt-5 mb-4">New Books</h3>
	<div class="container">
		<div class="row">
			<%
			for (int i = 0; i < Math.min(limit, newBooks.size()); i++) {
				BookDtls book = newBooks.get(i);
			%>
			<div class="col-md-3 book-card">
				<div class="card">
					<div class="card-body text-center">
						<div class="availability-label">Available</div>
						<img src="books/<%=book.getPhotoName()%>"
							alt="<%=book.getBookName()%>" style="width: 150px; height: 200px"
							class="img-thumbnail">
						<p><%=book.getBookName()%></p>
						<p><%=book.getAuthor()%></p>
						<p>
							Categories:
							<%=book.getBookCategory()%></p>
						<div class="btn-container">
						<%
							if (u == null) {
								%>
								<a href="login.jsp" class="btn btn-danger btn-sm btn-icon"> <i class="fas fa-cart-plus"></i>Cart</a>
								<% } else {
								%>
								
							<a href="cart?bid=<%= book.getBookId() %>&&uid=<%=u.getId() %>" class="btn btn-danger btn-sm btn-icon"> <i class="fas fa-cart-plus"></i> Cart </a>
							
							<% } %>
						

						 <a href="viewBooks.jsp?Bookid=<%=book.getBookId()%>"
								class="btn btn-success btn-sm btn-icon"> <i
								class="fas fa-eye"></i> View
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
		<a href="allNewBook.jsp" class="btn btn-primary view-all">View All</a>
	</div>

	<!-- Old Books Section -->
	<h3 class="text-center mt-5 mb-4">Old Books</h3>
	<div class="container">
		<div class="row">
			<%
			for (int i = 0; i < Math.min(limit, oldBooks.size()); i++) {
				BookDtls book = oldBooks.get(i);
			%>
			<div class="col-md-3 book-card">
				<div class="card">
					<div class="card-body text-center">
						<div class="availability-label">Available</div>
						<img src="books/<%=book.getPhotoName()%>"
							alt="<%=book.getBookName()%>" style="width: 150px; height: 200px"
							class="img-thumbnail">
						<p><%=book.getBookName()%></p>
						<p><%=book.getAuthor()%></p>
						<p>
							Categories:
							<%=book.getBookCategory()%></p>
						<div class="btn-container">
							<a href="#" class="btn btn-danger btn-sm btn-icon"> <i
								class="fas fa-cart-plus"></i> Cart
							</a> <a href="viewBooks.jsp?Bookid=<%=book.getBookId()%>"
								class="btn btn-success btn-sm btn-icon"> <i
								class="fas fa-eye"></i> View
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
		<a href="allOldBook.jsp" class="btn btn-primary view-all">View All</a>
	</div>

	<%@ include file="allcomponents/footer.jsp"%>
</body>
</html>