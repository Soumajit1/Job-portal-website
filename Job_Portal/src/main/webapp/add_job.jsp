<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>


<%
    // =====================================================
    // CHECK LOGIN
    // =====================================================

    com.entity.User user =
        (com.entity.User) session.getAttribute("userobj");


    // =====================================================
    // ONLY ADMIN AND RECRUITER CAN ACCESS
    // =====================================================

    if (user == null ||
        (!"admin".equals(user.getRole()) &&
         !"recruiter".equals(user.getRole()))) {

        response.sendRedirect(
            "login.jsp"
        );

        return;
    }
%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Post Job</title>

    <%@ include file="all_component/all_css.jsp"%>

</head>


<body style="background-color: #f0f1f2;">


    <!-- ================================================= -->
    <!-- NAVBAR -->
    <!-- ================================================= -->

    <%@ include file="all_component/navbar.jsp"%>


    <div class="container">

        <div class="row">

            <div class="col-md-8 offset-md-2">

                <div class="card mt-4">

                    <div class="card-body">


                        <!-- ================================================= -->
                        <!-- TITLE -->
                        <!-- ================================================= -->

                        <h4 class="text-center text-primary">

                            Post New Job

                        </h4>

                        <hr>


                        <!-- ================================================= -->
                        <!-- SUCCESS MESSAGE -->
                        <!-- ================================================= -->

                        <c:if test="${not empty succMsg}">

                            <div class="alert alert-success text-center">

                                ${succMsg}

                            </div>

                            <c:remove var="succMsg"/>

                        </c:if>


                        <!-- ================================================= -->
                        <!-- ERROR MESSAGE -->
                        <!-- ================================================= -->

                        <c:if test="${not empty errorMsg}">

                            <div class="alert alert-danger text-center">

                                ${errorMsg}

                            </div>

                            <c:remove var="errorMsg"/>

                        </c:if>


                        <!-- ================================================= -->
                        <!-- JOB FORM -->
                        <!-- ================================================= -->

                        <form action="add_job"
                              method="post">


                            <!-- JOB TITLE -->

                            <div class="form-group">

                                <label>
                                    Job Title
                                </label>

                                <input type="text"
                                       name="title"
                                       class="form-control"
                                       placeholder="Enter job title"
                                       required>

                            </div>


                            <!-- LOCATION -->

                            <div class="form-group">

                                <label>
                                    Location
                                </label>

                                <input type="text"
                                       name="location"
                                       class="form-control"
                                       placeholder="Enter job location"
                                       required>

                            </div>


                            <!-- CATEGORY -->

                            <div class="form-group">

                                <label>
                                    Category
                                </label>

                                <input type="text"
                                       name="category"
                                       class="form-control"
                                       placeholder="Enter job category"
                                       required>

                            </div>


                            <!-- STATUS -->

                            <div class="form-group">

                                <label>
                                    Status
                                </label>

                                <select name="status"
                                        class="form-control"
                                        required>

                                    <option value="">
                                        -- Select Status --
                                    </option>

                                    <option value="Active">
                                        Active
                                    </option>

                                    <option value="Inactive">
                                        Inactive
                                    </option>

                                </select>

                            </div>


                            <!-- DESCRIPTION -->

                            <div class="form-group">

                                <label>
                                    Job Description
                                </label>

                                <textarea name="desc"
                                          class="form-control"
                                          rows="5"
                                          placeholder="Enter job description"
                                          required></textarea>

                            </div>


                            <!-- ================================================= -->
                            <!-- POST BUTTON -->
                            <!-- ================================================= -->

                            <div class="text-center">

                                <button type="submit"
                                        class="btn btn-primary">

                                    Post Job

                                </button>

                            </div>


                        </form>


                    </div>

                </div>

            </div>

        </div>

    </div>


</body>

</html>