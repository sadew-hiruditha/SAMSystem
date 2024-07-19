<%@page import="app.java.ClassArm"%>
<%@page import="app.java.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int classId = Integer.parseInt(request.getParameter("classId"));
    String classArmName = request.getParameter("classArmName");
    String status = "0"; // Default to failure
    
    ClassArm classArm = new ClassArm(classId, classArmName, false);
    
    try {
        if(classArm.addClassArm(DBConnector.getConnection())) {
            status = "1"; // Success
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("../manageClassArms.jsp?s=" + status);
%>