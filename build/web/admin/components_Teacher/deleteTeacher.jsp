<%@page import="java.sql.Connection"%>
<%@page import="app.java.Teacher"%>
<%@page import="app.java.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String status = "0"; // Default to failure
    Teacher teacher = new Teacher();
    teacher.setId(id);
    try {

        if (teacher.deleteTeacher(DBConnector.getConnection())) {
            status = "2"; // Success
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("../manageTeacher.jsp?s=" + status);
%>