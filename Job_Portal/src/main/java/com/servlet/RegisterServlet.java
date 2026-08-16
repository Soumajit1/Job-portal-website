package com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DB.DBConnect;
import com.dao.UserDAO;
import com.entity.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        try {

            // Get registration data
            String name = req.getParameter("name");
            String qualification = req.getParameter("qua");
            String email = req.getParameter("email");
            String password = req.getParameter("ps");
            String role = req.getParameter("role");

            // Basic validation
            if (name == null || qualification == null ||
                email == null || password == null || role == null ||
                name.trim().isEmpty() ||
                qualification.trim().isEmpty() ||
                email.trim().isEmpty() ||
                password.trim().isEmpty() ||
                role.trim().isEmpty()) {

                session.setAttribute("errorMsg",
                        "Please fill all fields.");

                resp.sendRedirect("signup.jsp");
                return;
            }

            // Only USER and RECRUITER can register
            if (!role.equals("user") && !role.equals("recruiter")) {

                session.setAttribute("errorMsg",
                        "Admin registration is not allowed.");

                resp.sendRedirect("signup.jsp");
                return;
            }

            // Create User object
            User u = new User();

            u.setName(name);
            u.setQualification(qualification);
            u.setEmail(email);
            u.setPassword(password);
            u.setRole(role);

            // Save to database
            UserDAO dao = new UserDAO(DBConnect.getConn());

            boolean f = dao.registerUser(u);

            if (f) {

                session.setAttribute("succMsg",
                        "Registration successful. Please login.");

                resp.sendRedirect("login.jsp");

            } else {

                session.setAttribute("errorMsg",
                        "Email already exists or registration failed.");

                resp.sendRedirect("signup.jsp");
            }

        } catch (Exception e) {

            e.printStackTrace();

            session.setAttribute("errorMsg",
                    "Something went wrong. Please try again.");

            resp.sendRedirect("signup.jsp");
        }
    }
}