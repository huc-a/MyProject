<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>病人服务平台</title>
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
        
        .title {
            font-size: 24px;
            color: #333;
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
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
        
        .registration-form {
            max-width: 600px;
            margin: 20px 0;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        
        .form-group select, .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .fee-info {
            margin: 10px 0;
            padding: 10px;
            background: #f8f8f8;
            border-radius: 4px;
        }
        
        button {
            padding: 10px 20px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        button:hover {
            background: #45a049;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="title">病人服务平台</div>
            <div class="user-info">
                欢迎您，${sessionScope.username}
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">退出登录</a>
            </div>
        </div>
        
        <div class="nav-tabs">
            <button class="active" onclick="switchTab('appointments')">我的挂号记录</button>
            <button onclick="switchTab('register')">预约挂号</button>
        </div>
        
        <div class="tab-content">
            <!-- 挂号记录标签页 -->
            <div id="appointments" class="active">
                <table>
                    <thead>
                        <tr>
                            <th>就诊日期</th>
                            <th>时间段</th>
                            <th>科室</th>
                            <th>医生</th>
                            <th>状态</th>
                            <th>费用</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody id="appointmentList">
                        <!-- 这里将通过AJAX动态加载数据 -->
                    </tbody>
                </table>
            </div>
            
            <!-- 预约挂号标签页 -->
            <div id="register">
                <form class="registration-form" id="registrationForm">
                    <div class="form-group">
                        <label>选择科室</label>
                        <select id="departmentSelect" onchange="loadDoctors()">
                            <option value="">请选择科室</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>选择医生</label>
                        <select id="doctorSelect" disabled>
                            <option value="">请先选择科室</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>就诊日期</label>
                        <input type="date" id="visitDate" min="" required>
                    </div>
                    
                    <div class="form-group">
                        <label>时间段</label>
                        <select id="timeSlot" onchange="updateFee()">
                            <option value="">请选择时间段</option>
                            <option value="上午">上午</option>
                            <option value="下午">下午</option>
                            <option value="晚上">晚上</option>
                        </select>
                    </div>
                    
                    <div class="fee-info" id="feeInfo">
                        挂号费用：<span id="feeAmount">0</span>元
                    </div>
                    
                    <button type="submit">提交预约</button>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        // 设置日期选择器的最小值为今天
        document.getElementById('visitDate').min = new Date().toISOString().split('T')[0];
        
        // 切换标签页
        function switchTab(tabId) {
            // 移除所有标签页的 active 类
            document.querySelectorAll('.tab-content > div').forEach(tab => {
                tab.classList.remove('active');
            });
            document.querySelectorAll('.nav-tabs button').forEach(button => {
                button.classList.remove('active');
            });
            
            // 激活选中的标签页
            document.getElementById(tabId).classList.add('active');
            // 找到对应的按钮并激活
            document.querySelector('.nav-tabs button[onclick*="' + tabId + '"]').classList.add('active');
            
            // 加载对应的数据
            if (tabId === 'appointments') {
                loadAppointments();
            } else if (tabId === 'register') {
                loadDepartments();
                // 重置表单
                document.getElementById('registrationForm').reset();
                document.getElementById('doctorSelect').disabled = true;
                document.getElementById('doctorSelect').innerHTML = '<option value="">请先选择科室</option>';
                document.getElementById('feeAmount').textContent = '0';
            }
        }
        
        // 加载科室列表
        function loadDepartments() {
            fetch('${pageContext.request.contextPath}/patient/departments')
                .then(response => response.json())
                .then(data => {
                    const select = document.getElementById('departmentSelect');
                    select.innerHTML = '<option value="">请选择科室</option>' +
                        data.map(dept => 
                            '<option value="' + dept.id + '">' + dept.name + '</option>'
                        ).join('');
                });
        }
        
        // 加载医生列表
        function loadDoctors() {
            const departmentId = document.getElementById('departmentSelect').value;
            const doctorSelect = document.getElementById('doctorSelect');
            
            if (!departmentId) {
                doctorSelect.innerHTML = '<option value="">请先选择科室</option>';
                doctorSelect.disabled = true;
                return;
            }
            
            fetch('${pageContext.request.contextPath}/patient/doctors?departmentId=' + departmentId)
                .then(response => response.json())
                .then(data => {
                    doctorSelect.innerHTML = '<option value="">请选择医生</option>' +
                        data.map(doctor => 
                            '<option value="' + doctor.id + '">' + doctor.fullName + '</option>'
                        ).join('');
                    doctorSelect.disabled = false;
                });
        }
        
        // 更新费用显示
        function updateFee() {
            const timeSlot = document.getElementById('timeSlot').value;
            if (timeSlot) {
                fetch('${pageContext.request.contextPath}/patient/fee?timeSlot=' + timeSlot)
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('feeAmount').textContent = data.fee;
                    });
            }
        }
        
        // 加载挂号记录
        function loadAppointments() {
            const tbody = document.getElementById('appointmentList');
            tbody.innerHTML = '<tr><td colspan="7" style="text-align:center">加载中...</td></tr>';
            
            fetch('${pageContext.request.contextPath}/patient/appointments')
                .then(response => response.json())
                .then(data => {
                    if (data && data.length > 0) {
                        tbody.innerHTML = data.map(appointment => 
                            '<tr>' +
                                '<td>' + appointment.visitDate + '</td>' +
                                '<td>' + appointment.timeSlot + '</td>' +
                                '<td>' + appointment.departmentName + '</td>' +
                                '<td>' + appointment.doctorName + '</td>' +
                                '<td>' + getStatusText(appointment.status) + '</td>' +
                                '<td>' + appointment.fee + '元</td>' +
                                '<td>' + 
                                    (appointment.status === 'pending' ? 
                                        '<button onclick="cancelAppointment(' + appointment.id + ')">取消预约</button>' : 
                                        '') +
                                '</td>' +
                            '</tr>'
                        ).join('');
                    } else {
                        tbody.innerHTML = '<tr><td colspan="7" style="text-align:center">暂无预约记录</td></tr>';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    tbody.innerHTML = '<tr><td colspan="7" style="text-align:center">加载失败，请刷新重试</td></tr>';
                });
        }
        
        // 取消预约
        function cancelAppointment(appointmentId) {
            if (confirm('确定要取消这个预约吗？')) {
                fetch('${pageContext.request.contextPath}/patient/appointments/' + appointmentId, {
                    method: 'DELETE'
                }).then(() => loadAppointments());
            }
        }
        
        // 提交预约
        document.getElementById('registrationForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const departmentId = document.getElementById('departmentSelect').value;
            const doctorId = document.getElementById('doctorSelect').value;
            const visitDate = document.getElementById('visitDate').value;
            const timeSlot = document.getElementById('timeSlot').value;
            
            // 验证所有字段都已填写
            if (!departmentId || !doctorId || !visitDate || !timeSlot) {
                alert('请填写所有必填项');
                return;
            }
            
            const data = {
                departmentId: parseInt(departmentId),
                doctorId: parseInt(doctorId),
                visitDate: visitDate,
                timeSlot: timeSlot
            };
            
            // 禁用提交按钮，防止重复提交
            const submitButton = this.querySelector('button[type="submit"]');
            submitButton.disabled = true;
            
            fetch('${pageContext.request.contextPath}/patient/appointments', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json;charset=UTF-8',
                    'Accept': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    alert('预约成功！');
                    // 先切换到预约记录标签页
                    switchTab('appointments');
                    // 重置表单
                    this.reset();
                    document.getElementById('doctorSelect').disabled = true;
                    document.getElementById('doctorSelect').innerHTML = '<option value="">请先选择科室</option>';
                    document.getElementById('feeAmount').textContent = '0';
                } else {
                    alert(result.message || '预约失败，请重试');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('预约失败，请重试');
            })
            .finally(() => {
                // 恢复提交按钮
                submitButton.disabled = false;
            });
        });
        
        // 状态文本转换
        function getStatusText(status) {
            const statusMap = {
                'pending': '待就诊',
                'completed': '已完成',
                'cancelled': '已取消'
            };
            return statusMap[status] || status;
        }
        
        // 初始加载
        document.addEventListener('DOMContentLoaded', () => {
            loadAppointments();
        });
    </script>
</body>
</html> 