package com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DB.DBConnect;
import com.dao.JobDAO;
import com.entity.Jobs;
import com.entity.User;

@WebServlet("/add_job")
public class AddPostServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req,
                           HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        try {

            // =====================================================
            // CHECK LOGIN
            // =====================================================

            Object userObj = session.getAttribute("userobj");

            if (userObj == null) {

                resp.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }

            User user = (User) userObj;

            // =====================================================
            // ALLOW ADMIN AND RECRUITER
            // =====================================================

            String role = user.getRole();

            if (!"admin".equals(role) &&
                !"recruiter".equals(role)) {

                session.setAttribute(
                    "errorMsg",
                    "You are not authorized to post a job."
                );

                resp.sendRedirect(
                    req.getContextPath() + "/index.jsp"
                );

                return;
            }


            // =====================================================
            // GET FORM DATA
            // =====================================================

            String title = req.getParameter("title");
            String location = req.getParameter("location");
            String category = req.getParameter("category");
            String status = req.getParameter("status");
            String desc = req.getParameter("desc");


            // =====================================================
            // VALIDATE FORM DATA
            // =====================================================

            if (title == null || title.trim().isEmpty() ||
                location == null || location.trim().isEmpty() ||
                category == null || category.trim().isEmpty() ||
                status == null || status.trim().isEmpty() ||
                desc == null || desc.trim().isEmpty()) {

                session.setAttribute(
                    "errorMsg",
                    "Please fill all the required fields."
                );

                resp.sendRedirect(
                    req.getContextPath() + "/add_job.jsp"
                );

                return;
            }


            // =====================================================
            // CREATE JOB OBJECT
            // =====================================================

            Jobs j = new Jobs();

            j.setTitle(title.trim());
            j.setDescription(desc.trim());
            j.setLocation(location.trim());
            j.setStatus(status.trim());
            j.setCategory(category.trim());

            // VERY IMPORTANT
            // Store the ID of the person who posted the job.
            j.setRecruiterId(user.getId());


            // =====================================================
            // SAVE JOB
            // =====================================================

            JobDAO dao =
                new JobDAO(DBConnect.getConn());

            boolean success =
                dao.addJobs(j);


            // =====================================================
            // RESULT
            // =====================================================

            if (success) {

                session.setAttribute(
                    "succMsg",
                    "Job Posted Successfully!"
                );

            } else {

                session.setAttribute(
                    "errorMsg",
                    "Something went wrong while posting the job."
                );
            }


            // =====================================================
            // REDIRECT BACK TO ADD JOB PAGE
            // =====================================================

            resp.sendRedirect(
                req.getContextPath() + "/add_job.jsp"
            );


        } catch (Exception e) {

            e.printStackTrace();

            session.setAttribute(
                "errorMsg",
                "Error: " + e.getMessage()
            );

            resp.sendRedirect(
                req.getContextPath() + "/add_job.jsp"
            );
        }
    }
}