package com.admin.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.BookDAOImpl;
import com.DB.DBConnect;

@WebServlet("/deletebook")
public class DeleteBook extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Retrieve the book ID from the request
            int id = Integer.parseInt(req.getParameter("id"));
            
            // Create an instance of BookDAOImpl and perform the delete operation
            BookDAOImpl bookDao = new BookDAOImpl(DBConnect.getConnection());
            boolean success = bookDao.deleteBook(id);

            // Set up the session and message based on the delete result
            HttpSession session = req.getSession();
            if (success) {
                session.setAttribute("msg", "Book deleted successfully.");
                session.setAttribute("msgType", "success");
            } else {
                session.setAttribute("msg", "Something went wrong. Book deletion failed.");
                session.setAttribute("msgType", "error");
            }
            
            // Redirect back to the page showing the list of books
            resp.sendRedirect("admin/allBooks.jsp"); // Adjust the redirect path as necessary
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = req.getSession();
            session.setAttribute("msg", "An error occurred: " + e.getMessage());
            session.setAttribute("msgType", "error");
            resp.sendRedirect("admin/allBooks.jsp"); // Adjust the redirect path as necessary
        }
    }
}

