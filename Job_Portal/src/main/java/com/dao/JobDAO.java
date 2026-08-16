package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.entity.Jobs;

public class JobDAO {

    private Connection conn;

    public JobDAO(Connection conn) {
        super();
        this.conn = conn;
    }


    // =========================================================
    // ADD JOB
    // =========================================================

    public boolean addJobs(Jobs j) {

        boolean f = false;

        try {

            String sql =
                "INSERT INTO jobs " +
                "(title, description, category, status, location, recruiter_id) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps =
                conn.prepareStatement(sql);

            ps.setString(1, j.getTitle());
            ps.setString(2, j.getDescription());
            ps.setString(3, j.getCategory());
            ps.setString(4, j.getStatus());
            ps.setString(5, j.getLocation());

            // IMPORTANT
            ps.setInt(6, j.getRecruiterId());

            int i = ps.executeUpdate();

            if (i == 1) {
                f = true;
            }

            ps.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return f;
    }


    // =========================================================
    // GET ALL JOBS
    // =========================================================

    public List<Jobs> getAllJobs() {

        List<Jobs> list =
            new ArrayList<Jobs>();

        try {

            String sql =
                "SELECT * FROM jobs ORDER BY id DESC";

            PreparedStatement ps =
                conn.prepareStatement(sql);

            ResultSet rs =
                ps.executeQuery();

            while (rs.next()) {

                Jobs j =
                    new Jobs();

                j.setId(
                    rs.getInt("id")
                );

                j.setTitle(
                    rs.getString("title")
                );

                j.setDescription(
                    rs.getString("description")
                );

                j.setCategory(
                    rs.getString("category")
                );

                j.setStatus(
                    rs.getString("status")
                );

                j.setLocation(
                    rs.getString("location")
                );


                // Publish Date

                if (rs.getTimestamp("pdate") != null) {

                    j.setPdate(
                        rs.getTimestamp("pdate").toString()
                    );
                }


                // Recruiter ID

                j.setRecruiterId(
                    rs.getInt("recruiter_id")
                );


                list.add(j);
            }

            rs.close();
            ps.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return list;
    }


    // =========================================================
    // GET JOB BY ID
    // =========================================================

    public Jobs getJobById(int id) {

        Jobs j = null;

        try {

            String sql =
                "SELECT * FROM jobs WHERE id=?";

            PreparedStatement ps =
                conn.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs =
                ps.executeQuery();

            if (rs.next()) {

                j =
                    new Jobs();

                j.setId(
                    rs.getInt("id")
                );

                j.setTitle(
                    rs.getString("title")
                );

                j.setDescription(
                    rs.getString("description")
                );

                j.setCategory(
                    rs.getString("category")
                );

                j.setStatus(
                    rs.getString("status")
                );

                j.setLocation(
                    rs.getString("location")
                );


                if (rs.getTimestamp("pdate") != null) {

                    j.setPdate(
                        rs.getTimestamp("pdate").toString()
                    );
                }


                j.setRecruiterId(
                    rs.getInt("recruiter_id")
                );
            }

            rs.close();
            ps.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return j;
    }


    // =========================================================
    // UPDATE JOB
    // =========================================================

    public boolean updateJob(Jobs j) {

        boolean f = false;

        try {

            String sql =
                "UPDATE jobs SET " +
                "title=?, " +
                "description=?, " +
                "category=?, " +
                "status=?, " +
                "location=? " +
                "WHERE id=?";

            PreparedStatement ps =
                conn.prepareStatement(sql);

            ps.setString(1, j.getTitle());
            ps.setString(2, j.getDescription());
            ps.setString(3, j.getCategory());
            ps.setString(4, j.getStatus());
            ps.setString(5, j.getLocation());
            ps.setInt(6, j.getId());

            int i =
                ps.executeUpdate();

            if (i == 1) {
                f = true;
            }

            ps.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return f;
    }


    // =========================================================
    // DELETE JOB
    // =========================================================

    public boolean deleteJob(int id) {

        boolean f = false;

        try {

            String sql =
                "DELETE FROM jobs WHERE id=?";

            PreparedStatement ps =
                conn.prepareStatement(sql);

            ps.setInt(1, id);

            int i =
                ps.executeUpdate();

            if (i == 1) {
                f = true;
            }

            ps.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return f;
    }


    // =========================================================
    // APPLY FOR JOB
    // =========================================================

    public boolean applyJob(int jobId, int userId) {

        boolean f = false;

        try {

            String sql =
                "INSERT INTO job_application " +
                "(job_id, user_id, status) " +
                "VALUES (?, ?, ?)";

            PreparedStatement ps =
                conn.prepareStatement(sql);

            ps.setInt(1, jobId);
            ps.setInt(2, userId);
            ps.setString(3, "Applied");

            int i =
                ps.executeUpdate();

            if (i == 1) {
                f = true;
            }

            ps.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return f;
    }


    // =========================================================
    // CHECK WHETHER USER ALREADY APPLIED
    // =========================================================

    public boolean checkApplication(
            int jobId,
            int userId) {

        boolean f = false;

        try {

            String sql =
                "SELECT id FROM job_application " +
                "WHERE job_id=? AND user_id=?";

            PreparedStatement ps =
                conn.prepareStatement(sql);

            ps.setInt(1, jobId);
            ps.setInt(2, userId);

            ResultSet rs =
                ps.executeQuery();

            if (rs.next()) {
                f = true;
            }

            rs.close();
            ps.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return f;
    }


    // =========================================================
    // GET USER APPLICATION HISTORY
    // =========================================================

    public List<Jobs> getUserApplicationHistory(
            int userId) {

        List<Jobs> list =
            new ArrayList<Jobs>();

        try {

            String sql =
                "SELECT j.* " +
                "FROM job_application ja " +
                "INNER JOIN jobs j " +
                "ON ja.job_id = j.id " +
                "WHERE ja.user_id=? " +
                "ORDER BY ja.application_date DESC";

            PreparedStatement ps =
                conn.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs =
                ps.executeQuery();

            while (rs.next()) {

                Jobs j =
                    new Jobs();

                j.setId(
                    rs.getInt("id")
                );

                j.setTitle(
                    rs.getString("title")
                );

                j.setDescription(
                    rs.getString("description")
                );

                j.setCategory(
                    rs.getString("category")
                );

                j.setStatus(
                    rs.getString("status")
                );

                j.setLocation(
                    rs.getString("location")
                );


                if (rs.getTimestamp("pdate") != null) {

                    j.setPdate(
                        rs.getTimestamp("pdate").toString()
                    );
                }


                j.setRecruiterId(
                    rs.getInt("recruiter_id")
                );

                list.add(j);
            }

            rs.close();
            ps.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return list;
    }


    // =========================================================
    // GET RECRUITER APPLICATIONS
    // =========================================================

    public List<Map<String, Object>>
    getRecruiterApplications(int recruiterId) {

        List<Map<String, Object>> list =
            new ArrayList<Map<String, Object>>();

        try {

            String sql =
                "SELECT " +
                "ja.id AS application_id, " +
                "ja.application_date, " +
                "ja.status, " +

                "u.id AS user_id, " +
                "u.name AS applicant_name, " +
                "u.email, " +
                "u.qualification, " +

                "j.id AS job_id, " +
                "j.title AS job_title, " +
                "j.category, " +
                "j.location, " +
                "j.recruiter_id " +

                "FROM job_application ja " +

                "INNER JOIN user u " +
                "ON ja.user_id = u.id " +

                "INNER JOIN jobs j " +
                "ON ja.job_id = j.id " +

                "WHERE j.recruiter_id = ? " +

                "ORDER BY ja.application_date DESC";


            PreparedStatement ps =
                conn.prepareStatement(sql);

            ps.setInt(1, recruiterId);

            ResultSet rs =
                ps.executeQuery();


            while (rs.next()) {

                Map<String, Object> application =
                    new HashMap<String, Object>();


                // =================================================
                // APPLICATION INFORMATION
                // =================================================

                application.put(
                    "applicationId",
                    rs.getInt("application_id")
                );

                application.put(
                    "applicationDate",
                    rs.getTimestamp("application_date")
                );

                application.put(
                    "status",
                    rs.getString("status")
                );


                // =================================================
                // USER INFORMATION
                // =================================================

                application.put(
                    "userId",
                    rs.getInt("user_id")
                );

                application.put(
                    "userName",
                    rs.getString("applicant_name")
                );

                application.put(
                    "userEmail",
                    rs.getString("email")
                );

                application.put(
                    "userQualification",
                    rs.getString("qualification")
                );


                // =================================================
                // JOB INFORMATION
                // =================================================

                application.put(
                    "jobId",
                    rs.getInt("job_id")
                );

                application.put(
                    "jobTitle",
                    rs.getString("job_title")
                );

                application.put(
                    "jobCategory",
                    rs.getString("category")
                );

                application.put(
                    "jobLocation",
                    rs.getString("location")
                );

                application.put(
                    "recruiterId",
                    rs.getInt("recruiter_id")
                );


                list.add(application);
            }


            rs.close();
            ps.close();

        } catch (Exception e) {

            e.printStackTrace();
        }


        return list;
    }
}