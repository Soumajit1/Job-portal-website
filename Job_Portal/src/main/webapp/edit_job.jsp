<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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


    // =====================================================
    // GET JOB
    // =====================================================

    Jobs job = null;

    try {

        String id = request.getParameter("id");

        if (id != null && !id.trim().isEmpty()) {

            int jobId = Integer.parseInt(id);

            JobDAO dao = new JobDAO(DBConnect.getConn());

            job = dao.getJobById(jobId);

            if (job == null) {

                session.setAttribute(
                    "errorMsg",
                    "Job not found!"
                );

                response.sendRedirect("view_job.jsp");
                return;
            }

        } else {

            session.setAttribute(
                "errorMsg",
                "Invalid Job ID!"
            );

            response.sendRedirect("view_job.jsp");
            return;
        }

    } catch (Exception e) {

        e.printStackTrace();

        session.setAttribute(
            "errorMsg",
            "Something went wrong!"
        );

        response.sendRedirect("view_job.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Edit Job</title>

    <%@ include file="all_component/all_css.jsp"%>

</head>


<body style="background-color: #f0f1f2;">

    <%@ include file="all_component/navbar.jsp"%>


    <div class="container p-2">

        <div class="col-md-10 offset-md-1">

            <div class="card">

                <div class="card-body">


                    <div class="text-center text-primary">

                        <i class="fas fa-edit fa-3x"></i>

                        <h5>Edit Job</h5>

                    </div>


                    <!-- ERROR MESSAGE -->

                    <c:if test="${not empty errorMsg}">

                        <div class="alert alert-danger text-center">

                            ${errorMsg}

                        </div>

                        <c:remove var="errorMsg"/>

                    </c:if>


                    <!-- EDIT FORM -->

                    <form action="edit_job" method="post">


                        <!-- JOB ID -->

                        <input type="hidden"
                               name="id"
                               value="<%= job.getId() %>">


                        <!-- TITLE -->

                        <div class="form-group">

                            <label>Enter Title</label>

                            <input type="text"
                                   name="title"
                                   value="<%= job.getTitle() %>"
                                   required
                                   class="form-control">

                        </div>


                        <div class="form-row">


                            <!-- LOCATION -->

                            <div class="form-group col-md-4">

                                <label>Location</label>

                                <select name="location"
                                        class="custom-select"
                                        required>

                                    <option value="West Bengal"
                                        <%= "West Bengal".equals(job.getLocation()) ? "selected" : "" %>>
                                        West Bengal
                                    </option>

                                    <option value="Odisha"
                                        <%= "Odisha".equals(job.getLocation()) ? "selected" : "" %>>
                                        Odisha
                                    </option>

                                    <option value="Jharkhand"
                                        <%= "Jharkhand".equals(job.getLocation()) ? "selected" : "" %>>
                                        Jharkhand
                                    </option>

                                    <option value="Gujarat"
                                        <%= "Gujarat".equals(job.getLocation()) ? "selected" : "" %>>
                                        Gujarat
                                    </option>

                                    <option value="Bhubaneswar"
                                        <%= "Bhubaneswar".equals(job.getLocation()) ? "selected" : "" %>>
                                        Bhubaneswar
                                    </option>

                                    <option value="Delhi"
                                        <%= "Delhi".equals(job.getLocation()) ? "selected" : "" %>>
                                        Delhi
                                    </option>

                                    <option value="Bangalore"
                                        <%= "Bangalore".equals(job.getLocation()) ? "selected" : "" %>>
                                        Bangalore
                                    </option>

                                    <option value="Chennai"
                                        <%= "Chennai".equals(job.getLocation()) ? "selected" : "" %>>
                                        Chennai
                                    </option>

                                    <option value="Hyderabad"
                                        <%= "Hyderabad".equals(job.getLocation()) ? "selected" : "" %>>
                                        Hyderabad
                                    </option>

                                </select>

                            </div>


                            <!-- CATEGORY -->

                            <div class="form-group col-md-4">

                                <label>Category</label>

                                <select name="category"
                                        class="custom-select"
                                        required>

                                    <option value="IT"
                                        <%= "IT".equals(job.getCategory()) ? "selected" : "" %>>
                                        IT
                                    </option>

                                    <option value="Developer"
                                        <%= "Developer".equals(job.getCategory()) ? "selected" : "" %>>
                                        Developer
                                    </option>

                                    <option value="Banking"
                                        <%= "Banking".equals(job.getCategory()) ? "selected" : "" %>>
                                        Banking
                                    </option>

                                    <option value="Engineer"
                                        <%= "Engineer".equals(job.getCategory()) ? "selected" : "" %>>
                                        Engineer
                                    </option>

                                    <option value="Teacher"
                                        <%= "Teacher".equals(job.getCategory()) ? "selected" : "" %>>
                                        Teacher
                                    </option>

                                </select>

                            </div>


                            <!-- STATUS -->

                            <div class="form-group col-md-4">

                                <label>Status</label>

                                <select name="status"
                                        class="form-control"
                                        required>

                                    <option value="Active"
                                        <%= "Active".equals(job.getStatus()) ? "selected" : "" %>>
                                        Active
                                    </option>

                                    <option value="Inactive"
                                        <%= "Inactive".equals(job.getStatus()) ? "selected" : "" %>>
                                        Inactive
                                    </option>

                                </select>

                            </div>

                        </div>


                        <!-- DESCRIPTION -->

                        <div class="form-group">

                            <label>Enter Description</label>

                            <textarea name="desc"
                                      rows="6"
                                      required
                                      class="form-control"><%= job.getDescription() %></textarea>

                        </div>


                        <!-- BUTTONS -->

                        <div class="text-center">

                            <button type="submit"
                                    class="btn btn-success">

                                <i class="fas fa-save"></i>

                                Update Job

                            </button>


                            <a href="view_job.jsp"
                               class="btn btn-secondary">

                                Cancel

                            </a>

                        </div>


                    </form>

                </div>

            </div>

        </div>

    </div>

</body>

</html>