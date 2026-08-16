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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        try {

            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String role = req.getParameter("role");


            // ==============================
            // VALIDATION
            // ==============================

            if (email == null || password == null || role == null ||
                email.trim().isEmpty() ||
                password.trim().isEmpty() ||
                role.trim().isEmpty()) {

                session.setAttribute("errorMsg",
                        "Please enter email, password and select role.");

                resp.sendRedirect("login.jsp");
                return;
            }


            // ==============================
            // ADMIN LOGIN
            // ==============================

            if (role.equals("admin")) {

                if ("admin@gmail.com".equals(email)
                        && "admin@121".equals(password)) {

                    User admin = new User();

                    admin.setEmail(email);
                    admin.setRole("admin");
                    admin.setName("Administrator");

                    session.setAttribute("userobj", admin);

                    resp.sendRedirect("admin.jsp");

                } else {

                    session.setAttribute("errorMsg",
                            "Invalid Admin email or password.");

                    resp.sendRedirect("login.jsp");
                }

                return;
            }


            // ==============================
            // USER / RECRUITER LOGIN
            // ==============================

            if (!role.equals("user") && !role.equals("recruiter")) {

                session.setAttribute("errorMsg",
                        "Invalid role selected.");

                resp.sendRedirect("login.jsp");
                return;
            }


            UserDAO dao = new UserDAO(DBConnect.getConn());

            User u = dao.loginUser(email, password, role);


            // ==============================
            // LOGIN SUCCESS
            // ==============================

            if (u != null) {

                session.setAttribute("userobj", u);


                // USER
                if ("user".equals(u.getRole())) {

                    resp.sendRedirect("user.jsp");

                }

                // RECRUITER
                else if ("recruiter".equals(u.getRole())) {

                    resp.sendRedirect("recruiter.jsp");

                }

            }

            // ==============================
            // LOGIN FAILED
            // ==============================

            else {

                session.setAttribute("errorMsg",
                        "Invalid email, password or selected role.");

                resp.sendRedirect("login.jsp");
            }


        } catch (Exception e) {

            e.printStackTrace();

            session.setAttribute("errorMsg",
                    "Something went wrong during login.");

            resp.sendRedirect("login.jsp");
        }
    }
}