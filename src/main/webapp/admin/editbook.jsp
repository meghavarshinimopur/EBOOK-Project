<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.DAO.BookDAOImpl"%>
<%@ page import="com.Entity.BookDtls"%>
<%@ page import="com.DB.DBConnect"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin : Edit Book</title>
    <%@ include file="allCss.jsp" %>
    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
</head>
<body>
    

    <style>
        .container {
            margin-top: 30px;
            width: 800px;
        }
        .card-header {
            background-color: white;
            border-bottom: 2px solid red;
        }
        .card {
            padding: 40px;
        }
        .required:after {
            content: '*';
            color: red;
            margin-left: 5px;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
<%@ include file="navbar.jsp" %>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title text-center">Edit Book</h4>
                    </div>
                    <div class="card-body">
                        <%
                            int id = Integer.parseInt(request.getParameter("id"));
                            BookDAOImpl dao = new BookDAOImpl(DBConnect.getConnection());
                            BookDtls book = dao.getBookById(id);
                        %>
                        <form action="../editbooks" method="post">
                            <input type="hidden" name="id" value="<%= book.getBookId() %>">
                            <div class="form-group">
                                <label for="bookName" class="required">Book Name</label>
                                <input type="text" class="form-control" id="bookName" name="bookName" value="<%= book.getBookName() %>" required>
                            </div>
                            <div class="form-group">
                                <label for="authorName" class="required">Author Name</label>
                                <input type="text" class="form-control" id="authorName" name="authorName" value="<%= book.getAuthor() %>" required>
                            </div>
                            <div class="form-group">
                                <label for="price" class="required">Price ($)</label>
                                <input type="number" step="1" class="form-control" id="price" name="price" value="<%= book.getPrice() %>" required>
                            </div>
                            <div class="form-group">
                                <label for="status" class="required">Book Status</label>
                                <select id="status" name="status" class="form-control" required>
                                    <option value="Available" <%= "Available".equals(book.getStatus()) ? "selected" : "" %>>Available</option>
                                    <option value="Out Of Stock" <%= "Out Of Stock".equals(book.getStatus()) ? "selected" : "" %>>Out Of Stock</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Update</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <!-- SweetAlert2 JavaScript -->
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
</body>
</html>
