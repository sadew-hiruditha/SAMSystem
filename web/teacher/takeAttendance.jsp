<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/dashboard/modern-styles.css">
    <script>
        function loadClassArms() {
            document.getElementById('classArmId').innerHTML = '<option value="">--Select Class Arm--</option>';
            document.forms[0].submit();
        }

        function submitAttendance(event) {
            event.preventDefault();
            const form = event.target;
            const formData = new FormData(form);

            fetch('takeAttendance.jsp', {
                method: 'POST',
                body: formData
            })
            .then(response => response.text())
            .then(data => {
                document.querySelector('.content').innerHTML = data;
                Swal.fire({
                    icon: 'success',
                    title: 'Attendance Submitted',
                    text: 'Attendance has been recorded successfully.',
                    confirmButtonText: 'Okay'
                });
            })
            .catch(error => {
                console.error('Error:', error);
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'An error occurred while submitting attendance.',
                    confirmButtonText: 'Try Again'
                });
            });
        }
    </script>
    <style>
        .form-check-input:checked + .form-check-label i.text-success {
            color: #28a745 !important;
        }

        .form-check-input:checked + .form-check-label i.text-danger {
            color: #dc3545 !important;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004d99;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="navbar.jsp" />
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 content-wrapper">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2"><i class="fas fa-clipboard-list"></i> Take Attendance</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="modern-teacherDashboard.jsp"><i class="fas fa-home"></i> Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page"><i class="fas fa-clipboard-list"></i> Take Attendance</li>
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
                            String status = "0";

                            Connection conn = null;
                            try {
                                conn = DBConnector.getConnection();
                                conn.setAutoCommit(false);

                                List<Map<String, Object>> attendanceData = new ArrayList<Map<String, Object>>();

                                Enumeration<String> parameterNames = request.getParameterNames();
                                while (parameterNames.hasMoreElements()) {
                                    String paramName = parameterNames.nextElement();
                                    if (paramName.startsWith("attendance_")) {
                                        String studentId = paramName.substring("attendance_".length());
                                        String attStatus = request.getParameter(paramName);

                                        Map<String, Object> data = new HashMap<String, Object>();
                                        data.put("classId", Integer.parseInt(classId));
                                        data.put("classArmId", Integer.parseInt(classArmId));
                                        data.put("studentId", Integer.parseInt(studentId));
                                        data.put("attendanceStatus", attStatus);
                                        data.put("attendanceDate", java.sql.Date.valueOf(attendanceDate));

                                        attendanceData.add(data);
                                    }
                                }

                                boolean result = Student.submitBatchAttendance(conn, attendanceData);
                                if (result) {
                                    conn.commit();
                                    status = "1";
                                    request.setAttribute("successMessage", "Attendance submitted successfully!");
                                } else {
                                    conn.rollback();
                                    request.setAttribute("errorMessage", "Failed to submit attendance. Please try again.");
                                }
                            } catch (SQLException e) {
                                if (conn != null) {
                                    try {
                                        conn.rollback();
                                    } catch (SQLException ex) {
                                        ex.printStackTrace();
                                    }
                                }
                                e.printStackTrace();
                                request.setAttribute("errorMessage", "An error occurred while submitting attendance: " + e.getMessage());
                            } finally {
                                if (conn != null) {
                                    try {
                                        conn.setAutoCommit(true);
                                        conn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                        }
                        %>
                        <div class="card mb-4 shadow">
                            <div class="card-header bg-primary text-white">
                                <i class="fas fa-clipboard-list"></i> Take Attendance
                            </div>
                            <div class="card-body">
                                <% if (request.getAttribute("successMessage") != null) { %>
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <%= request.getAttribute("successMessage") %>
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                <% } %>
                                <% if (request.getAttribute("errorMessage") != null) { %>
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <%= request.getAttribute("errorMessage") %>
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                <% } %>
                                <form action="takeAttendance.jsp" method="POST" onsubmit="submitAttendance(event)">

                                    <div class="row">
                                        <div class="col-md-4 mb-3">
                                            <label for="classId" class="form-label"><i class="fas fa-school"></i> Select Class *</label>
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
                                            <label for="classArmId" class="form-label"><i class="fas fa-users"></i> Select Class Arm *</label>
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
                                            <label for="attendanceDate" class="form-label"><i class="fas fa-calendar-alt"></i> Attendance Date *</label>
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
                                        <table class="table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th><i class="fas fa-user"></i> First Name</th>
                                                    <th><i class="fas fa-user"></i> Last Name</th>
                                                    <th><i class="fas fa-id-card"></i> Admission No</th>
                                                    <th><i class="fas fa-school"></i> Class</th>
                                                    <th><i class="fas fa-users"></i> Class Arm</th>
                                                    <th><i class="fas fa-calendar-alt"></i> Date Created</th>
                                                    <th><i class="fas fa-calendar-check"></i> Status</th>
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
                                                        <div class="form-check form-check-inline">
                                                            <input class="form-check-input" type="radio" name="attendance_<%= s.getId() %>" id="present_<%= s.getId() %>" value="Present" required>
                                                            <label class="form-check-label" for="present_<%= s.getId() %>">
                                                                <i class="fas fa-check-circle text-success"></i> Present
                                                            </label>
                                                        </div>
                                                        <div class="form-check form-check-inline">
                                                            <input class="form-check-input" type="radio" name="attendance_<%= s.getId() %>" id="absent_<%= s.getId() %>" value="Absent">
                                                            <label class="form-check-label" for="absent_<%= s.getId() %>">
                                                                <i class="fas fa-times-circle text-danger"></i> Absent
                                                            </label>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                    <button type="submit" name="submitAttendance" class="btn btn-primary">
                                        <i class="fas fa-check-circle"></i> Submit Attendance
                                    </button>
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

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>