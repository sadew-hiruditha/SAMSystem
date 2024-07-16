<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    String username = (String) session.getAttribute("username");
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
            response.sendRedirect("index.jsp");
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
        <link rel="stylesheet" href="../css/dashboard/styles.css">
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Left Sidebar Navigation -->
                <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                    <div class="position-sticky">
                        <div class="user-info">
                            <h5>Welcome, <%= session.getAttribute("firstname")%> <%= session.getAttribute("lastname")%>!</h5>
                            <p><%= session.getAttribute("role")%></p>
                        </div>
                        <ul class="nav flex-column mt-4">
                            <li class="nav-item">
                                <a class="nav-link active" href="dashboard.jsp" data-page="dashboard.jsp">
                                    <i class="fas fa-tachometer-alt"></i> Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="manageClass.jsp" data-page="manageClass.jsp">
                                    <i class="fas fa-clipboard-check"></i> Manage Classes
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" data-page="view-attendance.jsp">
                                    <i class="fas fa-chalkboard-teacher"></i> Manage Class Arms
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" data-page="reports.jsp">
                                    <i class="fas fas fa-user-tie"></i> Manage Teachers
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" data-page="settings.jsp">
                                    <i class="fas fa-user-graduate"></i> Manage Students
                                </a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link logout" href="../logout.jsp" id="logout-link">
                                    <i class="fas fa-sign-out-alt"></i> Logout
                                </a>
                            </li>


                        </ul>

                    </div>
                </nav>

                <!-- Main Content Area -->
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 content-wrapper">
                    <nav class="navbar navbar-expand-md navbar-light bg-light mb-4 d-md-none">
                        <div class="container-fluid">
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#sidebar" aria-controls="sidebar" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <span class="navbar-brand">Admin Dashboard</span>
                        </div>
                    </nav>
                    <div id="content">
                        <!-- Content will be loaded here -->
                    </div>
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                // Load default page
                $("#content").load("dashboard.jsp");

                // Handle navigation clicks
                $(".nav-link").click(function (e) {
                    e.preventDefault();
                    var page = $(this).data("page");

                    // Check if it's the logout link
                    if ($(this).attr('id') === 'logout-link') {
                        window.location.href = "../logout.jsp";
                        return;
                    }

                    if (page) {
                        $("#content").load(page);
                        $(".nav-link").removeClass("active");
                        $(this).addClass("active");
                        // Close sidebar on mobile after clicking a link
                        if ($(window).width() < 768) {
                            $("#sidebar").removeClass("show");
                        }
                    }
                });

                // Toggle sidebar on mobile
                $(".navbar-toggler").click(function () {
                    $("#sidebar").toggleClass("show");
                });

                // Close sidebar when clicking outside on mobile
                $(document).click(function (event) {
                    if (!$(event.target).closest('#sidebar, .navbar-toggler').length) {
                        $("#sidebar").removeClass("show");
                    }
                });
            });
        </script>
    </body>
</html>