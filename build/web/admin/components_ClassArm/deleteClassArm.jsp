<%@page import="app.java.ClassArm"%>
<%@page import="app.java.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String status = "0"; // Default to failure
    
    ClassArm classArm = new ClassArm();
    classArm.setId(id);
    try {
        if(classArm.deleteClassArm(DBConnector.getConnection())) {
            status = "3"; // Success
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("../manageClassArms.jsp?s=" + status);
%>