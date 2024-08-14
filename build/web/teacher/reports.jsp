<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, app.java.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="app.java.DBConnector" %>
<%@ page import="app.java.Student" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Attendance Reports</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="../css/dashboard/styles.css">
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <jsp:include page="navbar.jsp" />
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 content-wrapper">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">Attendance Reports</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="teacherDashboard.jsp">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Reports</li>
                            </ol>
                        </nav>
                    </div>
                    <div class="content">
                        <div class="container mt-5">
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-body">
                                            <h5 class="card-title">Monthly Attendance Report</h5>
                                            <form action="reports.jsp" method="post" id="reportForm">
                                                <input type="hidden" name="reportType" value="monthly">
                                                <div class="mb-3">
                                                    <label for="monthlyClass" class="form-label">Select Class</label>
                                                    <select class="form-select" id="monthlyClass" name="classId" required>
                                                        <option value="">Choose...</option>
                                                        <%
                                                            Connection con = null;
                                                            try {
                                                                con = DBConnector.getConnection();
                                                                List<app.java.Class> classes = new app.java.Class().getAllClasses(con);
                                                                for (app.java.Class cls : classes) {%>
                                                        <option value="<%= cls.getId()%>"><%= cls.getClassName()%></option>
                                                        <%
                                                                }
                                                            } catch (Exception e) {
                                                                e.printStackTrace();
                                                            } finally {
                                                                if (con != null) {
                                                                    con.close();
                                                                }
                                                            }
                                                        %>
                                                    </select>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="monthlyMonth" class="form-label">Select Month</label>
                                                    <input type="month" class="form-control" id="monthlyMonth" name="month" required>
                                                </div>
                                                <button type="submit" class="btn btn-primary" id="generateReportBtn">Generate Report</button>
                                            </form>
                                            <form action="downloadPDF.jsp" method="post" class="mt-3" id="downloadForm" style="display: none;">
                                                <input type="hidden" name="reportType" value="monthly">
                                                <input type="hidden" name="classId" id="downloadClassId">
                                                <input type="hidden" name="month" id="downloadMonth">
                                                <button type="submit" class="btn btn-success">Download PDF</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <h3>Generated Report</h3>
                                    <div id="reportContent">
                                        <%
                                            String reportType = request.getParameter("reportType");
                                            if (reportType != null) {
                                                try {
                                                    con = DBConnector.getConnection();
                                                    List<AttendanceRecord> records = null;

                                                    if ("monthly".equals(reportType)) {
                                                        int classId = Integer.parseInt(request.getParameter("classId"));
                                                        String month = request.getParameter("month");
                                                        records = AttendanceRecord.getMonthlyReport(con, classId, month);
                                        %>
                                        <h4>Monthly Attendance Report</h4>
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Date</th>
                                                    <th>Student Name</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% for (AttendanceRecord record : records) {%>
                                                <tr>
                                                    <td><%= record.getDate()%></td>
                                                    <td><%= record.getStudentName()%></td>
                                                    <td>
                                                        <% if (record.getStatus().equalsIgnoreCase("present")) { %>
                                                        <span class="badge bg-success">Present</span>
                                                        <% } else if (record.getStatus().equalsIgnoreCase("absent")) { %>
                                                        <span class="badge bg-danger">Absent</span>
                                                        <% } else {%>
                                                        <%= record.getStatus()%>
                                                        <% } %>
                                                    </td>
                                                </tr>
                                                <% } %>
                                            </tbody>
                                        </table>
                                        <%
                                            }
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        %>
                                        <p class="text-danger">Error generating report: <%= e.getMessage()%></p>
                                        <%
                                            } finally {
                                                if (con != null) {
                                                    con.close();
                                                }
                                            }
                                        } else {
                                        %>
                                        <p class="text-muted">No report generated yet. Please select options and click 'Generate Report'.</p>
                                        <%
                                            }
                                        %>
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

            // Show download button after report generation
            $(document).ready(function () {
                $('#reportForm').submit(function () {
                    $('#downloadForm').show();
                    $('#downloadClassId').val($('#monthlyClass').val());
                    $('#downloadMonth').val($('#monthlyMonth').val());
                });

                if ($('#reportContent').children().length > 1) {
                    $('#downloadForm').show();
                    $('#downloadClassId').val('<%= request.getParameter("classId")%>');
                    $('#downloadMonth').val('<%= request.getParameter("month")%>');
                }
            });
        </script>
    </body>
</html>