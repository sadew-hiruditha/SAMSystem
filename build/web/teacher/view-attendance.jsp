<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="app.java.DBConnector, app.java.Attendance, app.java.ClassArm, app.java.Class" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Attendance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/dashboard/styles.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="navbar.jsp" />
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 content-wrapper">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2"><i class="fas fa-eye"></i> View Attendance</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="teacherDashboard.jsp"><i class="fas fa-home"></i> Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">View Attendance</li>
                        </ol>
                    </nav>
                </div>
                <div class="content">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <form action="view-attendance.jsp" method="POST">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <label for="classId" class="form-label"><i class="fas fa-chalkboard"></i> Select Class</label>
                                        <select class="form-select" id="classId" name="classId" required onchange="this.form.submit()">
                                            <option value="">--Select Class--</option>
                                            <%
                                                Class classObj = new Class();
                                                List<Class> classes = classObj.getAllClasses(DBConnector.getConnection());
                                                for (Class cls : classes) {
                                                    String selected = (request.getParameter("classId") != null && request.getParameter("classId").equals(String.valueOf(cls.getId()))) ? "selected" : "";
                                            %>
                                            <option value="<%= cls.getId()%>" <%= selected%>><%= cls.getClassName()%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label for="classArmId" class="form-label"><i class="fas fa-chalkboard-teacher"></i> Class Arm</label>
                                        <select class="form-select" id="classArmId" name="classArmId" required>
                                            <option value="">--Select Class Arm--</option>
                                            <%
                                                if (request.getParameter("classId") != null) {
                                                    int selectedClassId = Integer.parseInt(request.getParameter("classId"));
                                                    ClassArm classArmObj = new ClassArm();
                                                    List<ClassArm> classArms = classArmObj.getClassArmsByClassId(DBConnector.getConnection(), selectedClassId);
                                                    for (ClassArm arm : classArms) {
                                            %>
                                            <option value="<%= arm.getId()%>"><%= arm.getClassArmName()%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label for="attendanceDate" class="form-label"><i class="fas fa-calendar-alt"></i> Attendance Date</label>
                                        <input type="date" class="form-control" id="attendanceDate" name="attendanceDate" required value="<%= new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>">
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label for="attendanceStatus" class="form-label"><i class="fas fa-filter"></i> Attendance Status</label>
                                        <select class="form-select" id="attendanceStatus" name="attendanceStatus">
                                            <option value="">All</option>
                                            <option value="Present">Present</option>
                                            <option value="Absent">Absent</option>
                                            <option value="Not Marked">Not Marked</option>
                                        </select>
                                    </div>
                                </div>
                                <button type="submit" name="viewAttendance" class="btn btn-primary"><i class="fas fa-search"></i> View Attendance</button>
                            </form>
                        </div>
                    </div>

                    <%
                        if (request.getParameter("viewAttendance") != null) {
                            int classId = Integer.parseInt(request.getParameter("classId"));
                            int classArmId = Integer.parseInt(request.getParameter("classArmId"));
                            String attendanceDate = request.getParameter("attendanceDate");
                            String attendanceStatus = request.getParameter("attendanceStatus");

                            Attendance attendanceObj = new Attendance(classId, classArmId, attendanceDate);
                            List<Attendance> attendanceList = attendanceObj.getAttendanceByClassArmAndDate(DBConnector.getConnection());

                            if (!attendanceList.isEmpty()) {
                    %>
                    <div class="card mt-4 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fas fa-calendar-day"></i> Attendance for <%= attendanceDate %></h5>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th><i class="fas fa-id-card"></i> Admission Number</th>
                                            <th><i class="fas fa-user"></i> Student Name</th>
                                            <th><i class="fas fa-check-circle"></i> Attendance Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% 
                                        for (Attendance record : attendanceList) {
                                            String status = record.getAttendanceStatus() != null ? record.getAttendanceStatus() : "Not Marked";
                                            String badgeClass = "";
                                            if (status.equals("Present")) {
                                                badgeClass = "badge bg-success";
                                            } else if (status.equals("Absent")) {
                                                badgeClass = "badge bg-danger";
                                            } else {
                                                badgeClass = "badge bg-secondary";
                                            }
                                            if (attendanceStatus == null || attendanceStatus.isEmpty() || attendanceStatus.equals(status)) {
                                        %>
                                        <tr>
                                            <td><%= record.getAdmissionNumber() %></td>
                                            <td><%= record.getStudentName() %></td>
                                            <td><span class="<%= badgeClass %>"><%= status %></span></td>
                                        </tr>
                                        <% 
                                            }
                                        } 
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <%
                            } else {
                    %>
                    <div class="alert alert-info mt-4" role="alert">
                        <i class="fas fa-info-circle"></i> No attendance records found for the selected date and class.
                    </div>
                    <%
                            }
                        }
                    %>
                </div>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
