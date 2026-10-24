<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - TaskFlow Manager</title>
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
            --theme-color: ${param.role == 'ADMIN' ? '#ef4444' : '#4361ee'};
            --theme-bg-subtle: ${param.role == 'ADMIN' ? '#fef2f2' : '#eef2ff'};
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
            position: relative;
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

        .form-control {
            border-radius: 0.75rem;
            padding: 0.75rem 1rem;
            border: 1px solid #e2e8f0;
            font-size: 0.95rem;
        }

        .form-control:focus {
            border-color: var(--theme-color);
            box-shadow: 0 0 0 4px rgba(67, 97, 238, 0.12);
        }

        .password-toggle-btn {
            border: 1px solid #e2e8f0;
            border-left: none;
            background: #ffffff;
            color: #64748b;
            border-radius: 0 0.75rem 0.75rem 0;
            padding: 0.75rem 1rem;
        }

        .password-toggle-btn:hover {
            color: #0f172a;
        }

        .btn-submit {
            background-color: var(--theme-color);
            border: none;
            border-radius: 0.75rem;
            padding: 0.85rem;
            font-weight: 700;
            font-size: 0.95rem;
            color: #ffffff;
            transition: all 0.25s ease;
        }

        .btn-submit:hover {
            opacity: 0.92;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            color: #ffffff;
        }
    </style>
</head>
<body>

<div class="auth-card">
    <!-- Top Header -->
    <div class="text-center">
        <div class="auth-icon-badge">
            <i class="bi ${param.role == 'ADMIN' ? 'bi-shield-lock-fill' : 'bi-person-badge-fill'}"></i>
        </div>
        <h4 class="fw-bold text-dark mb-1">
            ${param.role == 'ADMIN' ? 'Đăng Nhập Quản Lý' : 'Đăng Nhập Nhân Viên'}
        </h4>
        <span class="badge ${param.role == 'ADMIN' ? 'bg-danger-subtle text-danger' : 'bg-primary-subtle text-primary'} px-3 py-1 rounded-pill small fw-semibold">
            ${param.role == 'ADMIN' ? 'Cổng Quản Trị Hệ Thống' : 'Cổng Nhân Sự Vận Hành'}
        </span>
    </div>

    <!-- Alert Messages -->
    <div class="mt-4">
        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2.5 px-3 rounded-3 small d-flex align-items-center gap-2 border-0" role="alert">
                <i class="bi bi-exclamation-triangle-fill fs-6"></i>
                <div>${error}</div>
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success py-2.5 px-3 rounded-3 small d-flex align-items-center gap-2 border-0" role="alert">
                <i class="bi bi-check-circle-fill fs-6"></i>
                <div>${success}</div>
            </div>
        </c:if>
    </div>

    <!-- Form -->
    <form action="${pageContext.request.contextPath}/login" method="POST" class="mt-3">
        <input type="hidden" name="expectedRole" value="${param.role}">

        <div class="mb-3">
            <label class="form-label small fw-semibold text-secondary">Tên đăng nhập</label>
            <div class="input-group">
                <span class="input-group-text bg-white border-end-0 text-muted rounded-start-3"><i class="bi bi-person"></i></span>
                <input type="text" name="username" class="form-control border-start-0 rounded-end-3" placeholder="Nhập tên tài khoản" required autofocus>
            </div>
        </div>

        <div class="mb-3">
            <div class="d-flex justify-content-between align-items-center mb-1">
                <label class="form-label small fw-semibold text-secondary mb-0">Mật khẩu</label>
                <a href="${pageContext.request.contextPath}/forgot-password?role=${param.role}" class="small text-decoration-none fw-semibold" style="color: var(--theme-color);">
                    Quên mật khẩu?
                </a>
            </div>
            <div class="input-group">
                <span class="input-group-text bg-white border-end-0 text-muted rounded-start-3"><i class="bi bi-key"></i></span>
                <input type="password" id="loginPassword" name="password" class="form-control border-start-0 border-end-0" placeholder="Nhập mật khẩu" required>
                <button type="button" class="btn password-toggle-btn" id="togglePasswordBtn" title="Xem/Ẩn mật khẩu">
                    <i class="bi bi-eye" id="eyeIcon"></i>
                </button>
            </div>
        </div>

        <button type="submit" class="btn btn-submit w-100 mt-2 shadow-sm d-flex align-items-center justify-content-center gap-2">
            <span>Đăng Nhập Vào Hệ Thống</span>
            <i class="bi bi-box-arrow-in-right"></i>
        </button>
    </form>

    <!-- Footer Role Check -->
    <c:choose>
        <c:when test="${param.role != 'ADMIN'}">
            <div class="text-center mt-4">
                <span class="text-muted small">Bạn chưa có tài khoản?</span>
                <a href="${pageContext.request.contextPath}/register" class="fw-bold text-decoration-none small ms-1" style="color: var(--theme-color);">Đăng ký tài khoản</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-light border small text-muted text-center mt-4 mb-0 py-2 rounded-3">
                <i class="bi bi-shield-check me-1 text-danger"></i>Tài khoản Quản lý được cấp phát độc quyền.
            </div>
        </c:otherwise>
    </c:choose>

    <div class="text-center mt-3 pt-3 border-top">
        <a href="${pageContext.request.contextPath}/home" class="text-decoration-none small text-secondary d-inline-flex align-items-center gap-1">
            <i class="bi bi-arrow-left"></i> Quay lại chọn vai trò
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // ẨN / HIỆN MẬT KHẨU
    const toggleBtn = document.getElementById('togglePasswordBtn');
    const pwdInput = document.getElementById('loginPassword');
    const eyeIcon = document.getElementById('eyeIcon');

    toggleBtn.addEventListener('click', () => {
        const isPassword = pwdInput.type === 'password';
        pwdInput.type = isPassword ? 'text' : 'password';
        eyeIcon.className = isPassword ? 'bi bi-eye-slash' : 'bi bi-eye';
    });
</script>
</body>
</html>