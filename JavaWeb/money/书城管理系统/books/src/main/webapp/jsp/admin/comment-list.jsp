<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>评论管理 - 书城管理系统</title>
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
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 300px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        .search-box input:focus {
            outline: none;
            border-color: #007bff;
        }
        
        .search-box select {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            min-width: 120px;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
        }
        
        .btn-primary { background-color: #007bff; }
        .btn-primary:hover { background-color: #0056b3; }
        .btn-success { background-color: #28a745; }
        .btn-success:hover { background-color: #218838; }
        .btn-danger { background-color: #dc3545; }
        .btn-danger:hover { background-color: #c82333; }
        
        .comment-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        
        .comment-table th,
        .comment-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
            vertical-align: top;
        }
        
        .comment-table th {
            background-color: #f8f9fa;
            font-weight: 500;
            color: #333;
            white-space: nowrap;
        }
        
        .comment-table tr:hover {
            background-color: #f8f9fa;
        }
        
        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            display: inline-block;
        }
        
        .status-pending { 
            background-color: #fff3cd; 
            color: #856404;
            border: 1px solid #ffeeba;
        }
        
        .status-approved { 
            background-color: #d4edda; 
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .status-rejected { 
            background-color: #f8d7da; 
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
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
            resize: vertical;
            min-height: 60px;
        }
        
        .reply-form textarea:focus {
            outline: none;
            border-color: #007bff;
        }
        
        .action-buttons {
            display: flex;
            gap: 5px;
        }
        
        .rating {
            color: #ffc107;
            font-weight: bold;
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
        
        .debug-info {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 8px;
            font-size: 14px;
            color: #666;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <jsp:include page="../common/nav.jsp"/>
    
    <div class="container">
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="搜索图书名称或评论内容..." value="${search}">
            <select id="statusFilter" onchange="filterComments()">
                <option value="">全部状态</option>
                <option value="0">待审核</option>
                <option value="1">已通过</option>
                <option value="2">已拒绝</option>
            </select>
            <button onclick="searchComments()" class="btn btn-primary">搜索</button>
        </div>
        
        <c:choose>
            <c:when test="${empty comments}">
                <div class="empty-message">暂无评论数据</div>
            </c:when>
            <c:otherwise>
                <table class="comment-table">
                    <thead>
                        <tr>
                            <th>图书</th>
                            <th>用户</th>
                            <th>评分</th>
                            <th>评论内容</th>
                            <th>评论时间</th>
                            <th>状态</th>
                            <th>回复</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${comments}" var="comment">
                            <tr>
                                <td>${comment.bookName}</td>
                                <td>${comment.username}</td>
                                <td><span class="rating">${comment.rating}星</span></td>
                                <td>${comment.content}</td>
                                <td><fmt:formatDate value="${comment.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>
                                    <span class="status-badge ${comment.status == 0 ? 'status-pending' : 
                                                      comment.status == 1 ? 'status-approved' : 
                                                      'status-rejected'}">
                                        ${comment.status == 0 ? '待审核' : 
                                          comment.status == 1 ? '已通过' : '已拒绝'}
                                    </span>
                                </td>
                                <td>
                                    <div>${comment.reply}</div>
                                    <button onclick="showReplyForm(${comment.id})" class="btn btn-primary btn-sm">回复</button>
                                    <div id="replyForm${comment.id}" class="reply-form">
                                        <textarea id="replyContent${comment.id}" rows="3" placeholder="请输入回复内容..."></textarea>
                                        <button onclick="submitReply(${comment.id})" class="btn btn-success btn-sm">提交回复</button>
                                    </div>
                                </td>
                                <td class="action-buttons">
                                    <button onclick="approveComment(${comment.id})" class="btn btn-success btn-sm">通过</button>
                                    <button onclick="rejectComment(${comment.id})" class="btn btn-danger btn-sm">拒绝</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
    function searchComments() {
        var search = document.getElementById('searchInput').value;
        var status = document.getElementById('statusFilter').value;
        window.location.href = '${pageContext.request.contextPath}/comment/list?search=' + 
            encodeURIComponent(search) + '&status=' + status;
    }
    
    function filterComments() {
        searchComments();
    }
    
    function showReplyForm(commentId) {
        document.getElementById('replyForm' + commentId).style.display = 'block';
    }
    
    function submitReply(commentId) {
        var reply = document.getElementById('replyContent' + commentId).value;
        fetch('${pageContext.request.contextPath}/comment/reply', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'id=' + commentId + '&reply=' + encodeURIComponent(reply)
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
    
    function approveComment(commentId) {
        updateCommentStatus(commentId, 1);
    }
    
    function rejectComment(commentId) {
        updateCommentStatus(commentId, 2);
    }
    
    function updateCommentStatus(commentId, status) {
        fetch('${pageContext.request.contextPath}/comment/status', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'id=' + commentId + '&status=' + status
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