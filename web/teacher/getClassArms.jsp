<%@page import="java.util.List"%>
<%@page import="app.java.ClassArm"%>
<%@page import="app.java.DBConnector"%>
<%
    String classIdParam = request.getParameter("classId");
    if (classIdParam != null && !classIdParam.isEmpty()) {
        try {
            int classId = Integer.parseInt(classIdParam);
            ClassArm classArmObj = new ClassArm();
            List<ClassArm> classArms = classArmObj.getClassArmsByClassId(DBConnector.getConnection(), classId);

            for (ClassArm arm : classArms) {
%>
                <option value="<%= arm.getId() %>"><%= arm.getClassArmName() %></option>
<%
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
%>
