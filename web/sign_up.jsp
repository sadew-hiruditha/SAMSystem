<%-- 
    Document   : sign_up
    Created on : Jun 25, 2024, 3:20:21 PM
    Author     : Sadew
--%>

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
                    <h2>Welcome to SAM System</h2>
                    <p>Sign up now!</p>
                </div>
            </div>

            <!-- Right Section -->
            <div class="col-lg-6 p-0">
                <div class="right-section">
                    <div class="signup-form">
                        <h2>Sign Up to the System</h2>
                        <form action="sign_up.jsp" method="POST">
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
                            if (request.getMethod().equalsIgnoreCase("POST")) {
                                String firstName = request.getParameter("firstname");
                                String lastName = request.getParameter("lastname");
                                String username = request.getParameter("username");
                                String password = request.getParameter("password");
                                String confirmPassword = request.getParameter("confirmPassword");

                                if (!password.equals(confirmPassword)) {
                                    out.println("<div class='alert alert-danger mt-3'>Passwords do not match. Please try again.</div>");
                                } else {
                                    String encryptedPassword = MD5.getMD5(password);
                                    try {
                                        Connection con = DBConnector.getConnection();
                                        String query = "INSERT INTO users (firstname, lastname, username, password, role) VALUES (?, ?, ?, ?, ?)";
                                        PreparedStatement pst = con.prepareStatement(query);
                                        pst.setString(1, firstName);
                                        pst.setString(2, lastName);
                                        pst.setString(3, username);
                                        pst.setString(4, encryptedPassword);
                                        pst.setString(5, "teacher");
                                        int result = pst.executeUpdate();

                                        if (result > 0) {
                                            out.println("<div class='alert alert-success mt-3'>Signup successful. You can now <a href='index.jsp'>login</a>.</div>");
                                        } else {
                                            out.println("<div class='alert alert-danger mt-3'>Signup failed. Please try again.</div>");
                                        }

                                        pst.close();
                                        con.close();
                                    } catch (Exception e) {
                                       
                                        out.println("<div class='alert alert-danger mt-3'>An error occurred: " + e.getMessage() + "</div>");
                                    }
                                }
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
