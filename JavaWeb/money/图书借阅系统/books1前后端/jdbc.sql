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

 Date: 20/12/2024 15:50:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for books
-- ----------------------------
CREATE TABLE `books`  (
  `bookid` int NOT NULL AUTO_INCREMENT,
  `bookname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `publish` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `price` float NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`bookid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of books
-- ----------------------------
INSERT INTO `books` VALUES (1, '数据库技术', '清华大学出版社', 69.9, 'resource/books/book1.jpg');
INSERT INTO `books` VALUES (2, '高等数学', '高等教育出版社', 45.5, 'resource/books/book2.jpg');
INSERT INTO `books` VALUES (3, '大学语文', '清华大学出版社', 56.7, 'resource/books/book3.jpg');
INSERT INTO `books` VALUES (4, 'Java程序设计', '机械工业出版社', 69.9, 'resource/books/book4.jpg');
INSERT INTO `books` VALUES (5, '计算机网络', '电子工业出版社', 58, 'resource/books/book5.jpg');
INSERT INTO `books` VALUES (6, '操作系统原理', '清华大学出版社', 49.8, 'resource/books/book6.jpg');
INSERT INTO `books` VALUES (7, 'Python入门到实践', '人民邮电出版社', 79, 'resource/books/book7.jpg');
INSERT INTO `books` VALUES (8, '数据结构与算法', '高等教育出版社', 45, 'resource/books/book8.jpg');
INSERT INTO `books` VALUES (9, 'Web开发实战', '电子工业出版社', 68.5, 'resource/books/book9.jpg');
INSERT INTO `books` VALUES (10, '软件工程导论', '清华大学出版社', 42, 'resource/books/book10.jpg');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
CREATE TABLE `orders`  (
  `orderid` int NOT NULL AUTO_INCREMENT,
  `bookid` int NULL DEFAULT NULL,
  `id` int NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL COMMENT '借阅时间',
  `returntime` datetime NULL DEFAULT NULL COMMENT '归还时间',
  PRIMARY KEY (`orderid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 1, 1, '2024-12-05 00:00:00', '2024-12-12 14:42:52');
INSERT INTO `orders` VALUES (3, 3, 1, '2024-12-03 00:00:00', NULL);
INSERT INTO `orders` VALUES (4, 1, 2, '2024-11-13 00:00:00', NULL);
INSERT INTO `orders` VALUES (5, 2, 2, '2024-11-07 00:00:00', '2024-12-04 15:49:02');
INSERT INTO `orders` VALUES (8, 2, 3, '2024-07-04 00:00:00', NULL);
INSERT INTO `orders` VALUES (11, 1, 3, '2024-12-20 00:00:00', '2024-12-20 15:49:35');
INSERT INTO `orders` VALUES (12, 4, 3, '2024-12-15 00:00:00', NULL);
INSERT INTO `orders` VALUES (13, 5, 3, '2024-12-10 00:00:00', NULL);
INSERT INTO `orders` VALUES (14, 6, 4, '2024-12-18 00:00:00', '2024-12-19 15:49:10');
INSERT INTO `orders` VALUES (15, 7, 4, '2024-12-05 00:00:00', NULL);
INSERT INTO `orders` VALUES (16, 8, 5, '2024-12-19 00:00:00', NULL);
INSERT INTO `orders` VALUES (17, 9, 5, '2024-12-01 00:00:00', '2024-12-14 15:49:17');
INSERT INTO `orders` VALUES (18, 9, 3, '2024-12-20 14:20:47', NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `PASSWORD` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `email` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `birthday` date NULL DEFAULT NULL,
  `isadmin` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'zs', '123456', 'zs@sina.com', '2004-11-25', 1);
INSERT INTO `users` VALUES (2, 'lisi', '123456', '54664@vdv.com', '2004-10-14', 1);
INSERT INTO `users` VALUES (3, 'wangwu', '123456', '4898453@4596.com', '2001-11-08', 0);
INSERT INTO `users` VALUES (4, 'ddd22', '2163456', 'wer@gag.cn', '2024-12-05', 0);
INSERT INTO `users` VALUES (5, '张三', '123456', 'cy165@gag.cn', '2024-12-08', 0);

SET FOREIGN_KEY_CHECKS = 1;
