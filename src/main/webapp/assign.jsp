<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phân Công Công Việc - TaskFlow Pro</title>
    <!-- Fonts & Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --primary: #4361ee;
            --sidebar-bg: #0f172a;
            --sidebar-width: 270px;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            color: #334155;
            min-height: 100vh;
        }

        .main-container {
            max-width: 860px;
            margin: 3rem auto;
            padding: 0 1.5rem;
        }

        .form-card {
            background: #ffffff;
            border-radius: 1.25rem;
            border: 1px solid #eef2f6;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.03);
            padding: 2.25rem;
        }

        .form-select, .form-control {
            border-radius: 0.75rem;
            padding: 0.8rem 1rem;
            border: 1px solid #e2e8f0;
            font-size: 0.95rem;
        }

        .form-select:focus, .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(67, 97, 238, 0.12);
        }

        .preview-box {
            background: #f8fafc;
            border: 1px dashed #cbd5e1;
            border-radius: 1rem;
            padding: 1.25rem;
            margin-top: 1.5rem;
        }
    </style>
</head>
<body>

<div class="main-container">
    <!-- Back to Dashboard -->
    <div class="mb-4">
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-light border rounded-pill px-3 py-1.5 small fw-semibold text-secondary d-inline-flex align-items-center gap-2">
            <i class="bi bi-arrow-left"></i> Quay lại Bảng Điều Khiển
        </a>
    </div>

    <div class="form-card">
        <div class="d-flex align-items-center gap-3 mb-4 pb-3 border-bottom">
            <div class="rounded-3 bg-primary-subtle text-primary p-3 fs-3">
                <i class="bi bi-person-check-fill"></i>
            </div>
            <div>
                <h4 class="fw-bold text-dark mb-1">Phân Công Nhân Sự</h4>
                <p class="text-muted small mb-0">Chỉ định thành viên phụ trách và xác lập tiến độ triển khai công việc</p>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/assign" method="POST">
            <!-- 1. CHỌN NHIỆM VỤ -->
            <div class="mb-3">
                <label class="form-label small fw-bold text-secondary">Chọn Nhiệm Vụ Cần Giao</label>
                <select name="taskId" id="taskSelector" class="form-select" required>
                    <option value="">-- Danh sách nhiệm vụ đang mở --</option>
                    <c:forEach items="${taskList}" var="t">
                        <option value="${t.id}" data-desc="${t.description}" data-deadline="${t.deadline}">
                            #${t.id} - ${t.taskName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- 2. CHỌN NHÂN VIÊN PHỤ TRÁCH -->
            <div class="mb-3">
                <label class="form-label small fw-bold text-secondary">Chỉ Định Nhân Sự Phụ Trách</label>
                <select name="employeeId" id="employeeSelector" class="form-select" required>
                    <option value="">-- Chọn thành viên phụ trách --</option>
                    <c:forEach items="${employeeList}" var="e">
                        <option value="${e.id}">${e.name} (ID: #${e.id})</option>
                    </c:forEach>
                </select>
            </div>

            <!-- 3. NGÀY PHÂN CÔNG -->
            <div class="mb-4">
                <label class="form-label small fw-bold text-secondary">Ngày Bắt Đầu Phân Công</label>
                <input type="date" name="assignedDate" id="assignDateInput" class="form-control" required>
            </div>

            <!-- SUBMIT BUTTONS -->
            <div class="d-flex justify-content-end gap-2 pt-3 border-top">
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-light border px-4 py-2 fw-semibold rounded-3">Hủy bỏ</a>
                <button type="submit" class="btn btn-primary px-4 py-2 fw-bold rounded-3 shadow-sm d-inline-flex align-items-center gap-2">
                    <i class="bi bi-check2-circle"></i> Xác Nhận Phân Công
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Tự động gán ngày hôm nay vào ô input date
    document.addEventListener("DOMContentLoaded", () => {
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('assignDateInput').value = today;
    });
</script>
</body>
</html>