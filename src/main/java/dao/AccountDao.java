package dao;

import model.Account;
import util.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AccountDao {

    // 1. Kiểm tra đăng nhập (Trim sạch khoảng trắng)
    public Account checkLogin(String username, String password) {
        String sql = "SELECT * FROM Account WHERE LTRIM(RTRIM(username)) = ? AND LTRIM(RTRIM(password)) = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username.trim());
            ps.setString(2, password.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Account acc = new Account();
                    acc.setId(rs.getInt("id"));
                    acc.setUsername(rs.getString("username").trim());
                    acc.setPassword(rs.getString("password").trim());
                    acc.setFullname(rs.getNString("fullname"));
                    acc.setRole(rs.getString("role").trim());
                    return acc;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 2. Lấy tài khoản theo username
    public Account getByUsername(String username) {
        String sql = "SELECT * FROM Account WHERE LTRIM(RTRIM(username)) = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Account acc = new Account();
                    acc.setId(rs.getInt("id"));
                    acc.setUsername(rs.getString("username").trim());
                    acc.setPassword(rs.getString("password").trim());
                    acc.setFullname(rs.getNString("fullname"));
                    acc.setRole(rs.getString("role").trim());
                    return acc;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 3. Kiểm tra xem tài khoản đã tồn tại chưa
    public boolean checkUsernameExists(String username) {
        String sql = "SELECT 1 FROM Account WHERE LTRIM(RTRIM(username)) = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username.trim());
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 4. Đặt lại mật khẩu mới
    public boolean resetPassword(String username, String newPassword) {
        String sql = "UPDATE Account SET password = ? WHERE LTRIM(RTRIM(username)) = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword.trim());
            ps.setString(2, username.trim());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 5. Đăng ký tài khoản Nhân Viên
    public boolean register(Account acc) {
        String sql = "INSERT INTO Account (username, password, fullname, role) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, acc.getUsername().trim());
            ps.setString(2, acc.getPassword().trim());
            ps.setNString(3, acc.getFullname());
            ps.setString(4, "EMPLOYEE"); // Cố định chỉ tạo nhân viên
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}