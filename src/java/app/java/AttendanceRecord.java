package app.java;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class AttendanceRecord {
    private int id;
    private int studentId;
    private String studentName;
    private Date date;
    private String status;

    public AttendanceRecord(int id, int studentId, String studentName, Date date, String status) {
        this.id = id;
        this.studentId = studentId;
        this.studentName = studentName;
        this.date = date;
        this.status = status;
    }

    // Getters
    public int getId() { return id; }
    public int getStudentId() { return studentId; }
    public String getStudentName() { return studentName; }
    public Date getDate() { return date; }
    public String getStatus() { return status; }

    public static List<AttendanceRecord> getMonthlyReport(Connection con, int classId, String month) throws SQLException {
        List<AttendanceRecord> records = new ArrayList<>();
        String query = "SELECT a.id, s.id as studentId, s.firstName, s.lastName, a.attendanceDate, a.attendanceStatus " +
                       "FROM tblattendance a " +
                       "JOIN tblstudents s ON a.studentId = s.id " +
                       "WHERE s.classId = ? AND DATE_FORMAT(a.attendanceDate, '%Y-%m') = ? " +
                       "ORDER BY a.attendanceDate, s.lastName, s.firstName";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, classId);
            pstmt.setString(2, month);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    records.add(new AttendanceRecord(
                        rs.getInt("id"),
                        rs.getInt("studentId"),
                        rs.getString("firstName") + " " + rs.getString("lastName"),
                        rs.getDate("attendanceDate"),
                        rs.getString("attendanceStatus")
                    ));
                }
            }
        }
        return records;
    }

    public static List<AttendanceRecord> getAttendanceRecords(Connection con, int classId, int armId, String date) throws SQLException {
        List<AttendanceRecord> records = new ArrayList<>();
        String query = "SELECT a.id, s.id as studentId, s.firstName, s.lastName, a.attendanceDate, a.attendanceStatus " +
                       "FROM tblattendance a " +
                       "JOIN tblstudents s ON a.studentId = s.id " +
                       "WHERE s.classId = ? AND s.armId = ? AND DATE(a.attendanceDate) = ? " +
                       "ORDER BY s.lastName, s.firstName";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, classId);
            pstmt.setInt(2, armId);
            pstmt.setString(3, date);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    records.add(new AttendanceRecord(
                        rs.getInt("id"),
                        rs.getInt("studentId"),
                        rs.getString("firstName") + " " + rs.getString("lastName"),
                        rs.getDate("attendanceDate"),
                        rs.getString("attendanceStatus")
                    ));
                }
            }
        }
        return records;
    }
}