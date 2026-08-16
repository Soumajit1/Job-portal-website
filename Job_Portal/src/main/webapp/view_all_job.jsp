<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.dao.JobDAO"%>
<%@ page import="com.entity.Jobs"%>
<%@ page import="com.entity.User"%>
<%@ page import="com.DB.DBConnect"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    // =========================================================
    // CHECK LOGGED-IN USER
    // =========================================================

    User user = (User) session.getAttribute("userobj");

    // Only USER can access this page
    if (user == null || !"user".equals(user.getRole())) {

        response.sendRedirect("login.jsp");
        return;
    }


    // =========================================================
    // GET ALL JOBS
    // =========================================================

    JobDAO dao = new JobDAO(DBConnect.getConn());

    List<Jobs> list = dao.getAllJobs();
%>


<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>All Jobs</title>

    <%@ include file="all_component/all_css.jsp"%>

</head>


<body style="background-color: #f0f1f2;">


    <!-- NAVBAR -->

    <%@ include file="all_component/navbar.jsp"%>


    <div class="container">


        <!-- =====================================================
             SUCCESS MESSAGE
        ====================================================== -->

        <c:if test="${not empty succMsg}">

            <div class="alert alert-success text-center mt-3">

                ${succMsg}

            </div>

            <c:remove var="succMsg"/>

        </c:if>


        <!-- =====================================================
             ERROR MESSAGE
        ====================================================== -->

        <c:if test="${not empty errorMsg}">

            <div class="alert alert-danger text-center mt-3">

                ${errorMsg}

            </div>

            <c:remove var="errorMsg"/>

        </c:if>


        <!-- =====================================================
             PAGE TITLE
        ====================================================== -->

        <h4 class="text-center text-primary mt-3">

            Available Jobs

        </h4>


        <%
            if (list != null && !list.isEmpty()) {

                for (Jobs j : list) {
        %>


        <!-- =====================================================
             JOB CARD
        ====================================================== -->

        <div class="card mt-3">

            <div class="card-body">


                <!-- JOB ICON -->

                <div class="text-center text-primary">

                    <i class="far fa-clipboard fa-2x"></i>

                </div>


                <!-- JOB TITLE -->

                <h5>

                    <%= j.getTitle() %>

                </h5>


                <!-- JOB DESCRIPTION -->

                <p>

                    <%= j.getDescription() %>

                </p>


                <!-- =================================================
                     JOB INFORMATION
                ================================================== -->

                <div class="form-row">


                    <!-- LOCATION -->

                    <div class="form-group col-md-4">

                        <input
                            type="text"
                            class="form-control form-control-sm"
                            value="Location: <%= j.getLocation() %>"
                            readonly>

                    </div>


                    <!-- CATEGORY -->

                    <div class="form-group col-md-4">

                        <input
                            type="text"
                            class="form-control form-control-sm"
                            value="Category: <%= j.getCategory() %>"
                            readonly>

                    </div>


                    <!-- STATUS -->

                    <div class="form-group col-md-4">

                        <input
                            type="text"
                            class="form-control form-control-sm"
                            value="Status: <%= j.getStatus() %>"
                            readonly>

                    </div>

                </div>


                <!-- =================================================
                     PUBLISH DATE
                ================================================== -->

                <h6>

                    Publish Date:
                    <%= j.getPdate() %>

                </h6>


                <!-- =================================================
                     APPLY BUTTON
                     
                     IMPORTANT:
                     ApplyJobServlet expects parameter "id"
                     
                     Therefore:
                     apply_job?id=<%= j.getId() %>
                ================================================== -->

                <div class="text-center mt-3">

                    <a
                        href="apply_job?id=<%= j.getId() %>"
                        class="btn btn-sm btn-primary">

                        <i class="fas fa-paper-plane"></i>

                        Apply For Job

                    </a>

                </div>


            </div>

        </div>


        <%
                }

            } else {
        %>


        <!-- =====================================================
             NO JOBS
        ====================================================== -->

        <div class="alert alert-info text-center mt-4">

            No jobs are currently available.

        </div>


        <%
            }
        %>


    </div>


</body>

</html>