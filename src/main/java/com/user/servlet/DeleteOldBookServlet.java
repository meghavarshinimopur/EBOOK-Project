package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.BookDAOImpl;
import com.DB.DBConnect;

@WebServlet("/delete_old_book")
public class DeleteOldBookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String email = req.getParameter("em");
            int bid= Integer.parseInt(req.getParameter("bid"));
            BookDAOImpl dao = new BookDAOImpl(DBConnect.getConnection());
            boolean isDeleted = dao.OldDeleteBook(email, "Old",bid);

            HttpSession session = req.getSession();

            if (isDeleted) {
                // Set success message in session
                session.setAttribute("successMessage", "Old book deleted successfully.");
            } else {
                // Set failure message in session
                session.setAttribute("errorMessage", "Failed to delete the old book.");
            }

            // Redirect to a confirmation page or back to the book list
            resp.sendRedirect("old_book.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            // Handle any exception that occurs and set the error message
            req.getSession().setAttribute("errorMessage", "An error occurred while deleting the book.");
            resp.sendRedirect("old_book.jsp"); // Redirect to an error page
        }
    }
}
