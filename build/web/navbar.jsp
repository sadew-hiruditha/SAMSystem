<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - Attendance Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="../css/dashboard/styles.css">
    </head>
    <body>
<nav id="sidebar" class="col-md-3 col-lg-2 d-md-block sidebar collapse">
    <div class="position-sticky">
        <div class="user-info">
            <h5>Welcome, <%= session.getAttribute("firstname")%> <%= session.getAttribute("lastname")%>!</h5>
            <p><%= session.getAttribute("role")%></p>
        </div>
        <ul class="nav flex-column mt-4">
            <li class="nav-item">
                <a class="nav-link" href="adminDashboard.jsp">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manageClass.jsp">
                    <i class="fas fa-clipboard-check"></i> Manage Classes
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manageClassArms.jsp">
                    <i class="fas fa-chalkboard-teacher"></i> Manage Class Arms
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manageTeachers.jsp">
                    <i class="fas fa-user-tie"></i> Manage Teachers
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manageStudents.jsp">
                    <i class="fas fa-user-graduate"></i> Manage Students
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link logout" href="../logout.jsp">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </li>
        </ul>
    </div>
</nav>
<nav class="navbar navbar-expand-md navbar-light bg-light mb-4 d-md-none">
    <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#sidebar" aria-controls="sidebar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <span class="navbar-brand"><%= session.getAttribute("firstname")%></span>
    </div>
</nav>
    </body>
</html>
