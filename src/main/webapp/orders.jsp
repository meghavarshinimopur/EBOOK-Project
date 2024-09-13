<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.DAO.BookOrderImpl"%>
<%@ page import="com.Entity.User"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="com.Entity.Book_Order" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Orders</title>
<%@ include file="allcomponents/allCss.jsp"%>
</head>
<body>
	<%@ include file="allcomponents/navbar.jsp"%>
	<c:if test="${ empty userobj}">
        <c:redirect url="login.jsp"/>
    </c:if>

	<h1 class="mb-4 text-center" style="padding-top: 20px;">Your Order</h1>

	<%
		User u = (User) session.getAttribute("userobj");
		BookOrderImpl dao = new BookOrderImpl(DBConnect.getConnection());
		List<Book_Order> blist = dao.getBook(u.getEmail());

		if (blist == null || blist.isEmpty()) {
			// Display the jumbotron-style message when no orders are found
	%>
			<div class="container">
				<div class="jumbotron bg-light text-center" style="padding: 2rem; margin-top: 2rem;">
					<h1 class="display-4">No Orders Placed</h1>
					<p class="lead">You haven't placed any orders yet.</p>
					<hr class="my-4">
					<p>Explore our collection and place your first order now!</p>
					<a class="btn btn-primary btn-lg" href="index.jsp" role="button">Go to Shop</a>
				</div>
			</div>
	<%
		} else {
	%>
			<table class="table table-striped">
				<thead class="bg-custom" style="color: #ffffff;">
					<tr>
						<th scope="col" style="padding-left: 50px;">Order Id</th>
						<th scope="col">Name</th>
						<th scope="col">Book Name</th>
						<th scope="col">Author</th>
						<th scope="col">Price</th>
						<th scope="col">Payment type</th>
					</tr>
				</thead>
				<tbody>
				<%
					for (Book_Order b : blist) {
				%>
					<tr>
						<td scope="row"><%= b.getOrderId() %></td>
						<td><%= b.getName() %></td>
						<td><%= b.getBookName() %></td>
						<td><%= b.getAuthor() %></td>
						<td><%= b.getPrice() %></td>
						<td><%= b.getPaymentType() %></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
	<%
		}
	%>

	<%@ include file="allcomponents/footer.jsp"%>
</body>
</html>
