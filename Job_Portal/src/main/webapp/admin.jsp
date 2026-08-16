```jsp
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // =====================================================
    // ADMIN ACCESS PROTECTION
    // =====================================================

    Object userObj = session.getAttribute("userobj");

    if (userObj == null) {

        response.sendRedirect("login.jsp");
        return;
    }

    com.entity.User user =
        (com.entity.User) userObj;

    if (!"admin".equals(user.getRole())) {

        response.sendRedirect("login.jsp");
        return;
    }
%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Admin Dashboard</title>

    <%@ include file="all_component/all_css.jsp"%>

</head>


<body style="background-color: #f0f1f2;">


    <!-- ================================================= -->
    <!-- NAVBAR -->
    <!-- ================================================= -->

    <%@ include file="all_component/navbar.jsp"%>


    <!-- ================================================= -->
    <!-- ADMIN WELCOME SECTION -->
    <!-- ================================================= -->

    <div class="container">

        <div class="text-center mt-5">

            <h1 class="text-primary">

                Welcome Admin

            </h1>


            <p class="mt-3 text-secondary">

                Welcome to the Job Portal Admin Dashboard.

            </p>


            <p class="text-secondary">

                You can manage jobs and applications from the navigation menu.

            </p>

        </div>

    </div>


</body>

</html>
```
