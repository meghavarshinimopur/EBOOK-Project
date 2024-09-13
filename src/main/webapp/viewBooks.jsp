<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="java.util.List"%>
<%@ page import="com.DAO.BookDAOImpl"%>
<%@ page import="com.Entity.BookDtls"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="com.Entity.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Details</title>
<%@ include file="allcomponents/allCss.jsp"%>
</head>
<body style="background-color: #f0f1f2;">
	<%@ include file="allcomponents/navbar.jsp"%>
	<%

	User u = (User)session.getAttribute("userobj");
	
	int bookId = Integer.parseInt(request.getParameter("Bookid"));

	BookDAOImpl dao = new BookDAOImpl(DBConnect.getConnection());
	
	BookDtls book = dao.getBookById(bookId);
	%>
	<div class="container p-3">
		<div class="row">
			<div class="col-md-6 text-center p-5 border bg-white">
				<img src="books/<%= book.getPhotoName() %>" alt="<%= book.getPhotoName() %>" style="height: 200px; width: 150px;"><br>
				<h4 class="mt-3">
					Book Name: <span class="text-success"><%= book.getBookName() %></span>
				</h4>
				<h4>
					Author Name: <span class="text-success"><%= book.getAuthor() %></span>
				</h4>
				<h4>
					Category: <span class="text-success"><%= book.getBookCategory() %></span>
				</h4>
			</div>
			<div class="col-md-6 text-center p-5 border bg-white">
				<h2><%= book.getBookName() %></h2>
				
		      <%
		      if("Old" .equals(book.getBookCategory()))
		      {%>		
				<h5>Contact To Seller</h5>
				<h5 class="text-primary">
				<i class="fa-solid fa-envelope"></i>Email: 
				<%=book.getEmail() %></h5>
				<%
				}
		        %>
				
				<div class="row">
					<div class="col-md-4 text-danger text-center p-2">
						<i class="fa-solid fa-money-bill-wave fa-2x"></i>
						<p>Cash On Delivery</p>
					</div>
					<div class="col-md-4 text-danger text-center p-2">
						<i class="fa-sharp fa-solid fa-rotate-left fa-2x"></i>
						<p>Return Available</p>
					</div>
					<div class="col-md-4 text-danger text-center p-2">
						<i class="fa-solid fa-truck fa-2x" ></i>
						<p>Free Shipping</p>
					</div>
				</div>
				
				<%
				if("Old".equals(book.getBookCategory())){
				%>
				<div class="btn-container text-center p-3">
					<a href="index.jsp"
						class="btn btn-danger btn-sm btn-icon"> <i
						class="fas fa-cart-plus"></i> Continue Shopping
					</a> 
					<a href=""
						class="btn btn-success btn-sm btn-icon"> <i
						class="fas fa-credit-card"></i> <%= book.getPrice() %>
					</a>
				</div>
				<%
				}else{
				
				%>
				<div class="btn-container text-center p-3">
				<a href="cart?bid=<%= book.getBookId() %>&&uid=<%=u.getId() %>" 
					
						class="btn btn-danger btn-sm btn-icon"> <i
						class="fas fa-cart-plus"></i> Add to Cart
					</a> 
					<a href=""
						class="btn btn-success btn-sm btn-icon"> 
						<i class="fa-solid fa-rupee-sign"></i>
						<%= book.getPrice() %>
					</a>
				</div>
				
				<%
				}
				%>
				
			</div>
		</div>
	</div>
</body>
</html>