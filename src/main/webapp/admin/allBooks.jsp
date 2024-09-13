<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.DAO.BookDAOImpl"%>
<%@ page import="com.Entity.BookDtls"%>
<%@ page import="com.DB.DBConnect"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index Page</title>
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script
    src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

<%@include file="allCss.jsp"%>

<style>
.action-buttons .btn {
    margin-right: 5px;
}

.btn-edit {
    background-color: #ffc40c; /* Yellow */
    color: #dc3545; /* Red text */
}

.btn-delete {
    background-color: #dc3545; /* Red */
    color: #ffc40c; /* Yellow text */
}

.btn-edit:hover, .btn-delete:hover {
    opacity: 0.8;
}
</style>
</head>
<body>

    <%
    String message = (String) session.getAttribute("msg");
    if (message != null) {
    %>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            Swal.fire({
                title: 'Notification',
                text: '<%= message %>', // Ensure proper handling of the message text
                icon: 'info',
                confirmButtonText: 'OK'
            });
            // Remove the message from the session after displaying it
            <%
                session.removeAttribute("msg");
            %>
        });
    </script>
    <%
    }
    %>
<%@include file="navbar.jsp"%>
    <!-- The rest of your page content goes here -->
    <!-- e.g., List of all books, etc. -->

    <h1 class="mb-4 text-center" style="padding-top: 20px;">All Books</h1>
    <table class="table table-striped">
        <thead>
            <tr>
                <th scope="col" style="padding-left: 50px;">Id</th>
                <th scope="col">Image</th>
                <th scope="col">Book Name</th>
                <th scope="col">Author</th>
                <th scope="col">Price</th>
                <th scope="col">Category</th>
                <th scope="col">Status</th>
                <th scope="col">Action</th>
            </tr>
        </thead>
        <tbody>
            <%
            // Initialize DAO and fetch book list
            BookDAOImpl dao = new BookDAOImpl(DBConnect.getConnection());
            List<BookDtls> list = dao.getAllBooks();

            // Check if list is not null and not empty
            if (list != null && !list.isEmpty()) {
                for (BookDtls book : list) {
            %>
            <tr>
                <td style="padding-left: 50px;"><%= book.getBookId() %></td>
                <td>
                    <!-- Ensure correct path for images -->
                    <img src="../books/<%= book.getPhotoName() %>" alt="Book Image"
                        style="width: 50px; height: 50px;">
                </td>
                <td><%= book.getBookName() %></td>
                <td><%= book.getAuthor() %></td>
                <td>$<%= book.getPrice() %></td>
                <td><%= book.getBookCategory() %></td>
                <td><%= book.getStatus() %></td>
                <td class="action-buttons">
                    <!-- Edit and Delete buttons -->
                    <a href="editbook.jsp?id=<%= book.getBookId() %>" class="btn btn-warning btn-sm">Edit</a>
                    <button onclick="confirmDelete(<%= book.getBookId() %>)" class="btn btn-danger btn-sm">Delete</button>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="8" class="text-center">No books available.</td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>

    <%@include file="footer.jsp"%>

    <script>
        function confirmDelete(bookId) {
            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Redirect to the servlet to perform the deletion
                    window.location.href = `../deletebook?id=${bookId}`;
                }
            });
        }
    </script>

</body>
</html>
