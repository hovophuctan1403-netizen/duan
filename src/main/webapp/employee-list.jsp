<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Manager - Quản Lý Nhân Viên</title>
    <!-- Fonts & Bootstrap 5 & Bootstrap Icons -->
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

        /* SIDEBAR OFFCANVAS */
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

        /* FORM CARD */
        .custom-card {
            background: #ffffff;
            border-radius: 1.15rem;
            border: 1px solid var(--card-border);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
            overflow: hidden;
            height: 100%;
        }

        .form-header-bar {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: #ffffff;
            padding: 1.15rem 1.5rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.65rem;
        }

        .form-control, .form-select {
            border-radius: 0.75rem;
            border: 1px solid #e2e8f0;
            padding: 0.65rem 0.95rem;
            font-size: 0.92rem;
            transition: all 0.2s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
        }

        .btn-submit-custom {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            border: none;
            color: #ffffff;
            font-weight: 700;
            padding: 0.75rem 1.25rem;
            border-radius: 0.75rem;
            transition: all 0.25s ease;
            box-shadow: 0 4px 14px rgba(37, 99, 235, 0.25);
        }

        .btn-submit-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(37, 99, 235, 0.35);
            color: #ffffff;
        }

        /* TABLE VIEW */
        .table-custom thead th {
            background: #f8fafc;
            color: #475569;
            font-size: 0.78rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            padding: 1rem 1.25rem;
            border-bottom: 1px solid #e2e8f0;
            white-space: nowrap;
        }

        .table-custom tbody td {
            padding: 1rem 1.25rem;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
            white-space: nowrap;
        }

        .table-custom tbody tr:hover {
            background-color: #f8fbff;
        }

        .emp-avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: #eef2ff;
            color: #2563eb;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 0.88rem;
            border: 1px solid #e0e7ff;
        }

        .role-badge {
            background: #f1f5f9;
            color: #334155;
            font-weight: 600;
            padding: 0.35rem 0.75rem;
            border-radius: 0.5rem;
            font-size: 0.8rem;
            border: 1px solid #e2e8f0;
        }

        .btn-edit-action {
            color: #d97706;
            border: 1px solid #fde68a;
            background-color: #fffbeb;
            padding: 0.35rem 0.7rem;
            border-radius: 0.5rem;
            font-size: 0.82rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .btn-edit-action:hover {
            background-color: #fef3c7;
            color: #b45309;
        }

        .btn-delete-action {
            color: #dc2626;
            border: 1px solid #fecaca;
            background-color: #fef2f2;
            padding: 0.35rem 0.7rem;
            border-radius: 0.5rem;
            font-size: 0.82rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .btn-delete-action:hover {
            background-color: #fee2e2;
            color: #991b1b;
        }
    </style>
</head>
<body>

<!-- TOP NAVBAR -->
<header class="top-navbar">
    <div class="container-fluid px-3 d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center gap-3">
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

<!-- THANH MENU OFFCANVAS TRƯỢT TỪ BÊN TRÁI -->
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
        <ul class="nav flex-column mb-auto">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-link-item">
                    <i class="bi bi-speedometer2 fs-5"></i>
                    <span>Tổng Quan</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employees" class="nav-link-item active">
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

<!-- NỘI DUNG CHÍNH -->
<main class="container-fluid px-4 py-4" style="max-width: 1440px;">
    <div class="row g-4">
        
        <!-- CỘT TRÁI: FORM THÊM / CẬP NHẬT NHÂN VIÊN MỚI -->
        <div class="col-lg-4 col-md-5">
            <div class="custom-card">
                <div class="form-header-bar">
                    <i class="bi bi-person-plus-fill fs-5"></i>
                    <span>Thêm Nhân Viên Mới</span>
                </div>
                <div class="p-4">
                    <form action="${pageContext.request.contextPath}/employees" method="POST">
                        <input type="hidden" name="action" value="insert">

                        <div class="mb-3">
                            <label class="form-label small fw-bold text-secondary">Họ và tên</label>
                            <input type="text" name="name" class="form-control" placeholder="VD: Nguyễn Văn A" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-bold text-secondary">Email</label>
                            <input type="email" name="email" class="form-control" placeholder="VD: an.nv@company.com" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-bold text-secondary">Số điện thoại</label>
                            <input type="text" name="phone" class="form-control" placeholder="VD: 0901234567">
                        </div>

                        <div class="mb-4">
                            <label class="form-label small fw-bold text-secondary">Vị trí / Chức vụ</label>
                            <select name="position" class="form-select">
                                <option value="Backend Developer">Backend Developer</option>
                                <option value="Frontend Developer">Frontend Developer</option>
                                <option value="Project Manager">Project Manager</option>
                                <option value="Tester">Tester</option>
                                <option value="UI/UX Designer">UI/UX Designer</option>
                            </select>
                        </div>

                        <button type="submit" class="btn btn-submit-custom w-100 d-flex align-items-center justify-content-center gap-2">
                            <i class="bi bi-floppy"></i>
                            <span>Lưu Nhân Viên</span>
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- CỘT PHẢI: BẢNG DANH SÁCH NHÂN VIÊN -->
        <div class="col-lg-8 col-md-7">
            <div class="custom-card">
                <!-- Header bảng kèm bộ đếm & tìm kiếm -->
                <div class="p-3 border-bottom d-flex flex-wrap align-items-center justify-content-between gap-3">
                    <div class="d-flex align-items-center gap-2">
                        <h5 class="fw-bold text-dark mb-0">Danh Sách Nhân Viên</h5>
                        <span class="badge bg-secondary-subtle text-secondary rounded-pill px-2.5 py-1 small fw-bold">
                            ${not empty employeeList ? employeeList.size() : 0} nhân sự
                        </span>
                    </div>

                    <!-- Ô tìm kiếm tức thì -->
                    <div style="max-width: 260px; width: 100%;">
                        <div class="input-group input-group-sm">
                            <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-search"></i></span>
                            <input type="text" id="empSearchInput" class="form-control border-start-0 ps-0" placeholder="Tìm theo tên, email...">
                        </div>
                    </div>
                </div>

                <!-- Bảng dữ liệu -->
                <div class="table-responsive">
                    <table class="table table-custom mb-0">
                        <thead>
                            <tr>
                                <th style="width: 60px;">#ID</th>
                                <th>HỌ TÊN</th>
                                <th>LIÊN HỆ</th>
                                <th>CHỨC VỤ</th>
                                <th class="text-end pe-4" style="width: 140px;">THAO TÁC</th>
                            </tr>
                        </thead>
                        <tbody id="empTableBody">
                            <c:choose>
                                <c:when test="${not empty employeeList}">
                                    <c:forEach items="${employeeList}" var="e">
                                        <tr class="emp-row" 
                                            data-name="${e.name.toLowerCase()}" 
                                            data-email="${e.email != null ? e.email.toLowerCase() : ''}"
                                            data-phone="${e.phone != null ? e.phone : ''}">
                                            
                                            <td class="text-muted fw-bold">#${e.id}</td>

                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <div class="emp-avatar">
                                                        ${e.name.substring(0,1).toUpperCase()}
                                                    </div>
                                                    <span class="fw-bold text-dark">${e.name}</span>
                                                </div>
                                            </td>

                                            <td>
                                                <div class="small text-secondary mb-1">
                                                    <i class="bi bi-envelope me-1 text-primary"></i>${not empty e.email ? e.email : 'Chưa cập nhật'}
                                                </div>
                                                <div class="small text-muted">
                                                    <i class="bi bi-telephone me-1 text-success"></i>${not empty e.phone ? e.phone : 'Chưa có SĐT'}
                                                </div>
                                            </td>

                                            <td>
                                                <span class="role-badge">
                                                    ${not empty e.position ? e.position : 'Kỹ sư phát triển'}
                                                </span>
                                            </td>

                                            <td class="text-end pe-4">
                                                <div class="d-inline-flex gap-2">
                                                    <a href="${pageContext.request.contextPath}/employees?action=edit&id=${e.id}" class="btn-edit-action" title="Chỉnh sửa">
                                                        <i class="bi bi-pencil-square me-1"></i>Sửa
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/employees?action=delete&id=${e.id}" 
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa nhân viên #${e.id} - ${e.name}?');" 
                                                       class="btn-delete-action" title="Xóa">
                                                        <i class="bi bi-trash3 me-1"></i>Xóa
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="text-center py-5 text-muted">
                                            <i class="bi bi-people fs-2 d-block mb-2"></i>
                                            Chưa có dữ liệu nhân viên nào.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // BỘ LỌC TÌM KIẾM NHÂN VIÊN THỜI GIAN THỰC
    document.addEventListener("DOMContentLoaded", () => {
        const searchInput = document.getElementById('empSearchInput');
        const rows = document.querySelectorAll('.emp-row');

        searchInput.addEventListener('input', () => {
            const query = searchInput.value.toLowerCase().trim();
            rows.forEach(row => {
                const name = row.getAttribute('data-name') || '';
                const email = row.getAttribute('data-email') || '';
                const phone = row.getAttribute('data-phone') || '';

                if (!query || name.includes(query) || email.includes(query) || phone.includes(query)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    });
</script>
</body>
</html>