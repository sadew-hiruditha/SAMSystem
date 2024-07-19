package app.java;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Admin {
    
    private int id;
    private String className;

    public Admin() {}

    public Admin(String className) {
        this.className = className;
    }

    public Admin(int id, String className) {
        this.id = id;
        this.className = className;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public boolean classExists(Connection con) throws SQLException {
        String query = "SELECT COUNT(*) FROM tblclass WHERE className = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, this.className);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public boolean addClass(Connection con) {
        try {
            if (classExists(con)) {
                return false; // Class already exists
            }

            String query = "INSERT INTO tblclass (className) VALUES (?)";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setString(1, this.className);
                int result = ps.executeUpdate();
                return result > 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Admin.class.getName()).log(Level.SEVERE, "Error adding class", ex);
            ex.printStackTrace();
            return false;
        }
    }

    public List<Admin> getAllClasses(Connection con) throws SQLException {
        List<Admin> classes = new ArrayList<>();
        String query = "SELECT id, className FROM tblclass ORDER BY id";
        try (PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                classes.add(new Admin(rs.getInt("id"), rs.getString("className")));
            }
        }
        return classes;
    }

    public boolean updateClass(Connection con) throws SQLException {
        String query = "UPDATE tblclass SET className = ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, this.className);
            ps.setInt(2, this.id);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteClass(Connection con) throws SQLException {
        String query = "DELETE FROM tblclass WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, this.id);
            return ps.executeUpdate() > 0;
        }
    }
}