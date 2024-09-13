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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Retrieve form data
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String password = req.getParameter("password");
            String confirmPassword = req.getParameter("confirmPassword");
            String checkbox = req.getParameter("checkbox");

            // Check if the checkbox is checked
            if (checkbox == null) {
                req.setAttribute("msg", "Please agree to Terms & Conditions.");
                req.setAttribute("messageType", "error");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
                return;
            }

            // Validate password and confirmPassword match
            if (!password.equals(confirmPassword)) {
                req.setAttribute("msg", "Passwords do not match.");
                req.setAttribute("messageType", "error");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
                return;
            }

            // Create DAO object
            UserDAOImpl dao = new UserDAOImpl(DBConnect.getConnection());

            // Check if email is already registered
            if (dao.isEmailRegistered(email)) {
                req.setAttribute("msg", "Email is already registered.");
                req.setAttribute("messageType", "error");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
                return;
            }

            // Set data in User object
            User us = new User();
            us.setName(name);
            us.setEmail(email);
            us.setPhno(phone);
            us.setPassword(password);
            us.setCpassword(confirmPassword);

            // Register the user
            boolean registrationSuccess = dao.userRegister(us);

            if (registrationSuccess) {
                // Create session for the new user
                HttpSession session = req.getSession();
                session.setAttribute("userobj", us);
                req.setAttribute("msg", "User registered successfully!");
                req.setAttribute("messageType", "success");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            } else {
                req.setAttribute("msg", "Something went wrong, try again!");
                req.setAttribute("messageType", "error");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("msg", "An unexpected error occurred.");
            req.setAttribute("messageType", "error");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        }
    }
}
