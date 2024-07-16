<%@page import="app.java.Admin"%>
<%@page import="app.java.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String message;
    String messageType;
    
    Admin admin = new Admin();
    admin.setId(id);
    try {
        if(admin.deleteClass(DBConnector.getConnection())) {
            message = "Class deleted successfully!";
            messageType = "success";
        } else {
            message = "Failed to delete the class. Please try again.";
            messageType = "danger";
        }
    } catch(Exception e) {
        e.printStackTrace();
        message = "An error occurred during deletion. Please try again.";
        messageType = "danger";
    }
    response.sendRedirect("manageClass.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8") + "&messageType=" + messageType);
%>