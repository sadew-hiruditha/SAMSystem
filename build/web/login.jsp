<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="app.java.MD5"%>
<%@page import="app.java.DBConnector"%>
<%@page import="java.net.URLEncoder"%>
<%
    // Retrieve form parameters
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String rememberMe = request.getParameter("rememberMe");

    // Encrypt the password using MD5 (Note: Consider using a more secure hashing algorithm in production)
    String encryptedPassword = MD5.getMD5(password);

    try {
        Connection con = DBConnector.getConnection();
        String query = "SELECT firstname, lastname, role FROM users WHERE username=? AND password=?";
        PreparedStatement pst = con.prepareStatement(query);
        pst.setString(1, username);
        pst.setString(2, encryptedPassword);
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            // User found, create a session
            String role = rs.getString("role");
            String firstname = rs.getString("firstname");
            String lastname = rs.getString("lastname");
            
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            session.setAttribute("firstname", firstname);
            session.setAttribute("lastname", lastname);

            // Handle "Remember Me" functionality
            if ("on".equals(rememberMe)) {
                Cookie usernameCookie = new Cookie("username", URLEncoder.encode(username, "UTF-8"));
                Cookie roleCookie = new Cookie("role", URLEncoder.encode(role, "UTF-8"));
                Cookie firstnameCookie = new Cookie("firstname", URLEncoder.encode(firstname, "UTF-8"));
                Cookie lastnameCookie = new Cookie("lastname", URLEncoder.encode(lastname, "UTF-8"));
                
                int maxAge = 30 * 24 * 60 * 60; // 30 days
                usernameCookie.setMaxAge(maxAge);
                roleCookie.setMaxAge(maxAge);
                firstnameCookie.setMaxAge(maxAge);
                lastnameCookie.setMaxAge(maxAge);
                
                response.addCookie(usernameCookie);
                response.addCookie(roleCookie);
                response.addCookie(firstnameCookie);
                response.addCookie(lastnameCookie);
            }

            // Redirect to the respective dashboard
            if ("admin".equals(role)) {
                response.sendRedirect("adminDashboard.jsp");
            } else if ("teacher".equals(role)) {
                response.sendRedirect("teacherDashboard.jsp");
            } else {
                // Handle other roles or show an error
                request.setAttribute("errorMessage", "Invalid user role.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } else {
            // Invalid login
            request.setAttribute("errorMessage", "Invalid username or password. Please try again.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }

        // Close connections
        rs.close();
        pst.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred. Please try again later.");
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
%>