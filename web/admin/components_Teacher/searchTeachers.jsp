<%@page import="java.sql.Connection"%>
<%@page import="app.java.Teacher"%>
<%@page import="app.java.DBConnector"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String searchTerm = request.getParameter("searchTerm");
    List<Teacher> teachers = null;
    
    try (Connection con = DBConnector.getConnection()) {
        teachers = Teacher.searchTeachers(con, searchTerm);
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    if (teachers != null && !teachers.isEmpty()) {
        for (Teacher t : teachers) {
%>
    <tr>
        <td><%= t.getId() %></td>
        <td><%= t.getFirstName() %></td>
        <td><%= t.getLastName() %></td>
        <td><%= t.getEmail() %></td>
        <td><%= t.getPhoneNo() %></td>
        <td><%= t.getClassName() %></td>
        <td><%= t.getClassArmName() %></td>
        <td><%= t.getDateCreated() %></td>
        <td>
            <button class="btn btn-warning btn-sm" onclick="editTeacher(<%= t.getId() %>)">Edit</button>
            <button class="btn btn-danger btn-sm" onclick="deleteTeacher(<%= t.getId() %>)">Delete</button>
        </td>
    </tr>
<%
        }
    } else {
%>
    <tr>
        <td colspan="9">No teachers found</td>
    </tr>
<%
    }
%>