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

@WebServlet("/update_profile")
public class UpdateProfile extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Get form data
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String password = req.getParameter("password");
            String confirmPassword = req.getParameter("confirmPassword");

            HttpSession session = req.getSession();
            UserDAOImpl dao = new UserDAOImpl(DBConnect.getConnection());

            // Check if the password matches
            if (password.equals(confirmPassword)) {
                // Verify the old password for the current user
                boolean isPasswordCorrect = dao.checkPassword(id, password);

                if (isPasswordCorrect) {
                    // Update the profile
                    User user = new User();
                    user.setId(id);
                    user.setName(name);
                    user.setEmail(email);
                    user.setPhno(phone);

                    boolean isUpdated = dao.updateProfile(user);

                    if (isUpdated) {
                        session.setAttribute("successMessage", "Profile updated successfully!");
                        resp.sendRedirect("editprofile.jsp");
                    } else {
                        session.setAttribute("errorMessage", "Profile update failed!");
                        resp.sendRedirect("editprofile.jsp");
                    }
                } else {
                    session.setAttribute("errorMessage", "Incorrect password!");
                    resp.sendRedirect("editprofile.jsp");
                }
            } else {
                session.setAttribute("errorMessage", "Passwords do not match!");
                resp.sendRedirect("editprofile.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "Something went wrong!");
            resp.sendRedirect("editprofile.jsp");
        }
    }
}
