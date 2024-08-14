<%@ page import="app.java.MD5" %>
<%@ page import="app.java.DBConnector" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign Up</title>
        <link rel="stylesheet" href="css/signup.css">
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

            .custom-select {
                border-radius: 0;
                border: 2px solid #007bff;
                color: #007bff;
                font-weight: 500;
                padding: 10px;
            }

            .custom-select:focus {
                border-color: #0056b3;
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
                        <h1 class="display-4 mb-4">Teacher Registration</h1>
                        <p>Join to Manage and Monitor Student Attendance</p>
                    </div>
                </div>

                <!-- Right Section -->
                <div class="col-lg-6 p-0">
                    <div class="right-section">
                        <div class="signup-form">
                            <h2>Sign Up to the System</h2>
                            <form action="registration.jsp" method="POST">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <input type="text" class="form-control" placeholder="First name" name="firstname" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <input type="text" class="form-control" placeholder="Last name" name="lastname" required>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <input type="email" class="form-control" placeholder="Email address" name="username" required>
                                </div>
                                <div class="mb-3">
                                    <input type="text" class="form-control" placeholder="NIC Number" name="nic" required>
                                </div>
                                <div class="mb-3">
                                    <input type="password" class="form-control" placeholder="Password" name="password" required>
                                </div>
                                <div class="mb-3">
                                    <input type="password" class="form-control" placeholder="Confirm Password" name="confirmPassword" required>
                                </div>
                                <div class="mb-3">
                                    <button type="submit" class="btn btn-primary">Sign Up</button>
                                </div>
                                <p class="form-footer">Already have an account? <a href="index.jsp">Sign in</a></p>
                            </form>
                            <%
                                String status = request.getParameter("s");
                                String error = request.getParameter("error");
                                if (status != null) {
                                    if (status.equals("1")) { %>
                            <div class="alert alert-success mt-3">Signup successful</div>
                            <% } else if (status.equals("0")) {
                                String errorMessage = "";
                                if (error != null) {
                                    if (error.equals("missing_fields")) {
                                        errorMessage = "Please fill in all fields.";
                                    } else if (error.equals("invalid_password")) {
                                        errorMessage = "Password must be at least 8 characters long and include a special character.";
                                    } else if (error.equals("password_mismatch")) {
                                        errorMessage = "Passwords do not match.";
                                    } else if (error.equals("duplicate_email")) {
                                        errorMessage = "This email is already registered.";
                                    } else if (error.equals("duplicate_nic")) {
                                        errorMessage = "This NIC is already registered.";
                                    } else if (error.equals("duplicate_entry")) {
                                        errorMessage = "This user already exists.";
                                    } else if (error.equals("registration_failed")) {
                                        errorMessage = "Registration failed. Please try again.";
                                    } else {
                                        errorMessage = "An unknown error occurred. Please try again.";
                                    }
                                }
                            %>
                            <div class="alert alert-danger mt-3"><%= errorMessage%></div>
                            <% }
                                }
                            %>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
        </script>
    </body>

</html>
