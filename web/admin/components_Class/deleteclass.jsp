<%@page import="app.java.Admin"%>
<%@page import="app.java.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String status = "0"; // Default to failure
    
    Admin admin = new Admin();
    admin.setId(id);
    try {
        if(admin.deleteClass(DBConnector.getConnection())) {
            status = "3"; // Success
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
 response.sendRedirect("../manageClass.jsp?s=" + status);
%>