<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.dao.JobDAO"%>
<%@ page import="com.entity.User"%>
<%@ page import="com.DB.DBConnect"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>


<%
    // =====================================================
    // CHECK LOGIN
    // =====================================================

    User recruiter =
        (User) session.getAttribute("userobj");


    // Only recruiter can access this page
    if (recruiter == null ||
        !"recruiter".equals(recruiter.getRole())) {

        response.sendRedirect("login.jsp");
        return;
    }


    // =====================================================
    // GET RECRUITER ID
    // =====================================================

    int recruiterId = recruiter.getId();


    // =====================================================
    // GET APPLICATIONS
    // =====================================================

    JobDAO dao =
        new JobDAO(DBConnect.getConn());

    List<Map<String, Object>> applications =
        dao.getRecruiterApplications(recruiterId);

%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Applicant History</title>

    <%@ include file="all_component/all_css.jsp"%>

</head>


<body style="background-color: #f0f1f2;">


    <!-- NAVBAR -->

    <%@ include file="all_component/navbar.jsp"%>


    <div class="container">


        <!-- ================================================= -->
        <!-- PAGE TITLE -->
        <!-- ================================================= -->

        <h4 class="text-center text-primary mt-4">

            Applicant History

        </h4>


        <p class="text-center">

            Applications received for your posted jobs

        </p>


        <hr>


        <!-- ================================================= -->
        <!-- APPLICATION TABLE -->
        <!-- ================================================= -->

        <%
            if (applications != null &&
                !applications.isEmpty()) {
        %>


        <div class="table-responsive">

            <table class="table table-bordered table-striped">

                <thead class="thead-dark">

                    <tr>

                        <th>#</th>

                        <th>Applicant Name</th>

                        <th>Email</th>

                        <th>Qualification</th>

                        <th>Job</th>

                        <th>Category</th>

                        <th>Location</th>

                        <th>Application Date</th>

                        <th>Status</th>

                    </tr>

                </thead>


                <tbody>


                <%
                    int count = 1;

                    for (Map<String, Object> app
                            : applications) {
                %>


                    <tr>

                        <!-- NUMBER -->

                        <td>
                            <%= count++ %>
                        </td>


                        <!-- APPLICANT NAME -->

                        <td>
                            <%= app.get("userName") %>
                        </td>


                        <!-- EMAIL -->

                        <td>
                            <%= app.get("userEmail") %>
                        </td>


                        <!-- QUALIFICATION -->

                        <td>
                            <%= app.get("userQualification") %>
                        </td>


                        <!-- JOB -->

                        <td>
                            <%= app.get("jobTitle") %>
                        </td>


                        <!-- CATEGORY -->

                        <td>
                            <%= app.get("jobCategory") %>
                        </td>


                        <!-- LOCATION -->

                        <td>
                            <%= app.get("jobLocation") %>
                        </td>


                        <!-- APPLICATION DATE -->

                        <td>
                            <%= app.get("applicationDate") %>
                        </td>


                        <!-- STATUS -->

                        <td>

                            <span class="badge badge-primary">

                                <%= app.get("status") %>

                            </span>

                        </td>


                    </tr>


                <%
                    }
                %>


                </tbody>

            </table>

        </div>


        <%
            } else {
        %>


        <!-- ================================================= -->
        <!-- NO APPLICATION -->
        <!-- ================================================= -->

        <div class="alert alert-info text-center mt-4">

            No applications received for your jobs yet.

        </div>


        <%
            }
        %>


    </div>


</body>

</html>