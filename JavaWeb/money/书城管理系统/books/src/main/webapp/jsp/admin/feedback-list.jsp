<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>反馈管理 - 书城管理系统</title>
    <style>
        .container {
            margin-top: 130px;
            padding: 20px;
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .search-box {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
            align-items: center;
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .search-box input {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 300px;
            font-size: 14px;
        }
        
        .search-box select {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .btn-sm { padding: 6px 12px; }
        
        .btn-primary { background-color: #007bff; }
        .btn-primary:hover { background-color: #0056b3; }
        .btn-success { background-color: #28a745; }
        .btn-success:hover { background-color: #218838; }
        .btn-warning { background-color: #ffc107; color: #000; }
        .btn-warning:hover { background-color: #e0a800; }
        .btn-danger { background-color: #dc3545; }
        .btn-danger:hover { background-color: #c82333; }
        
        .feedback-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        
        .feedback-table th,
        .feedback-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .feedback-table th {
            background-color: #f8f9fa;
            font-weight: 500;
        }
        
        .feedback-table tr:hover { background-color: #f8f9fa; }
        
        .status-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status-pending { background-color: #fff3cd; color: #856404; }
        .status-processing { background-color: #cce5ff; color: #004085; }
        .status-completed { background-color: #d4edda; color: #155724; }
        .status-closed { background-color: #f8d7da; color: #721c24; }
        
        .type-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .type-system { background-color: #e9ecef; color: #495057; }
        .type-service { background-color: #e3f2fd; color: #0d47a1; }
        .type-other { background-color: #f3e5f5; color: #4a148c; }
        
        .reply-form {
            margin-top: 10px;
            display: none;
            background-color: #f8f9fa;
            padding: 10px;
            border-radius: 4px;
        }
        
        .reply-form textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 10px;
            min-height: 60px;
        }
        
        .empty-message {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 16px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <jsp:include page="../common/nav.jsp"/>
    
    <div class="container">
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="搜索反馈标题或内容..." value="${search}">
            <select id="statusFilter" onchange="filterFeedbacks()">
                <option value="">全部状态</option>
                <option value="0" ${param.status == '0' ? 'selected' : ''}>待处理</option>
                <option value="1" ${param.status == '1' ? 'selected' : ''}>处理中</option>
                <option value="2" ${param.status == '2' ? 'selected' : ''}>已处理</option>
                <option value="3" ${param.status == '3' ? 'selected' : ''}>已关闭</option>
            </select>
            <button onclick="searchFeedbacks()" class="btn btn-primary">搜索</button>
        </div>
        
        <c:choose>
            <c:when test="${empty feedbacks}">
                <div class="empty-message">暂无反馈数据</div>
            </c:when>
            <c:otherwise>
                <table class="feedback-table">
                    <thead>
                        <tr>
                            <th>类型</th>
                            <th>标题</th>
                            <th>用户</th>
                            <th>内容</th>
                            <th>提交时间</th>
                            <th>状态</th>
                            <th>回复</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${feedbacks}" var="feedback">
                            <tr>
                                <td>
                                    <span class="type-badge ${feedback.type == 1 ? 'type-system' : 
                                                    feedback.type == 2 ? 'type-service' : 'type-other'}">
                                        ${feedback.type == 1 ? '系统问题' : 
                                          feedback.type == 2 ? '服务建议' : '其他'}
                                    </span>
                                </td>
                                <td>${feedback.title}</td>
                                <td>${feedback.username}</td>
                                <td>${feedback.content}</td>
                                <td><fmt:formatDate value="${feedback.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>
                                    <span class="status-badge ${feedback.status == 0 ? 'status-pending' : 
                                                      feedback.status == 1 ? 'status-processing' : 
                                                      feedback.status == 2 ? 'status-completed' : 
                                                      'status-closed'}">
                                        ${feedback.status == 0 ? '待处理' : 
                                          feedback.status == 1 ? '处理中' : 
                                          feedback.status == 2 ? '已处理' : '已关闭'}
                                    </span>
                                </td>
                                <td>
                                    <div>${feedback.reply}</div>
                                    <button onclick="showReplyForm(${feedback.id})" class="btn btn-primary btn-sm">回复</button>
                                    <div id="replyForm${feedback.id}" class="reply-form">
                                        <textarea id="replyContent${feedback.id}" placeholder="请输入回复内容..."></textarea>
                                        <button onclick="submitReply(${feedback.id})" class="btn btn-success btn-sm">提交</button>
                                    </div>
                                </td>
                                <td>
                                    <button onclick="updateStatus(${feedback.id}, 1)" class="btn btn-warning btn-sm">处理中</button>
                                    <button onclick="updateStatus(${feedback.id}, 2)" class="btn btn-success btn-sm">已处理</button>
                                    <button onclick="updateStatus(${feedback.id}, 3)" class="btn btn-danger btn-sm">关闭</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
    function searchFeedbacks() {
        var search = document.getElementById('searchInput').value;
        var status = document.getElementById('statusFilter').value;
        window.location.href = '${pageContext.request.contextPath}/feedback/list?' + 
            'search=' + encodeURIComponent(search) + 
            '&status=' + status;
    }
    
    function filterFeedbacks() {
        searchFeedbacks();
    }
    
    function showReplyForm(feedbackId) {
        document.getElementById('replyForm' + feedbackId).style.display = 'block';
    }
    
    function submitReply(feedbackId) {
        var reply = document.getElementById('replyContent' + feedbackId).value;
        fetch('${pageContext.request.contextPath}/feedback/reply', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'id=' + feedbackId + '&reply=' + encodeURIComponent(reply)
        })
        .then(response => response.text())
        .then(result => {
            if (result === 'success') {
                alert('回复成功');
                window.location.reload();
            } else {
                alert('回复失败');
            }
        });
    }
    
    function updateStatus(feedbackId, status) {
        fetch('${pageContext.request.contextPath}/feedback/status', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'id=' + feedbackId + '&status=' + status
        })
        .then(response => response.text())
        .then(result => {
            if (result === 'success') {
                window.location.reload();
            } else {
                alert('操作失败');
            }
        });
    }
    </script>
</body>
</html> 