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
        font-family: 'Inter', sans-serif;
    }
    .sidebar {
        background-color: #212529;
        min-height: 100vh;
    }
    .content-wrapper {
        padding: 2rem;
    }
    .card {
        border: none;
        border-radius: 0.5rem;
        box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        background-color: #ffffff;
        position: relative;
        overflow: hidden;
    }
    .card:hover {
        transform: translateY(-0.25rem);
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
    }
    .card-title {
        font-size: 1rem;
        font-weight: 500;
        color: #495057;
    }
    .card-text {
        font-size: 2rem;
        font-weight: 600;
        color: #212529;
    }
    .icon-container {
        position: absolute;
        top: 1rem;
        right: 1rem;
        font-size: 2.5rem;
        opacity: 0.8;
    }
    .modern-datetime {
        background-color: #ffffff;
        padding: 1rem;
        border-radius: 0.5rem;
        box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.05);
    }
    #currentTime {
        font-size: 2rem;
        font-weight: 600;
        color: #212529;
    }
    #currentDate {
        font-size: 0.9rem;
        color: #6c757d;
    }
    .welcome-message {
        font-size: 1.25rem;
        font-weight: 500;
        color: #212529;
    }
    .card-1 { border-left: 4px solid #007bff; }
    .card-2 { border-left: 4px solid #28a745; }
    .card-3 { border-left: 4px solid #ffc107; }
    .card-4 { border-left: 4px solid #17a2b8; }
    
    .icon-1 { color: #007bff; }
    .icon-2 { color: #28a745; }
    .icon-3 { color: #ffc107; }
    .icon-4 { color: #17a2b8; }
</style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <jsp:include page="navbar.jsp" />
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                    <div class="content-wrapper">
                        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-4">
                            <h1 class="h2 fw-bold text-primary">Admin Dashboard</h1>
                            <div class="modern-datetime">
                                <div id="currentTime"></div>
                                <div id="currentDate"></div>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-12">
                                <h2 class="welcome-message">Welcome, <%= firstname%></h2>
                            </div>
                        </div>

                        <div class="row">
                 
                            <div class="col-md-3 mb-4">
                                <div class="card card-1">
                                    <div class="card-body">
                                        <div class="icon-container icon-1">
                                            <i class="fas fa-users"></i>
                                        </div>
                                        <h5 class="card-title">Total Students</h5>
                                        <p class="card-text"><%= totalStudents%></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 mb-4">
                                <div class="card card-2">
                                    <div class="card-body">
                                        <div class="icon-container icon-2">
                                            <i class="fas fa-chalkboard-teacher"></i>
                                        </div>
                                        <h5 class="card-title">Class Teachers</h5>
                                        <p class="card-text"><%= totalTeachers%></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 mb-4">
                                <div class="card card-3">
                                    <div class="card-body">
                                        <div class="icon-container icon-3">
                                            <i class="fas fa-chalkboard"></i>
                                        </div>
                                        <h5 class="card-title">Classes</h5>
                                        <p class="card-text"><%= totalClasses%></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 mb-4">
                                <div class="card card-4">
                                    <div class="card-body">
                                        <div class="icon-container icon-4">
                                            <i class="fas fa-sitemap"></i>
                                        </div>
                                        <h5 class="card-title">Class Arms</h5>
                                        <p class="card-text"><%= totalClassArms%></p>
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