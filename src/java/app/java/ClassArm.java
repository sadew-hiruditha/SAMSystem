package app.java;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ClassArm {
    
    private int id;
    private int classId;
    private String classArmName;
    private boolean isAssigned;
    private String className; // To store the associated class name

    public ClassArm() {}

    public ClassArm(int classId, String classArmName, boolean isAssigned) {
        this.classId = classId;
        this.classArmName = classArmName;
        this.isAssigned = isAssigned;
    }

    public ClassArm(int id, int classId, String classArmName, boolean isAssigned) {
        this.id = id;
        this.classId = classId;
        this.classArmName = classArmName;
        this.isAssigned = isAssigned;
    }

    // Getters and setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public String getClassArmName() {
        return classArmName;
    }

    public void setClassArmName(String classArmName) {
        this.classArmName = classArmName;
    }

    public boolean isIsAssigned() {
        return isAssigned;
    }

    public void setIsAssigned(boolean isAssigned) {
        this.isAssigned = isAssigned;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    // Database operations

    public boolean classArmExists(Connection con) throws SQLException {
        String query = "SELECT COUNT(*) FROM tblclassarms WHERE classId = ? AND classArmName = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, this.classId);
            ps.setString(2, this.classArmName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public boolean addClassArm(Connection con) {
        try {
            if (classArmExists(con)) {
                return false; // Class arm already exists
            }
            String query = "INSERT INTO tblclassarms (classId, classArmName, isAssigned) VALUES (?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setInt(1, this.classId);
                ps.setString(2, this.classArmName);
                ps.setBoolean(3, this.isAssigned);
                int result = ps.executeUpdate();
                return result > 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassArm.class.getName()).log(Level.SEVERE, "Error adding class arm", ex);
            return false;
        }
    }

    public List<ClassArm> getAllClassArms(Connection con) throws SQLException {
        List<ClassArm> classArms = new ArrayList<>();
        String query = "SELECT ca.id, ca.classId, c.className, ca.classArmName, ca.isAssigned FROM tblclassarms ca JOIN tblclass c ON ca.classId = c.id ORDER BY ca.id";
        try (PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ClassArm classArm = new ClassArm(rs.getInt("id"), rs.getInt("classId"), rs.getString("classArmName"), rs.getBoolean("isAssigned"));
                classArm.setClassName(rs.getString("className"));
                classArms.add(classArm);
            }
        }
        return classArms;
    }

    public boolean updateClassArm(Connection con) throws SQLException {
        String query = "UPDATE tblclassarms SET classArmName = ?, isAssigned = ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, this.classArmName);
            ps.setBoolean(2, this.isAssigned);
            ps.setInt(3, this.id);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteClassArm(Connection con) throws SQLException {
        String query = "DELETE FROM tblclassarms WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, this.id);
            return ps.executeUpdate() > 0;
        }
    }
    
    public List<ClassArm> getClassArmsByClassId(Connection con, int classId) throws SQLException {
    List<ClassArm> classArms = new ArrayList<>();
    String query = "SELECT id, classId, classArmName, isAssigned FROM tblclassarms WHERE classId = ? ORDER BY classArmName";
    try (PreparedStatement ps = con.prepareStatement(query)) {
        ps.setInt(1, classId);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ClassArm classArm = new ClassArm(
                    rs.getInt("id"),
                    rs.getInt("classId"),
                    rs.getString("classArmName"),
                    rs.getBoolean("isAssigned")
                );
                classArms.add(classArm);
            }
        }
    }
    return classArms;
}
    
    
    public static int getTotalCalssArms(Connection con) throws SQLException {
        String query = "SELECT COUNT(*) AS totalClassArms FROM tblclassarms";
        try (PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("totalClassArms");
            }
        }
        return 0;
    }
}