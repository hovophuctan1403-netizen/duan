<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khôi Phục Mật Khẩu - TaskFlow Pro</title>
    <!-- Fonts & Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --primary: #4361ee;
            --danger: #ef4444;
            --theme-color: ${role == 'ADMIN' || param.role == 'ADMIN' ? '#ef4444' : '#4361ee'};
            --theme-bg-subtle: ${role == 'ADMIN' || param.role == 'ADMIN' ? '#fef2f2' : '#eef2ff'};
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .auth-card {
            width: 100%;
            max-width: 440px;
            background: #ffffff;
            border-radius: 1.5rem;
            border: 1px solid #f1f5f9;
            box-shadow: 0 12px 35px -5px rgba(0, 0, 0, 0.05);
            padding: 2.5rem 2rem;
        }

        .auth-icon-badge {
            width: 64px;
            height: 64px;
            border-radius: 1rem;
            background-color: var(--theme-bg-subtle);
            color: var(--theme-color);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.85rem;
            margin-bottom: 1.25rem;
        }

        .otp-input {
            letter-spacing: 0.35em;
            font-size: 1.5rem;
            font-weight: 700;
            text-align: center;
            border: 2px dashed #cbd5e1;
            border-radius: 0.85rem;
            padding: 0.75rem;
            color: var(--theme-color);
        }

        .otp-input:focus {
            border-color: var(--theme-color);
            border-style: solid;
            box-shadow: 0 0 0 4px rgba(239, 68, 68, 0.12);
        }
    </style>
</head>
<body>

<c:set var="userRole" value="${not empty role ? role : param.role}" />

<div class="auth-card">
    <div class="text-center">
        <div class="auth-icon-badge">
            <i class="bi ${userRole == 'ADMIN' ? 'bi-shield-check' : 'bi-key-fill'}"></i>
        </div>
        <h4 class="fw-bold text-dark mb-1">
            ${userRole == 'ADMIN' ? 'Đổi Mật Khẩu Quản Lý' : 'Đổi Mật Khẩu Nhân Viên'}
        </h4>
        <p class="text-muted small mb-0">
            ${userRole == 'ADMIN' ? 'Xác thực OTP an toàn qua Email Quản Trị' : 'Khôi phục mật khẩu tài khoản thành viên'}
        </p>
    </div>

    <!-- Alert Messages -->
    <div class="mt-4">
        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2.5 px-3 rounded-3 small d-flex align-items-center gap-2 border-0">
                <i class="bi bi-exclamation-triangle-fill"></i>
                <div>${error}</div>
            </div>
        </c:if>
        <c:if test="${not empty msg}">
            <div class="alert alert-success py-2.5 px-3 rounded-3 small d-flex align-items-center gap-2 border-0">
                <i class="bi bi-check-circle-fill"></i>
                <div>${msg}</div>
            </div>
        </c:if>
    </div>

    <c:choose>
        <%-- BƯỚC 1: NHẬP USERNAME --%>
        <c:when test="${empty step}">
            <form action="${pageContext.request.contextPath}/forgot-password" method="POST" class="mt-3">
                <input type="hidden" name="action" value="sendOtp">
                <input type="hidden" name="role" value="${userRole}">

                <div class="mb-3">
                    <label class="form-label small fw-semibold text-secondary">
                        ${userRole == 'ADMIN' ? 'Tài khoản Quản trị' : 'Tên tài khoản Nhân viên'}
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-person"></i></span>
                        <input type="text" name="username" class="form-control border-start-0" placeholder="Nhập tên đăng nhập" required autofocus>
                    </div>
                    <c:if test="${userRole == 'ADMIN'}">
                        <small class="text-muted d-block mt-1"><i class="bi bi-envelope me-1"></i>OTP sẽ gửi về: <b>hovophuctan1403@gmail.com</b></small>
                    </c:if>
                </div>

                <button type="submit" class="btn w-100 py-2.5 fw-bold text-white shadow-sm mt-2 rounded-3" style="background-color: var(--theme-color);">
                    Tiếp Tục <i class="bi bi-arrow-right ms-1"></i>
                </button>
            </form>
        </c:when>

        <%-- BƯỚC 2: NHẬP OTP (NẾU LÀ ADMIN) VÀ MẬT KHẨU MỚI --%>
        <c:otherwise>
            <form action="${pageContext.request.contextPath}/forgot-password" method="POST" class="mt-3">
                <input type="hidden" name="action" value="confirmReset">
                <input type="hidden" name="role" value="${userRole}">

                <c:if test="${step == 'verifyOtp'}">
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-danger">Nhập mã xác thực OTP (6 chữ số từ Gmail)</label>
                        <input type="text" name="otp" class="form-control otp-input" placeholder="••••••" maxlength="6" required autofocus>
                        <small class="text-muted d-block mt-1 text-center">Kiểm tra hộp thư đến hoặc thư mục Spam</small>
                    </div>
                </c:if>

                <div class="mb-3">
                    <label class="form-label small fw-semibold text-secondary">Mật khẩu mới</label>
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-lock"></i></span>
                        <input type="password" name="newPassword" class="form-control border-start-0" placeholder="Nhập mật khẩu mới" required ${step != 'verifyOtp' ? 'autofocus' : ''}>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label small fw-semibold text-secondary">Xác nhận lại mật khẩu mới</label>
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" name="confirmPassword" class="form-control border-start-0" placeholder="Nhập lại mật khẩu mới" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-success w-100 py-2.5 fw-bold shadow-sm rounded-3">
                    <i class="bi bi-check2-circle me-1"></i> Xác Nhận Đổi Mật Khẩu
                </button>
            </form>
        </c:otherwise>
    </c:choose>

    <div class="text-center mt-4 pt-3 border-top">
        <a href="${pageContext.request.contextPath}/login?role=${userRole}" class="text-decoration-none small text-secondary d-inline-flex align-items-center gap-1">
            <i class="bi bi-arrow-left"></i> Quay lại Đăng Nhập
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>