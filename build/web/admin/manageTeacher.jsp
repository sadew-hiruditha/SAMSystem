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
        int classId = Integer.parseInt(request.getParameter("classId"));
        int classArmId = Integer.parseInt(request.getParameter("classArmId"));
        String password = "";
        String status = "0"; // Default to failure
        
        Teacher teacher = new Teacher(firstName, lastName, email, phoneNo, password, classId, classArmId);
        
        try {
            if(teacher.addTeacher(DBConnector.getConnection())) {
                status = "1"; // Success
            }
        } catch(Exception e) {
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
                                    Create Class Teachers
                                </div>
                                <div class="card-body">
                                    <form action="manageTeacher.jsp" method="POST">
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="classId" class="form-label">Select Class *</label>
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
                                            <div class="col-md-6 mb-3">
                                                <label for="classArmId" class="form-label">Class Arm *</label>
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
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="firstName" class="form-label">Firstname *</label>
                                                <input type="text" class="form-control" id="firstName" name="firstName" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="lastName" class="form-label">Lastname *</label>
                                                <input type="text" class="form-control" id="lastName" name="lastName" required>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="email" class="form-label">Email Address *</label>
                                                <input type="email" class="form-control" id="email" name="email" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="phoneNo" class="form-label">Phone No *</label>
                                                <input type="tel" class="form-control" id="phoneNo" name="phoneNo" required>
                                            </div>
                                        </div>
                                 
                                        <button type="submit" name="addTeacher" class="btn btn-primary">Save</button>
                                    </form>
                                </div>
                            </div>

                            <!-- Teachers Table -->
                            <div class="card">
                                <div class="card-header">
                                    All Class Teachers
                                </div>
                                <div class="card-body">
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="entriesSelect" class="form-label">Show entries</label>
                                            <select class="form-select" id="entriesSelect" style="width: auto;">
                                                <option>10</option>
                                                <option>25</option>
                                                <option>50</option>
                                                <option>100</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="search" class="form-label">Search:</label>
                                            <input type="text" class="form-control" id="search" style="width: auto;">
                                        </div>
                                    </div>
                                    <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
<!--                                                <th>#</th>-->
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
                                                List<Teacher> teachers = teacher.getAllTeachers(DBConnector.getConnection());
                                                int count = 1;
                                                for (Teacher t : teachers) {
                                            %>
                                            <tr>
<!--                                                <td><%= count++%></td>-->
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