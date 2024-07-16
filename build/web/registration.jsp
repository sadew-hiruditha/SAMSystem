<%-- 
    Document   : registration
    Created on : Jul 15, 2024, 6:16:57 PM
    Author     : Sadew
--%>
<%@page import="app.java.User"%>
<%@page import="app.java.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String firstName = request.getParameter("firstname");
    String lastName = request.getParameter("lastname");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");
    String role = "teacher";
    String NIC = request.getParameter("nic");

    // Input validation
    if (firstName == null || lastName == null || username == null || password == null || confirmPassword == null || NIC == null
            || firstName.isEmpty() || lastName.isEmpty() || username.isEmpty() || password.isEmpty() || confirmPassword.isEmpty() || NIC.isEmpty()) {
        response.sendRedirect("sign_up.jsp?error=missing_fields");
        return;
    }

    // Password confirmation check
    if (!password.equals(confirmPassword)) {
        response.sendRedirect("sign_up.jsp?error=password_mismatch");
        return;
    }

    User user = new User(firstName, lastName, username, role, NIC, password, confirmPassword);
    
    try {
        if (user.register(DBConnector.getConnection())) {
            response.sendRedirect("sign_up.jsp?s=1");
        } else {
            response.sendRedirect("sign_up.jsp?s=0");
        }
    } catch (Exception e) {
        // Log the exception
        e.printStackTrace();
        response.sendRedirect("sign_up.jsp?error=registration_failed");
    }
%>