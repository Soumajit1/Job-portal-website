
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Online Job Portal</title>

    <%@ include file="all_component/all_css.jsp"%>


    <style>

        body {
            background-color: #f0f1f2;
            margin: 0;
            padding: 0;
        }


        /* =========================================
           HOME SECTION
           ========================================= */

        .home-section {

            display: flex;

            align-items: center;

            justify-content: center;

            text-align: center;

            padding: 45px 15px;

        }


        /* =========================================
           HOME CONTENT
           ========================================= */

        .home-content {

            background-color: #ffffff;

            padding: 40px 40px;

            border-radius: 5px;

            width: 100%;

            max-width: 850px;

            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

        }


        /* =========================================
           LOGO
           ========================================= */

        .portal-logo {

            width: 190px;

            max-width: 70%;

            height: auto;

            margin-bottom: 20px;

        }


        /* =========================================
           TITLE
           ========================================= */

        .home-content h1 {

            color: #007bff;

            font-size: 38px;

            font-weight: 500;

            margin-bottom: 20px;

        }


        /* =========================================
           SUBTITLE
           ========================================= */

        .home-content h4 {

            color: #333;

            font-weight: 400;

            margin-bottom: 15px;

        }


        /* =========================================
           DESCRIPTION
           ========================================= */

        .home-content p {

            color: #666;

            font-size: 17px;

            line-height: 1.7;

            margin-bottom: 20px;

        }


        /* =========================================
           DIVIDER
           ========================================= */

        .home-divider {

            width: 70px;

            height: 2px;

            background-color: #007bff;

            margin: 10px auto 20px auto;

        }


        /* =========================================
           MOBILE
           ========================================= */

        @media (max-width: 576px) {

            .home-section {

                padding: 30px 15px;

            }

            .home-content {

                padding: 30px 20px;

            }

            .portal-logo {

                width: 150px;

            }

            .home-content h1 {

                font-size: 30px;

            }

            .home-content p {

                font-size: 15px;

            }

        }

    </style>

</head>


<body>


    <!-- =========================================
         NAVBAR
         ========================================= -->

    <%@ include file="all_component/navbar.jsp"%>


    <!-- =========================================
         HOME CONTENT
         ========================================= -->

    <div class="container home-section">

        <div class="home-content">


            <!-- LOGO -->

            <img src="img/online-job-portal-logo.jpg"
                 alt="Online Job Portal Logo"
                 class="portal-logo">


            <!-- TITLE -->

            <h1>

                Online Job Portal

            </h1>


            <!-- DIVIDER -->

            <div class="home-divider"></div>


            <!-- SUBTITLE -->

            <h4>

                Welcome to the Online Job Portal

            </h4>


            <!-- DESCRIPTION -->

            <p>

                A simple platform that connects job seekers
                with available employment opportunities.
                Users can explore and apply for suitable jobs,
                while recruiters can post job opportunities
                and manage applications.

            </p>


            <!-- LOGIN MESSAGE -->

            <p>

                Please login to access the features available
                for your account.

            </p>


        </div>

    </div>


    <!-- =========================================
         FOOTER
         ========================================= -->

    <%@ include file="all_component/footer.jsp"%>


</body>

</html>
