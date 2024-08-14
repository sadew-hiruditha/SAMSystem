<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In</title>
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .form-control {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);
        }
        .password-container {
            position: relative;
        }
        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Left Section -->
            <div class="col-lg-6 p-0 d-none d-lg-block">
                <div class="left-section">
                    <h1 class="display-4 mb-4">Welcome To SAMS</h1>
                      <p class="lead">Manage Your Students' Attendance</p>
                </div>
            </div>
           
            <!-- Right Section -->
            <div class="col-lg-6 p-0 ">
                <div class="right-section">
                    <div class="signin-form">
                        <h3>Login to the System</h3>
                        <% if (request.getAttribute("errorMessage") != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <%= request.getAttribute("errorMessage") %>
                            </div>
                        <% } %>
                        <form action="login.jsp" method="POST">
                            <div class="mb-3">
                                <input type="email" class="form-control" placeholder="Email address" name="username" required>
                            </div>
                            <div class="mb-3 password-container">
                                <input type="password" class="form-control" id="password" placeholder="Password" name="password" required>
                            </div>
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                                <label class="form-check-label" for="rememberMe">Remember Me</label>
                            </div>
                            <button type="submit" class="btn btn-primary">Sign in</button>
                            <p class="form-footer">Don't have an account? <a href="sign_up.jsp">Sign up</a></p>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        
    </script>
</body>
</html>