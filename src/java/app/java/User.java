package app.java;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class User {

    private int id;
    private String firstName;
    private String lastName;
    private String username;
    private String role;
    private String NIC;
    private String PassWord;
    private String confirmPassword;

    public User(String username, String PassWord) {
        this.username = username;
        this.PassWord = MD5.getMD5(PassWord);
    }

    public User(String firstName, String lastName, String username, String role, String NIC, String PassWord, String confirmPassword) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.username = username;
        this.role = role;
        this.NIC = NIC;
        this.PassWord = MD5.getMD5(PassWord);
        this.confirmPassword = confirmPassword;
    }

    // Getters and Setters
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getNIC() {
        return NIC;
    }

    public void setNIC(String NIC) {
        this.NIC = NIC;
    }

    public String getPassWord() {
        return PassWord;
    }

    public void setPassWord(String PassWord) {
        this.PassWord = MD5.getMD5(PassWord);
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public boolean register(Connection con) throws SQLException {
        try {
            String query = "INSERT INTO users (first_name, last_name, username, role, nic, password) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(query);

            pstmt.setString(1, this.firstName);
            pstmt.setString(2, this.lastName);
            pstmt.setString(3, this.username);
            pstmt.setString(4, this.role);
            pstmt.setString(5, this.NIC);
            pstmt.setString(6, this.PassWord);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, "Error registering user", ex);
            throw ex;
        }
    }

    public boolean authenticate(Connection con) throws SQLException {
        try {

            String query = "SELECT id, password FROM users WHERE username = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String db_password = rs.getString("PassWord");
                if (db_password.equals(this.PassWord)) {
                    int user_id = rs.getInt("id");
                    this.setId(user_id);
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }

        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public boolean retrieveUserDetails(Connection con) throws SQLException {
    String query = "SELECT first_name, last_name, role FROM users WHERE id = ?";
    try (PreparedStatement pstmt = con.prepareStatement(query)) {
        pstmt.setInt(1, this.id);
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                this.firstName = rs.getString("first_name");
                this.lastName = rs.getString("last_name");
                this.role = rs.getString("role");
                return true;
            }
        }
    }
    return false;
}
    
    
    
}
