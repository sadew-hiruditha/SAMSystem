<%@page import="app.java.Class"%>
<%@page import="app.java.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String className = request.getParameter("className");
    String status = "0"; // Default to failure
    
    if(className != null && !className.isEmpty()) {
        Class classm = new Class(id, className);
        try {
            if(classm.updateClass(DBConnector.getConnection())) {
                status = "4"; // Success
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    response.sendRedirect("../manageClass.jsp?s=" + status);
%>