/*
 Navicat Premium Data Transfer

 Source Server         : tree
 Source Server Type    : MySQL
 Source Server Version : 80040
 Source Host           : localhost:3306
 Source Schema         : book

 Target Server Type    : MySQL
 Target Server Version : 80040
 File Encoding         : 65001

 Date: 07/01/2025 22:19:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '管理员用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES (1, 'admin', '123456', '系统管理员', NULL, NULL, 1, '2025-01-06 11:06:21', '2025-01-06 11:06:21');
INSERT INTO `admin_user` VALUES (2, 'zhangsan', '123456', '张三', '13666666666', 'zhangsan@example.com', 1, '2025-01-06 11:07:05', '2025-01-06 11:07:05');

-- ----------------------------
-- Table structure for book_comments
-- ----------------------------
DROP TABLE IF EXISTS `book_comments`;
CREATE TABLE `book_comments`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `book_id` int NOT NULL COMMENT '图书ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评论内容',
  `rating` int NOT NULL COMMENT '评分(1-5星)',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态：0-待审核，1-已通过，2-已拒绝',
  `reply` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '管理员回复',
  `reply_time` datetime NULL DEFAULT NULL COMMENT '回复时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `book_id`(`book_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `book_comments_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `book_comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '图书评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book_comments
-- ----------------------------
INSERT INTO `book_comments` VALUES (1, 1, 1, '这本书讲解得很详细，对Java初学者很有帮助', 5, 1, NULL, NULL, '2024-03-15 10:00:00', '2025-01-07 20:25:31');
INSERT INTO `book_comments` VALUES (2, 1, 2, '内容深入浅出，很适合进阶学习', 4, 1, NULL, NULL, '2024-03-15 11:30:00', '2025-01-07 20:25:31');
INSERT INTO `book_comments` VALUES (3, 2, 3, '春天实战确实实用，案例丰富', 5, 1, NULL, NULL, '2024-03-16 09:15:00', '2025-01-07 20:25:31');
INSERT INTO `book_comments` VALUES (4, 2, 1, '这本书有点难度，但是很值得一读', 4, 0, NULL, NULL, '2024-03-16 14:20:00', '2025-01-07 20:25:31');
INSERT INTO `book_comments` VALUES (5, 3, 2, '必知必会系列一如既往的好', 5, 1, NULL, NULL, '2024-03-17 16:45:00', '2025-01-07 20:25:31');
INSERT INTO `book_comments` VALUES (6, 3, 3, '这是一本很好的入门书籍', 4, 2, NULL, NULL, '2024-03-17 18:30:00', '2025-01-07 20:25:31');
INSERT INTO `book_comments` VALUES (7, 4, 1, 'JavaScript进阶必读', 5, 1, '哈哈哈哈哈', '2025-01-07 21:19:30', '2024-03-18 10:00:00', '2025-01-07 21:19:43');
INSERT INTO `book_comments` VALUES (8, 5, 2, 'Python入门的不二选择', 4, 1, '11', '2025-01-07 20:37:15', '2024-03-18 11:30:00', '2025-01-07 20:37:15');
INSERT INTO `book_comments` VALUES (9, 1, 3, '这本书的翻译有些地方不太准确', 3, 1, '感谢您的反馈，我们会在下次再版时改进翻译质量', '2024-03-16 15:00:00', '2024-03-16 10:00:00', '2025-01-07 20:25:31');
INSERT INTO `book_comments` VALUES (10, 2, 2, '希望能出新版本，更新一下Spring最新特性', 4, 1, '新版本正在编写中，预计今年下半年出版', '2024-03-17 14:00:00', '2024-03-17 10:00:00', '2025-01-07 20:25:31');

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书名',
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者',
  `publisher` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出版社',
  `price` decimal(10, 2) NOT NULL COMMENT '价格',
  `stock` int NOT NULL DEFAULT 0 COMMENT '库存数量',
  `cover_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图片URL',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '图书描述',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态：0-下架，1-上架',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '图书表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of books
-- ----------------------------
INSERT INTO `books` VALUES (1, 'Java编程思想', 'Bruce Eckel', '机械工业出版社', 108.00, 100, '/static/images/books/1.jpg', 'Java程序员必读经典著作', 1, '2025-01-06 21:17:42', '2025-01-06 21:18:34');
INSERT INTO `books` VALUES (2, 'Spring实战', 'Craig Walls', '人民邮电出版社', 89.00, 50, '/static/images/books/2.jpg', 'Spring框架经典教程', 1, '2025-01-06 21:17:42', '2025-01-06 21:18:40');
INSERT INTO `books` VALUES (3, '活着', '余华', '作家出版社', 35.00, 200, '/static/images/books/3.jpg', '余华代表作，很好看', 1, '2025-01-06 21:17:42', '2025-01-07 21:16:37');
INSERT INTO `books` VALUES (4, 'Python编程：从入门到实践', 'Eric Matthes', '人民邮电出版社', 79.00, 150, '/static/images/books/4.jpg', 'Python入门经典教程', 1, '2025-01-06 21:22:44', '2025-01-06 21:22:44');
INSERT INTO `books` VALUES (5, '算法导论', 'Thomas H.Cormen', '机械工业出版社', 128.00, 80, '/static/images/books/5.jpg', '计算机科学必读经典', 1, '2025-01-06 21:22:44', '2025-01-06 21:22:44');
INSERT INTO `books` VALUES (6, '红楼梦', '曹雪芹', '人民文学出版社', 59.90, 200, '/static/images/books/6.jpg', '中国古典文学巅峰之作', 1, '2025-01-06 21:22:44', '2025-01-06 21:22:44');
INSERT INTO `books` VALUES (7, '三体', '刘慈欣', '重庆出版社', 93.00, 180, '/static/images/books/7.jpg', '中国科幻文学代表作', 1, '2025-01-06 21:22:44', '2025-01-06 21:22:44');
INSERT INTO `books` VALUES (8, 'JavaScript高级程序设计', 'Nicholas C.Zakas', '人民邮电出版社', 119.00, 120, '/static/images/books/8.jpg', 'JavaScript红宝书', 1, '2025-01-06 21:22:44', '2025-01-06 21:22:44');
INSERT INTO `books` VALUES (9, '深入理解计算机系统', 'Randal E.Bryant', '机械工业出版社', 139.00, 90, '/static/images/books/9.jpg', '计算机系统底层原理', 1, '2025-01-06 21:22:44', '2025-01-06 21:22:44');
INSERT INTO `books` VALUES (10, '明朝那些事儿', '当年明月', '中国海关出版社', 219.00, 150, '/static/images/books/10.jpg', '明朝历史通俗读物', 1, '2025-01-06 21:22:44', '2025-01-06 21:22:44');
INSERT INTO `books` VALUES (11, '围城', '钱钟书', '人民文学出版社', 39.00, 160, '/static/images/books/11.jpg', '现代文学经典', 1, '2025-01-06 21:22:44', '2025-01-06 21:22:44');
INSERT INTO `books` VALUES (12, 'MySQL技术内幕', '姜承尧', '机械工业出版社', 89.00, 100, '/static/images/books/12.jpg', 'MySQL进阶必读', 1, '2025-01-06 21:22:44', '2025-01-06 21:22:44');
INSERT INTO `books` VALUES (13, 'Docker实战', '杨保华', '机械工业出版社', 79.00, 110, '/static/images/books/13.jpg', 'Docker入门与实践', 1, '2025-01-06 21:22:44', '2025-01-06 21:22:44');
INSERT INTO `books` VALUES (14, '百年孤独', '加西亚·马尔克斯', '南海出版公司', 55.00, 130, '/static/images/books/14.jpg', '魔幻现实主义文学代表作', 1, '2025-01-06 21:22:44', '2025-01-06 21:22:44');
INSERT INTO `books` VALUES (15, '人类简史', '尤瓦尔·赫拉利', '中信出版社', 68.00, 140, '/static/images/books/15.jpg', '人类历史的宏大叙事', 1, '2025-01-06 21:22:44', '2025-01-06 21:22:44');

-- ----------------------------
-- Table structure for feedbacks
-- ----------------------------
DROP TABLE IF EXISTS `feedbacks`;
CREATE TABLE `feedbacks`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `type` tinyint NOT NULL COMMENT '反馈类型：1-系统问题，2-服务建议，3-其他',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '反馈标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '反馈内容',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态：0-待处理，1-处理中，2-已处理，3-已关闭',
  `reply` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '处理回复',
  `reply_time` datetime NULL DEFAULT NULL COMMENT '回复时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `feedbacks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户反馈表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of feedbacks
-- ----------------------------
INSERT INTO `feedbacks` VALUES (1, 1, 1, '网站搜索功能异常', '搜索图书时经常出现卡顿现象', 0, NULL, NULL, '2024-03-15 10:00:00', '2025-01-07 20:25:31');
INSERT INTO `feedbacks` VALUES (2, 2, 2, '建议增加分类筛选', '希望能按照图书难度级别进行筛选', 2, NULL, NULL, '2024-03-16 11:30:00', '2025-01-07 21:20:46');
INSERT INTO `feedbacks` VALUES (3, 3, 1, '移动端显示问题', '手机浏览时部分页面显示混乱', 1, '12', '2025-01-07 20:45:41', '2024-03-17 14:20:00', '2025-01-07 21:20:38');
INSERT INTO `feedbacks` VALUES (4, 1, 2, '配送建议', '建议增加当日达配送服务', 1, NULL, NULL, '2024-03-18 16:45:00', '2025-01-07 20:45:27');
INSERT INTO `feedbacks` VALUES (5, 2, 1, '订单状态更新慢', '订单支付后状态更新很慢', 2, '系统已优化，状态更新延迟已解决', '2024-03-16 15:00:00', '2024-03-16 10:00:00', '2025-01-07 20:25:31');
INSERT INTO `feedbacks` VALUES (6, 3, 2, '客服服务时间建议', '建议延长客服在线时间', 2, '我们已调整客服排班，延长服务时间至晚上10点', '2024-03-17 14:00:00', '2024-03-17 10:00:00', '2025-01-07 20:25:31');

-- ----------------------------
-- Table structure for order_items
-- ----------------------------
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL COMMENT '订单ID',
  `book_id` int NOT NULL COMMENT '图书ID',
  `book_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图书名称',
  `price` decimal(10, 2) NOT NULL COMMENT '购买时价格',
  `quantity` int NOT NULL COMMENT '购买数量',
  `subtotal` decimal(10, 2) NOT NULL COMMENT '小计金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_items
-- ----------------------------
INSERT INTO `order_items` VALUES (2, 2, 2, 'Spring实战', 158.00, 1, 158.00);
INSERT INTO `order_items` VALUES (3, 3, 1, 'Java编程思想', 128.00, 1, 128.00);
INSERT INTO `order_items` VALUES (4, 3, 3, 'MySQL必知必会', 99.00, 2, 198.00);
INSERT INTO `order_items` VALUES (5, 4, 4, 'JavaScript高级程序设计', 99.00, 1, 99.00);
INSERT INTO `order_items` VALUES (6, 5, 2, 'Spring实战', 158.00, 1, 158.00);
INSERT INTO `order_items` VALUES (7, 5, 3, 'MySQL必知必会', 99.00, 2, 198.00);
INSERT INTO `order_items` VALUES (8, 6, 1, 'Java编程思想', 99.50, 2, 199.00);
INSERT INTO `order_items` VALUES (9, 7, 2, 'Spring实战', 158.00, 2, 316.00);
INSERT INTO `order_items` VALUES (10, 7, 4, 'JavaScript高级程序设计', 112.00, 1, 112.00);
INSERT INTO `order_items` VALUES (11, 8, 5, 'Python编程从入门到实践', 158.00, 1, 158.00);
INSERT INTO `order_items` VALUES (12, 9, 1, 'Java编程思想', 128.00, 1, 128.00);
INSERT INTO `order_items` VALUES (13, 9, 3, 'MySQL必知必会', 171.00, 1, 171.00);
INSERT INTO `order_items` VALUES (14, 10, 2, 'Spring实战', 158.00, 2, 316.00);
INSERT INTO `order_items` VALUES (15, 10, 4, 'JavaScript高级程序设计', 142.00, 1, 142.00);
INSERT INTO `order_items` VALUES (16, 11, 5, 'Python编程从入门到实践', 128.50, 2, 257.00);
INSERT INTO `order_items` VALUES (17, 12, 3, 'MySQL必知必会', 99.00, 2, 198.00);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单号',
  `user_id` int NOT NULL COMMENT '用户ID',
  `amount` decimal(10, 2) NOT NULL COMMENT '订单金额',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '订单状态：0-待付款 1-已付款 2-已发货 3-已完成 4-已取消',
  `receiver` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货人',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系电话',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货地址',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (2, '202403160001', 1, 158.00, 2, '张三', '13800138001', '北京市朝阳区望京SOHO', '2024-03-16 09:15:00', '2025-01-07 20:15:40');
INSERT INTO `orders` VALUES (3, '202403170001', 1, 327.00, 1, '张三', '13800138001', '北京市朝阳区望京SOHO', '2024-03-17 14:30:00', '2025-01-07 20:15:40');
INSERT INTO `orders` VALUES (4, '202403180001', 1, 99.00, 0, '张三', '13800138001', '北京市朝阳区望京SOHO', '2024-03-18 16:45:00', '2025-01-07 20:15:40');
INSERT INTO `orders` VALUES (5, '202403150002', 2, 356.00, 3, '李四', '13800138002', '上海市浦东新区陆家嘴', '2024-03-15 11:30:00', '2025-01-07 20:15:40');
INSERT INTO `orders` VALUES (6, '202403160002', 2, 199.00, 2, '李四', '13800138002', '上海市浦东新区陆家嘴', '2024-03-16 13:40:00', '2025-01-07 20:15:40');
INSERT INTO `orders` VALUES (7, '202403170002', 2, 428.00, 1, '李四', '13800138002', '上海市浦东新区陆家嘴', '2024-03-17 15:20:00', '2025-01-07 20:15:40');
INSERT INTO `orders` VALUES (8, '202403180002', 2, 158.00, 0, '李四', '13800138002', '上海市浦东新区陆家嘴', '2024-03-18 17:10:00', '2025-01-07 20:15:40');
INSERT INTO `orders` VALUES (9, '202403150003', 3, 299.00, 3, '王五', '13800138003', '广州市天河区珠江新城', '2024-03-15 14:20:00', '2025-01-07 20:15:40');
INSERT INTO `orders` VALUES (10, '202403160003', 3, 458.00, 2, '王五', '13800138003', '广州市天河区珠江新城', '2024-03-16 16:50:00', '2025-01-07 20:15:40');
INSERT INTO `orders` VALUES (11, '202403170003', 3, 257.00, 1, '王五', '13800138003', '广州市天河区珠江新城', '2024-03-17 18:30:00', '2025-01-07 20:15:40');
INSERT INTO `orders` VALUES (12, '202403180003', 3, 198.00, 0, '王五', '13800138003', '广州市天河区珠江新城', '2024-03-18 19:45:00', '2025-01-07 20:15:40');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `gender` tinyint NULL DEFAULT 0 COMMENT '性别：0-未知，1-男，2-女',
  `birth_date` date NULL DEFAULT NULL COMMENT '出生日期',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'zhangsan', '13812345678', 'zhangsan@example.com', '张三', 1, '1990-01-15', '2025-01-06 21:17:42', '2025-01-06 21:17:42');
INSERT INTO `users` VALUES (2, 'lisi', '13987654321', 'lisi@example.com', '李四', 1, '1992-03-20', '2025-01-06 21:17:42', '2025-01-06 21:17:42');
INSERT INTO `users` VALUES (3, 'wangwu', '13700001111', 'wangwu@example.com', '王五', 1, '1988-07-08', '2025-01-06 21:17:42', '2025-01-06 21:17:42');
INSERT INTO `users` VALUES (4, 'zhaoliu', '13622222222', 'zhaoliu@example.com', '赵六', 2, '1995-12-25', '2025-01-06 21:17:42', '2025-01-06 21:17:42');
INSERT INTO `users` VALUES (5, 'xiaohong', '13933333333', 'xiaohong@example.com', '小红', 2, '1993-05-18', '2025-01-06 21:17:42', '2025-01-06 21:17:42');
INSERT INTO `users` VALUES (6, 'xiaohua', '13844444444', 'xiaohua@example.com', '小华', 2, '1991-09-30', '2025-01-06 21:17:42', '2025-01-06 21:17:42');
INSERT INTO `users` VALUES (7, 'xiaoming', '13755555555', 'xiaoming@example.com', '小明', 1, '1994-11-11', '2025-01-06 21:17:42', '2025-01-06 21:17:42');
INSERT INTO `users` VALUES (8, 'xiaoli', '13866666666', 'xiaoli@example.com', '小李', 2, '1989-04-01', '2025-01-06 21:17:42', '2025-01-07 19:26:57');

SET FOREIGN_KEY_CHECKS = 1;
