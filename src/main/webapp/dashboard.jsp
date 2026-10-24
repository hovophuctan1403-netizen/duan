<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Manager - Bảng Điều Khiển</title>
    <!-- Fonts & Bootstrap 5 & Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --primary-soft: #eff6ff;
            --success: #10b981;
            --success-soft: #ecfdf5;
            --warning: #f59e0b;
            --warning-soft: #fffbeb;
            --danger: #ef4444;
            --danger-soft: #fef2f2;
            --card-border: #f1f5f9;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            color: #334155;
            min-height: 100vh;
        }

        /* TOP NAVBAR */
        .top-navbar {
            background-color: #0f172a;
            border-bottom: 1px solid #1e293b;
            padding: 0.85rem 1.5rem;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }

        .btn-menu-toggle {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.15);
            color: #ffffff;
            border-radius: 0.5rem;
            padding: 0.4rem 0.65rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.15rem;
            transition: all 0.2s ease;
        }

        .btn-menu-toggle:hover {
            background: rgba(255, 255, 255, 0.2);
            color: #ffffff;
        }

        .brand-logo {
            font-size: 1.15rem;
            font-weight: 700;
            color: #ffffff;
            display: flex;
            align-items: center;
            gap: 0.65rem;
            text-decoration: none;
        }

        .brand-icon-box {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            font-size: 1rem;
        }

        /* SIDEBAR OFFCANVAS (TRƯỢT MƯỢT TỪ BÊN TRÁI) */
        .offcanvas-sidebar {
            width: 270px !important;
            background-color: #0f172a !important;
            color: #94a3b8;
            border-right: 1px solid #1e293b;
        }

        .offcanvas-sidebar .offcanvas-header {
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            padding: 1.25rem 1.5rem;
        }

        .offcanvas-sidebar .nav-link-item {
            display: flex;
            align-items: center;
            gap: 0.85rem;
            padding: 0.75rem 1rem;
            color: #94a3b8;
            border-radius: 0.65rem;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s ease;
            margin-bottom: 0.35rem;
        }

        .offcanvas-sidebar .nav-link-item:hover {
            color: #ffffff;
            background: rgba(255, 255, 255, 0.08);
            transform: translateX(4px);
        }

        .offcanvas-sidebar .nav-link-item.active {
            color: #ffffff;
            background: var(--primary);
            box-shadow: 0 4px 14px rgba(37, 99, 235, 0.35);
        }

        .offcanvas-sidebar .user-bottom-box {
            padding: 1.25rem;
            border-top: 1px solid rgba(255, 255, 255, 0.08);
            background: rgba(0, 0, 0, 0.2);
        }

        /* KPI STAT CARDS */
        .stat-card {
            background: #ffffff;
            border-radius: 1.15rem;
            border: 1px solid var(--card-border);
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.03);
            padding: 1.4rem 1.5rem;
            position: relative;
            overflow: hidden;
            transition: all 0.28s ease;
            height: 100%;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 28px -4px rgba(0, 0, 0, 0.07);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
        }

        .stat-card.border-success-theme::before { background-color: var(--success); }
        .stat-card.border-primary-theme::before { background-color: var(--primary); }
        .stat-card.border-danger-theme::before { background-color: var(--danger); }

        .stat-icon-wrapper {
            width: 54px;
            height: 54px;
            border-radius: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
        }

        .stat-title {
            font-size: 0.76rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #64748b;
            margin-bottom: 0.4rem;
        }

        .stat-number {
            font-size: 2.2rem;
            font-weight: 800;
            line-height: 1;
        }

        /* FILTER TOOLBAR */
        .filter-wrapper {
            background: #ffffff;
            border-radius: 1.15rem;
            border: 1px solid var(--card-border);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
            padding: 1.15rem 1.35rem;
            margin-bottom: 1.75rem;
        }

        .form-control, .form-select {
            border-radius: 0.75rem;
            border: 1px solid #e2e8f0;
            padding: 0.65rem 0.95rem;
            font-size: 0.92rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
        }

        /* TABLE CARD */
        .table-card {
            background: #ffffff;
            border-radius: 1.25rem;
            border: 1px solid var(--card-border);
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.03);
            overflow: hidden;
        }

        .table-header-box {
            padding: 1.4rem 1.6rem;
            border-bottom: 1px solid #f1f5f9;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .table-custom {
            margin-bottom: 0;
            vertical-align: middle;
        }

        .table-custom thead th {
            background: #f8fafc;
            color: #475569;
            font-size: 0.78rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            padding: 1rem 1.4rem;
            border-bottom: 1px solid #e2e8f0;
            white-space: nowrap;
        }

        .table-custom tbody tr:hover {
            background-color: #f8fbff;
        }

        .table-custom tbody td {
            padding: 1.1rem 1.4rem;
            border-bottom: 1px solid #f1f5f9;
            white-space: nowrap;
        }

        .badge-project {
            background-color: #f1f5f9;
            color: #475569;
            font-weight: 600;
            padding: 0.4rem 0.75rem;
            border-radius: 0.55rem;
            font-size: 0.8rem;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
        }

        .badge-assignee {
            background-color: #ecfeff;
            color: #0891b2;
            border: 1px solid #cffafe;
            font-weight: 600;
            padding: 0.38rem 0.75rem;
            border-radius: 0.55rem;
            font-size: 0.82rem;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
        }

        .badge-unassigned {
            background-color: #f8fafc;
            color: #94a3b8;
            border: 1px solid #e2e8f0;
            font-weight: 500;
            padding: 0.38rem 0.75rem;
            border-radius: 0.55rem;
            font-size: 0.82rem;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
        }

        .badge-priority-high {
            background-color: #fef2f2;
            color: #dc2626;
            font-weight: 700;
            padding: 0.35rem 0.7rem;
            border-radius: 0.5rem;
            font-size: 0.78rem;
        }

        .badge-priority-medium {
            background-color: #fffbeb;
            color: #d97706;
            font-weight: 700;
            padding: 0.35rem 0.7rem;
            border-radius: 0.5rem;
            font-size: 0.78rem;
        }

        .badge-priority-low {
            background-color: #ecfdf5;
            color: #059669;
            font-weight: 700;
            padding: 0.35rem 0.7rem;
            border-radius: 0.5rem;
            font-size: 0.78rem;
        }

        .badge-status-progress {
            background-color: #eff6ff;
            color: #2563eb;
            font-weight: 700;
            padding: 0.4rem 0.85rem;
            border-radius: 2rem;
            font-size: 0.78rem;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
        }

        .badge-status-done {
            background-color: #ecfdf5;
            color: #059669;
            font-weight: 700;
            padding: 0.4rem 0.85rem;
            border-radius: 2rem;
            font-size: 0.78rem;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
        }

        .btn-assign-new {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            border: none;
            color: #ffffff;
            font-weight: 600;
            padding: 0.55rem 1.15rem;
            border-radius: 0.65rem;
            box-shadow: 0 4px 14px rgba(37, 99, 235, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
        }

        .btn-assign-new:hover {
            background: linear-gradient(135deg, #1d4ed8 0%, #1e40af 100%);
            color: #ffffff;
        }
    </style>
</head>
<body>

<!-- TOP NAVBAR -->
<header class="top-navbar">
    <div class="container-fluid px-3 d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center gap-3">
            <!-- NÚT 3 DẤU GẠCH MỞ THANH MENU BÊN TRÁI -->
            <button class="btn btn-menu-toggle" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarOffcanvas" aria-controls="sidebarOffcanvas" title="Mở danh mục điều hướng">
                <i class="bi bi-list fs-5"></i>
            </button>

            <a href="${pageContext.request.contextPath}/dashboard" class="brand-logo">
                <div class="brand-icon-box">
                    <i class="bi bi-kanban"></i>
                </div>
                <span>Task Manager</span>
            </a>
        </div>

        <!-- Bên phải: Người dùng & Đăng xuất -->
        <div class="d-flex align-items-center gap-3">
            <div class="d-flex align-items-center gap-2 text-white">
                <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center fw-bold" style="width: 32px; height: 32px; font-size: 0.85rem;">
                    ${not empty sessionScope.user ? sessionScope.user.username.substring(0,1).toUpperCase() : 'A'}
                </div>
                <div class="d-none d-sm-block text-start">
                    <div class="fw-semibold small leading-tight">${not empty sessionScope.user ? sessionScope.user.fullname : 'Quản Lý Trưởng'}</div>
                    <span class="badge ${sessionScope.user.role == 'ADMIN' ? 'bg-danger' : 'bg-primary'} px-1.5 py-0.5" style="font-size: 0.65rem;">
                        ${sessionScope.user.role == 'ADMIN' ? 'Quản Lý' : 'Nhân Viên'}
                    </span>
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-outline-danger border-0 text-white-50" title="Đăng xuất">
                <i class="bi bi-box-arrow-right fs-5"></i>
            </a>
        </div>
    </div>
</header>

<!-- THANH MENU OFFCANVAS TRƯỢT TỪ BÊN TRÁI (KHÔNG BAO GIỜ BỊ KẸT MÀN HÌNH ĐEN) -->
<div class="offcanvas offcanvas-start offcanvas-sidebar" tabindex="-1" id="sidebarOffcanvas" aria-labelledby="sidebarOffcanvasLabel">
    <div class="offcanvas-header d-flex justify-content-between align-items-center">
        <div class="d-flex align-items-center gap-2 text-white fw-bold fs-5" id="sidebarOffcanvasLabel">
            <div class="brand-icon-box">
                <i class="bi bi-kanban"></i>
            </div>
            <span>Task Manager</span>
        </div>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Đóng"></button>
    </div>

    <div class="offcanvas-body d-flex flex-column justify-content-between p-3">
        <!-- Danh mục menu điều hướng -->
        <ul class="nav flex-column mb-auto">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-link-item active">
                    <i class="bi bi-speedometer2 fs-5"></i>
                    <span>Tổng Quan</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employees" class="nav-link-item">
                    <i class="bi bi-people fs-5 text-warning"></i>
                    <span>Nhân Viên</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/projects" class="nav-link-item">
                    <i class="bi bi-folder2 fs-5 text-info"></i>
                    <span>Dự Án</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/tasks" class="nav-link-item">
                    <i class="bi bi-check2-square fs-5 text-success"></i>
                    <span>Công Việc</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/assign" class="nav-link-item">
                    <i class="bi bi-person-plus fs-5 text-danger"></i>
                    <span>Phân Công</span>
                </a>
            </li>
        </ul>

        <!-- Thông tin tài khoản phía dưới thanh menu -->
        <div class="user-bottom-box rounded-3 mt-4">
            <div class="d-flex align-items-center gap-2 mb-3">
                <div class="rounded-circle bg-info text-dark d-flex align-items-center justify-content-center fw-bold" style="width: 36px; height: 36px;">
                    <i class="bi bi-person-fill fs-5"></i>
                </div>
                <div>
                    <div class="fw-bold text-white small">${not empty sessionScope.user ? sessionScope.user.fullname : 'Quản Lý Trưởng'}</div>
                    <span class="badge bg-danger text-white py-0.5 px-2" style="font-size: 0.65rem;">Quản Lý</span>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm w-100 d-flex align-items-center justify-content-center gap-2">
                <i class="bi bi-box-arrow-right"></i> Đăng Xuất
            </a>
        </div>
    </div>
</div>

<!-- NỘI DUNG CHÍNH (MAIN CONTAINER) -->
<main class="container-fluid px-4 py-4" style="max-width: 1440px;">
    
    <!-- KPI STAT CARDS ROW -->
    <div class="row g-3 mb-4">
        <!-- Đã hoàn thành -->
        <div class="col-md-4">
            <div class="stat-card border-success-theme">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <div class="stat-title">CÔNG VIỆC HOÀN THÀNH</div>
                        <div class="stat-number text-success count-up" data-target="${completedCount != null ? completedCount : 0}">
                            ${completedCount != null ? completedCount : 0}
                        </div>
                    </div>
                    <div class="stat-icon-wrapper" style="background-color: var(--success-soft); color: var(--success);">
                        <i class="bi bi-check-lg"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Đang thực hiện -->
        <div class="col-md-4">
            <div class="stat-card border-primary-theme">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <div class="stat-title">ĐANG THỰC HIỆN</div>
                        <div class="stat-number text-primary count-up" data-target="${inProgressCount != null ? inProgressCount : 5}">
                            ${inProgressCount != null ? inProgressCount : 5}
                        </div>
                    </div>
                    <div class="stat-icon-wrapper" style="background-color: var(--primary-soft); color: var(--primary);">
                        <i class="bi bi-hourglass-split"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Đã quá hạn -->
        <div class="col-md-4">
            <div class="stat-card border-danger-theme">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <div class="stat-title">ĐÃ QUÁ HẠN</div>
                        <div class="stat-number text-danger count-up" data-target="${overdueCount != null ? overdueCount : 2}">
                            ${overdueCount != null ? overdueCount : 2}
                        </div>
                    </div>
                    <div class="stat-icon-wrapper" style="background-color: var(--danger-soft); color: var(--danger);">
                        <i class="bi bi-calendar-x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- FILTER TOOLBAR -->
    <div class="filter-wrapper">
        <div class="row g-2 align-items-center">
            <!-- Tìm theo nhân viên -->
            <div class="col-md-4">
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-person"></i></span>
                    <input type="text" id="filterEmployeeInput" class="form-control border-start-0 ps-0" placeholder="Tìm theo tên nhân viên...">
                </div>
            </div>

            <!-- Tìm theo dự án -->
            <div class="col-md-4">
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-folder2"></i></span>
                    <input type="text" id="filterProjectInput" class="form-control border-start-0 ps-0" placeholder="Tìm theo tên dự án...">
                </div>
            </div>

            <!-- Trạng thái -->
            <div class="col-md-3">
                <select id="filterStatusSelect" class="form-select text-secondary">
                    <option value="">-- Tất cả --</option>
                    <option value="Đang thực hiện">Đang thực hiện</option>
                    <option value="Hoàn thành">Hoàn thành</option>
                    <option value="Tạm hoãn">Tạm hoãn</option>
                </select>
            </div>

            <!-- Nút tìm kiếm -->
            <div class="col-md-1 d-flex gap-1">
                <button type="button" id="triggerSearchBtn" class="btn btn-primary w-100 fw-semibold" title="Tìm kiếm">
                    <i class="bi bi-search"></i>
                </button>
            </div>
        </div>
    </div>

    <!-- TABLE CARD -->
    <div class="table-card">
        <div class="table-header-box">
            <h5 class="fw-bold text-dark mb-0">Tiến Độ Công Việc Toàn Bộ</h5>
            <a href="${pageContext.request.contextPath}/assign" class="btn-assign-new">
                <i class="bi bi-plus-lg"></i>
                <span>Phân công mới</span>
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-custom">
                <thead>
                    <tr>
                        <th style="width: 60px;">#</th>
                        <th>CÔNG VIỆC</th>
                        <th>DỰ ÁN</th>
                        <th>NGƯỜI PHỤ TRÁCH</th>
                        <th>HẠN CHÓT</th>
                        <th>MỨC ƯU TIÊN</th>
                        <th>TRẠNG THÁI</th>
                        <th class="text-end pe-4" style="width: 90px;">THAO TÁC</th>
                    </tr>
                </thead>
                <tbody id="taskTableBody">
                    <c:choose>
                        <c:when test="${not empty taskList}">
                            <c:forEach items="${taskList}" var="t">
                                <tr class="task-row-item" 
                                    data-taskname="${t.taskName.toLowerCase()}" 
                                    data-employee="${t.employeeName != null ? t.employeeName.toLowerCase() : ''}"
                                    data-project="${t.projectName != null ? t.projectName.toLowerCase() : ''}" 
                                    data-status="${t.status}">
                                    
                                    <td class="text-muted fw-bold">#${t.id}</td>

                                    <td>
                                        <div class="fw-bold text-dark fs-6">${t.taskName}</div>
                                        <c:if test="${not empty t.description}">
                                            <div class="text-muted small text-truncate" style="max-width: 280px;">
                                                ${t.description}
                                            </div>
                                        </c:if>
                                    </td>

                                    <td>
                                        <span class="badge-project">
                                            <i class="bi bi-folder2"></i>
                                            <span>${not empty t.projectName ? t.projectName : 'Website E-Commerce'}</span>
                                        </span>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty t.employeeName}">
                                                <span class="badge-assignee">
                                                    <i class="bi bi-person-fill"></i>
                                                    <span>${t.employeeName}</span>
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-unassigned">
                                                    <i class="bi bi-person-dash"></i>
                                                    <span>Chưa phân công</span>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <div class="small fw-semibold text-secondary">
                                            ${t.deadline}
                                        </div>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${t.priority == 'Cao' || t.priority == 'High'}">
                                                <span class="badge-priority-high">Cao</span>
                                            </c:when>
                                            <c:when test="${t.priority == 'Trung bình' || t.priority == 'Medium'}">
                                                <span class="badge-priority-medium">Trung bình</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-priority-low">Thấp</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${t.status == 'Hoàn thành'}">
                                                <span class="badge-status-done">
                                                    <i class="bi bi-check2-circle"></i> Hoàn thành
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-status-progress">
                                                    <i class="bi bi-arrow-repeat"></i> Đang thực hiện
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td class="text-end pe-4">
                                        <a href="${pageContext.request.contextPath}/assign?taskId=${t.id}" class="btn btn-sm btn-light border text-primary" title="Phân công nhân sự">
                                            <i class="bi bi-person-plus"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="8" class="text-center py-5 text-muted">
                                    <i class="bi bi-inbox fs-2 d-block mb-2"></i>
                                    Chưa có công việc nào được ghi nhận.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</main>

<!-- JAVASCRIPT BOOTSTRAP 5 & LOGIC BỘ LỌC TỨC THÌ -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        // Count-up
        const counters = document.querySelectorAll('.count-up');
        counters.forEach(counter => {
            const target = +counter.getAttribute('data-target');
            if (target === 0) return;
            let current = 0;
            const step = Math.max(1, Math.ceil(target / 15));
            const timer = setInterval(() => {
                current += step;
                if (current >= target) {
                    counter.innerText = target;
                    clearInterval(timer);
                } else {
                    counter.innerText = current;
                }
            }, 35);
        });

        // Instant Filter
        const empInput = document.getElementById('filterEmployeeInput');
        const projInput = document.getElementById('filterProjectInput');
        const statusSelect = document.getElementById('filterStatusSelect');
        const searchBtn = document.getElementById('triggerSearchBtn');
        const rows = document.querySelectorAll('.task-row-item');

        function executeFilter() {
            const empVal = empInput.value.toLowerCase().trim();
            const projVal = projInput.value.toLowerCase().trim();
            const statusVal = statusSelect.value.trim();

            rows.forEach(row => {
                const rowEmp = row.getAttribute('data-employee') || '';
                const rowProj = row.getAttribute('data-project') || '';
                const rowStatus = row.getAttribute('data-status') || '';

                const matchEmp = !empVal || rowEmp.includes(empVal);
                const matchProj = !projVal || rowProj.includes(projVal);
                const matchStatus = !statusVal || rowStatus === statusVal;

                if (matchEmp && matchProj && matchStatus) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        empInput.addEventListener('input', executeFilter);
        projInput.addEventListener('input', executeFilter);
        statusSelect.addEventListener('change', executeFilter);
        searchBtn.addEventListener('click', executeFilter);
    });
</script>
</body>
</html>