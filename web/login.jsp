<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="app.java.MD5" %>
<%@page import="app.java.DBConnector" %>

<%
    // Retrieve form parameters
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String role = request.getParameter("role");

    // Encrypt the password using MD5
    String encryptedPassword = MD5.getMD5(password);

    try {
        // Get database connection
        Connection con = DBConnector.getConnection();

        // Query to check the user
        String query = "SELECT firstname, lastname FROM users WHERE username=? AND password=? AND role=?";
        PreparedStatement pst = con.prepareStatement(query);
        pst.setString(1, username);
        pst.setString(2, encryptedPassword);
        pst.setString(3, role);

        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            // User found, create a session
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            session.setAttribute("firstname", rs.getString("firstname"));
            session.setAttribute("lastname", rs.getString("lastname"));

            // Redirect to the respective dashboard
            if ("admin".equals(role)) {
                response.sendRedirect("adminDashboard.jsp");
            } else if ("teacher".equals(role)) {
                response.sendRedirect("teacherDashboard.jsp");
            }
        } else {
            // Invalid login
            out.println("<div class='alert alert-danger'>Invalid username, password, or role. Please try again.</div>");
            response.setHeader("Refresh", "2; URL=index.jsp");
        }

        // Close connections
        rs.close();
        pst.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<div class='alert alert-danger'>An error occurred. Please try again later.</div>");
    }
%>
