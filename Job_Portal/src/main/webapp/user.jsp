<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    com.entity.User user =
        (com.entity.User) session.getAttribute("userobj");

    // Only normal users can access this page
    if (user == null || !"user".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>User Dashboard</title>

    <%@ include file="all_component/all_css.jsp"%>

</head>

<body style="background-color: #f0f1f2;">

    <%@ include file="all_component/navbar.jsp"%>


    <div class="container mt-5">

        <div class="text-center">

            <h2 class="text-primary">
                Welcome User
            </h2>

            <p>
                Welcome, <strong>${userobj.name}</strong>
            </p>

        </div>


        <div class="row mt-4">


            <!-- SEE ALL JOBS -->

            <div class="col-md-6">

                <div class="card shadow">

                    <div class="card-body text-center">

                        <i class="fas fa-briefcase fa-3x text-primary"></i>

                        <h4 class="mt-3">
                            See All Jobs
                        </h4>

                        <p>
                            View all available job opportunities.
                        </p>

                        <a href="view_all_job.jsp"
                           class="btn btn-primary">

                            <i class="fas fa-search"></i>
                            See All Jobs

                        </a>

                    </div>

                </div>

            </div>


            <!-- APPLICATION HISTORY -->

            <div class="col-md-6">

                <div class="card shadow">

                    <div class="card-body text-center">

                        <i class="fas fa-history fa-3x text-success"></i>

                        <h4 class="mt-3">
                            Application History
                        </h4>

                        <p>
                            View the jobs you have applied for.
                        </p>

                        <a href="application_history.jsp"
                           class="btn btn-success">

                            <i class="fas fa-file-alt"></i>
                            Application History

                        </a>

                    </div>

                </div>

            </div>


        </div>

    </div>


</body>

</html>