<%@page import="java.sql.Connection"%>
<%@page import="app.java.Teacher"%>
<%@page import="app.java.DBConnector"%>
<%@page import="com.google.gson.Gson"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Teacher teacher = null;
    
    try (Connection con = DBConnector.getConnection()) {
        teacher = Teacher.getTeacherById(con, id);
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    Gson gson = new Gson();
    String jsonTeacher = gson.toJson(teacher);
    out.print(jsonTeacher);
%>