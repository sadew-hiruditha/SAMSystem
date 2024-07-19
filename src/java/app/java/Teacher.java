package app.java;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Teacher {

    private static final String DEFAULT_PASSWORD = "1234"; // Default password constant

    private int id;
    private String firstName;
    private String lastName;
    private String email;
    private String phoneNo;
    private int classId;
    private int classArmId;
    private String className;
    private String classArmName;
    private String dateCreated;
    private String password;

    public Teacher() {
    }

    public Teacher(String firstName, String lastName, String email, String phoneNo, String password, int classId, int classArmId) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phoneNo = phoneNo;
        this.classId = classId;
        this.classArmId = classArmId;
        this.password = password;
    }

    // Getters and setters
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String PassWord) {
        this.password = MD5.getMD5(PassWord);
    }

    // Database operations
    public boolean addTeacher(Connection con) throws SQLException {
        if (this.password == null || this.password.isEmpty()) {
            this.password = MD5.getMD5(DEFAULT_PASSWORD); // Set default password and hash it
        }

        try {
            String query;
            query = "INSERT INTO tblteachers (firstName, lastName, email, phoneNo, classId, classArmId, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setString(1, this.firstName);
                ps.setString(2, this.lastName);
                ps.setString(3, this.email);
                ps.setString(4, this.phoneNo);
                ps.setInt(5, this.classId);
                ps.setInt(6, this.classArmId);
                ps.setString(7, this.password);
                int result = ps.executeUpdate();
                return result > 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, "Error adding teacher", ex);
            return false;
        }
    }

    public List<Teacher> getAllTeachers(Connection con) throws SQLException {
        List<Teacher> teachers = new ArrayList<>();
        String query = "SELECT t.*, c.className, ca.classArmName FROM tblteachers t "
                + "JOIN tblclass c ON t.classId = c.id "
                + "JOIN tblclassarms ca ON t.classArmId = ca.id "
                + "ORDER BY t.id";
        try (PreparedStatement ps = con.prepareStatement(query);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Teacher teacher = new Teacher();
                teacher.setId(rs.getInt("id"));
                teacher.setFirstName(rs.getString("firstName"));
                teacher.setLastName(rs.getString("lastName"));
                teacher.setEmail(rs.getString("email"));
                teacher.setPhoneNo(rs.getString("phoneNo"));
                teacher.setClassId(rs.getInt("classId"));
                teacher.setClassArmId(rs.getInt("classArmId"));
                teacher.setClassName(rs.getString("className"));
                teacher.setClassArmName(rs.getString("classArmName"));
                teacher.setDateCreated(rs.getString("dateCreated"));
                teachers.add(teacher);
            }
        }
        return teachers;
    }

    public boolean deleteTeacher(Connection con) throws SQLException {
        String query = "DELETE FROM tblteachers WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, this.id);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, "Error deleting teacher", ex);
            throw ex;
        }
    }

    public static Teacher getTeacherById(Connection con, int teacherId) throws SQLException {
        String query = "SELECT t.*, c.className, ca.classArmName FROM tblteachers t "
                + "JOIN tblclass c ON t.classId = c.id "
                + "JOIN tblclassarms ca ON t.classArmId = ca.id "
                + "WHERE t.id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, teacherId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Teacher teacher = new Teacher();
                    teacher.setId(rs.getInt("id"));
                    teacher.setFirstName(rs.getString("firstName"));
                    teacher.setLastName(rs.getString("lastName"));
                    teacher.setEmail(rs.getString("email"));
                    teacher.setPhoneNo(rs.getString("phoneNo"));
                    teacher.setClassId(rs.getInt("classId"));
                    teacher.setClassArmId(rs.getInt("classArmId"));
                    teacher.setClassName(rs.getString("className"));
                    teacher.setClassArmName(rs.getString("classArmName"));
                    teacher.setDateCreated(rs.getString("dateCreated"));
                    return teacher;
                }
            }
        }
        return null;
    }

    public boolean updateTeacher(Connection con) throws SQLException {
        String query = "UPDATE tblteachers SET firstName = ?, lastName = ?, email = ?, phoneNo = ?, classId = ?, classArmId = ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, this.firstName);
            ps.setString(2, this.lastName);
            ps.setString(3, this.email);
            ps.setString(4, this.phoneNo);
            ps.setInt(5, this.classId);
            ps.setInt(6, this.classArmId);
            ps.setInt(7, this.id);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, "Error updating teacher", ex);
            throw ex;
        }
    }

    public static boolean isEmailUnique(Connection con, String email, Integer excludeId) throws SQLException {
        String query = "SELECT COUNT(*) FROM tblteachers WHERE email = ? " + (excludeId != null ? "AND id != ?" : "");
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, email);
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

    public static List<Teacher> searchTeachers(Connection con, String searchTerm) throws SQLException {
        List<Teacher> teachers = new ArrayList<>();
        String query = "SELECT t.*, c.className, ca.classArmName FROM tblteachers t "
                + "JOIN tblclass c ON t.classId = c.id "
                + "JOIN tblclassarms ca ON t.classArmId = ca.id "
                + "WHERE t.firstName LIKE ? OR t.lastName LIKE ? OR t.email LIKE ? OR t.phoneNo LIKE ? "
                + "ORDER BY t.id";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            String likeSearchTerm = "%" + searchTerm + "%";
            ps.setString(1, likeSearchTerm);
            ps.setString(2, likeSearchTerm);
            ps.setString(3, likeSearchTerm);
            ps.setString(4, likeSearchTerm);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Teacher teacher = new Teacher();
                    teacher.setId(rs.getInt("id"));
                    teacher.setFirstName(rs.getString("firstName"));
                    teacher.setLastName(rs.getString("lastName"));
                    teacher.setEmail(rs.getString("email"));
                    teacher.setPhoneNo(rs.getString("phoneNo"));
                    teacher.setClassId(rs.getInt("classId"));
                    teacher.setClassArmId(rs.getInt("classArmId"));
                    teacher.setClassName(rs.getString("className"));
                    teacher.setClassArmName(rs.getString("classArmName"));
                    teacher.setDateCreated(rs.getString("dateCreated"));
                    teachers.add(teacher);
                }
            }
        }
        return teachers;
    }
    
     public static int getTotalTeachers(Connection con) throws SQLException {
        String query = "SELECT COUNT(*) AS totalTeachers FROM tblteachers";
        try (PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("totalTeachers");
            }
        }
        return 0;
    }

}



