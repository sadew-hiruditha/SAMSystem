<%@page import="java.sql.SQLException"%>
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
        response.sendRedirect("sign_up.jsp?s=0&error=missing_fields");
        return;
    }

    // Password validation
    if (password.length() < 8 || !password.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*")) {
        response.sendRedirect("sign_up.jsp?s=0&error=invalid_password");
        return;
    }

    // Password confirmation check
    if (!password.equals(confirmPassword)) {
        response.sendRedirect("sign_up.jsp?s=0&error=password_mismatch");
        return;
    }

    User user = new User(firstName, lastName, username, role, NIC, password, confirmPassword);
    try {
        if (user.register(DBConnector.getConnection())) {
            response.sendRedirect("sign_up.jsp?s=1");
        } else {
            response.sendRedirect("sign_up.jsp?s=0&error=registration_failed");
        }
    } catch (SQLException e) {
        if (e.getErrorCode() == 1062) {
            // Duplicate entry error
            if (e.getMessage().contains("username")) {
                response.sendRedirect("sign_up.jsp?s=0&error=duplicate_email");
            } else if (e.getMessage().contains("nic")) {
                response.sendRedirect("sign_up.jsp?s=0&error=duplicate_nic");
            } else {
                response.sendRedirect("sign_up.jsp?s=0&error=duplicate_entry");
            }
        } else {
            // Log the exception
            e.printStackTrace();
            response.sendRedirect("sign_up.jsp?s=0&error=unknown_error");
        }
    } catch (Exception e) {
        // Log the exception
        e.printStackTrace();
        response.sendRedirect("sign_up.jsp?s=0&error=unknown_error");
    }
%>