<%@page import="app.java.Admin"%>
<%@page import="app.java.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String className = request.getParameter("className");
    String message;
    String messageType;
    
    if(className == null || className.isEmpty()) {
        message = "Please fill in all required fields.";
        messageType = "danger";
    } else {
        Admin admin = new Admin(id, className);
        try {
            if(admin.updateClass(DBConnector.getConnection())) {
                message = "Class updated successfully!";
                messageType = "success";
            } else {
                message = "Failed to update the class. Please try again.";
                messageType = "danger";
            }
        } catch(Exception e) {
            e.printStackTrace();
            message = "An error occurred during update. Please try again.";
            messageType = "danger";
        }
    }
    response.sendRedirect("manageClass.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8") + "&messageType=" + messageType);
%>