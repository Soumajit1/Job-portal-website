package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ApplicationDAO {

    private Connection conn;


    // ==========================================
    // CONSTRUCTOR
    // ==========================================

    public ApplicationDAO(Connection conn) {

        this.conn = conn;
    }


    // ==========================================
    // CHECK WHETHER USER ALREADY APPLIED
    // ==========================================

    public boolean checkApplication(int jobId, int userId) {

        boolean f = false;

        try {

            String sql =
                    "SELECT id FROM job_application "
                    + "WHERE job_id=? AND user_id=?";


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


    // ==========================================
    // APPLY FOR JOB
    // ==========================================

    public boolean applyJob(int jobId, int userId) {

        boolean f = false;

        try {


            String sql =
                    "INSERT INTO job_application "
                    + "(job_id, user_id, status) "
                    + "VALUES (?, ?, ?)";


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

}