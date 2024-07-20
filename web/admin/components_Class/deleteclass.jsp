<%@page import="app.java.Class"%>
<%@page import="app.java.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String status = "0"; // Default to failure
    
    Class classm = new Class();
    classm.setId(id);
    try {
        if(classm.deleteClass(DBConnector.getConnection())) {
            status = "3"; // Success
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
 response.sendRedirect("../manageClass.jsp?s=" + status);
%>