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
    <style>
        body { background-color: #f8f9fa; }
        .content-wrapper {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-top: 20px;
        }
        .card {
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .table { box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); }
        .table thead th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
        }
        .alert { border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="navbar.jsp" />
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 content-wrapper">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Manage Classes</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="adminDashboard.jsp">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Manage Classes</li>
                        </ol>
                    </nav>
                </div>
                <div class="content">
                    <div class="container mt-5">
                        <%
                            String status = request.getParameter("s");
                            if (status != null) {
                                String alertClass = "";
                                String message = "";
                                if ("1".equals(status)) {
                                    alertClass = "success";
                                    message = "Class added successfully!";
                                } else if ("0".equals(status)) {
                                    alertClass = "danger";
                                    message = "Failed to add the class. Please try again.";
                                } else if ("2".equals(status)) {
                                    alertClass = "warning";
                                    message = "This class already exists!";
                                } else if ("3".equals(status)) {
                                    alertClass = "info";
                                    message = "Class deleted successfully!";
                                } else if ("4".equals(status)) {
                                    alertClass = "success";
                                    message = "Class updated successfully!";
                                }
                                if (!"".equals(alertClass)) {
                        %>
                        <div class="alert alert-<%= alertClass %> alert-dismissible fade show" role="alert">
                            <%= message %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <%
                                }
                            }
                        %>

                        <div class="row">
                            <div class="col-md-4">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-plus-circle me-2"></i>Add New Class
                                    </div>
                                    <div class="card-body">
                                        <form action="components_Class/addclass.jsp" method="POST">
                                            <div class="mb-3">
                                                <label for="className" class="form-label">Class Name</label>
                                                <input type="text" class="form-control" id="className" placeholder="Enter class name" name="classname" required>
                                            </div>
                                            <button type="submit" class="btn btn-primary w-100">
                                                <i class="fas fa-save me-2"></i>Save
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="card">
                                    <div class="card-header">
                                        <i class="fas fa-list-alt me-2"></i>Existing Classes
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Class Name</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        Class classm = new Class();
                                                        List classes = classm.getAllClasses(DBConnector.getConnection());
                                                        for (int i = 0; i < classes.size(); i++) {
                                                            Class cls = (Class) classes.get(i);
                                                    %>
                                                    <tr>
                                                        <td><%= cls.getClassName() %></td>
                                                        <td>
                                                            <button class="btn btn-warning btn-sm" onclick="editClass(<%= cls.getId() %>, '<%= cls.getClassName() %>')">
                                                                <i class="fas fa-edit"></i> Edit
                                                            </button>
                                                            <button class="btn btn-danger btn-sm" onclick="deleteClass(<%= cls.getId() %>, '<%= cls.getClassName() %>')">
                                                                <i class="fas fa-trash-alt"></i> Delete
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
                    <h5 class="modal-title" id="editClassModalLabel"><i class="fas fa-edit me-2"></i>Edit Class</h5>
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
                        <button type="submit" class="btn btn-primary"><i class="fas fa-save me-2"></i>Save changes</button>
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
                    <h5 class="modal-title" id="deleteConfirmModalLabel"><i class="fas fa-exclamation-triangle me-2"></i>Confirm Deletion</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete the class "<span id="deleteClassName"></span>"?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form action="components_Class/deleteclass.jsp" method="POST">
                        <input type="hidden" id="deleteClassId" name="id">
                        <button type="submit" class="btn btn-danger"><i class="fas fa-trash-alt me-2"></i>Delete</button>
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