<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.dao.JobDAO"%>
<%@ page import="com.entity.Jobs"%>
<%@ page import="com.DB.DBConnect"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    // =====================================================
    // ADMIN ACCESS PROTECTION
    // =====================================================

    Object userObj = session.getAttribute("userobj");

    if (userObj == null) {

        response.sendRedirect("login.jsp");
        return;
    }

    com.entity.User user = (com.entity.User) userObj;

    if (!"admin".equals(user.getRole())) {

        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Admin: View Jobs</title>

    <%@include file="all_component/all_css.jsp"%>

</head>


<body style="background-color: #f0f1f2;">

    <%@include file="all_component/navbar.jsp"%>


    <div class="container">

        <div class="row">

            <div class="col-md-12">

                <h5 class="text-center text-primary mt-3">
                    All Jobs
                </h5>


                <!-- SUCCESS MESSAGE -->

                <c:if test="${not empty succMsg}">

                    <div class="alert alert-success text-center"
                         role="alert">

                        ${succMsg}

                    </div>

                    <c:remove var="succMsg"/>

                </c:if>


                <!-- ERROR MESSAGE -->

                <c:if test="${not empty errorMsg}">

                    <div class="alert alert-danger text-center"
                         role="alert">

                        ${errorMsg}

                    </div>

                    <c:remove var="errorMsg"/>

                </c:if>


                <%

                    JobDAO dao = new JobDAO(DBConnect.getConn());

                    List<Jobs> list = dao.getAllJobs();

                    if (list != null && !list.isEmpty()) {

                        for (Jobs j : list) {

                %>


                <!-- JOB CARD -->

                <div class="card mt-2">

                    <div class="card-body">


                        <!-- JOB ICON -->

                        <div class="text-center text-primary">

                            <i class="far fa-clipboard fa-2x"></i>

                        </div>


                        <!-- TITLE -->

                        <h6>
                            <%= j.getTitle() %>
                        </h6>


                        <!-- DESCRIPTION -->

                        <p>
                            <%= j.getDescription() %>
                        </p>


                        <br>


                        <!-- JOB INFORMATION -->

                        <div class="form-row">


                            <!-- LOCATION -->

                            <div class="form-group col-md-3">

                                <input type="text"
                                       class="form-control form-control-sm"
                                       value="Location: <%= j.getLocation() %>"
                                       readonly>

                            </div>


                            <!-- CATEGORY -->

                            <div class="form-group col-md-3">

                                <input type="text"
                                       class="form-control form-control-sm"
                                       value="Category: <%= j.getCategory() %>"
                                       readonly>

                            </div>


                            <!-- STATUS -->

                            <div class="form-group col-md-3">

                                <input type="text"
                                       class="form-control form-control-sm"
                                       value="Status: <%= j.getStatus() %>"
                                       readonly>

                            </div>


                        </div>


                        <!-- PUBLISH DATE -->

                        <h6>

                            Publish Date:
                            <%= j.getPdate() %>

                        </h6>


                        <!-- BUTTONS -->

                        <div class="text-center">


                            <!-- EDIT -->

                            <a href="edit_job.jsp?id=<%= j.getId() %>"
                               class="btn btn-sm bg-success text-white">

                                <i class="fas fa-edit"></i>

                                Edit

                            </a>


                            <!-- DELETE -->

                            <a href="delete_job?id=<%= j.getId() %>"
                               class="btn btn-sm bg-danger text-white"
                               onclick="return confirm('Are you sure you want to delete this job?');">

                                <i class="fas fa-trash"></i>

                                Delete

                            </a>


                        </div>


                    </div>

                </div>


                <%

                        }

                    } else {

                %>


                <div class="alert alert-info text-center mt-3">

                    No jobs available.

                </div>


                <%

                    }

                %>


            </div>

        </div>

    </div>


</body>

</html>