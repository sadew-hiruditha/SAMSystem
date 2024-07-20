<%@page import="java.sql.Connection"%>
<%@page import="app.java.Student"%>
<%@page import="app.java.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String status = "0"; // Default to failure
    Student student = new Student();
    student.setId(id);
    try {

        if (student.deleteStudent(DBConnector.getConnection())) {
            status = "2"; // Success
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("../manageStudent.jsp?s=" + status);
%>