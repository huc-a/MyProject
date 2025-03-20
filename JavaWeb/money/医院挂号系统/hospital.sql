/*
 Navicat Premium Data Transfer

 Source Server         : tree
 Source Server Type    : MySQL
 Source Server Version : 80040
 Source Host           : localhost:3306
 Source Schema         : hospital

 Target Server Type    : MySQL
 Target Server Version : 80040
 File Encoding         : 65001

 Date: 24/12/2024 11:52:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '科室名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '科室描述',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '内科', '处理内部器官疾病', '2024-12-23 22:03:12', '2024-12-23 22:03:12');
INSERT INTO `department` VALUES (2, '外科', '进行外科手术治疗', '2024-12-23 22:03:12', '2024-12-23 22:03:12');
INSERT INTO `department` VALUES (3, '儿科', '专门治疗儿童疾病', '2024-12-23 22:03:12', '2024-12-23 22:03:12');
INSERT INTO `department` VALUES (4, '妇科', '专门治疗妇科疾病', '2024-12-23 22:03:12', '2024-12-23 22:03:12');
INSERT INTO `department` VALUES (5, '骨科', '处理骨骼相关疾病', '2024-12-23 22:03:12', '2024-12-23 22:03:12');

-- ----------------------------
-- Table structure for doctor_department
-- ----------------------------
DROP TABLE IF EXISTS `doctor_department`;
CREATE TABLE `doctor_department`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `doctor_id` bigint NOT NULL COMMENT '医生ID',
  `department_id` bigint NOT NULL COMMENT '科室ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_doctor_dept`(`doctor_id` ASC, `department_id` ASC) USING BTREE COMMENT '确保医生不会重复关联同一科室',
  INDEX `department_id`(`department_id` ASC) USING BTREE,
  CONSTRAINT `doctor_department_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `doctor_department_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctor_department
-- ----------------------------
INSERT INTO `doctor_department` VALUES (2, 2, 2, '2024-12-23 22:03:12');
INSERT INTO `doctor_department` VALUES (3, 3, 3, '2024-12-23 22:03:12');
INSERT INTO `doctor_department` VALUES (10, 1, 1, '2024-12-23 22:25:35');

-- ----------------------------
-- Table structure for registration
-- ----------------------------
DROP TABLE IF EXISTS `registration`;
CREATE TABLE `registration`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `patient_id` bigint NOT NULL COMMENT '病人ID',
  `doctor_id` bigint NOT NULL COMMENT '医生ID',
  `department_id` bigint NOT NULL COMMENT '科室ID',
  `registration_time` datetime NOT NULL COMMENT '挂号时间',
  `visit_date` date NOT NULL COMMENT '就诊日期',
  `time_slot` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '就诊时间段',
  `status` enum('pending','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending' COMMENT '状态：待就诊/已完成/已取消',
  `fee` decimal(10, 2) NOT NULL COMMENT '挂号费用',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `patient_id`(`patient_id` ASC) USING BTREE,
  INDEX `doctor_id`(`doctor_id` ASC) USING BTREE,
  INDEX `department_id`(`department_id` ASC) USING BTREE,
  CONSTRAINT `registration_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `registration_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `registration_ibfk_3` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of registration
-- ----------------------------
INSERT INTO `registration` VALUES (1, 4, 1, 1, '2024-12-23 22:30:10', '2024-12-23', '上午', 'pending', 20.00, '2024-12-23 22:30:10', '2024-12-24 11:42:31');
INSERT INTO `registration` VALUES (2, 5, 1, 1, '2024-12-23 22:30:10', '2024-12-23', '下午', 'pending', 15.00, '2024-12-23 22:30:10', '2024-12-24 11:42:37');
INSERT INTO `registration` VALUES (3, 6, 2, 2, '2024-12-23 22:30:10', '2024-12-23', '上午', 'cancelled', 20.00, '2024-12-23 22:30:10', '2024-12-23 22:30:10');
INSERT INTO `registration` VALUES (4, 7, 2, 2, '2024-12-23 22:30:10', '2024-12-23', '下午', 'pending', 15.00, '2024-12-23 22:30:10', '2024-12-23 22:30:10');
INSERT INTO `registration` VALUES (5, 4, 1, 1, '2024-12-23 22:30:10', '2024-12-24', '上午', 'cancelled', 20.00, '2024-12-23 22:30:10', '2024-12-23 22:41:06');
INSERT INTO `registration` VALUES (6, 5, 2, 2, '2024-12-23 22:30:10', '2024-12-24', '下午', 'pending', 15.00, '2024-12-23 22:30:10', '2024-12-23 22:30:10');
INSERT INTO `registration` VALUES (7, 6, 3, 3, '2024-12-23 22:30:10', '2024-12-24', '晚上', 'pending', 30.00, '2024-12-23 22:30:10', '2024-12-23 22:30:10');
INSERT INTO `registration` VALUES (8, 7, 1, 1, '2024-12-23 22:30:10', '2024-12-25', '上午', 'pending', 20.00, '2024-12-23 22:30:10', '2024-12-24 11:42:50');
INSERT INTO `registration` VALUES (9, 4, 2, 2, '2024-12-23 22:30:10', '2024-12-25', '下午', 'pending', 15.00, '2024-12-23 22:30:10', '2024-12-23 22:30:10');
INSERT INTO `registration` VALUES (10, 5, 3, 3, '2024-12-23 22:30:10', '2024-12-25', '晚上', 'pending', 30.00, '2024-12-23 22:30:10', '2024-12-24 11:41:06');
INSERT INTO `registration` VALUES (11, 6, 1, 1, '2024-12-23 22:30:10', '2024-12-26', '上午', 'pending', 20.00, '2024-12-23 22:30:10', '2024-12-24 11:44:15');
INSERT INTO `registration` VALUES (12, 7, 2, 2, '2024-12-23 22:30:10', '2024-12-27', '下午', 'pending', 15.00, '2024-12-23 22:30:10', '2024-12-23 22:30:10');
INSERT INTO `registration` VALUES (13, 4, 3, 3, '2024-12-23 22:30:10', '2024-12-28', '晚上', 'pending', 30.00, '2024-12-23 22:30:10', '2024-12-23 22:30:10');
INSERT INTO `registration` VALUES (14, 5, 1, 1, '2024-12-23 22:30:10', '2024-12-29', '上午', 'pending', 20.00, '2024-12-23 22:30:10', '2024-12-23 22:30:10');
INSERT INTO `registration` VALUES (15, 6, 2, 2, '2024-12-23 22:30:10', '2024-12-30', '下午', 'pending', 15.00, '2024-12-23 22:30:10', '2024-12-23 22:30:10');
INSERT INTO `registration` VALUES (16, 4, 1, 1, '2024-12-23 22:45:51', '2024-12-24', '上午', 'cancelled', 20.00, '2024-12-23 22:45:51', '2024-12-23 23:47:23');
INSERT INTO `registration` VALUES (17, 4, 3, 3, '2024-12-23 22:49:15', '2024-12-25', '下午', 'pending', 15.00, '2024-12-23 22:49:15', '2024-12-23 22:49:15');
INSERT INTO `registration` VALUES (18, 4, 3, 3, '2024-12-23 23:26:04', '2024-12-24', '下午', 'cancelled', 15.00, '2024-12-23 23:26:04', '2024-12-23 23:26:13');
INSERT INTO `registration` VALUES (19, 4, 2, 2, '2024-12-23 23:47:58', '2024-12-24', '上午', 'cancelled', 20.00, '2024-12-23 23:47:58', '2024-12-23 23:52:50');
INSERT INTO `registration` VALUES (20, 4, 3, 3, '2024-12-23 23:53:46', '2024-12-25', '晚上', 'cancelled', 30.00, '2024-12-23 23:53:46', '2024-12-23 23:54:44');

-- ----------------------------
-- Table structure for registration_fee
-- ----------------------------
DROP TABLE IF EXISTS `registration_fee`;
CREATE TABLE `registration_fee`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `time_slot` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '时间段',
  `fee` decimal(10, 2) NOT NULL COMMENT '费用',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `time_slot`(`time_slot` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of registration_fee
-- ----------------------------
INSERT INTO `registration_fee` VALUES (1, '上午', 20.00, '2024-12-23 22:03:12', '2024-12-23 22:03:12');
INSERT INTO `registration_fee` VALUES (2, '下午', 15.00, '2024-12-23 22:03:12', '2024-12-23 22:03:12');
INSERT INTO `registration_fee` VALUES (3, '晚上', 30.00, '2024-12-23 22:03:12', '2024-12-23 22:03:12');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号，用作登录账号',
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `full_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓名',
  `user_type` enum('patient','doctor') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户类型：病人/医生',
  `id_card_number` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `phone`(`phone` ASC) USING BTREE,
  UNIQUE INDEX `id_card_number`(`id_card_number` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, '13800138001', '123456', '张豪', 'doctor', '110101199001011234', '2024-12-23 22:03:12', '2024-12-24 11:47:50');
INSERT INTO `users` VALUES (2, '13800138002', '123456', '李锦泽', 'doctor', '110101199001021235', '2024-12-23 22:03:12', '2024-12-24 11:48:37');
INSERT INTO `users` VALUES (3, '13800138003', '123456', '王一酒', 'doctor', '110101199001031236', '2024-12-23 22:03:12', '2024-12-24 11:48:24');
INSERT INTO `users` VALUES (4, '13900139001', '123456', '刘易宏', 'patient', '110101199501011234', '2024-12-23 22:03:12', '2024-12-24 11:48:18');
INSERT INTO `users` VALUES (5, '13900139002', '123456', '陈糕', 'patient', '110101199502021235', '2024-12-23 22:03:12', '2024-12-24 11:49:02');
INSERT INTO `users` VALUES (6, '13900139003', '123456', '杨尚禾', 'patient', '110101199503031236', '2024-12-23 22:03:12', '2024-12-24 11:49:15');
INSERT INTO `users` VALUES (7, '13900139004', '123456', '黄术', 'patient', '110101199504041237', '2024-12-23 22:03:12', '2024-12-24 11:49:21');

SET FOREIGN_KEY_CHECKS = 1;
