<%-- 
    Document   : manageClass
    Created on : Jul 16, 2024, 12:47:34 PM
    Author     : Sadew
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Classes</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">Manage Classes</h2>
        
        <!-- Add Class Form -->
        <div class="card mb-4">
            <div class="card-header">
                Add New Class
            </div>
            <div class="card-body">
                <form id="addClassForm">
                    <div class="mb-3">
                        <label for="className" class="form-label">Class Name</label>
                        <input type="text" class="form-control" id="className" placeholder="Enter class name">
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
                            <th>#</th>
                            <th>Class Name</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody id="classesTableBody">
                        <!-- Dynamic class rows go here -->
                        <!-- Example row -->
                        <tr>
                            <td>1</td>
                            <td>Class A</td>
                            <td><button class="btn btn-warning btn-sm">Edit</button></td>
                            <td><button class="btn btn-danger btn-sm">Delete</button></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        // Example script for handling form submission and table updates
        $(document).ready(function() {
            $('#addClassForm').on('submit', function(e) {
                e.preventDefault();
                var className = $('#className').val();
                if (className) {
                    // Here you would typically send the data to the server and update the table
                    var newRow = `<tr>
                        <td>1</td>
                        <td>${className}</td>
                        <td><button class="btn btn-warning btn-sm">Edit</button></td>
                        <td><button class="btn btn-danger btn-sm">Delete</button></td>
                    </tr>`;
                    $('#classesTableBody').append(newRow);
                    $('#className').val(''); // Clear input
                }
            });
        });
    </script>
</body>
</html>
