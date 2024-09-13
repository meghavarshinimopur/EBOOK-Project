package com.admin.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.DAO.BookDAOImpl;
import com.DB.DBConnect;
import com.Entity.BookDtls;

@WebServlet("/addbook")
@MultipartConfig
public class BookAdd extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		try {
			// Retrieve form parameters
			String bookName = req.getParameter("bookName");
			String author = req.getParameter("authorName");
			String price = req.getParameter("price");
			String category = req.getParameter("category");
			String status = req.getParameter("status");

			// Handle file upload
			Part part = req.getPart("bookImage");
			String fileName = part.getSubmittedFileName();

			// Create a BookDtls object with image data as Base64 string
			BookDtls book = new BookDtls(bookName, author, price, category, status, fileName, "adminexample1@gmail.com");

			// Add the book to the database
			BookDAOImpl dao = new BookDAOImpl(DBConnect.getConnection());
			boolean isAdded = dao.addBook(book);

			// File path to save the uploaded image
			String path = getServletContext().getRealPath("") + "books";

			if (isAdded) {
				// Save the uploaded file
				File file = new File(path);
				part.write(path + File.separator + fileName);

				// Set success message
				session.setAttribute("msg", "Book added successfully!");
				session.setAttribute("msgType", "success");
			} else {
				// Set failure message
				session.setAttribute("msg", "Failed to add the book.");
				session.setAttribute("msgType", "error");
			}

			resp.sendRedirect("admin/addbook.jsp"); // Redirect to avoid form resubmission

		} catch (NumberFormatException e) {
			e.printStackTrace();
			session.setAttribute("msg", "Invalid price format.");
			session.setAttribute("msgType", "error");
			resp.sendRedirect("admin/addbook.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("msg", "An error occurred.");
			session.setAttribute("msgType", "error");
			resp.sendRedirect("admin/addbook.jsp");
		}
	}
}
