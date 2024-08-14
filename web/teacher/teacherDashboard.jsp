<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="app.java.DBConnector" %>
<%@ page import="app.java.Student" %>

<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Get current date
    LocalDate today = LocalDate.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd-yyyy");
    String formattedDate = today.format(formatter);

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int totalStudents = 0;
    int presentToday = 0;
    int absentToday = 0;
    double overallAttendance = 0.0;

    try {
        conn = DBConnector.getConnection();

        // Get total students
        totalStudents = Student.getTotalStudents(conn);

        String attendanceQuery = "SELECT attendanceStatus, COUNT(*) as count FROM tblattendance WHERE attendanceDate = ? GROUP BY attendanceStatus";
        pstmt = conn.prepareStatement(attendanceQuery);
        pstmt.setDate(1, java.sql.Date.valueOf(today));
        rs = pstmt.executeQuery();

        while (rs.next()) {
            if ("Present".equals(rs.getString("attendanceStatus"))) {
                presentToday = rs.getInt("count");
            } else if ("Absent".equals(rs.getString("attendanceStatus"))) {
                absentToday = rs.getInt("count");
            }
        }

        // Calculate overall attendance
        if (totalStudents > 0) {
            overallAttendance = (double) presentToday / totalStudents * 100;
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Dashboard - Attendance Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .sidebar {
            background-color: #343a40;
            min-height: 100vh;
        }
        .sidebar .nav-link {
            color: #fff;
            padding: 0.5rem 1rem;
            border-radius: 0.25rem;
            margin-bottom: 0.5rem;
        }
        .sidebar .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        .sidebar .nav-link.active {
            background-color: rgba(255, 255, 255, 0.2);
        }
        .content-wrapper {
            padding: 2rem;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-title {
            font-size: 1rem;
            font-weight: 600;
            color: #6c757d;
        }
        .card-text {
            font-size: 2rem;
            font-weight: 700;
            color: #343a40;
        }
        .list-group-item {
            border: none;
            background-color: transparent;
            padding: 0.75rem 1rem;
        }
        .list-group-item:not(:last-child) {
            border-bottom: 1px solid #e9ecef;
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
                        <h1 class="h2">Teacher Dashboard</h1>
                
                    </div>

                    <div class="row">
                        <div class="col-md-3 mb-4">
                            <div class="card bg-primary text-white">
                                <div class="card-body">
                                    <h5 class="card-title text-white">Total Students</h5>
                                    <p class="card-text"><%= totalStudents %></p>
                                    <i class="fas fa-users fa-3x position-absolute bottom-0 end-0 mb-3 me-3 opacity-50"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-4">
                            <div class="card bg-success text-white">
                                <div class="card-body">
                                    <h5 class="card-title text-white">Present Today</h5>
                                    <p class="card-text"><%= presentToday %></p>
                                    <i class="fas fa-user-check fa-3x position-absolute bottom-0 end-0 mb-3 me-3 opacity-50"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-4">
                            <div class="card bg-danger text-white">
                                <div class="card-body">
                                    <h5 class="card-title text-white">Absent Today</h5>
                                    <p class="card-text"><%= absentToday %></p>
                                    <i class="fas fa-user-times fa-3x position-absolute bottom-0 end-0 mb-3 me-3 opacity-50"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-4">
                            <div class="card bg-info text-white">
                                <div class="card-body">
                                    <h5 class="card-title text-white">Overall Attendance</h5>
                                    <p class="card-text"><%= String.format("%.2f%%", overallAttendance) %></p>
                                    <i class="fas fa-chart-pie fa-3x position-absolute bottom-0 end-0 mb-3 me-3 opacity-50"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Recent Absences</h5>
                                    <ul class="list-group list-group-flush">
                                        <%
                                            try {
                                                conn = DBConnector.getConnection();
                                                String recentAbsencesQuery = "SELECT s.firstName, s.lastName, a.attendanceDate FROM tblattendance a JOIN tblstudents s ON a.studentId = s.id WHERE a.attendanceStatus = 'Absent' ORDER BY a.attendanceDate DESC LIMIT 3";
                                                pstmt = conn.prepareStatement(recentAbsencesQuery);
                                                rs = pstmt.executeQuery();
                                                while (rs.next()) {
                                        %>
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                            <%= rs.getString("firstName") + " " + rs.getString("lastName") %>
                                            <span class="badge bg-primary rounded-pill"><%= rs.getDate("attendanceDate") %></span>
                                        </li>
                                        <%
                                                }
                                            } catch (SQLException e) {
                                                e.printStackTrace();
                                            } finally {
                                                try {
                                                    if (rs != null) rs.close();
                                                    if (pstmt != null) pstmt.close();
                                                    if (conn != null) conn.close();
                                                } catch (SQLException e) {
                                                    e.printStackTrace();
                                                }
                                            }
                                        %>
                                    </ul>
                                </div>
                            </div>
                        </div>
                     
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

       
    </script>
</body>
</html>