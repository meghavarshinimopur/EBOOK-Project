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
import com.Entity.BookDtls;

@WebServlet("/editbooks")
public class EditBook extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String bookName = req.getParameter("bookName");
            String author = req.getParameter("authorName");
            String price = req.getParameter("price");            
            String status = req.getParameter("status");

            // Create a BookDtls object with the extracted details
            BookDtls book = new BookDtls();
            book.setBookId(id);
            book.setBookName(bookName);
            book.setAuthor(author);
            book.setPrice(price);
            book.setStatus(status);

            // Instantiate BookDao and call the updateEditBook method
            BookDAOImpl dao = new BookDAOImpl(DBConnect.getConnection());
            boolean f  = dao.updateEditBooks(book);

            // Set up the session and message based on the update result
            HttpSession session = req.getSession();
            if (f) {
                session.setAttribute("msg", "Book updated successfully.");
                session.setAttribute("msgType", "success");
            } else {
                session.setAttribute("msg", "Something went wrong. Book update failed.");
                session.setAttribute("msgType", "error");
            }
            resp.sendRedirect("admin/allBooks.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

