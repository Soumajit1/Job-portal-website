package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.entity.User;

public class UserDAO {

    private Connection conn;

    public UserDAO(Connection conn) {
        super();
        this.conn = conn;
    }


    // ==============================
    // REGISTER USER / RECRUITER
    // ==============================

    public boolean registerUser(User u) {

        boolean f = false;

        try {

            String sql = "INSERT INTO user(name,email,password,qualification,role) "
                       + "VALUES(?,?,?,?,?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getQualification());
            ps.setString(5, u.getRole());

            int i = ps.executeUpdate();

            if (i == 1) {
                f = true;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return f;
    }


    // ==============================
    // LOGIN USER / RECRUITER
    // ==============================

    public User loginUser(String email, String password, String role) {

        User u = null;

        try {

            String sql = "SELECT * FROM user "
                       + "WHERE email=? AND password=? AND role=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);
            ps.setString(3, role);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                u = new User();

                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setQualification(rs.getString("qualification"));
                u.setRole(rs.getString("role"));
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return u;
    }
}