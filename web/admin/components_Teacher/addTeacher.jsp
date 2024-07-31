<%@page import="app.java.DBConnector"%>
<%@page import="app.java.Teacher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phoneNo = request.getParameter("phoneNo");
    String classIdStr = request.getParameter("classId");
    String classArmIdStr = request.getParameter("classArmId");
    String password = "";
    String addStatus = "0"; // Default to failure
    
    if(firstName != null && !firstName.trim().isEmpty() &&
       lastName != null && !lastName.trim().isEmpty() &&
       email != null && !email.trim().isEmpty() &&
       phoneNo != null && !phoneNo.trim().isEmpty() &&
       classIdStr != null && !classIdStr.trim().isEmpty() &&
       classArmIdStr != null && !classArmIdStr.trim().isEmpty()) {
        
        try {
            int classId = Integer.parseInt(classIdStr);
            int classArmId = Integer.parseInt(classArmIdStr);
            
            Teacher newTeacher = new Teacher(firstName, lastName, email, phoneNo,password, classId, classArmId);
            if(newTeacher.addTeacher(DBConnector.getConnection())) {
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
    response.sendRedirect("manageTeacher.jsp?s=" + addStatus);
%>