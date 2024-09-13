<div class="container-fluid p-3">
  <div class="row align-items-center">
    <div class="col-md-3">
      <h1>Ebooks</h1>
    </div>
    <div class="col-md-6">
      <form class="d-flex justify-content-center">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-primary" type="submit">Search</button>
      </form>
    </div>
    <div class="col-md-3 d-flex justify-content-end">
      <%
        // Retrieve the user's email from the session
        String userEmail = (String) session.getAttribute("userEmail");

        // Check if the user is an admin
        if ("admin@example1.com".equals(userEmail) || "mopurmeghavarshini@gmail.com".equals(userEmail) || "gajendrakawre540@gmail.com".equals(userEmail)) {
      %>
        <a href="profile.jsp" class="btn btn-warning me-2"><i class="fas fa-user-shield"></i> Admin</a>
        <a href="../logout" id="logoutButton" class="btn btn-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
      <%
        } else {
      %>
        <a href="../login.jsp" class="btn btn-success me-2"><i class="fas fa-sign-in-alt"></i> Login</a>
        <a href="../register.jsp" class="btn btn-primary"><i class="fas fa-user-plus"></i> Register</a>
      <%
        }
      %>
    </div>
  </div>
</div>

<nav class="navbar navbar-expand-lg navbar-dark bg-custom">
  <div class="container-fluid">
    <a class="navbar-brand" href="#"><i class="fas fa-home"></i></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link text-white active" aria-current="page" href="home.jsp"> Home</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<h3 style="text-align: center; color: #333; font-family: Arial, sans-serif; margin: 30px;">
    <%
    // Retrieve the user's email and name from the session
    String userName = (String) session.getAttribute("userName");
    userEmail = (String) session.getAttribute("userEmail"); // Assuming you have userEmail in session as well

    // Check if the user is logged in
    if (userName != null && userEmail != null) {
    %>
    <p>
        Hello, <%= userName %>! Your email is <%= userEmail %>.
    </p>
    <%
    } else {
    %>
    <p>Redirecting to login page in 1 seconds...</p>
    <script type="text/javascript">
        setTimeout(function(){
            window.location.href = '../login.jsp'; // Adjust the path if necessary
        },1000);
    </script>
    <%
    }
    %>
</h3>

<!-- Include SweetAlert2 JavaScript -->
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
                window.location.href = '../logout'; // Adjust URL as needed
            }
        });
    });
});
</script>
