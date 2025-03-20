/*
 Navicat Premium Data Transfer

 Source Server         : tree
 Source Server Type    : MySQL
 Source Server Version : 80040
 Source Host           : localhost:3306
 Source Schema         : jdbc

 Target Server Type    : MySQL
 Target Server Version : 80040
 File Encoding         : 65001

 Date: 09/01/2025 22:48:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book_categories
-- ----------------------------
DROP TABLE IF EXISTS `book_categories`;
CREATE TABLE `book_categories`  (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of book_categories
-- ----------------------------
INSERT INTO `book_categories` VALUES (1, '计算机科学', '计算机相关的专业书籍');
INSERT INTO `book_categories` VALUES (2, '文学艺术', '文学、艺术类书籍');
INSERT INTO `book_categories` VALUES (3, '经济管理', '经济、管理类书籍');
INSERT INTO `book_categories` VALUES (4, '自然科学', '物理、化学、生物等自然科学类书籍');
INSERT INTO `book_categories` VALUES (5, '社会科学', '社会学、心理学等社会科学类书籍');

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books`  (
  `bookid` int NOT NULL AUTO_INCREMENT,
  `bookname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `publish` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `price` float NULL DEFAULT NULL,
  `stock` int NULL DEFAULT 100,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `category_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`bookid`) USING BTREE,
  INDEX `fk_book_category`(`category_id` ASC) USING BTREE,
  CONSTRAINT `fk_book_category` FOREIGN KEY (`category_id`) REFERENCES `book_categories` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of books
-- ----------------------------
INSERT INTO `books` VALUES (1, '人工智能导论', '清华大学出版社', 79, 10, '/upload/books/1.jpg', 1);
INSERT INTO `books` VALUES (2, '深度学习实战', '清华大学出版社', 89, 8, '/upload/books/2.jpg', 1);
INSERT INTO `books` VALUES (3, '微服务架构设计', '机械工业出版社', 69, 15, '/upload/books/3.jpg', 1);
INSERT INTO `books` VALUES (4, '云计算与大数据', '电子工业出版社', 75, 12, '/upload/books/4.jpg', 1);
INSERT INTO `books` VALUES (5, 'Spring Boot实践', '华中科技大学出版社', 65, 20, '/upload/books/5.jpg', 1);
INSERT INTO `books` VALUES (6, '区块链技术指南', '北京大学出版社', 85, 25, '/upload/books/6.jpg', 4);
INSERT INTO `books` VALUES (7, '物联网应用开发', '西安交通大学出版社', 72, 40, '/upload/books/7.jpg', 4);
INSERT INTO `books` VALUES (8, '移动应用开发实战', '浙江大学出版社', 68, 35, '/upload/books/8.jpg', 3);
INSERT INTO `books` VALUES (9, '网络安全技术', '复旦大学出版社', 78, 30, '/upload/books/9.jpg', 3);
INSERT INTO `books` VALUES (10, '数据可视化设计', '同济大学出版社', 66, 40, '/upload/books/10.jpg', 3);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `orderid` int NOT NULL AUTO_INCREMENT,
  `bookid` int NULL DEFAULT NULL,
  `id` int NULL DEFAULT NULL,
  `quantity` int NULL DEFAULT 1,
  `total_price` decimal(10, 2) NULL DEFAULT NULL,
  `status` int NULL DEFAULT 0,
  `time` datetime NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`orderid`) USING BTREE,
  INDEX `bookid`(`bookid` ASC) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`bookid`) REFERENCES `books` (`bookid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 1, 2, 1, 79.00, 3, '2024-01-05 10:00:00', '上海市徐汇区', '13922222222');
INSERT INTO `orders` VALUES (2, 3, 2, 2, 138.00, 2, '2024-01-06 14:30:00', '上海市徐汇区', '13922222222');
INSERT INTO `orders` VALUES (3, 2, 3, 1, 89.00, 1, '2024-01-07 16:20:00', '广州市番禺区', '13933333333');
INSERT INTO `orders` VALUES (4, 5, 4, 1, 65.00, 0, '2024-01-08 09:15:00', '深圳市罗湖区', '13944444444');
INSERT INTO `orders` VALUES (5, 4, 5, 1, 75.00, 2, '2024-01-08 14:30:00', '杭州市西湖区', '13955555555');
INSERT INTO `orders` VALUES (6, 6, 6, 2, 170.00, 1, '2024-01-08 15:45:00', '成都市武侯区', '13966666666');
INSERT INTO `orders` VALUES (7, 7, 7, 1, 72.00, 3, '2024-01-08 16:20:00', '南京市鼓楼区', '13977777777');
INSERT INTO `orders` VALUES (8, 8, 8, 1, 68.00, 0, '2024-01-09 09:15:00', '武汉市洪山区', '13988888888');
INSERT INTO `orders` VALUES (9, 9, 2, 2, 156.00, 2, '2024-01-09 10:30:00', '上海市徐汇区', '13922222222');
INSERT INTO `orders` VALUES (10, 10, 3, 1, 66.00, 1, '2024-01-09 11:45:00', '广州市番禺区', '13933333333');
INSERT INTO `orders` VALUES (11, 1, 4, 2, 158.00, 0, '2024-01-09 14:20:00', '深圳市罗湖区', '13944444444');
INSERT INTO `orders` VALUES (12, 3, 5, 1, 69.00, 2, '2024-01-09 15:40:00', '杭州市西湖区', '13955555555');
INSERT INTO `orders` VALUES (13, 5, 6, 2, 130.00, 3, '2024-01-09 16:55:00', '成都市武侯区', '13966666666');
INSERT INTO `orders` VALUES (14, 7, 7, 1, 72.00, 1, '2024-01-10 09:30:00', '南京市鼓楼区', '13977777766');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `PASSWORD` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `email` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `birthday` date NULL DEFAULT NULL,
  `isadmin` int NULL DEFAULT 0,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '123456', 'admin@example.com', '1990-01-01', 1, '北京市朝阳区', '13811111111');
INSERT INTO `users` VALUES (2, 'chenming', '123456', 'chenming@example.com', '1995-03-15', 0, '上海市徐汇区', '13922222222');
INSERT INTO `users` VALUES (3, 'liuyan', '123456', 'liuyan@example.com', '1997-08-20', 0, '广州市番禺区', '13933333333');
INSERT INTO `users` VALUES (4, 'wangfei', '123456', 'wangfei@example.com', '1994-05-25', 0, '深圳市罗湖区', '13944444444');
INSERT INTO `users` VALUES (5, 'zhangwei', '123456', 'zhangwei@example.com', '1996-11-18', 0, '杭州市西湖区', '13955555555');
INSERT INTO `users` VALUES (6, 'linjing', '123456', 'linjing@example.com', '1993-07-10', 0, '成都市武侯区', '13966666666');
INSERT INTO `users` VALUES (7, 'huangxiao', '123456', 'huangxiao@example.com', '1998-04-22', 0, '南京市鼓楼区', '13977777777');
INSERT INTO `users` VALUES (8, 'zhoujie', '123456', 'zhoujie@example.com', '1992-09-30', 0, '武汉市洪山区', '13988888888');

SET FOREIGN_KEY_CHECKS = 1;
