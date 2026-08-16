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

@WebServlet("/edit_job")
public class EditJobServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            // Get values from edit_job.jsp
            int id = Integer.parseInt(req.getParameter("id"));

            String title = req.getParameter("title");
            String location = req.getParameter("location");
            String category = req.getParameter("category");
            String status = req.getParameter("status");
            String description = req.getParameter("desc");

            // Create Jobs object
            Jobs j = new Jobs();

            j.setId(id);
            j.setTitle(title);
            j.setLocation(location);
            j.setCategory(category);
            j.setStatus(status);
            j.setDescription(description);

            // Get DAO
            JobDAO dao = new JobDAO(DBConnect.getConn());

            // Update job
            boolean f = dao.updateJob(j);

            HttpSession session = req.getSession();

            if (f) {

                session.setAttribute("succMsg", "Job Updated Successfully!");

            } else {

                session.setAttribute("errorMsg", "Something went wrong while updating the job.");

            }

            resp.sendRedirect("view_job.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            HttpSession session = req.getSession();

            session.setAttribute("errorMsg",
                    "Error while updating job: " + e.getMessage());

            resp.sendRedirect("view_job.jsp");
        }
    }
}