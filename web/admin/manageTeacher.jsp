<%@page import="app.java.User"%>
<%@page import="java.util.List"%>
<%@page import="app.java.DBConnector"%>
<%@page import="app.java.Teacher"%>
<%@page import="app.java.Class"%>
<%@page import="app.java.ClassArm"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (request.getParameter("addTeacher") != null) {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phoneNo = request.getParameter("phoneNo");
        int classId = 0;
        int classArmId = 0;
        String status = "0"; // Default to failure

        String classIdParam = request.getParameter("classId");
        String classArmIdParam = request.getParameter("classArmId");

        if (classIdParam != null && !classIdParam.isEmpty()) {
            classId = Integer.parseInt(classIdParam);
        }

        if (classArmIdParam != null && !classArmIdParam.isEmpty()) {
            classArmId = Integer.parseInt(classArmIdParam);
        }

        Teacher teacher = new Teacher(firstName, lastName, email, phoneNo, classId, classArmId);

        try {
            if (teacher.addTeacher(DBConnector.getConnection())) {
                status = "1"; // Success
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("manageTeacher.jsp?s=" + status);
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Class Teachers</title>
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
                        <h1 class="h2">Create Class Teachers</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="adminDashboard.jsp">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Create Class Teachers</li>
                            </ol>
                        </nav>
                    </div>
                    <div class="content">
                        <div class="container mt-5">
                            <%
                                String status = request.getParameter("s");
                                if (status != null) {
                                    if (status.equals("1")) {
                            %>
                            <div class="alert alert-success mt-3">Teacher added successfully!</div>
                            <%
                            } else if (status.equals("4")) {
                            %>
                            <div class="alert alert-danger mt-3">Failed to add the teacher. Please try again.</div>
                            <%
                            } else if (status.equals("0")) {
                            %>
                            <div class="alert alert-danger mt-3">Failed to add the teacher. The email address is already in use.</div>
                            <%
                            } else if (status.equals("2")) {
                            %>
                            <div class="alert alert-danger mt-3">Teacher Deleted successfully!</div>
                            <%
                                    }
                                }
                            %>
                            <!-- Add Teacher Form -->
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-user-plus"></i> Create Class Teachers
                                </div>
                                <div class="card-body">
                                    <form action="manageTeacher.jsp" method="POST">
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label for="teacherId" class="form-label"> <i class="fas fa-user-tie"></i> Select Teacher </label>
                                                <select class="form-select" id="teacherId" name="teacherId" required onchange="this.form.submit()">
                                                    <option value="">--Select Teacher--</option>
                                                    <%
                                                        User userObj = new User();
                                                        List<User> teachers = userObj.getUsersByRole(DBConnector.getConnection(), "teacher");
                                                        for (User t : teachers) {
                                                            String selected = (request.getParameter("teacherId") != null && request.getParameter("teacherId").equals(String.valueOf(t.getId()))) ? "selected" : "";
                                                    %>
                                                    <option value="<%= t.getId()%>" <%= selected%>><%= t.getFirstName() + " " + t.getLastName()%></option>
                                                    <% } %>
                                                </select>
                                            </div>

                                            <div class="col-md-6">
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
                                                    <% } %>
                                                </select>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="classArmId" class="form-label"><i class="fas fa-sitemap"></i> Class Arm</label>
                                                <select class="form-select" id="classArmId" name="classArmId" required>
                                                    <option value="">--Select Class Arm--</option>
                                                    <%
                                                        if (request.getParameter("classId") != null && !request.getParameter("classId").isEmpty()) {
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

                                            <%
                                                String firstName = "";
                                                String lastName = "";
                                                String username = "";
                                                String phoneNo = "";

                                                if (request.getParameter("teacherId") != null && !request.getParameter("teacherId").isEmpty()) {
                                                    int selectedTeacherId = Integer.parseInt(request.getParameter("teacherId"));
                                                    User selectedTeacher = new User();
                                                    selectedTeacher.setId(selectedTeacherId);
                                                    selectedTeacher.retrieveUserDetails(DBConnector.getConnection());

                                                    firstName = selectedTeacher.getFirstName();
                                                    lastName = selectedTeacher.getLastName();
                                                    username = selectedTeacher.getUsername();
                                                }
                                            %>

                                            <div class="col-md-6">
                                                <label for="firstName" class="form-label"><i class="fas fa-user"></i> First Name</label>
                                                <input type="text" class="form-control" id="firstName" name="firstName" value="<%= firstName%>" readonly required>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="lastName" class="form-label"><i class="fas fa-user"></i> Last Name</label>
                                                <input type="text" class="form-control" id="lastName" name="lastName" value="<%= lastName%>" readonly required>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="username" class="form-label"><i class="fas fa-at"></i> Username</label>
                                                <input type="text" class="form-control" id="username" name="email" value="<%= username%>" readonly required>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="phoneNo" class="form-label"><i class="fas fa-phone"></i> Phone Number</label>
                                                <input type="tel" class="form-control" id="phoneNo" name="phoneNo" value="<%= phoneNo%>" required>
                                            </div>

                                            <div class="col-12">
                                                <button type="submit" name="addTeacher" class="btn btn-primary"><i class="fas fa-save"></i> Save</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Teachers Table -->
                            <div class="card">
                                <div class="card-header">
                                    All Class Teachers
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>First Name</th>
                                                    <th>Last Name</th>
                                                    <th>Email Address</th>
                                                    <th>Phone No</th>
                                                    <th>Class</th>
                                                    <th>Class Arm</th>
                                                    <th>Date Created</th>
                                                    <th>Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    Teacher teacher = new Teacher();
                                                    List<Teacher> teachersfor = teacher.getAllTeachers(DBConnector.getConnection());
                                                    for (Teacher t : teachersfor) {
                                                %>
                                                <tr>
                                                    <td><%= t.getFirstName()%></td>
                                                    <td><%= t.getLastName()%></td>
                                                    <td><%= t.getEmail()%></td>
                                                    <td><%= t.getPhoneNo()%></td>
                                                    <td><%= t.getClassName()%></td>
                                                    <td><%= t.getClassArmName()%></td>
                                                    <td><%= t.getDateCreated()%></td>
                                                    <td>
                                                        <button class="btn btn-danger btn-sm" onclick="deleteTeacher(<%= t.getId()%>)">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteConfirmModalLabel">Confirm Deletion</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this teacher?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <form action="components_Teacher/deleteTeacher.jsp" method="POST">
                            <input type="hidden" id="deleteTeacherId" name="id">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                                                            function deleteTeacher(id) {
                                                                document.getElementById('deleteTeacherId').value = id;
                                                                var deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
                                                                deleteModal.show();
                                                            }
        </script>
    </body>
</html>