package app.java;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Student {

    private int id;
    private String firstName;
    private String lastName;
    private String admissionNumber;
    private int classId;
    private int classArmId;
    private String className;
    private String classArmName;
    private String dateCreated;

    public Student() {
    }

    public Student(int id,String firstName, String lastName, String admissionNumber, int classId, int classArmId) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.admissionNumber = admissionNumber;
        this.classId = classId;
        this.classArmId = classArmId;
    }
    
     public Student(String firstName, String lastName, String admissionNumber, int classId, int classArmId) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.admissionNumber = admissionNumber;
        this.classId = classId;
        this.classArmId = classArmId;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getAdmissionNumber() {
        return admissionNumber;
    }

    public void setAdmissionNumber(String admissionNumber) {
        this.admissionNumber = admissionNumber;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public int getClassArmId() {
        return classArmId;
    }

    public void setClassArmId(int classArmId) {
        this.classArmId = classArmId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getClassArmName() {
        return classArmName;
    }

    public void setClassArmName(String classArmName) {
        this.classArmName = classArmName;
    }

    public String getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(String dateCreated) {
        this.dateCreated = dateCreated;
    }

    

    public boolean addStudent(Connection con) throws SQLException {
        try {
            String query = "INSERT INTO tblstudents (firstName, lastName, admissionNumber, classId, classArmId) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setString(1, this.firstName);
                ps.setString(2, this.lastName);
                ps.setString(3, this.admissionNumber);
                ps.setInt(4, this.classId);
                ps.setInt(5, this.classArmId);
                int result = ps.executeUpdate();
                return result > 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, "Error adding student", ex);
            return false;
        }
    }

    public List<Student> getAllStudents(Connection con) throws SQLException {
        List<Student> students = new ArrayList<>();
        String query = "SELECT s.*, c.className, ca.classArmName FROM tblstudents s "
                + "JOIN tblclass c ON s.classId = c.id "
                + "JOIN tblclassarms ca ON s.classArmId = ca.id "
                + "ORDER BY s.id";
        try (PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("id"));
                student.setFirstName(rs.getString("firstName"));
                student.setLastName(rs.getString("lastName"));
                student.setAdmissionNumber(rs.getString("admissionNumber"));
                student.setClassId(rs.getInt("classId"));
                student.setClassArmId(rs.getInt("classArmId"));
                student.setClassName(rs.getString("className"));
                student.setClassArmName(rs.getString("classArmName"));
                student.setDateCreated(rs.getString("dateCreated"));
                students.add(student);
            }
        }
        return students;
    }

    public boolean deleteStudent(Connection con) throws SQLException {
        String query = "DELETE FROM tblstudents WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, this.id);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, "Error deleting student", ex);
            throw ex;
        }
    }

    public static Student getStudentById(Connection con, int studentId) throws SQLException {
        String query = "SELECT s.*, c.className, ca.classArmName FROM tblstudents s "
                + "JOIN tblclass c ON s.classId = c.id "
                + "JOIN tblclassarms ca ON s.classArmId = ca.id "
                + "WHERE s.id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Student student = new Student();
                    student.setId(rs.getInt("id"));
                    student.setFirstName(rs.getString("firstName"));
                    student.setLastName(rs.getString("lastName"));
                    student.setAdmissionNumber(rs.getString("admissionNumber"));
                    student.setClassId(rs.getInt("classId"));
                    student.setClassArmId(rs.getInt("classArmId"));
                    student.setClassName(rs.getString("className"));
                    student.setClassArmName(rs.getString("classArmName"));
                    student.setDateCreated(rs.getString("dateCreated"));
                    return student;
                }
            }
        }
        return null;
    }

    public boolean updateStudent(Connection con) throws SQLException {
        String query = "UPDATE tblstudents SET firstName = ?, lastName = ?, admissionNumber = ?, classId = ?, classArmId = ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, this.firstName);
            ps.setString(2, this.lastName);
            ps.setString(3, this.admissionNumber);
            ps.setInt(4, this.classId);
            ps.setInt(5, this.classArmId);
            ps.setInt(6, this.id);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, "Error updating student", ex);
            throw ex;
        }
    }

    public static boolean isAdmissionNumberUnique(Connection con, String admissionNumber, Integer excludeId) throws SQLException {
        String query = "SELECT COUNT(*) FROM tblstudents WHERE admissionNumber = ? " + (excludeId != null ? "AND id != ?" : "");
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, admissionNumber);
            if (excludeId != null) {
                ps.setInt(2, excludeId);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }
        }
        return false;
    }
    
    public static List<Student> getStudentsByClassAndClassArm(Connection con, int classId, int classArmId) throws SQLException {
        List<Student> students = new ArrayList<>();
        String query = "SELECT s.*, c.className, ca.classArmName FROM tblstudents s "
                + "JOIN tblclass c ON s.classId = c.id "
                + "JOIN tblclassarms ca ON s.classArmId = ca.id "
                + "WHERE s.classId = ? AND s.classArmId = ? "
                + "ORDER BY s.id";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, classId);
            ps.setInt(2, classArmId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Student student = new Student();
                    student.setId(rs.getInt("id"));
                    student.setFirstName(rs.getString("firstName"));
                    student.setLastName(rs.getString("lastName"));
                    student.setAdmissionNumber(rs.getString("admissionNumber"));
                    student.setClassId(rs.getInt("classId"));
                    student.setClassArmId(rs.getInt("classArmId"));
                    student.setClassName(rs.getString("className"));
                    student.setClassArmName(rs.getString("classArmName"));
                    student.setDateCreated(rs.getString("dateCreated"));
                    students.add(student);
                }
            }
        }
        return students;
    }

    public static List<Student> searchStudents(Connection con, String searchTerm) throws SQLException {
        List<Student> students = new ArrayList<>();
        String query = "SELECT s.*, c.className, ca.classArmName FROM tblstudents s "
                + "JOIN tblclass c ON s.classId = c.id "
                + "JOIN tblclassarms ca ON s.classArmId = ca.id "
                + "WHERE s.firstName LIKE ? OR s.lastName LIKE ? OR s.admissionNumber LIKE ? "
                + "ORDER BY s.id";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            String likeSearchTerm = "%" + searchTerm + "%";
            ps.setString(1, likeSearchTerm);
            ps.setString(2, likeSearchTerm);
            ps.setString(3, likeSearchTerm);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Student student = new Student();
                    student.setId(rs.getInt("id"));
                    student.setFirstName(rs.getString("firstName"));
                    student.setLastName(rs.getString("lastName"));
                    student.setAdmissionNumber(rs.getString("admissionNumber"));
                    student.setClassId(rs.getInt("classId"));
                    student.setClassArmId(rs.getInt("classArmId"));
                    student.setClassName(rs.getString("className"));
                    student.setClassArmName(rs.getString("classArmName"));
                    student.setDateCreated(rs.getString("dateCreated"));
                    students.add(student);
                }
            }
        }
        return students;
    }
    
    public static int getTotalStudents(Connection con) throws SQLException {
        String query = "SELECT COUNT(*) AS totalStudents FROM tblstudents";
        try (PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("totalStudents");
            }
        }
        return 0;
    }
    
    public static boolean submitAttendance(Connection conn, int classId, int classArmId, int studentId, String attendanceStatus, Date attendanceDate) throws SQLException {
        String sql = "INSERT INTO tblattendance (classId, classArmId, studentId, attendanceStatus, attendanceDate) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, classId);
            pstmt.setInt(2, classArmId);
            pstmt.setInt(3, studentId);
            pstmt.setString(4, attendanceStatus);
            pstmt.setDate(5, attendanceDate);
            int result = pstmt.executeUpdate();
            return result > 0;
        }
    }

    public static boolean submitBatchAttendance(Connection conn, List<Map<String, Object>> attendanceData) throws SQLException {
        String sql = "INSERT INTO tblattendance (classId, classArmId, studentId, attendanceStatus, attendanceDate) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            for (Map<String, Object> data : attendanceData) {
                pstmt.setInt(1, (Integer) data.get("classId"));
                pstmt.setInt(2, (Integer) data.get("classArmId"));
                pstmt.setInt(3, (Integer) data.get("studentId"));
                pstmt.setString(4, (String) data.get("attendanceStatus"));
                pstmt.setDate(5, (Date) data.get("attendanceDate"));
                pstmt.addBatch();
            }
            int[] results = pstmt.executeBatch();
            return results.length > 0;
        }
    }
    
    
}