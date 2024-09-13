<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="allcomponents/allCss.jsp"%>
</head>
<style>
.sp{
color:red;}
</style>
<body>
<%@ include file="allcomponents/navbar.jsp"%>
<div class="container d-flex justify-content-center align-items-center mt-4 vh-80">
    <div class="card p-4 shadow-sm" style="max-width: 600px; width: 100%;">
        <h2 class="card-title text-center mb-4">Add Address</h2>

        <!-- Display the form -->
        <form method="post" action="register">
            <!-- Address Row -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="address" class="form-label">Address<span class="sp"> *</span></label>
                    <input type="text" class="form-control" id="address" name="address" placeholder="Enter your address" required>
                </div>
                <div class="col-md-6">
                    <label for="landmark" class="form-label">Landmark<span class="sp"> *</span></label>
                    <input type="text" class="form-control" id="landmark" name="landmark" placeholder="Enter landmark">
                </div>
            </div>

            <!-- City and State Row -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="city" class="form-label">City<span class="sp"> *</span></label>
                    <input type="text" class="form-control" id="city" name="city" placeholder="Enter city" required>
                </div>
                <div class="col-md-6">
                    <label for="state" class="form-label">State<span class="sp"> *</span></label>
                    <input type="text" class="form-control" id="state" name="state" placeholder="Enter state" required>
                </div>
            </div>

            <!-- Pin and Country Row -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="pin" class="form-label">Pincode<span class="sp"> *</span></label>
                    <input type="number" class="form-control" id="pin" name="pin" placeholder="Enter pincode" required>
                </div>
                <div class="col-md-6">
                    <label for="country" class="form-label">Country<span class="sp"> *</span></label>
                    <select id="country" name="country" class="form-select" >
                        <option value="India">India</option>
                        <option value="USA">USA</option>
                        <option value="UK">UK</option>
                        <option value="Australia">Australia</option>
                        <!-- Add more countries as needed -->
                    </select>
                </div>
            </div>

            

            <!-- Submit Button -->
            <button type="submit" class="btn btn-warning w-100">Register</button>
        </form>
    </div>
</div>

<%@ include file="allcomponents/footer.jsp"%>
</body>
</html>