-- 用户表
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(64) NOT NULL,  -- 存储加密后的密码
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 商品表
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    image_url VARCHAR(255),
    category VARCHAR(50),
    status TINYINT DEFAULT 1, -- 1:上架 0:下架
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 购物车表
CREATE TABLE cart_items (
    cart_item_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 订单表
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status TINYINT DEFAULT 0, -- 0:待付款 1:已付款 2:已发货 3:已完成 4:已取消
    shipping_address TEXT NOT NULL,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 订单详情表
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL, -- 下单时的价格
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 插入用户数据
INSERT INTO users (username, password, email, phone, address) VALUES
('张三', '123456', 'zhangsan@example.com', '13800138001', '北京市朝阳区xx街xx号'),
('李四', '123456', 'lisi@example.com', '13800138002', '上海市浦东新区xx路xx号'),
('王五', '123456', 'wangwu@example.com', '13800138003', '广州市天河区xx路xx号');

-- 插入商品数据
INSERT INTO products (name, description, price, stock, image_url, category) VALUES
('iPhone 15', '苹果最新旗舰手机，A17芯片', 6999.00, 100, '/images/iphone15.jpg', '手机'),
('华为 Mate 60', '华为新一代旗舰手机', 6299.00, 50, '/images/mate60.jpg', '手机'),
('MacBook Pro', 'M2芯片版本MacBook Pro', 12999.00, 30, '/images/macbook.jpg', '笔记本'),
('AirPods Pro', '主动降噪无线耳机', 1999.00, 200, '/images/airpods.jpg', '配件'),
('小米手环8', '智能运动手环', 299.00, 500, '/images/miband.jpg', '配件');

-- 插入购物车数据
INSERT INTO cart_items (user_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 4, 2),
(2, 2, 1),
(3, 3, 1),
(3, 5, 2);

-- 插入订单数据
INSERT INTO orders (user_id, total_amount, status, shipping_address) VALUES
(1, 8998.00, 1, '北京市朝阳区xx街xx号'),
(2, 6299.00, 2, '上海市浦东新区xx路xx号'),
(3, 13597.00, 3, '广州市天河区xx路xx号');

-- 插入订单详情数据
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 6999.00),
(1, 4, 1, 1999.00),
(2, 2, 1, 6299.00),
(3, 3, 1, 12999.00),
(3, 5, 2, 299.00); 