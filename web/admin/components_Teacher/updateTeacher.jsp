<%@page import="java.sql.Connection"%>
<%@page import="app.java.Teacher"%>
<%@page import="app.java.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phoneNo = request.getParameter("phoneNo");
    int classId = Integer.parseInt(request.getParameter("classId"));
    int classArmId = Integer.parseInt(request.getParameter("classArmId"));
    String password ="";
    String status = "0"; // Default to failure
    
    try (Connection con = DBConnector.getConnection()) {
        Teacher existingTeacher = Teacher.getTeacherById(con, id);
        if (existingTeacher != null) {
            if (existingTeacher.getEmail().equals(email) || Teacher.isEmailUnique(con, email, id)) {
                Teacher teacher = new Teacher(firstName, lastName, email, phoneNo,password, classId, classArmId);
                teacher.setId(id);
                if (teacher.updateTeacher(con)) {
                    status = "1"; // Success
                }
            } else {
                status = "2"; // Email already exists
            }
        } else {
            status = "3"; // Teacher not found
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("../manageTeacher.jsp?s=" + status);
%>