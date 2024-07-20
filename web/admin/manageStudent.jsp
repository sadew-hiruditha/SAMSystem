<%@page import="java.util.List"%>
<%@page import="app.java.DBConnector"%>
<%@page import="app.java.Student"%>
<%@page import="app.java.Class"%>
<%@page import="app.java.ClassArm"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (request.getParameter("addStudent") != null) {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String admissionNumber = request.getParameter("admissionNumber");
        int classId = Integer.parseInt(request.getParameter("classId"));
        int classArmId = Integer.parseInt(request.getParameter("classArmId"));
        String status = "0"; // Default to failure
        
        Student student = new Student(firstName, lastName, admissionNumber, classId, classArmId);
        
        try {
            if(student.addStudent(DBConnector.getConnection())) {
                status = "1"; // Success
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("manageStudent.jsp?s=" + status);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Students</title>
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
                    <h1 class="h2">Manage Students</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="adminDashboard.jsp">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Manage Students</li>
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
                        <div class="alert alert-success mt-3">Student added successfully!</div>
                        <%
                        } else if (status.equals("0")) {
                        %>
                        <div class="alert alert-danger mt-3">Failed to add the student. Please try again.</div>
                        <%
                        } else if (status.equals("2")) {
                        %>
                        <div class="alert alert-danger mt-3">Student Deleted successfully!</div>
                        <%
                                }
                            }
                        %>
                        <!-- Add Student Form -->
                        <div class="card mb-4">
                            <div class="card-header">
                                Create Students
                            </div>
                            <div class="card-body">
                                <form action="manageStudent.jsp" method="POST">
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
                                            <label for="admissionNumber" class="form-label">Admission Number *</label>
                                            <input type="text" class="form-control" id="admissionNumber" name="admissionNumber" required>
                                        </div>
                                    </div>
                                    <button type="submit" name="addStudent" class="btn btn-primary">Save</button>
                                </form>
                            </div>
                        </div>

                        <!-- Students Table -->
                        <div class="card">
                            <div class="card-header">
                                All Students
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
                                                <th>Admission No</th>
                                                <th>Class</th>
                                                <th>Class Arm</th>
                                                <th>Date Created</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                Student student = new Student();
                                                List<Student> students = student.getAllStudents(DBConnector.getConnection());
                                                int count = 1;
                                                for (Student s : students) {
                                            %>
                                            <tr>
<!--                                                <td><%= count++%></td>-->
                                                <td><%= s.getFirstName()%></td>
                                                <td><%= s.getLastName()%></td>
                                                <td><%= s.getAdmissionNumber()%></td>
                                                <td><%= s.getClassName()%></td>
                                                <td><%= s.getClassArmName()%></td>
                                                <td><%= s.getDateCreated()%></td>
                                                <td>
                                                    <button class="btn btn-primary btn-sm" onclick="editStudent(<%= s.getId()%>)">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                </td>
                                                <td>
                                                    <button class="btn btn-danger btn-sm" onclick="deleteStudent(<%= s.getId()%>)">
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
                    Are you sure you want to delete this student?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form action="components_Student/deleteStudent.jsp" method="POST">
                        <input type="hidden" id="deleteStudentId" name="id">
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Edit Student Modal -->
<div class="modal fade" id="editStudentModal" tabindex="-1" aria-labelledby="editStudentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editStudentModalLabel">Edit Student</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editStudentForm" action="components_Student/editStudent.jsp" method="POST">
                    <input type="hidden" id="editStudentId" name="id">
                    <div class="mb-3">
                        <label for="editFirstName" class="form-label">First Name</label>
                        <input type="text" class="form-control" id="editFirstName" name="firstName" required>
                    </div>
                    <div class="mb-3">
                        <label for="editLastName" class="form-label">Last Name</label>
                        <input type="text" class="form-control" id="editLastName" name="lastName" required>
                    </div>
                    <div class="mb-3">
                        <label for="editAdmissionNumber" class="form-label">Admission Number</label>
                        <input type="text" class="form-control" id="editAdmissionNumber" name="admissionNumber" required>
                    </div>
                    <div class="mb-3">
                        <label for="editClassId" class="form-label">Class</label>
                        <select class="form-select" id="editClassId" name="classId" required>
                            <!-- Options will be populated dynamically -->
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="editClassArmId" class="form-label">Class Arm</label>
                        <select class="form-select" id="editClassArmId" name="classArmId" required>
                            <!-- Options will be populated dynamically -->
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </form>
            </div>
        </div>
    </div>
</div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function deleteStudent(id) {
            document.getElementById('deleteStudentId').value = id;
            var deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
            deleteModal.show();
        }
        
        function editStudent(id) {
            // Implement edit functionality
            // You can redirect to an edit page or show an edit modal
        }
    </script>
</body>
</html>