<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
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
<title>Manage Books</title>
<%@ include file="allcomponents/allCss.jsp"%>
<!-- Include SweetAlert2 CSS and JS -->
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<%@ include file="allcomponents/navbar.jsp"%>

	<table class="table table-striped">
		<thead>
			<tr>
				<th scope="col">Book Name</th>
				<th scope="col">Author</th>
				<th scope="col">Price</th>
				<th scope="col">Category</th>
				<th scope="col">Action</th>
			</tr>
		</thead>
		<tbody>

			<%
			User u = (User) session.getAttribute("userobj");
			String email = u.getEmail();
			BookDAOImpl dao = new BookDAOImpl(DBConnect.getConnection());
			List<BookDtls> list = dao.getBookByOld(email, "Old");
			for (BookDtls b : list) 
			{%>
			<tr>
				<td scope="row"><%=b.getBookName() %></td>
				<td><%=b.getAuthor() %></td>
				<td><%=b.getPrice() %></td>
				<td><%=b.getBookCategory() %></td>
				<td>
					<button onclick="confirmDelete('<%=email %>', '<%= b.getBookId()%>')" class="btn btn-sm btn-danger">Delete</button>
				</td>
			</tr>
         
         <%}
			%>

		</tbody>
	</table>

	<%@ include file="allcomponents/footer.jsp"%>

	<!-- SweetAlert2 confirmation dialog -->
	<script type="text/javascript">
	function confirmDelete(email, bookId) {
	    Swal.fire({
	        title: 'Are you sure?',
	        text: "You won't be able to revert this!",
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        confirmButtonText: 'Yes, delete it!'
	    }).then((result) => {
	        if (result.isConfirmed) {
	            // If confirmed, redirect to delete servlet with both email and bookId
	            window.location.href = "delete_old_book?em=" + email + "&bid=" + bookId;
	        }
	    });
	}

		
	</script>
</body>
</html>
