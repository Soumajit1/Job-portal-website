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

@WebServlet("/delete_job")
public class DeleteJobServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            // Get job ID from URL
            int id = Integer.parseInt(req.getParameter("id"));

            // Create DAO
            JobDAO dao = new JobDAO(DBConnect.getConn());

            // Delete job
            boolean f = dao.deleteJob(id);

            HttpSession session = req.getSession();

            if (f) {

                session.setAttribute(
                    "succMsg",
                    "Job Deleted Successfully!"
                );

            } else {

                session.setAttribute(
                    "errorMsg",
                    "Something went wrong while deleting the job."
                );
            }

            // Go back to View Jobs
            resp.sendRedirect("view_job.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            HttpSession session = req.getSession();

            session.setAttribute(
                "errorMsg",
                "Error while deleting job: " + e.getMessage()
            );

            resp.sendRedirect("view_job.jsp");
        }
    }
}