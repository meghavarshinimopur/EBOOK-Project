package com.user.servlet;

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

@WebServlet("/add_old_book")
@MultipartConfig
public class AddOldBook extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		try {
			// Retrieve form parameters
			String bookName = req.getParameter("bookName");
			String author = req.getParameter("authorName");
			String price = req.getParameter("price");
			String category = "Old";
			String status = "Available";
			
			// Get user email from the form
			String useremail = req.getParameter("user");

			// Handle file upload
			Part part = req.getPart("bookImage");
			String fileName = part.getSubmittedFileName();

			// Create a BookDtls object with all form data
			BookDtls book = new BookDtls(bookName, author, price, category, status, fileName, useremail);

			// Initialize DAO for database interaction
			BookDAOImpl dao = new BookDAOImpl(DBConnect.getConnection());
			boolean isAdded = dao.addBook(book);

			// File path to save the uploaded image
			String path = getServletContext().getRealPath("") + "books";

			// Create a new directory if it doesn't exist
			File file = new File(path);
			if (!file.exists()) {
				file.mkdir();
			}

			if (isAdded) {
				// Save the uploaded file
				part.write(path + File.separator + fileName);

				// Set success message
				session.setAttribute("msg", "Old Book for sell added successfully!");
				session.setAttribute("msgType", "success");
			} else {
				// Set failure message
				session.setAttribute("msg", "Failed to add the book.");
				session.setAttribute("msgType", "error");
			}

			// Redirect to avoid form resubmission
			resp.sendRedirect("selloldbook.jsp");

		} catch (NumberFormatException e) {
			e.printStackTrace();
			session.setAttribute("msg", "Invalid price format.");
			session.setAttribute("msgType", "error");
			resp.sendRedirect("selloldbook.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("msg", "An error occurred.");
			session.setAttribute("msgType", "error");
			resp.sendRedirect("selloldbook.jsp");
		}
	}
}
