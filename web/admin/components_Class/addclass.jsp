<%@page import="app.java.Admin"%>
<%@page import="app.java.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String className = request.getParameter("classname");
    String status = "0"; // Default to failure
    
    if(className != null && !className.isEmpty()) {
        Admin admin = new Admin(className);
        try {
            if(admin.classExists(DBConnector.getConnection())) {
                status = "2"; // Class already exists
            } else if(admin.addClass(DBConnector.getConnection())) {
                status = "1"; // Success
            }
        } catch(Exception e) {
            e.printStackTrace();
            status = "0"; // Failure due to exception
        }
    }
    response.sendRedirect("../manageClass.jsp?s=" + status);
%>