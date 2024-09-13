package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.UserDAOImpl;
import com.DB.DBConnect;
import com.Entity.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession();
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            // Manual email-password checks
            if ("admin@example1.com".equals(email) && "admin".equals(password)) {
                session.setAttribute("userEmail", email);
                session.setAttribute("userName", "Admin User");
                resp.sendRedirect("admin/home.jsp");
            } else if ("mopurmeghavarshini@gmail.com".equals(email) && "admin123".equals(password)) {
                session.setAttribute("userEmail", email);
                session.setAttribute("userName", "Mopur Meghavarshini");
                resp.sendRedirect("admin/home.jsp");
            } else if ("gajendrakawre540@gmail.com".equals(email) && "admin123".equals(password)) {
                session.setAttribute("userEmail", email);
                session.setAttribute("userName", "Gajendra Kawre");
                resp.sendRedirect("admin/home.jsp");
            } else {
                // Handle login with database
                UserDAOImpl dao = new UserDAOImpl(DBConnect.getConnection());
                User us = dao.login(email, password);
                if (us != null) {
                   
                    session.setAttribute("userobj", us); // Assuming `User` has a `getName` method
                    resp.sendRedirect("index.jsp");
                } else {
                    // Set message attributes for the login page
                    req.setAttribute("msg", "Invalid email or password.");
                    req.setAttribute("messageType", "error");
                    req.getRequestDispatcher("login.jsp").forward(req, resp);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("msg", "An unexpected error occurred.");
            req.setAttribute("messageType", "error");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
