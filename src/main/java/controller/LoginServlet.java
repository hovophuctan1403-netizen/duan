package controller;

import dao.AccountDao;
import model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    private AccountDao accountDao = new AccountDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String u = request.getParameter("username");
        String p = request.getParameter("password");
        String expectedRole = request.getParameter("expectedRole");

        if (u != null) u = u.trim();
        if (p != null) p = p.trim();

        Account acc = accountDao.checkLogin(u, p);

        if (acc != null) {
            // Kiểm tra phân quyền đúng cổng
            if (expectedRole != null && !expectedRole.trim().isEmpty()) {
                if (!expectedRole.trim().equalsIgnoreCase(acc.getRole().trim())) {
                    String roleName = "ADMIN".equalsIgnoreCase(expectedRole) ? "Quản Lý" : "Nhân Viên";
                    request.setAttribute("error", "Tài khoản không thuộc quyền " + roleName + "!");
                    request.getRequestDispatcher("/login.jsp?role=" + expectedRole).forward(request, response);
                    return;
                }
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", acc);
            response.sendRedirect(request.getContextPath() + "/dashboard");
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            request.getRequestDispatcher("/login.jsp" + (expectedRole != null ? "?role=" + expectedRole : "")).forward(request, response);
        }
    }
}