<%@page import="java.sql.SQLException"%>
<%@page import="app.java.Student"%>
<%@page import="app.java.DBConnector"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ include file="components_Admin/getDetails.jsp" %>
<%    String username = (String) session.getAttribute("username");
    String firstname = (String) session.getAttribute("firstname");
    if (username == null) {
        Cookie[] cookies = request.getCookies();
        String rememberedUsername = null;
        String rememberedRole = null;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("username".equals(cookie.getName())) {
                    rememberedUsername = cookie.getValue();
                } else if ("role".equals(cookie.getName())) {
                    rememberedRole = cookie.getValue();
                }
            }
        }
        if (rememberedUsername != null && rememberedRole != null) {
            session.setAttribute("username", rememberedUsername);
            session.setAttribute("role", rememberedRole);
        } else {
            response.sendRedirect("../index.jsp");
            return;
        }
    }

    LocalDate today = LocalDate.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd-yyyy");
    String formattedDate = today.format(formatter);

%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - Attendance Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .sidebar {
                background-color: #212529;
                min-height: 100vh;
            }
            .content-wrapper {
                padding: 1.5rem;
                margin-top: 1rem;
            }
            .card {
                border: none;
                border-radius: 0.5rem;
                box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
                transition: transform 0.3s ease-in-out;
            }
            .card:hover {
                transform: translateY(-0.25rem);
            }
            .card-title {
                font-size: 1.5rem;
                font-weight: 500;
            }
            .card-text {
                font-size: 2rem;
                font-weight: 700;
            }
            .icon-container {
                position: absolute;
                top: 1rem;
                right: 1rem;
                opacity: 0.5;
            }
            .modern-datetime {

                padding: 0.5rem 1rem;
                display: inline-block;
            }
            #currentTime {
                font-size: 2.5rem;
            }
            #currentDate {
                font-size: 1rem;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <jsp:include page="navbar.jsp" />
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                    <div class="content-wrapper">
                        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                            <h1 class="h2">Admin Dashboard</h1>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <h5 class="text-muted">Welcome, <%= firstname%></h5>
                            </div>
                            <div class="col-md-6 text-end">
                                <div class="modern-datetime">
                                    <div id="currentTime" class="display-4 fw-bold"></div>
                                    <div id="currentDate" class="fs-5 text-muted"></div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3 mb-4">
                                <div class="card bg-white position-relative">
                                    <div class="card-body">
                                        <div class="icon-container text-primary">
                                            <i class="fas fa-users fa-3x"></i>
                                        </div>
                                        <h5 class="card-title text-muted">Total Students</h5>
                                        <p class="card-text text-primary"><%= totalStudents%></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 mb-4">
                                <div class="card bg-white position-relative">
                                    <div class="card-body">
                                        <div class="icon-container text-info">
                                            <i class="fas fa-chalkboard-teacher fa-3x"></i>
                                        </div>
                                        <h5 class="card-title text-muted">Class Teachers</h5>
                                        <p class="card-text text-info"><%= totalTeachers%></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 mb-4">
                                <div class="card bg-white position-relative">
                                    <div class="card-body">
                                        <div class="icon-container text-success">
                                            <i class="fas fa-chalkboard fa-3x"></i>
                                        </div>
                                        <h5 class="card-title text-muted">Classes</h5>
                                        <p class="card-text text-success"><%= totalClasses%></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 mb-4">
                                <div class="card bg-white position-relative">
                                    <div class="card-body">
                                        <div class="icon-container text-warning">
                                            <i class="fas fa-sitemap fa-3x"></i>
                                        </div>
                                        <h5 class="card-title text-muted">Class Arms</h5>
                                        <p class="card-text text-warning"><%= totalClassArms%></p>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <!-- Add more content here as needed -->

                    </div>
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            function updateDateTime() {
                const now = new Date();
                const timeOptions = {hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true};
                const dateOptions = {weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'};

                document.getElementById('currentTime').textContent = now.toLocaleTimeString('en-US', timeOptions);
                document.getElementById('currentDate').textContent = now.toLocaleDateString('en-US', dateOptions);
            }

            updateDateTime();
            setInterval(updateDateTime, 1000);

            // Sidebar toggle
            $(".navbar-toggler").click(function () {
                $("#sidebar").toggleClass("show");
            });

            // Close sidebar when clicking outside on mobile
            $(document).click(function (event) {
                if (!$(event.target).closest('#sidebar, .navbar-toggler').length) {
                    $("#sidebar").removeClass("show");
                }
            });
        </script>
    </body>
</html>