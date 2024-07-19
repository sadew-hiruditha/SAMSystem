<%@page import="app.java.ClassArm"%>
<%@page import="app.java.Teacher"%>
<%@page import="app.java.Class"%>
<%@ page import="java.sql.Connection, java.sql.SQLException" %>
<%@ page import="app.java.DBConnector, app.java.Student" %>
<%
    int totalStudents = 0;
    int totalTeachers = 0;
    int totalClasses = 0;
    int totalClassArms = 0;
    
    Connection con = null;
    try {
        con = DBConnector.getConnection();
        totalStudents = Student.getTotalStudents(con);
        totalTeachers = Teacher.getTotalTeachers(con);
        totalClasses = Class.getTotalClasses(con);
        totalClassArms = ClassArm.getTotalCalssArms(con);
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    // Store the result in a variable for use in the main JSP
    pageContext.setAttribute("totalStudents", totalStudents);
    pageContext.setAttribute("totalTeachers", totalTeachers);
    pageContext.setAttribute("totalClasses", totalClasses);
    pageContext.setAttribute("totalClassArms", totalClassArms);
        





%>
