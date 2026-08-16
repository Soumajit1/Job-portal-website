<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.dao.JobDAO"%>
<%@ page import="com.entity.Jobs"%>
<%@ page import="com.entity.User"%>
<%@ page import="com.DB.DBConnect"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<%
    // ==========================================
    // GET LOGGED-IN USER
    // ==========================================

    User user =
        (User) session.getAttribute("userobj");


    // ==========================================
    // ONLY USER CAN ACCESS
    // ==========================================

    if (user == null || !"user".equals(user.getRole())) {

        response.sendRedirect("login.jsp");

        return;
    }


    // ==========================================
    // GET USER ID
    // ==========================================

    int userId = user.getId();


    // ==========================================
    // GET APPLICATION HISTORY
    // ==========================================

    JobDAO dao =
        new JobDAO(DBConnect.getConn());

    List<Jobs> list =
        dao.getUserApplicationHistory(userId);

%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Application History</title>

    <%@ include file="all_component/all_css.jsp"%>

</head>


<body style="background-color: #f0f1f2;">


    <%@ include file="all_component/navbar.jsp"%>


    <div class="container">


        <!-- PAGE TITLE -->

        <h4 class="text-center text-primary mt-4">

            Application History

        </h4>


        <%
            if (list != null && !list.isEmpty()) {

                for (Jobs j : list) {
        %>


        <!-- ============================= -->
        <!-- APPLICATION CARD -->
        <!-- ============================= -->

        <div class="card mt-3">


            <div class="card-body">


                <!-- ICON -->

                <div class="text-center text-primary">

                    <i class="far fa-clipboard fa-2x"></i>

                </div>


                <!-- JOB TITLE -->

                <h5>

                    <%= j.getTitle() %>

                </h5>


                <!-- DESCRIPTION -->

                <p>

                    <%= j.getDescription() %>

                </p>


                <!-- JOB INFORMATION -->

                <div class="form-row">


                    <!-- LOCATION -->

                    <div class="form-group col-md-4">

                        <input type="text"
                               class="form-control form-control-sm"
                               value="Location: <%= j.getLocation() %>"
                               readonly>

                    </div>


                    <!-- CATEGORY -->

                    <div class="form-group col-md-4">

                        <input type="text"
                               class="form-control form-control-sm"
                               value="Category: <%= j.getCategory() %>"
                               readonly>

                    </div>


                    <!-- JOB STATUS -->

                    <div class="form-group col-md-4">

                        <input type="text"
                               class="form-control form-control-sm"
                               value="Job Status: <%= j.getStatus() %>"
                               readonly>

                    </div>


                </div>


                <!-- PUBLISH DATE -->

                <h6>

                    Publish Date:

                    <%= j.getPdate() %>

                </h6>


                <!-- APPLICATION STATUS -->

                <div class="mt-3">

                    <span class="badge badge-success">

                        Application Submitted

                    </span>

                </div>


            </div>

        </div>


        <%
                }

            } else {
        %>


        <!-- NO APPLICATION -->

        <div class="alert alert-info text-center mt-4">

            You have not applied for any jobs yet.

        </div>


        <%
            }
        %>


    </div>


</body>

</html>