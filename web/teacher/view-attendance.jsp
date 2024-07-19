<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Teacher Dashboard - Attendance Management</title>
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
                                <li class="breadcrumb-item"><a href="teacherDashboard.jsp">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">View Attendance</li>
                            </ol>
                        </nav>
                    </div>
                    <div class="content">
                        <div class="container mt-5">
    <h1 class="mb-4">View Attendance</h1>
    <form class="row g-3 mb-4">
        <div class="col-md-4">
            <label for="class" class="form-label">Select Class</label>
            <select class="form-select" id="class" required>
                <option value="">Choose...</option>
                <option value="1">Class 1</option>
                <option value="2">Class 2</option>
                <option value="3">Class 3</option>
            </select>
        </div>
        <div class="col-md-4">
            <label for="month" class="form-label">Select Month</label>
            <input type="month" class="form-control" id="month" required>
        </div>
        <div class="col-md-4">
            <label for="student" class="form-label">Select Student</label>
            <select class="form-select" id="student">
                <option value="">All Students</option>
                <option value="1">John Doe</option>
                <option value="2">Jane Smith</option>
                <!-- Add more options for other students -->
            </select>
        </div>
        <div class="col-12">
            <button type="submit" class="btn btn-primary">View Attendance</button>
        </div>
    </form>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Date</th>
                <th>Student Name</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>2023-07-01</td>
                <td>John Doe</td>
                <td>Present</td>
            </tr>
            <tr>
                <td>2023-07-02</td>
                <td>John Doe</td>
                <td>Absent</td>
            </tr>
            <tr>
                <td>2023-07-03</td>
                <td>Jane Smith</td>
                <td>Present</td>
            </tr>
            <!-- Add more rows for other dates and students -->
        </tbody>
    </table>
</div>
                                            </div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            }
            );
        </script>
    </body>
</html>
