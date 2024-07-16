<%@page import="app.java.Admin"%>
<%@page import="app.java.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String className = request.getParameter("classname");
    String message;
    String messageType;
    
    if(className == null || className.isEmpty()) {
        message = "Please fill in all required fields.";
        messageType = "danger";
    } else {
        Admin admin = new Admin(className);
        try {
            if(admin.classExists(DBConnector.getConnection())) {
                message = "This Class Already Exists!";
                messageType = "danger";
            } else if(admin.addClass(DBConnector.getConnection())) {
                message = "Class added successfully!";
                messageType = "success";
            } else {
                message = "Failed to add the class. Please try again.";
                messageType = "danger";
            }
        } catch(Exception e) {
            e.printStackTrace();
            message = "An error occurred during registration. Please try again.";
            messageType = "danger";
        }
    }
    response.sendRedirect("manageClass.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8") + "&messageType=" + messageType);
%>