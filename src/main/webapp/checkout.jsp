<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.DAO.CartDAOImpl"%>
<%@ page import="com.Entity.User"%>
<%@ page import="com.Entity.Cart"%>
<%@ page import="com.DB.DBConnect"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <%@ include file="allcomponents/allCss.jsp"%>
    <!-- Include SweetAlert CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <%@ include file="allcomponents/navbar.jsp"%>

    <!-- Check if user is logged in -->
    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp"></c:redirect>
    </c:if>

    <div class="container">
        <div class="row p-4">
            <!-- Selected Items Section -->
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h3 class="text-center text-success">Your Selected Items</h3>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Book Name</th>
                                    <th>Author</th>
                                    <th>Price</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                User u = (User) session.getAttribute("userobj");
                                CartDAOImpl dao = new CartDAOImpl(DBConnect.getConnection());
                                List<Cart> cartList = dao.getBookByUser(u.getId());

                                double totalPrice = 0;
                                boolean isCartEmpty = true;

                                if (cartList != null && !cartList.isEmpty()) {
                                    isCartEmpty = false;
                                    for (Cart c : cartList) {
                                        String priceStr = c.getPrice();
                                        double price = Double.parseDouble(priceStr);
                                        totalPrice += price;
                                %>
                                <tr>
                                    <td><%=c.getBookName()%></td>
                                    <td><%=c.getAuthor()%></td>
                                    <td><%=priceStr%></td>
                                    <td>
                                        <a href="#" onclick="confirmRemove(<%=c.getBid() %>, <%=c.getUserId() %>, <%=c.getCid() %>)" class="btn btn-danger">Remove</a>
                                    </td>
                                </tr>
                                <%
                                    }
                                    String totalPriceStr = String.format("%.2f", totalPrice);
                                %>
                                </tbody>
                            </table>
                            <h4>Total Price: <%=totalPriceStr%></h4>
                        <c:if test="${isCartEmpty}">
                            <h5 class="text-danger">Your cart is empty!</h5>
                        </c:if>
                        <%
                                } else {
                        %>
                        <h5 class="text-danger">Your cart is empty!</h5>
                        </tbody>
                        </table>
                        <%
                                }
                        %>
                    </div>
                </div>
            </div>

            <!-- Place Order Section -->
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h3 class="text-center text-success">Place Your Order</h3>

                        <!-- Disable form submission if cart is empty -->
                        <form action="orders" method="post" onsubmit="return validatePayment()" id="orderForm">
                            <input type="hidden" value="${userobj.id}" name="id">

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="name" class="form-label">Name</label>
                                    <input type="text" class="form-control" id="name" name="name" value="<%= u.getName() %>" readonly required>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="<%= u.getEmail() %>" readonly required>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="mobile" class="form-label">Mobile Number</label>
                                    <input type="tel" class="form-control" id="mobile" name="mobile" value="<%= u.getPhno() %>" readonly required>
                                </div>
                                <div class="col-md-6">
                                    <label for="address" class="form-label">Address</label>
                                    <input type="text" class="form-control" id="address" name="address" required>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="city" class="form-label">City</label>
                                    <input type="text" class="form-control" id="city" name="city" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="landmark" class="form-label">Landmark</label>
                                    <input type="text" class="form-control" id="landmark" name="landmark" required>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="state" class="form-label">State</label>
                                    <input type="text" class="form-control" id="state" name="state" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="zip" class="form-label">ZIP Code</label>
                                    <input type="text" class="form-control" id="zip" name="zip" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="payment" class="form-label">Payment Type</label>
                                <select id="payment" name="payment" class="form-select" required>
                                    <option value="noselect">Select Payment Type</option>
                                    <option value="credit_card">Credit Card</option>
                                    <option value="debit_card">Debit Card</option>
                                    <option value="paypal">PayPal</option>
                                    <option value="bank_transfer">Bank Transfer</option>
                                    <option value="cod">Cash on Delivery (COD)</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-warning" id="orderBtn">Order Now</button>
                            <a href="index.jsp" class="btn btn-success">Continue Shopping</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="allcomponents/footer.jsp"%>

    <!-- SweetAlert for Payment Validation -->
    <script>
        function validatePayment() {
            var paymentType = document.getElementById("payment").value;
            if (paymentType === "noselect") {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Please select a payment type!',
                });
                return false;
            }
            return true;
        }

        function confirmRemove(bid, uid, cid) {
            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, remove it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'remove_cart?bid=' + bid + '&uid=' + uid + '&cid=' + cid;
                }
            });
        }

        // Check if cart is empty and disable order button
        window.onload = function () {
            var isCartEmpty = <%= isCartEmpty ? "true" : "false" %>;
            if (isCartEmpty) {
                document.getElementById("orderBtn").disabled = true;
                Swal.fire({
                    icon: 'warning',
                    title: 'Your cart is empty!',
                    text: 'Please add items to your cart before placing an order.',
                });
            } else {
                document.getElementById("orderBtn").disabled = false;
            }
        }
    </script>
</body>
</html>
