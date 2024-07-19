<%@page import="app.java.DBConnector"%>
<%@page import="app.java.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String admissionNumber = request.getParameter("admissionNumber");
    String classIdStr = request.getParameter("classId");
    String classArmIdStr = request.getParameter("classArmId");
    
    String addStatus = "0"; // Default to failure
    
    if(firstName != null && !firstName.trim().isEmpty() &&
       lastName != null && !lastName.trim().isEmpty() &&
       admissionNumber != null && !admissionNumber.trim().isEmpty() &&
       classIdStr != null && !classIdStr.trim().isEmpty() &&
       classArmIdStr != null && !classArmIdStr.trim().isEmpty()) {
        
        try {
            int classId = Integer.parseInt(classIdStr);
            int classArmId = Integer.parseInt(classArmIdStr);
            
            Student newStudent = new Student(firstName, lastName, admissionNumber, classId, classArmId);
            if(newStudent.addStudent(DBConnector.getConnection())) {
                addStatus = "1"; // Success
            }
        } catch(NumberFormatException e) {
            e.printStackTrace();
            addStatus = "2"; // Invalid number format
        } catch(Exception e) {
            e.printStackTrace();
            addStatus = "0"; // Failure due to exception
        }
    } else {
        addStatus = "3"; // Missing or empty fields
    }
    response.sendRedirect("manageStudent.jsp?s=" + addStatus);
%>