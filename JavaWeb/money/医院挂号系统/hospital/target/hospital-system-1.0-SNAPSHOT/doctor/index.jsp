<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>医生工作平台</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
        .user-info {
            font-size: 14px;
            color: #666;
        }
        
        .logout-btn {
            margin-left: 15px;
            color: #666;
            text-decoration: none;
            padding: 5px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .logout-btn:hover {
            background: #f5f5f5;
        }
        
        .title {
            font-size: 24px;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .nav-tabs {
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
        }
        
        .nav-tabs button {
            background: none;
            border: none;
            padding: 10px 20px;
            margin-right: 10px;
            cursor: pointer;
            color: #666;
        }
        
        .nav-tabs button.active {
            border-bottom: 2px solid #4CAF50;
            color: #4CAF50;
        }
        
        .tab-content > div {
            display: none;
        }
        
        .tab-content > div.active {
            display: block;
        }
        
        .filter-group {
            margin-bottom: 20px;
            display: flex;
            gap: 15px;
        }
        
        .filter-group select {
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #f5f5f5;
        }
        
        .department-list {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 20px;
        }
        
        .department-item {
            background: #f5f5f5;
            padding: 15px;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
            min-width: 150px;
        }
        
        .department-item:hover {
            background: #e0e0e0;
        }
        
        .department-item.selected {
            background: #4CAF50;
            color: white;
        }
        
        .dept-desc {
            font-size: 12px;
            margin-top: 5px;
            color: #666;
        }
        
        .department-item.selected .dept-desc {
            color: #eee;
        }
        
        .error {
            color: #f44336;
            padding: 10px;
        }
        
        button {
            padding: 5px 10px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        button:hover {
            background: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="title">医生工作平台</div>
            <div class="user-info">
                欢迎您，${sessionScope.username}
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">退出登录</a>
            </div>
        </div>
        
        <div class="nav-tabs">
            <button class="active" onclick="switchTab('appointments')">挂号记录</button>
            <button onclick="switchTab('departments')">科室管理</button>
        </div>
        
        <div class="tab-content">
            <!-- 挂号记录标签页 -->
            <div id="appointments" class="active">
                <div class="filter-group">
                    <select id="dateFilter">
                        <option value="">全部日期</option>
                        <option value="today">今天</option>
                        <option value="tomorrow">明天</option>
                        <option value="week">本周</option>
                    </select>
                    <select id="statusFilter">
                        <option value="">全部状态</option>
                        <option value="pending">待就诊</option>
                        <option value="completed">已完成</option>
                        <option value="cancelled">已取消</option>
                    </select>
                    <select id="timeSlotFilter">
                        <option value="">全部时段</option>
                        <option value="上午">上午</option>
                        <option value="下午">下午</option>
                        <option value="晚上">晚上</option>
                    </select>
                </div>
                
                <table>
                    <thead>
                        <tr>
                            <th>患者姓名</th>
                            <th>就诊日期</th>
                            <th>时间段</th>
                            <th>科室</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody id="appointmentList">
                        <!-- 这里将通过AJAX动态加载数据 -->
                    </tbody>
                </table>
            </div>
            
            <!-- 科室管理标签页 -->
            <div id="departments">
                <h3>我的科室</h3>
                <div class="department-list" id="myDepartments">
                    <!-- 这里将通过AJAX动态加载数据 -->
                </div>
                
                <h3>可选科室</h3>
                <div class="department-list" id="availableDepartments">
                    <!-- 这里将通过AJAX动态加载数据 -->
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // 切换标签页
        function switchTab(tabId) {
            document.querySelectorAll('.tab-content > div').forEach(tab => {
                tab.classList.remove('active');
            });
            document.querySelectorAll('.nav-tabs button').forEach(button => {
                button.classList.remove('active');
            });
            
            document.getElementById(tabId).classList.add('active');
            event.target.classList.add('active');
            
            if (tabId === 'appointments') {
                loadAppointments();
            } else if (tabId === 'departments') {
                loadDepartments();
            }
        }
        
        // 加载挂号记录
        function loadAppointments() {
            const dateFilter = document.getElementById('dateFilter').value;
            const statusFilter = document.getElementById('statusFilter').value;
            const timeSlotFilter = document.getElementById('timeSlotFilter').value;
            
            fetch('${pageContext.request.contextPath}/doctor/appointments?date=' + dateFilter + 
                 '&status=' + statusFilter + '&timeSlot=' + timeSlotFilter)
                .then(response => response.json())
                .then(data => {
                    const tbody = document.getElementById('appointmentList');
                    tbody.innerHTML = data.map(appointment => 
                        '<tr>' +
                            '<td>' + appointment.patientName + '</td>' +
                            '<td>' + (appointment.visitDate || '--') + '</td>' +
                            '<td>' + appointment.timeSlot + '</td>' +
                            '<td>' + appointment.departmentName + '</td>' +
                            '<td>' + getStatusText(appointment.status) + '</td>' +
                            '<td>' + 
                                (appointment.status === 'pending' ? 
                                    '<button onclick="updateStatus(' + appointment.id + ', \'completed\')">完成就诊</button>' : 
                                    '') +
                            '</td>' +
                        '</tr>'
                    ).join('');
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('加载数据失败，请刷新页面重试');
                });
        }
        
        // 加载科室信息
        function loadDepartments() {
            const myDepts = document.getElementById('myDepartments');
            const availableDepts = document.getElementById('availableDepartments');
            
            // 添加加载中提示
            myDepts.innerHTML = '<div>加载中...</div>';
            availableDepts.innerHTML = '<div>加载中...</div>';
            
            fetch('${pageContext.request.contextPath}/doctor/departments')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    myDepts.innerHTML = data.myDepartments.map(dept => 
                        '<div class="department-item selected" onclick="toggleDepartment(' + dept.id + ', false)">' +
                            dept.name +
                            '<div class="dept-desc">' + (dept.description || '') + '</div>' +
                        '</div>'
                    ).join('');
                    
                    availableDepts.innerHTML = data.availableDepartments.map(dept => 
                        '<div class="department-item" onclick="toggleDepartment(' + dept.id + ', true)">' +
                            dept.name +
                            '<div class="dept-desc">' + (dept.description || '') + '</div>' +
                        '</div>'
                    ).join('');
                })
                .catch(error => {
                    console.error('Error:', error);
                    myDepts.innerHTML = '<div class="error">加载失败，请刷新重试</div>';
                    availableDepts.innerHTML = '<div class="error">加载失败，请刷新重试</div>';
                });
        }
        
        // 更新就诊状态
        function updateStatus(appointmentId, status) {
            fetch('${pageContext.request.contextPath}/doctor/appointments/' + appointmentId, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ status: status })
            }).then(() => loadAppointments());
        }
        
        // 切换科室
        function toggleDepartment(deptId, isAdd) {
            fetch('${pageContext.request.contextPath}/doctor/departments/' + deptId, {
                method: isAdd ? 'POST' : 'DELETE'
            }).then(() => loadDepartments());
        }
        
        // 初始加载
        document.addEventListener('DOMContentLoaded', () => {
            loadAppointments();
            
            // 添加筛选器变化监听
            ['dateFilter', 'statusFilter', 'timeSlotFilter'].forEach(id => {
                document.getElementById(id).addEventListener('change', loadAppointments);
            });
        });
        
        // 在script标签内添加状态映射函数
        function getStatusText(status) {
            const statusMap = {
                'pending': '待就诊',
                'completed': '已完成',
                'cancelled': '已取消'
            };
            return statusMap[status] || status;
        }
    </script>
</body>
</html> 