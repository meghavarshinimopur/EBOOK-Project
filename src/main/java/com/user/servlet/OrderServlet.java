package com.user.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.BookOrderImpl;
import com.DAO.CartDAOImpl;
import com.DB.DBConnect;
import com.Entity.Book_Order;
import com.Entity.Cart;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Get the user ID from request parameters
            int uid = Integer.parseInt(req.getParameter("uid"));

            // Retrieve the cart items for the user
            CartDAOImpl cartDAO = new CartDAOImpl(DBConnect.getConnection());
            List<Cart> cartList = cartDAO.getBookByUser(uid);

            HttpSession session = req.getSession();

            // Check if the cart is empty
            if (cartList == null || cartList.isEmpty()) {
                session.setAttribute("cartMessage", "Your cart is empty.");
                resp.sendRedirect("checkout.jsp"); // Redirect to cart page with the empty cart message
                return;
            }

            // If the cart is not empty, proceed to checkout.jsp
            session.setAttribute("cartList", cartList);
            resp.sendRedirect("checkout.jsp"); // Redirect to the checkout page
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp"); // Redirect to an error page in case of an exception
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession();

            // Retrieve order information from the request
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String phno = req.getParameter("mobile");
            String address = req.getParameter("address");
            String landmark = req.getParameter("landmark");
            String city = req.getParameter("city");
            String state = req.getParameter("state");
            String pinCode = req.getParameter("zip");
            String paymentType = req.getParameter("payment");

            // Create the full address string
            String fullAdd = address + ", " + landmark + ", " + city + ", " + state + ", " + pinCode;

            // Retrieve the cart items for the user
            CartDAOImpl cartDAO = new CartDAOImpl(DBConnect.getConnection());
            List<Cart> cartList = cartDAO.getBookByUser(id);

            // Check if cart is empty (failsafe)
            if (cartList == null || cartList.isEmpty()) {
                session.setAttribute("cartMessage", "Your cart is empty.");
                resp.sendRedirect("cart.jsp");
                return;
            }

            // Initialize BookOrderImpl to save the order
            BookOrderImpl orderDAO = new BookOrderImpl(DBConnect.getConnection());

            // Prepare the order list
            ArrayList<Book_Order> orderList = new ArrayList<>();
            Random random = new Random();

            // Loop through the cart items to create orders
            for (Cart cart : cartList) {
                Book_Order order = new Book_Order();
                order.setOrderId("BOOK-ORD-00" + random.nextInt(1000));
                order.setName(name);
                order.setEmail(email);
                order.setPhno(phno);
                order.setFulladd(fullAdd);
                order.setBookName(cart.getBookName());
                order.setAuthor(cart.getAuthor());
                order.setPrice(String.valueOf(cart.getPrice()));
                order.setPaymentType(paymentType);
                orderList.add(order);
            }

            // Validate the payment type
            if ("noselect".equals(paymentType)) {
                session.setAttribute("failMsg", "Please choose a payment method.");
                resp.sendRedirect("checkout.jsp?error=payment");
                return;
            }

            // Save the order and handle success or failure
            boolean isOrderSaved = orderDAO.saveOrder(orderList);

            if (isOrderSaved) {
                resp.sendRedirect("order_success.jsp"); // Redirect to success page
            } else {
                session.setAttribute("failMsg", "Your order failed.");
                resp.sendRedirect("checkout.jsp?error=orderfail"); // Redirect to checkout page with failure message
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp"); // Redirect to an error page in case of an exception
        }
    }
}
