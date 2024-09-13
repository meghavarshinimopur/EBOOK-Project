<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<div class="container-fluid p-3">
    <div class="row align-items-center">
        <div class="col-md-3">
            <h1>Ebooks</h1>
        </div>
        <div class="col-md-6">
            <form class="d-flex justify-content-center" action="search.jsp" method="post">
                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="ch">
                <button class="btn btn-primary" type="submit">Search</button>
            </form>
        </div>

        <c:if test="${not empty userobj}">
            <div class="col-md-3 d-flex justify-content-end">
                <!-- Cart Icon -->
                <a href="checkout.jsp" class="btn btn-light me-2">
                    <i class="fas fa-shopping-cart"></i>
                </a>
                <!-- User Name and Logout -->
                <a href="userprofile.jsp" class="btn btn-success me-2">
                    <i class="fa-solid fa-user"></i> ${userobj.name}
                </a>
                <a href="logout1" id="logoutButton" class="btn btn-danger">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </c:if>

        <c:if test="${empty userobj}">
            <div class="col-md-3 d-flex justify-content-end">
                <a href="login.jsp" class="btn btn-success me-2">
                    <i class="fas fa-sign-in-alt"></i> Login
                </a>
                <a href="register.jsp" class="btn btn-primary">
                    <i class="fas fa-user-plus"></i> Register
                </a>
            </div>
        </c:if>

    </div>
</div>

<nav class="navbar navbar-expand-lg navbar-dark bg-custom">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><i class="fas fa-home"></i></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
            aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link text-white active"
                    aria-current="page" href="index.jsp"> Home</a></li>
                <li class="nav-item"><a class="nav-link text-white"
                    href="allRecentBook.jsp"><i class="fas fa-book"></i> Recent Book</a></li>
                <li class="nav-item"><a class="nav-link text-white"
                    href="allNewBook.jsp"><i class="fas fa-plus"></i> New Book</a></li>
                <li class="nav-item"><a class="nav-link text-white"
                    href="allOldBook.jsp"><i class="fas fa-book-open"></i> Old Book</a></li>
            </ul>
            <div class="d-flex ms-auto">
                <a href='setting.jsp' class="btn btn-light me-2" type="button">
                    <i class="fas fa-cogs"></i> Setting
                </a>
                <a href="contact.jsp" class="btn btn-light" type="button">
                    <i class="fas fa-envelope"></i> Contact Us
                </a>
            </div>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('logoutButton').addEventListener('click', function(event) {
        event.preventDefault(); // Prevent the default action (navigation)

        Swal.fire({
            title: 'Are you sure?',
            text: 'Do you really want to log out?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, log out!',
            cancelButtonText: 'No, cancel!'
        }).then((result) => {
            if (result.isConfirmed) {
                // Redirect to logout URL
                window.location.href = 'logout1'; // Adjust URL as needed
            }
        });
    });
});
</script>
