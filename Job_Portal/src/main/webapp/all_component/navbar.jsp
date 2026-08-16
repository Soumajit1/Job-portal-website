<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<nav class="navbar navbar-expand-lg navbar-dark bg-custom">

    <!-- LOGO / BRAND -->
    <a class="navbar-brand" href="index.jsp">
        JOB PORTAL
    </a>


    <!-- MOBILE MENU BUTTON -->
    <button class="navbar-toggler"
            type="button"
            data-toggle="collapse"
            data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent"
            aria-expanded="false"
            aria-label="Toggle navigation">

        <span class="navbar-toggler-icon"></span>

    </button>


    <div class="collapse navbar-collapse"
         id="navbarSupportedContent">


        <!-- ================================================= -->
        <!-- LEFT SIDE MENU -->
        <!-- ================================================= -->

        <ul class="navbar-nav mr-auto">


            <!-- HOME -->
            <li class="nav-item">

                <a class="nav-link" href="index.jsp">

                    Home

                </a>

            </li>


            <!-- ================================================= -->
            <!-- USER ONLY -->
            <!-- ================================================= -->

            <c:if test="${not empty userobj and userobj.role eq 'user'}">


                <!-- SEE ALL JOBS -->

                <li class="nav-item">

                    <a class="nav-link"
                       href="view_all_job.jsp">

                        <i class="fas fa-briefcase"></i>

                        See All Jobs

                    </a>

                </li>


                <!-- APPLICATION HISTORY -->

                <li class="nav-item">

                    <a class="nav-link"
                       href="application_history.jsp">

                        <i class="fas fa-history"></i>

                        Application History

                    </a>

                </li>


            </c:if>


            <!-- ================================================= -->
            <!-- ADMIN ONLY -->
            <!-- ================================================= -->

            <c:if test="${not empty userobj and userobj.role eq 'admin'}">


                <!-- POST JOB -->

                <li class="nav-item">

                    <a class="nav-link"
                       href="add_job.jsp">

                        <i class="fas fa-plus-circle"></i>

                        Post Job

                    </a>

                </li>


                <!-- EDIT JOB -->

                <li class="nav-item">

                    <a class="nav-link"
                       href="view_job.jsp">

                        <i class="fas fa-edit"></i>

                        Edit Job

                    </a>

                </li>


            </c:if>


            <!-- ================================================= -->
            <!-- RECRUITER ONLY -->
            <!-- ================================================= -->

            <c:if test="${not empty userobj and userobj.role eq 'recruiter'}">


                <!-- POST JOB -->

                <li class="nav-item">

                    <a class="nav-link"
                       href="add_job.jsp">

                        <i class="fas fa-plus-circle"></i>

                        Post Job

                    </a>

                </li>


                <!-- APPLICANT HISTORY -->

                <li class="nav-item">

                    <a class="nav-link"
                       href="applicant_history.jsp">

                        <i class="fas fa-users"></i>

                        Applicant History

                    </a>

                </li>


            </c:if>


        </ul>


        <!-- ================================================= -->
        <!-- NOT LOGGED IN -->
        <!-- ================================================= -->

        <c:if test="${empty userobj}">

            <form class="form-inline my-2 my-lg-0">


                <!-- LOGIN -->

                <a href="login.jsp"
                   class="btn btn-light mr-1">

                    <i class="fas fa-sign-in-alt"></i>

                    Login

                </a>


                <!-- SIGNUP -->

                <a href="signup.jsp"
                   class="btn btn-light">

                    <i class="fas fa-user"></i>

                    Signup

                </a>


            </form>

        </c:if>


        <!-- ================================================= -->
        <!-- LOGGED IN -->
        <!-- ================================================= -->

        <c:if test="${not empty userobj}">

            <form class="form-inline my-2 my-lg-0">


                <!-- USER EMAIL -->

                <span class="text-white mr-3">

                    Welcome, ${userobj.email}

                </span>


                <!-- LOGOUT -->

                <a href="logout"
                   class="btn btn-light">

                    <i class="fas fa-sign-out-alt"></i>

                    Logout

                </a>


            </form>

        </c:if>


    </div>

</nav>
