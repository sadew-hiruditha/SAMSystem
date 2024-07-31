<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ page import="java.util.Enumeration, java.util.List" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<%@ page import="app.java.DBConnector, app.java.Student, app.java.Class, app.java.ClassArm" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Take Attendance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/dashboard/styles.css">
    <script>
        function loadClassArms() {
            document.getElementById('classArmId').innerHTML = '<option value="">--Select Class Arm--</option>';
            document.forms[0].submit();
        }
    </script>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="navbar.jsp" />
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 content-wrapper">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Take Attendance</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="teacherDashboard.jsp">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Take Attendance</li>
                        </ol>
                    </nav>
                </div>
                <div class="content">
                    <div class="container mt-5">
                        <%
                            if (request.getParameter("submitAttendance") != null) {
                                String classId = request.getParameter("classId");
                                String classArmId = request.getParameter("classArmId");
                                String attendanceDate = request.getParameter("attendanceDate");
                                String status = "0"; // Default to failure

                                Connection conn = null;
                                PreparedStatement pstmt = null;
                                try {
                                    conn = DBConnector.getConnection();
                                    String sql = "INSERT INTO tblattendance (classId, classArmId, studentId, attendanceStatus, attendanceDate) VALUES (?, ?, ?, ?, ?)";
                                    pstmt = conn.prepareStatement(sql);

                                    Enumeration<String> parameterNames = request.getParameterNames();
                                    while (parameterNames.hasMoreElements()) {
                                        String paramName = parameterNames.nextElement();
                                        if (paramName.startsWith("attendance_")) {
                                            String studentId = paramName.substring("attendance_".length());
                                            String attStatus = request.getParameter(paramName);

                                            pstmt.setInt(1, Integer.parseInt(classId));
                                            pstmt.setInt(2, Integer.parseInt(classArmId));
                                            pstmt.setInt(3, Integer.parseInt(studentId));
                                            pstmt.setString(4, attStatus);
                                            pstmt.setDate(5, java.sql.Date.valueOf(attendanceDate));
                                            pstmt.addBatch();
                                        }
                                    }

                                    pstmt.executeBatch();
                                    status = "1"; // Success
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } finally {
                                    try {
                                        if (pstmt != null) pstmt.close();
                                        if (conn != null) conn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }

                                response.sendRedirect("takeAttendance.jsp?s=" + status);
                                return; // Prevent further processing of the JSP
                            }
                        %>
                        <!-- Take Attendance Form -->
                        <div class="card mb-4">
                            <div class="card-header">
                                Take Attendance
                            </div>
                            <div class="card-body">
                                <form action="takeAttendance.jsp" method="POST">
                                    <div class="row">
                                        <div class="col-md-4 mb-3">
                                            <label for="classId" class="form-label">Select Class *</label>
                                            <select class="form-select" id="classId" name="classId" required onchange="loadClassArms()">
                                                <option value="">--Select Class--</option>
                                                <%
                                                    Class classObj = new Class();
                                                    List<Class> classes = classObj.getAllClasses(DBConnector.getConnection());
                                                    String selectedClassId = request.getParameter("classId");
                                                    for (Class cls : classes) {
                                                        String selected = (selectedClassId != null && selectedClassId.equals(String.valueOf(cls.getId()))) ? "selected" : "";
                                                %>
                                                <option value="<%= cls.getId() %>" <%= selected %>><%= cls.getClassName() %></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="classArmId" class="form-label">Select Class Arm *</label>
                                            <select class="form-select" id="classArmId" name="classArmId" required onchange="this.form.submit()">
                                                <option value="">--Select Class Arm--</option>
                                                <%
                                                    if (selectedClassId != null && !selectedClassId.isEmpty()) {
                                                        int classId = Integer.parseInt(selectedClassId);
                                                        ClassArm classArmObj = new ClassArm();
                                                        List<ClassArm> classArms = classArmObj.getClassArmsByClassId(DBConnector.getConnection(), classId);
                                                        String selectedClassArmId = request.getParameter("classArmId");
                                                        for (ClassArm arm : classArms) {
                                                            String selected = (selectedClassArmId != null && selectedClassArmId.equals(String.valueOf(arm.getId()))) ? "selected" : "";
                                                %>
                                                <option value="<%= arm.getId() %>" <%= selected %>><%= arm.getClassArmName() %></option>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="attendanceDate" class="form-label">Attendance Date *</label>
                                            <input type="date" class="form-control" id="attendanceDate" name="attendanceDate" required value="<%= new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>">
                                        </div>
                                    </div>
                                    
                                    <%
                                        if (selectedClassId != null && !selectedClassId.isEmpty() &&
                                            request.getParameter("classArmId") != null && !request.getParameter("classArmId").isEmpty()) {
                                            int classId = Integer.parseInt(selectedClassId);
                                            int classArmId = Integer.parseInt(request.getParameter("classArmId"));
                                            List<Student> students = Student.getStudentsByClassAndClassArm(DBConnector.getConnection(), classId, classArmId);
                                            if (students != null && !students.isEmpty()) {
                                    %>
                                    <div class="table-responsive">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>First Name</th>
                                                    <th>Last Name</th>
                                                    <th>Admission No</th>
                                                    <th>Class</th>
                                                    <th>Class Arm</th>
                                                    <th>Date Created</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    for (Student s : students) {
                                                %>
                                                <tr>
                                                    <td><%= s.getFirstName() %></td>
                                                    <td><%= s.getLastName() %></td>
                                                    <td><%= s.getAdmissionNumber() %></td>
                                                    <td><%= s.getClassName() %></td>
                                                    <td><%= s.getClassArmName() %></td>
                                                    <td><%= s.getDateCreated() %></td>
                                                    <td>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="attendance_<%= s.getId() %>" id="present_<%= s.getId() %>" value="Present" required>
                                                            <label class="form-check-label" for="present_<%= s.getId() %>">Present</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="attendance_<%= s.getId() %>" id="absent_<%= s.getId() %>" value="Absent">
                                                            <label class="form-check-label" for="absent_<%= s.getId() %>">Absent</label>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                    <button type="submit" name="submitAttendance" class="btn btn-primary">Submit</button>
                                    <%
                                            }
                                        }
                                    %>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
