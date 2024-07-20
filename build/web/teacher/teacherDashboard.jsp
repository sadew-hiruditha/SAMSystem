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
        <title>Teacher Dashboard - Attendance Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="../css/dashboard/styles.css">
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <jsp:include page="navbar.jsp" />
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                    <div class="content-wrapper">
                        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                            <h1 class="h2">Teacher Dashboard</h1>
                        </div>
                        <div class="container mt-4">
                            <h1 class="mb-4">Teacher Dashboard</h1>
                            <div class="row">
                                <div class="col-md-3 mb-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <h5 class="card-title">Total Students</h5>
                                            <p class="card-text display-4">150</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <h5 class="card-title">Present Today</h5>
                                            <p class="card-text display-4">142</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <h5 class="card-title">Absent Today</h5>
                                            <p class="card-text display-4">8</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <h5 class="card-title">Overall Attendance</h5>
                                            <p class="card-text display-4">95%</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div class="col-md-6">
                                    <h3>Recent Absences</h3>
                                    <ul class="list-group">
                                        <li class="list-group-item">John Doe - 2023-07-13</li>
                                        <li class="list-group-item">Jane Smith - 2023-07-12</li>
                                        <li class="list-group-item">Mike Johnson - 2023-07-11</li>
                                    </ul>
                                </div>
                                <div class="col-md-6">
                                    <h3>Upcoming Events</h3>
                                    <ul class="list-group">
                                        <li class="list-group-item">Parent-Teacher Meeting - 2023-07-20</li>
                                        <li class="list-group-item">School Trip - 2023-07-25</li>
                                        <li class="list-group-item">End of Term Exams - 2023-08-01</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>




        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>


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
            }
            );
        </script>
    </body>
</html>