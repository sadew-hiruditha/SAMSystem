<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="app.java.User"%>
<%@page import="app.java.DBConnector"%>
<%@page import="java.util.UUID"%>

<%
    // Retrieve form parameters
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String rememberMe = request.getParameter("rememberMe");

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        con = DBConnector.getConnection();
        if (con == null) {
            throw new Exception("Unable to establish database connection");
        }

        User user = new User(username, password);

        if (user.authenticate(con)) {
            if (user.retrieveUserDetails(con)) {
                // User authenticated successfully and details retrieved
                session.setAttribute("userId", user.getId());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("role", user.getRole());
                session.setAttribute("firstname", user.getFirstName());
                session.setAttribute("lastname", user.getLastName());

                // Handle "Remember Me" functionality
                if ("on".equals(rememberMe)) {
                    String cookieToken = UUID.randomUUID().toString();

                    // Store the cookie token in the database
                    String updateQuery = "UPDATE users SET cookie_token = ? WHERE id = ?";
                    pst = con.prepareStatement(updateQuery);
                    pst.setString(1, cookieToken);
                    pst.setInt(2, user.getId());
                    pst.executeUpdate();

                    // Set the cookie
                    Cookie tokenCookie = new Cookie("remember_token", cookieToken);
                    int maxAge = 30 * 24 * 60 * 60; // 30 days
                    tokenCookie.setMaxAge(maxAge);
                    tokenCookie.setHttpOnly(true); // For better security
                    tokenCookie.setPath("/"); // Available on all pages
                    response.addCookie(tokenCookie);
                }

                // Redirect to the respective dashboard
                String userRole = user.getRole();

                if (userRole != null) {
                    if ("admin".equalsIgnoreCase(userRole)) {
                        response.sendRedirect("./admin/adminDashboard.jsp");
                    } else if ("teacher".equalsIgnoreCase(userRole)) {
                        response.sendRedirect("./teacher/teacherDashboard.jsp");
                    } else {
                        request.setAttribute("errorMessage", "Invalid user role: " + userRole);
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("errorMessage", "User role is not set.");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "Failed to retrieve user details.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } else {
            // Invalid login
            request.setAttribute("errorMessage", "Invalid username or password. Please try again.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        request.getRequestDispatcher("index.jsp").forward(request, response);
    } finally {
        // Close resources
        try {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>