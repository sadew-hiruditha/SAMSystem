<%-- 
    Document   : index
    Created on : Jun 25, 2024, 3:19:28 PM
    Author     : Sadew
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign In</title>
        <link rel="stylesheet" href="css/login.css">
        <link rel="stylesheet" href="css/style.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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

        </style>
    </head>

    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Left Section -->
                <div class="col-lg-6 p-0 d-none d-lg-block">
                    <div class="left-section">
                        <h2>Welcome Batman</h2>
                        <h3>Student Attendance Management System</h3>
                        <!-- <p>This is where you can add some introductory text or information about your system.</p> -->
                    </div>
                </div>

                <!-- Right Section -->
                <div class="col-lg-6 p-0 ">
                    <div class="right-section">
                        <div class="signin-form">
                            <!-- <h4>Waste Management System</h4> -->
                            <h3>Login to the System</h3>

                            <form action="login.jsp" method="POST">
                                <div class="mb-3">
                                    <input type="email" class="form-control" placeholder="Email address" name="username">
                                </div>
                                <div class="mb-3">
                                    <input type="password" class="form-control" placeholder="Password" name="password">
                                </div>
                                <div class="mb-3">
                                    <label for="role" class="form-label">Role</label>
                                    <select class="form-select" id="role" name="role" required>
                                        <option value="admin">Admin</option>
                                        <option value="teacher">Teacher</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-primary">Sign in</button>
                                <p class="form-footer">Don't have an account? <a href="sign_up.jsp">Sign up</a></p>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
        </script>
    </body>

</html>
