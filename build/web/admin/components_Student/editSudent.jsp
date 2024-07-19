<%@page import="app.java.DBConnector"%>
<%@page import="app.java.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String idStr = request.getParameter("id");
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String admissionNumber = request.getParameter("admissionNumber");
    String classIdStr = request.getParameter("classId");
    String classArmIdStr = request.getParameter("classArmId");
    
    String editStatus = "0"; // Default to failure
    
    if(idStr != null && !idStr.trim().isEmpty() &&
       firstName != null && !firstName.trim().isEmpty() &&
       lastName != null && !lastName.trim().isEmpty() &&
       admissionNumber != null && !admissionNumber.trim().isEmpty() &&
       classIdStr != null && !classIdStr.trim().isEmpty() &&
       classArmIdStr != null && !classArmIdStr.trim().isEmpty()) {
        
        try {
            int id = Integer.parseInt(idStr);
            int classId = Integer.parseInt(classIdStr);
            int classArmId = Integer.parseInt(classArmIdStr);
            
            Student student = new Student(id,firstName, lastName, admissionNumber, classId, classArmId);
            if(student.updateStudent(DBConnector.getConnection())) {
                editStatus = "1"; // Success
            }
        } catch(NumberFormatException e) {
            e.printStackTrace();
            editStatus = "2"; // Invalid number format
        } catch(Exception e) {
            e.printStackTrace();
            editStatus = "0"; // Failure due to exception
        }
    } else {
        editStatus = "3"; // Missing or empty fields
    }
    response.sendRedirect("manageStudent.jsp?s=" + editStatus + "&op=edit");
%>