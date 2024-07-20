<%-- 
    Document   : manageClass
    Created on : Jul 16, 2024, 12:47:34 PM
    Author     : Sadew
--%>

<%@page import="java.util.List"%>
<%@page import="app.java.DBConnector"%>
<%@page import="app.java.Class"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Classes</title>
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
                        <h1 class="h2">Create Class Arms</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="adminDashboard.jsp">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Manage Class</li>
                            </ol>
                        </nav>
                    </div>
                    <div class="content">
                        <div class="container mt-5">
                            <!--<h2 class="mb-4">Manage Classes</h2>-->

                            <%
                                String status = request.getParameter("s");
                                if (status != null) {
                                    if (status.equals("1")) {
                            %>
                            <div class="alert alert-success mt-3">Class added successfully!</div>
                            <%
                            } else if (status.equals("0")) {
                            %>
                            <div class="alert alert-danger mt-3">Failed to add the class. Please try again.</div>
                            <%
                            } else if (status.equals("2")) {
                            %>
                            <div class="alert alert-warning mt-3">This class already exists!</div>
                            <%
                            } else if (status.equals("3")) {
                            %>
                            <div class="alert alert-danger mt-3">Class Delete Successfully!</div>
                            <%
                            } else if (status.equals("4")) {
                            %>
                            <div class="alert alert-success mt-3">Class Update Successfully!</div>
                            <%
                                    }
                                }
                            %>

                            <!-- Add Class Form -->
                            <div class="card mb-4">
                                <div class="card-header">
                                    Add New Class
                                </div>
                                <div class="card-body">
                                    <form action="components_Class/addclass.jsp" method="POST">
                                        <div class="mb-3">
                                            <label for="className" class="form-label">Class Name</label>
                                            <input type="text" class="form-control" id="className" placeholder="Enter class name" name="classname" required>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Save</button>
                                    </form>
                                </div>
                            </div>

                            <!-- Classes Table -->
                            <div class="card">
                                <div class="card-header">
                                    Existing Classes
                                </div>
                                <div class="card-body">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Class Name</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                Class classm = new Class();
                                                List<Class> classes = classm.getAllClasses(DBConnector.getConnection());
                                                for (Class cls : classes) {
                                            %>
                                            <tr>
                                                <td><%= cls.getClassName()%></td>
                                                <td>
                                                    <button class="btn btn-warning btn-sm" onclick="editClass(<%= cls.getId()%>, '<%= cls.getClassName()%>')">Edit</button>
                                                </td>
                                                <td>
                                                    <button class="btn btn-danger btn-sm" onclick="deleteClass(<%= cls.getId()%>, '<%= cls.getClassName()%>')">Delete</button>
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

        <!-- Edit Class Modal -->
        <div class="modal fade" id="editClassModal" tabindex="-1" aria-labelledby="editClassModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editClassModalLabel">Edit Class</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="components_Class/updateclass.jsp" method="POST">
                        <div class="modal-body">
                            <input type="hidden" id="editClassId" name="id">
                            <div class="mb-3">
                                <label for="editClassName" class="form-label">Class Name</label>
                                <input type="text" class="form-control" id="editClassName" name="className" required>
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
                        Are you sure you want to delete the class "<span id="deleteClassName"></span>"?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <form action="components_Class/deleteclass.jsp" method="POST">
                            <input type="hidden" id="deleteClassId" name="id">
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

                                                        function editClass(id, className) {
                                                            document.getElementById('editClassId').value = id;
                                                            document.getElementById('editClassName').value = className;
                                                            var editModal = new bootstrap.Modal(document.getElementById('editClassModal'));
                                                            editModal.show();
                                                        }

                                                        function deleteClass(id, className) {
                                                            document.getElementById('deleteClassId').value = id;
                                                            document.getElementById('deleteClassName').textContent = className;
                                                            var deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
                                                            deleteModal.show();
                                                        }
        </script>
    </body>
</html>