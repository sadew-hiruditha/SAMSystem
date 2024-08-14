<%@page import="java.util.List"%>
<%@page import="app.java.DBConnector"%>
<%@page import="app.java.ClassArm"%>
<%@page import="app.java.Class"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Class Arms</title>
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
                        <h1 class="h2">Manage Class Arms</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="adminDashboard.jsp">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Manage Class Arms</li>
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
                            <div class="alert alert-success mt-3">Class arm added successfully!</div>
                            <%
                            } else if (status.equals("0")) {
                            %>
                            <div class="alert alert-danger mt-3">Failed to add the class arm. Please try again.</div>
                            <%
                            } else if (status.equals("2")) {
                            %>

                            <%
                            } else if (status.equals("3")) {
                            %>
                            <div class="alert alert-danger mt-3">Class arm deleted successfully!</div>
                            <%
                            } else if (status.equals("4")) {
                            %>
                            <div class="alert alert-success mt-3">Class arm updated successfully!</div>
                            <%
                                    }
                                }
                            %>

                            <!-- Add Class Arm Form -->
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-plus-circle me-2"></i>Add New Class Arm
                                </div>
                                <div class="card-body">
                                    <form action="components_ClassArm/createClassArm.jsp" method="POST">
                                        <div class="mb-3">
                                            <label for="classId" class="form-label"><i class="fas fa-chalkboard"></i> Class</label>
                                            <select class="form-select" id="classId" name="classId" required>
                                                <option value="Select a class" > Select a class</option>
                                                <%
                                                    Class classObj = new Class();
                                                    List<Class> classes = classObj.getAllClasses(DBConnector.getConnection());
                                                    for (Class cls : classes) {
                                                %>
                                                <option value="<%= cls.getId()%>"><%= cls.getClassName()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="classArmName" class="form-label"><i class="fas fa-sitemap"></i> Class Arm Name</label>
                                            <input type="text" class="form-control" id="classArmName" placeholder="Enter class arm name" name="classArmName" required>
                                        </div>
                                        <button type="submit" class="btn btn-primary"><i class="fas fa-save me-2"></i>Save</button>
                                    </form>
                                </div>
                            </div>

                            <!-- Class Arms Table -->
                            <div class="card">
                                <div class="card-header">
                                    <i class="fas fa-list-alt me-2"></i>Existing Class Arms
                                </div>
                                <div class="card-body">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Class Name</th>
                                                <th>Class Arm Name</th>

                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                ClassArm classArm = new ClassArm();
                                                List<ClassArm> classArms = classArm.getAllClassArms(DBConnector.getConnection());
                                                for (ClassArm arm : classArms) {
                                            %>
                                            <tr>
                                                <td><%= arm.getClassName()%></td>
                                                <td><%= arm.getClassArmName()%></td>

                                                <td>
                                                    <button class="btn btn-warning btn-sm" onclick="editClassArm(<%= arm.getId()%>, <%= arm.getClassId()%>, '<%= arm.getClassArmName()%>')">Edit</button>
                                                </td>
                                                <td>
                                                    <button class="btn btn-danger btn-sm" onclick="deleteClassArm(<%= arm.getId()%>, '<%= arm.getClassArmName()%>')">Delete</button>
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
                </main>
            </div>
        </div>

        <!-- Edit Class Arm Modal -->
        <div class="modal fade" id="editClassArmModal" tabindex="-1" aria-labelledby="editClassArmModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editClassArmModalLabel">Edit Class Arm</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="components_ClassArm/updateClassArm.jsp" method="POST">
                        <div class="modal-body">
                            <input type="hidden" id="editClassArmId" name="id">
                            <div class="mb-3">
                                <label for="editClassId" class="form-label">Class</label>
                                <select class="form-select" id="editClassId" name="classId" required>
                                    <%
                                        for (Class cls : classes) {
                                    %>
                                    <option value="<%= cls.getId()%>"><%= cls.getClassName()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="editClassArmName" class="form-label">Class Arm Name</label>
                                <input type="text" class="form-control" id="editClassArmName" name="classArmName" required>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save changes</button>
                        </div>
                    </form>
                </div>
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
                        Are you sure you want to delete the class arm "<span id="deleteClassArmName"></span>"?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <form action="components_ClassArm/deleteClassArm.jsp" method="POST">
                            <input type="hidden" id="deleteClassArmId" name="id">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

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

                                                        function editClassArm(id, classId, classArmName) {
                                                            document.getElementById('editClassArmId').value = id;
                                                            document.getElementById('editClassId').value = classId;
                                                            document.getElementById('editClassArmName').value = classArmName;
                                                            var editModal = new bootstrap.Modal(document.getElementById('editClassArmModal'));
                                                            editModal.show();
                                                        }

                                                        function deleteClassArm(id, classArmName) {
                                                            document.getElementById('deleteClassArmId').value = id;
                                                            document.getElementById('deleteClassArmName').textContent = classArmName;
                                                            var deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
                                                            deleteModal.show();
                                                        }
        </script>
    </body>
</html>