/*
 Navicat Premium Data Transfer

 Source Server         : tree
 Source Server Type    : MySQL
 Source Server Version : 80040
 Source Host           : localhost:3306
 Source Schema         : student_management

 Target Server Type    : MySQL
 Target Server Version : 80040
 File Encoding         : 65001

 Date: 21/12/2024 22:26:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for students
-- ----------------------------
DROP TABLE IF EXISTS `students`;
CREATE TABLE `students`  (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `student_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `student_gender` enum('男','女') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `student_age` int NULL DEFAULT NULL,
  `student_class` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of students
-- ----------------------------
INSERT INTO `students` VALUES (1, '张三', '男', 19, '三班');
INSERT INTO `students` VALUES (2, '李四', '男', 18, '一班');
INSERT INTO `students` VALUES (3, '王五', '男', 21, '一班');
INSERT INTO `students` VALUES (4, '糊咖', '男', 18, '一班');
INSERT INTO `students` VALUES (5, '赵晓峰', '男', 18, '一班');
INSERT INTO `students` VALUES (6, '钱悦然', '女', 19, '二班');
INSERT INTO `students` VALUES (7, '孙宇轩', '男', 20, '三班');
INSERT INTO `students` VALUES (8, '李诗涵', '女', 18, '一班');
INSERT INTO `students` VALUES (9, '周俊辉', '男', 19, '二班');
INSERT INTO `students` VALUES (10, '吴静雅', '女', 20, '三班');
INSERT INTO `students` VALUES (11, '郑子豪', '男', 18, '一班');
INSERT INTO `students` VALUES (12, '王雨薇', '女', 19, '二班');
INSERT INTO `students` VALUES (13, '冯晨阳', '男', 20, '三班');
INSERT INTO `students` VALUES (14, '陈嘉怡', '女', 18, '一班');
INSERT INTO `students` VALUES (15, '刘宇航', '男', 19, '二班');
INSERT INTO `students` VALUES (16, '黄思琪', '女', 20, '三班');
INSERT INTO `students` VALUES (17, '张博远', '男', 18, '一班');
INSERT INTO `students` VALUES (18, '林晓妍', '女', 19, '二班');
INSERT INTO `students` VALUES (19, '杨泽宇', '男', 20, '三班');
INSERT INTO `students` VALUES (20, '苏婉晴', '女', 18, '一班');
INSERT INTO `students` VALUES (21, '叶俊熙', '男', 19, '二班');
INSERT INTO `students` VALUES (22, '许萌萌', '女', 20, '三班');
INSERT INTO `students` VALUES (23, '何雨泽', '男', 18, '一班');
INSERT INTO `students` VALUES (24, '谢安琪', '女', 19, '二班');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'user',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '123456', 'admin', '2024-12-21 16:43:37', '2024-12-21 16:43:37');

SET FOREIGN_KEY_CHECKS = 1;
