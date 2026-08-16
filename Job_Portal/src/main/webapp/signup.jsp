<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Signup Page</title>

    <%@include file="all_component/all_css.jsp"%>

</head>

<body style="background-color: #f0f1f2;">

    <%@include file="all_component/navbar.jsp"%>


    <div class="container-fluid">

        <div class="row p-4">

            <div class="col-md-4 offset-md-4">

                <div class="card">

                    <div class="card-body">


                        <!-- TITLE -->

                        <div class="text-center">

                            <i class="fa fa-user-plus fa-2x"
                               aria-hidden="true"></i>

                            <h5>Registration</h5>

                        </div>


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


                        <!-- REGISTRATION FORM -->

                        <form action="register" method="post">


                            <!-- FULL NAME -->

                            <div class="form-group">

                                <label>Enter Full Name</label>

                                <input type="text"
                                       name="name"
                                       required
                                       class="form-control">

                            </div>


                            <!-- QUALIFICATION -->

                            <div class="form-group">

                                <label>Enter Qualification</label>

                                <input type="text"
                                       name="qua"
                                       required
                                       class="form-control">

                            </div>


                            <!-- EMAIL -->

                            <div class="form-group">

                                <label>Enter Email</label>

                                <input type="email"
                                       name="email"
                                       required
                                       class="form-control">

                            </div>


                            <!-- PASSWORD -->

                            <div class="form-group">

                                <label>Enter Password</label>

                                <input type="password"
                                       name="ps"
                                       required
                                       class="form-control">

                            </div>


                            <!-- ROLE -->

                            <div class="form-group">

                                <label>Select Role</label>

                                <select name="role"
                                        class="form-control"
                                        required>

                                    <option value="">
                                        -- Select Role --
                                    </option>

                                    <option value="user">
                                        User
                                    </option>

                                    <option value="recruiter">
                                        Recruiter
                                    </option>

                                </select>

                            </div>


                            <!-- REGISTER BUTTON -->

                            <button type="submit"
                                    class="btn btn-primary badge-pill btn-block">

                                Register

                            </button>


                        </form>

                    </div>

                </div>

            </div>

        </div>

    </div>

</body>

</html>