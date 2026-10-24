package controller;

import dao.AccountDao;
import model.Account;
import util.EmailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Random;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {
    private AccountDao accountDao = new AccountDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lưu lại vai trò từ query param (EMPLOYEE hoặc ADMIN)
        String role = request.getParameter("role");
        request.setAttribute("role", role);
        request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String currentRole = request.getParameter("role");
        HttpSession session = request.getSession();

        // BƯỚC 1: XÁC THỰC TÀI KHOẢN
        if ("sendOtp".equals(action)) {
            String username = request.getParameter("username");
            if (username != null) username = username.trim();

            Account acc = accountDao.getByUsername(username);

            if (acc == null) {
                request.setAttribute("error", "Tên tài khoản không tồn tại trên hệ thống!");
                request.setAttribute("role", currentRole);
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                return;
            }

            // Kiểm tra nếu người dùng vào nhầm cổng (ví dụ: đang ở cổng Nhân viên nhưng lại gõ tk Admin)
            if (currentRole != null && !currentRole.trim().isEmpty()) {
                if (!currentRole.trim().equalsIgnoreCase(acc.getRole().trim())) {
                    String roleName = "ADMIN".equalsIgnoreCase(currentRole) ? "Quản Lý" : "Nhân Viên";
                    request.setAttribute("error", "Tài khoản này không thuộc nhóm " + roleName + "!");
                    request.setAttribute("role", currentRole);
                    request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                    return;
                }
            }

            session.setAttribute("reset_user", acc);
            request.setAttribute("role", acc.getRole());

            // NẾU LÀ ADMIN: GỬI MÃ OTP VỀ GMAIL
            if ("ADMIN".equalsIgnoreCase(acc.getRole())) {
                String otp = String.format("%06d", new Random().nextInt(999999));
                session.setAttribute("admin_otp", otp);

                boolean isSent = EmailService.sendOtp(EmailService.ADMIN_EMAIL, otp);
                if (isSent) {
                    request.setAttribute("msg", "Mã xác thực OTP đã được gửi đến: " + EmailService.ADMIN_EMAIL);
                    request.setAttribute("step", "verifyOtp");
                } else {
                    request.setAttribute("error", "Không thể gửi OTP qua email! Kiểm tra lại kết nối mạng hoặc mật khẩu ứng dụng.");
                }
            } else {
                // NẾU LÀ NHÂN VIÊN: BỎ QUA OTP, CHUYỂN THẲNG ĐẾN ĐỔI MẬT KHẨU MỚI
                request.setAttribute("step", "resetPass");
                request.setAttribute("msg", "Xác nhận tài khoản " + acc.getUsername() + " thành công. Hãy nhập mật khẩu mới.");
            }

            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        // BƯỚC 2: ĐỔI MẬT KHẨU
        if ("confirmReset".equals(action)) {
            Account acc = (Account) session.getAttribute("reset_user");
            if (acc == null) {
                response.sendRedirect(request.getContextPath() + "/forgot-password");
                return;
            }

            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (newPassword == null || !newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu xác nhận không trùng khớp!");
                request.setAttribute("role", acc.getRole());
                request.setAttribute("step", "ADMIN".equalsIgnoreCase(acc.getRole()) ? "verifyOtp" : "resetPass");
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                return;
            }

            // NẾU LÀ ADMIN: KIỂM TRA MÃ OTP
            if ("ADMIN".equalsIgnoreCase(acc.getRole())) {
                String inputOtp = request.getParameter("otp");
                String sessionOtp = (String) session.getAttribute("admin_otp");

                if (sessionOtp == null || !sessionOtp.trim().equals(inputOtp != null ? inputOtp.trim() : "")) {
                    request.setAttribute("error", "Mã OTP không chính xác!");
                    request.setAttribute("role", acc.getRole());
                    request.setAttribute("step", "verifyOtp");
                    request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                    return;
                }
            }

            // CẬP NHẬT MẬT KHẨU MỚI VÀO CSDL
            if (accountDao.resetPassword(acc.getUsername(), newPassword)) {
                String userRole = acc.getRole();
                session.removeAttribute("reset_user");
                session.removeAttribute("admin_otp");

                request.setAttribute("success", "Đặt lại mật khẩu thành công! Hãy đăng nhập lại.");
                // Chuyển hướng đúng về form đăng nhập theo vai trò của người dùng
                request.getRequestDispatcher("/login.jsp?role=" + userRole).forward(request, response);
            } else {
                request.setAttribute("error", "Lỗi cập nhật CSDL!");
                request.setAttribute("role", acc.getRole());
                request.setAttribute("step", "ADMIN".equalsIgnoreCase(acc.getRole()) ? "verifyOtp" : "resetPass");
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            }
        }
    }
}