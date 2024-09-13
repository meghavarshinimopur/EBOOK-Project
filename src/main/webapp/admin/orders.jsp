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
<title>Admin : Orders</title>
<%@include file="allCss.jsp"%>
</head>
<body>
    <%@include file="navbar.jsp"%>

    <!-- Orders Table -->
    <h2 class="text-center mb-4">Order List</h2>

    <%
        BookOrderImpl dao = new BookOrderImpl(DBConnect.getConnection());
        List<Book_Order> blist = dao.getAllOrder();

        if (blist == null || blist.isEmpty()) {
            // Display jumbotron message if there are no orders
    %>
        <div class="container">
            <div class="jumbotron bg-light text-center" style="padding: 2rem; margin-top: 2rem;">
                <h1 class="display-4">No Orders Placed</h1>
                <p class="lead">It seems no one has placed any orders yet.</p>
                <hr class="my-4">
                <p>Check back later or encourage customers to place their orders!</p>
            </div>
        </div>
    <%
        } else {
    %>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th scope="col">Order ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Address</th>
                    <th scope="col">Phone</th>
                    <th scope="col">Book</th>
                    <th scope="col">Author</th>
                    <th scope="col">Price</th>
                    <th scope="col">Payment Type</th>
                </tr>
            </thead>
            <tbody>
                <%
                for (Book_Order b : blist) {
                %>
                    <tr>
                        <td scope="row"><%= b.getOrderId() %></td>
                        <td><%= b.getName() %></td>
                        <td><%= b.getEmail() %></td>
                        <td><%= b.getFulladd() %></td>
                        <td><%= b.getPhno() %></td>
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

    <%@include file="footer.jsp"%>
</body>
</html>
