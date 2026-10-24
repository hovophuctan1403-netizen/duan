<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TaskFlow Pro - Hệ Thống Điều Hành & Phân Công Nhiệm Vụ</title>
    <!-- Fonts & Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --primary: #4361ee;
            --primary-gradient: linear-gradient(135deg, #4361ee 0%, #3a0ca3 100%);
            --danger-gradient: linear-gradient(135deg, #ef4444 0%, #b91c1c 100%);
            --bg-canvas: #f8fafc;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-canvas);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow-x: hidden;
        }

        /* Ambient Glow Background Circles */
        .ambient-glow {
            position: absolute;
            border-radius: 50%;
            filter: blur(100px);
            opacity: 0.45;
            z-index: 0;
            pointer-events: none;
        }
        .glow-1 { width: 380px; height: 380px; background: #4361ee; top: -50px; left: -80px; }
        .glow-2 { width: 420px; height: 420px; background: #f43f5e; bottom: -80px; right: -80px; }

        .container-content {
            position: relative;
            z-index: 1;
            max-width: 960px;
        }

        .portal-card {
            background: #ffffff;
            border-radius: 1.5rem;
            border: 1px solid rgba(226, 232, 240, 0.8);
            box-shadow: 0 10px 30px -5px rgba(0, 0, 0, 0.04);
            padding: 2.5rem 2rem;
            transition: all 0.35s cubic-bezier(0.34, 1.56, 0.64, 1);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
        }

        .portal-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px -10px rgba(0, 0, 0, 0.1);
        }

        .portal-card.employee:hover { border-color: #4361ee; }
        .portal-card.admin:hover { border-color: #ef4444; }

        .portal-icon {
            width: 76px;
            height: 76px;
            border-radius: 1.25rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2.2rem;
            margin-bottom: 1.5rem;
            transition: transform 0.3s ease;
        }

        .portal-card:hover .portal-icon {
            transform: scale(1.1) rotate(4deg);
        }

        .btn-portal {
            padding: 0.85rem 1.5rem;
            border-radius: 0.85rem;
            font-weight: 700;
            font-size: 0.95rem;
            letter-spacing: 0.02em;
            transition: all 0.25s ease;
        }

        .btn-portal:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }
    </style>
</head>
<body>

<div class="ambient-glow glow-1"></div>
<div class="ambient-glow glow-2"></div>

<div class="container container-content py-5">
    <!-- Header Title -->
    <div class="text-center mb-5">
        <div class="d-inline-flex align-items-center gap-2 px-3 py-1.5 rounded-pill bg-white border shadow-sm mb-3">
            <span class="badge bg-primary rounded-pill px-2.5">v2.5</span>
            <span class="small fw-semibold text-secondary">Nền tảng Quản trị & Điều phối công việc thông minh</span>
        </div>
        <h1 class="fw-extrabold text-dark tracking-tight mb-2">HỆ THỐNG ĐIỀU HÀNH TASKFLOW</h1>
        <p class="text-muted fs-6 mb-0">Lựa chọn đúng cổng vai trò để thiết lập phiên làm việc được bảo mật</p>
    </div>

    <!-- Cards Row -->
    <div class="row g-4 justify-content-center">
        <!-- CỔNG NHÂN VIÊN -->
        <div class="col-md-6 col-lg-5">
            <div class="portal-card employee">
                <div>
                    <div class="portal-icon bg-primary-subtle text-primary">
                        <i class="bi bi-person-workspace"></i>
                    </div>
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <h4 class="fw-bold text-dark mb-0">CỔNG NHÂN VIÊN</h4>
                        <span class="badge bg-primary-subtle text-primary rounded-pill small">Nhân sự</span>
                    </div>
                    <p class="text-muted small lh-base mb-4">
                        Theo dõi danh sách nhiệm vụ được giao, cập nhật tiến độ công việc theo thời gian thực và tham gia đăng ký tài khoản thành viên mới.
                    </p>
                </div>
                <a href="${pageContext.request.contextPath}/login?role=EMPLOYEE" class="btn btn-primary btn-portal w-100 d-flex align-items-center justify-content-center gap-2 shadow-sm">
                    <span>Truy cập Cổng Nhân Viên</span>
                    <i class="bi bi-arrow-right"></i>
                </a>
            </div>
        </div>

        <!-- CỔNG QUẢN LÝ -->
        <div class="col-md-6 col-lg-5">
            <div class="portal-card admin">
                <div>
                    <div class="portal-icon bg-danger-subtle text-danger">
                        <i class="bi bi-shield-lock-fill"></i>
                    </div>
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <h4 class="fw-bold text-dark mb-0">CỔNG QUẢN LÝ</h4>
                        <span class="badge bg-danger-subtle text-danger rounded-pill small">Bảo mật cao</span>
                    </div>
                    <p class="text-muted small lh-base mb-4">
                        Toàn quyền giám sát chỉ số KPI, phân công nhiệm vụ cho nhân viên, quản trị phòng ban và bảo vệ an toàn với xác thực OTP 2 lớp.
                    </p>
                </div>
                <a href="${pageContext.request.contextPath}/login?role=ADMIN" class="btn btn-danger btn-portal w-100 d-flex align-items-center justify-content-center gap-2 shadow-sm">
                    <span>Truy cập Cổng Quản Lý</span>
                    <i class="bi bi-shield-check"></i>
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>