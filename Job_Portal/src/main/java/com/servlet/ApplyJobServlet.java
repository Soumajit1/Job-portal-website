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
import com.entity.User;

@WebServlet("/apply_job")
public class ApplyJobServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        try {

            // ==========================================
            // CHECK LOGGED-IN USER
            // ==========================================

            User user = (User) session.getAttribute("userobj");

            if (user == null || !"user".equals(user.getRole())) {

                resp.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }


            // ==========================================
            // GET JOB ID
            // ==========================================

            String jobIdString = req.getParameter("id");

            if (jobIdString == null || jobIdString.trim().isEmpty()) {

                session.setAttribute(
                        "errorMsg",
                        "Invalid Job ID."
                );

                resp.sendRedirect(
                        req.getContextPath() + "/view_all_job.jsp"
                );

                return;
            }


            int jobId = Integer.parseInt(jobIdString);


            // ==========================================
            // GET USER ID
            // ==========================================

            int userId = user.getId();


            // ==========================================
            // DATABASE CONNECTION
            // ==========================================

            JobDAO dao = new JobDAO(DBConnect.getConn());


            // ==========================================
            // CHECK ALREADY APPLIED
            // ==========================================

            boolean alreadyApplied =
                    dao.checkApplication(jobId, userId);


            if (alreadyApplied) {

                session.setAttribute(
                        "errorMsg",
                        "You have already applied for this job."
                );

            } else {


                // ==========================================
                // APPLY FOR JOB
                // ==========================================

                boolean success =
                        dao.applyJob(jobId, userId);


                if (success) {

                    session.setAttribute(
                            "succMsg",
                            "Job application submitted successfully."
                    );

                } else {

                    session.setAttribute(
                            "errorMsg",
                            "Something went wrong while applying."
                    );
                }
            }


            // ==========================================
            // GO BACK TO ALL JOBS
            // ==========================================

            resp.sendRedirect(
                    req.getContextPath() + "/view_all_job.jsp"
            );


        } catch (NumberFormatException e) {

            e.printStackTrace();

            session.setAttribute(
                    "errorMsg",
                    "Invalid Job ID."
            );

            resp.sendRedirect(
                    req.getContextPath() + "/view_all_job.jsp"
            );


        } catch (Exception e) {

            e.printStackTrace();

            session.setAttribute(
                    "errorMsg",
                    "Something went wrong on server."
            );

            resp.sendRedirect(
                    req.getContextPath() + "/view_all_job.jsp"
            );
        }
    }
}