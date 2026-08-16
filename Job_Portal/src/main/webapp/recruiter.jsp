<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<%
    // =====================================================
    // CHECK LOGGED-IN USER
    // =====================================================

    com.entity.User user =
        (com.entity.User) session.getAttribute("userobj");


    // =====================================================
    // ONLY RECRUITER CAN ACCESS THIS PAGE
    // =====================================================

    if (user == null ||
        !"recruiter".equals(user.getRole())) {

        response.sendRedirect("login.jsp");

        return;
    }
%>


<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Recruiter Dashboard</title>

    <%@ include file="all_component/all_css.jsp"%>

</head>


<body style="background-color: #f0f1f2;">


    <!-- ================================================= -->
    <!-- NAVBAR -->
    <!-- ================================================= -->

    <%@ include file="all_component/navbar.jsp"%>


    <!-- ================================================= -->
    <!-- RECRUITER DASHBOARD -->
    <!-- ================================================= -->

    <div class="container">


        <!-- WELCOME MESSAGE -->

        <div class="text-center mt-5">

            <h2 class="text-primary">

                Welcome Recruiter

            </h2>

            <p class="mt-2">

                Welcome, ${userobj.name}

            </p>

        </div>


        <!-- ================================================= -->
        <!-- TWO OPTIONS -->
        <!-- ================================================= -->

        <div class="row mt-5">


            <!-- ================================================= -->
            <!-- POST JOB -->
            <!-- ================================================= -->

            <div class="col-md-5 offset-md-1">

                <div class="card">

                    <div class="card-body text-center">


                        <div class="text-primary">

                            <i class="fas fa-plus-circle fa-3x"></i>

                        </div>


                        <h4 class="mt-3">

                            Post Job

                        </h4>


                        <p>

                            Create and publish a new job
                            vacancy for applicants.

                        </p>


                        <a href="add_job.jsp"
                           class="btn btn-primary">

                            Post Job

                        </a>


                    </div>

                </div>

            </div>


            <!-- ================================================= -->
            <!-- SEE APPLICATIONS -->
            <!-- ================================================= -->

            <div class="col-md-5">

                <div class="card">

                    <div class="card-body text-center">


                        <div class="text-primary">

                            <i class="fas fa-users fa-3x"></i>

                        </div>


                        <h4 class="mt-3">

                            See Applications

                        </h4>


                        <p>

                            View applications submitted by
                            users for your posted jobs.

                        </p>


                        <a href="applicant_history.jsp"
                           class="btn btn-primary">

                            See Applications

                        </a>


                    </div>

                </div>

            </div>


        </div>


    </div>


</body>

</html>