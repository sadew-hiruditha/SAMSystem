<%@page import="app.java.ClassArm"%>
<%@page import="app.java.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String classArmName = request.getParameter("classArmName");
    boolean isAssigned = request.getParameter("isAssigned") != null;
    String status = "0"; // Default to failure
    
    ClassArm classArm = new ClassArm();
    classArm.setId(id);
    classArm.setClassArmName(classArmName);
    classArm.setIsAssigned(isAssigned);
    
    try {
        if(classArm.updateClassArm(DBConnector.getConnection())) {
            status = "2"; // Success
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("../manageClassArms.jsp?s=" + status);
%>