package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout1")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Invalidate the current session
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }

            // Set success message in session
            request.getSession().setAttribute("message", "Successfully logged out.");
            request.getSession().setAttribute("messageType", "success");

            // Redirect to login page
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            // Log the exception (optional)
            e.printStackTrace();

            // Set error message in session
            request.getSession().setAttribute("message", "Something went wrong. Please try again.");
            request.getSession().setAttribute("messageType", "error");

            // Redirect to login page
            response.sendRedirect("login.jsp");
        }
    }
}


