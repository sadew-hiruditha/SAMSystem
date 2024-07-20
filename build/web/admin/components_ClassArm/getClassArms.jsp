<%@ page import="java.sql.Connection" %>
<%@ page import="app.java.DBConnector" %>
<%@ page import="app.java.ClassArm" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int classId = Integer.parseInt(request.getParameter("classId"));
    Connection con = DBConnector.getConnection();
    ClassArm classArmObj = new ClassArm();
    List<ClassArm> classArms = classArmObj.getClassArmsByClassId(con, classId);

    out.println("<option value=''>--Select Class Arm--</option>");
    for (ClassArm arm : classArms) {
        out.println("<option value='" + arm.getId() + "'>" + arm.getClassArmName() + "</option>");
    }
%>