<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="order-detail-container">
    <div class="order-header">
        <h3>订单号：${order.orderNo}</h3>
        <span class="status-badge status-${order.status}">
            ${order.status == 0 ? '待付款' : 
              order.status == 1 ? '已付款' : 
              order.status == 2 ? '已发货' : 
              order.status == 3 ? '已完成' : '已取消'}
        </span>
    </div>
    
    <div class="info-section">
        <div class="info-group">
            <h4>收货信息</h4>
            <p>收货人：${order.receiver}</p>
            <p>联系电话：${order.phone}</p>
            <p>收货地址：${order.address}</p>
        </div>
        
        <div class="info-group">
            <h4>订单信息</h4>
            <p>下单时间：<fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
            <p>更新时间：<fmt:formatDate value="${order.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
        </div>
    </div>
    
    <table class="items-table">
        <thead>
            <tr>
                <th>商品名称</th>
                <th>单价</th>
                <th>数量</th>
                <th>小计</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${order.orderItems}" var="item">
                <tr>
                    <td>${item.bookName}</td>
                    <td>￥${item.price}</td>
                    <td>${item.quantity}</td>
                    <td>￥${item.subtotal}</td>
                </tr>
            </c:forEach>
            <tr class="total-row">
                <td colspan="3" style="text-align: right">订单总额：</td>
                <td>￥${order.amount}</td>
            </tr>
        </tbody>
    </table>
</div>

<style>
.order-detail-container {
    padding: 20px;
}

.order-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
}

.order-header h3 {
    margin: 0;
    color: #333;
}

.info-section {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 20px;
    margin-bottom: 20px;
}

.info-group {
    background-color: #f8f9fa;
    padding: 15px;
    border-radius: 4px;
}

.info-group h4 {
    margin: 0 0 10px 0;
    color: #666;
}

.info-group p {
    margin: 5px 0;
    color: #333;
}

.items-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

.items-table th,
.items-table td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #eee;
}

.items-table th {
    background-color: #f8f9fa;
    font-weight: 500;
    color: #333;
}

.total-row td {
    font-weight: bold;
    background-color: #f8f9fa;
}

.status-badge {
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 0.85rem;
}

.status-0 { background-color: #fff3cd; color: #856404; }
.status-1 { background-color: #d4edda; color: #155724; }
.status-2 { background-color: #cce5ff; color: #004085; }
.status-3 { background-color: #d1ecf1; color: #0c5460; }
.status-4 { background-color: #f8d7da; color: #721c24; }
</style> 