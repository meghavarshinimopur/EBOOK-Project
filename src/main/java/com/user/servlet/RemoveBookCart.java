package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.CartDAOImpl;
import com.DB.DBConnect;

@WebServlet("/remove_cart")
public class RemoveBookCart extends HttpServlet {

	 private static final long serialVersionUID = 1L;

	    @Override
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        int bid = Integer.parseInt(request.getParameter("bid"));
	        int uid = Integer.parseInt(request.getParameter("uid"));
	        int cid = Integer.parseInt(request.getParameter("cid"));
	        HttpSession session = request.getSession();

	        CartDAOImpl dao = new CartDAOImpl(DBConnect.getConnection());
	        boolean isDeleted = dao.deleteBookCart(bid,uid,cid);

	        if (isDeleted) {
	            session.setAttribute("succMsg", "Book removed from cart successfully.");
	        } else {
	            session.setAttribute("failMsg", "Something went wrong. Please try again.");
	        }
	        
	        response.sendRedirect("checkout.jsp");
	    }
}
