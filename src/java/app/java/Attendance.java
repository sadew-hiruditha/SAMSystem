package app.java;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Attendance {
    private int id;
    private int classId;
    private int classArmId;
    private int studentId;
    private String attendanceStatus;
    private String attendanceDate;
    private String studentName;
    private String admissionNumber;

    public Attendance() {}

    public Attendance(int classId, int classArmId, String attendanceDate) {
        this.classId = classId;
        this.classArmId = classArmId;
        this.attendanceDate = attendanceDate;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getClassId() { return classId; }
    public void setClassId(int classId) { this.classId = classId; }
    public int getClassArmId() { return classArmId; }
    public void setClassArmId(int classArmId) { this.classArmId = classArmId; }
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    public String getAttendanceStatus() { return attendanceStatus; }
    public void setAttendanceStatus(String attendanceStatus) { this.attendanceStatus = attendanceStatus; }
    public String getAttendanceDate() { return attendanceDate; }
    public void setAttendanceDate(String attendanceDate) { this.attendanceDate = attendanceDate; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public String getAdmissionNumber() { return admissionNumber; }
    public void setAdmissionNumber(String admissionNumber) { this.admissionNumber = admissionNumber; }

    public List<Attendance> getAttendanceByClassArmAndDate(Connection con) {
        List<Attendance> attendanceList = new ArrayList<>();
        String query = "SELECT a.id, a.classId, a.classArmId, a.studentId, a.attendanceStatus, a.attendanceDate, " +
                       "s.firstName, s.lastName, s.admissionNumber " +
                       "FROM tblattendance a " +
                       "RIGHT JOIN tblstudents s ON a.studentId = s.id " +
                       "WHERE s.classId = ? AND s.classArmId = ? " +
                       "AND (a.attendanceDate = ? OR a.attendanceDate IS NULL) " +
                       "ORDER BY s.firstName, s.lastName";
        
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, this.classId);
            ps.setInt(2, this.classArmId);
            ps.setString(3, this.attendanceDate);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Attendance attendance = new Attendance();
                    attendance.setId(rs.getInt("id"));
                    attendance.setClassId(rs.getInt("classId"));
                    attendance.setClassArmId(rs.getInt("classArmId"));
                    attendance.setStudentId(rs.getInt("studentId"));
                    attendance.setAttendanceStatus(rs.getString("attendanceStatus"));
                    attendance.setAttendanceDate(rs.getString("attendanceDate"));
                    attendance.setStudentName(rs.getString("firstName") + " " + rs.getString("lastName"));
                    attendance.setAdmissionNumber(rs.getString("admissionNumber"));
                    attendanceList.add(attendance);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return attendanceList;
    }
}