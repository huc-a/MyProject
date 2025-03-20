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

 Date: 09/01/2025 22:17:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books`  (
  `bookid` int NOT NULL AUTO_INCREMENT,
  `bookname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `publish` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `price` float NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `category_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`bookid`) USING BTREE,
  INDEX `fk_book_category`(`category_id` ASC) USING BTREE,
  CONSTRAINT `fk_book_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of books
-- ----------------------------
INSERT INTO `books` VALUES (1, '数据库技术', '北京理工大学出版社', 56.3, '/upload/books/1.jpg', 1);
INSERT INTO `books` VALUES (2, '高等数学', '高等教育出版社', 45.5, '/upload/books/2.jpg', 2);
INSERT INTO `books` VALUES (3, '大学语文', '北京师范大学出版社', 56.7, '/upload/books/3.jpg', 3);
INSERT INTO `books` VALUES (4, 'Java程序设计', '清华大学出版社', 68, '/upload/books/4.jpg', 1);
INSERT INTO `books` VALUES (5, 'Python基础教程', '人民邮电出版社', 59, '/upload/books/5.jpg', 1);
INSERT INTO `books` VALUES (6, 'C++程序设计', '机械工业出版社', 62, '/upload/books/6.jpg', 1);
INSERT INTO `books` VALUES (7, '计算机网络', '电子工业出版社', 58, '/upload/books/7.jpg', 1);
INSERT INTO `books` VALUES (8, '操作系统', '华中科技大学出版社', 49, '/upload/books/8.jpg', 1);
INSERT INTO `books` VALUES (9, '数据结构', '西安电子科技大学出版社', 45, '/upload/books/9.jpg', 1);
INSERT INTO `books` VALUES (10, '软件工程', '北京邮电大学出版社', 42, '/upload/books/10.jpg', 1);

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, '计算机科学', '包含编程、数据库、网络等计算机相关书籍');
INSERT INTO `categories` VALUES (2, '数学', '高等数学、线性代数等数学类书籍');
INSERT INTO `categories` VALUES (3, '文学', '包含语文、文学作品等');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `orderid` int NOT NULL AUTO_INCREMENT,
  `bookid` int NULL DEFAULT NULL,
  `id` int NULL DEFAULT NULL,
  `time` date NULL DEFAULT NULL,
  PRIMARY KEY (`orderid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 1, 2, '2024-01-05');
INSERT INTO `orders` VALUES (2, 2, 2, '2024-01-06');
INSERT INTO `orders` VALUES (3, 3, 3, '2024-01-07');
INSERT INTO `orders` VALUES (4, 4, 4, '2024-01-08');
INSERT INTO `orders` VALUES (5, 5, 5, '2024-01-09');
INSERT INTO `orders` VALUES (6, 6, 6, '2024-01-10');
INSERT INTO `orders` VALUES (7, 7, 7, '2024-01-11');
INSERT INTO `orders` VALUES (8, 8, 8, '2024-01-12');
INSERT INTO `orders` VALUES (9, 9, 9, '2024-01-13');
INSERT INTO `orders` VALUES (10, 10, 10, '2024-01-14');
INSERT INTO `orders` VALUES (11, 1, 3, '2024-01-15');
INSERT INTO `orders` VALUES (12, 2, 4, '2024-01-16');
INSERT INTO `orders` VALUES (13, 3, 5, '2024-01-17');
INSERT INTO `orders` VALUES (14, 4, 6, '2024-01-18');
INSERT INTO `orders` VALUES (15, 5, 7, '2024-01-19');
INSERT INTO `orders` VALUES (19, 3, 2, '2025-01-09');

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '123456', 'admin@example.com', '1990-01-01', 1);
INSERT INTO `users` VALUES (2, 'zhangsan', '123456', 'zhangsan@example.com', '1995-06-15', 0);
INSERT INTO `users` VALUES (3, 'lisi', '123456', 'lisi@example.com', '1992-08-20', 0);
INSERT INTO `users` VALUES (4, 'wangwu', '123456', 'wangwu@example.com', '1993-03-25', 0);
INSERT INTO `users` VALUES (5, 'zhaoliu', '123456', 'zhaoliu@example.com', '1994-11-30', 0);
INSERT INTO `users` VALUES (6, 'sunqi', '123456', 'sunqi@example.com', '1991-07-18', 0);
INSERT INTO `users` VALUES (7, 'zhouba', '123456', 'zhouba@example.com', '1996-04-22', 0);
INSERT INTO `users` VALUES (8, 'wujiu', '123456', 'wujiu@example.com', '1997-09-11', 0);
INSERT INTO `users` VALUES (9, 'zhengshi', '123456', 'zhengshi@example.com', '1998-12-05', 0);
INSERT INTO `users` VALUES (10, 'manager', '123456', 'manager@example.com', '1989-10-01', 1);

SET FOREIGN_KEY_CHECKS = 1;
