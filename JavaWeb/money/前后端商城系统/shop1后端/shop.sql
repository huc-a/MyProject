/*
 Navicat Premium Data Transfer

 Source Server         : tree
 Source Server Type    : MySQL
 Source Server Version : 80040
 Source Host           : localhost:3306
 Source Schema         : shop

 Target Server Type    : MySQL
 Target Server Version : 80040
 File Encoding         : 65001

 Date: 28/12/2024 22:13:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user`  (
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `real_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '真实姓名',
  `sex` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '性别',
  `birthday` date NOT NULL COMMENT '生日',
  `create_datetime` datetime NOT NULL COMMENT '创建日期',
  `update_datetime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES ('admin', 'admin', '超级管理员', '男', '2024-11-10', '2024-11-10 15:23:17', '2024-11-10 15:23:35');
INSERT INTO `admin_user` VALUES ('admin2', '123456', '张虎崖', '男', '2005-06-07', '2024-12-28 00:00:00', NULL);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键id',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `brand` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '品牌',
  `price` decimal(20, 2) NOT NULL COMMENT '价格',
  `stock` int NOT NULL DEFAULT 0 COMMENT '库存',
  `file_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '简介',
  `is_delete` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_datetime` datetime NOT NULL COMMENT '创建时间',
  `update_datetime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('591dcc65036a43bbb0a3db99d3c4a0e8', '玩具', '日用品', 999.00, 98, '591dcc65036a43bbb0a3db99d3c4a0e8.jpg', '我是天子', '0', '2024-12-19 00:00:00', '2024-12-27 00:00:00');
INSERT INTO `goods` VALUES ('9bb58e794b9249e89886362da2b898fb', '辣条', '零食', 6.00, 95, '9bb58e794b9249e89886362da2b898fb.png', '好吃的卫龙辣条', '0', '2024-12-18 00:00:00', '2024-12-18 00:00:00');
INSERT INTO `goods` VALUES ('a1b2c3d4e5f6', '小米手机', '小米', 1999.00, 50, 'a1b2c3d4e5f6.jpg', '小米最新款手机', '0', '2024-12-15 10:00:00', NULL);
INSERT INTO `goods` VALUES ('b2c3d4e5f6g7', 'MacBook Pro', 'Apple', 12999.00, 30, 'b2c3d4e5f6g7.jpg', '苹果笔记本电脑', '0', '2024-12-16 11:30:00', NULL);
INSERT INTO `goods` VALUES ('c3d4e5f6g7h8', '耐克运动鞋', 'Nike', 699.00, 100, 'c3d4e5f6g7h8.jpg', '舒适透气运动鞋', '0', '2024-12-17 14:20:00', NULL);
INSERT INTO `goods` VALUES ('d4e5f6g7h8i9', '可口可乐', '饮料', 3.00, 1000, 'd4e5f6g7h8i9.jpg', '碳酸饮料', '0', '2024-12-18 09:15:00', NULL);
INSERT INTO `goods` VALUES ('e5f6g7h8i9j0', '华为手表', '华为', 1299.00, 80, 'e5f6g7h8i9j0.jpg', '智能运动手表', '0', '2024-12-19 16:40:00', NULL);
INSERT INTO `goods` VALUES ('G101', '联想笔记本', '联想', 5999.00, 45, 'g101.jpg', 'i7处理器,16G内存,高性能商务本', '0', '2024-12-20 10:00:00', NULL);
INSERT INTO `goods` VALUES ('G102', 'OPPO Find X', 'OPPO', 4599.00, 85, 'g102.jpg', '超清相机,65W快充,8G+256G', '0', '2024-12-20 11:00:00', NULL);
INSERT INTO `goods` VALUES ('G103', '明基显示器', '明基', 2799.00, 60, 'g103.jpg', '27寸,2K分辨率,设计专用', '0', '2024-12-21 09:00:00', NULL);
INSERT INTO `goods` VALUES ('G104', '科大讯飞录音笔', '科大讯飞', 999.00, 120, 'g104.jpg', '实时翻译,16G存储,降噪录音', '0', '2024-12-21 10:00:00', NULL);
INSERT INTO `goods` VALUES ('G105', '米家扫地机器人', '小米', 1999.00, 75, 'g105.jpg', 'LDS激光导航,APP控制', '0', '2024-12-22 14:00:00', NULL);
INSERT INTO `goods` VALUES ('G106', '松下吹风机', '松下', 799.00, 150, 'g106.jpg', '纳米水离子,恒温护发', '0', '2024-12-22 15:00:00', NULL);
INSERT INTO `goods` VALUES ('G107', '九阳豆浆机', '九阳', 399.00, 200, 'g107.jpg', '双层防烫,智能预约,静音', '0', '2024-12-23 09:00:00', NULL);
INSERT INTO `goods` VALUES ('G108', '苏泊尔电饭煲', '苏泊尔', 599.00, 180, 'g108.jpg', 'IH加热,4L容量,智能预约', '0', '2024-12-23 10:00:00', NULL);
INSERT INTO `goods` VALUES ('G109', '安踏运动鞋', '安踏', 459.00, 300, 'g109.jpg', '减震透气,专业跑步鞋', '0', '2024-12-24 14:00:00', NULL);
INSERT INTO `goods` VALUES ('G110', '迪卡侬帐篷', '迪卡侬', 899.00, 90, 'g110.jpg', '防雨防晒,2-3人露营帐篷', '0', '2024-12-24 15:00:00', NULL);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键id',
  `user_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `total_price` decimal(20, 2) NOT NULL COMMENT '总价格',
  `issue_datetime` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `received_datetime` datetime NULL DEFAULT NULL COMMENT '签收时间',
  `create_datetime` datetime NOT NULL COMMENT '创建日期',
  `update_datetime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_phone`(`user_phone` ASC) USING BTREE,
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_phone`) REFERENCES `user` (`phone`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('5166c3e4ce0e4946bfc1f959fe0dda8b', '18888888888', 24.00, '2024-12-19 00:00:00', NULL, '2024-12-18 00:00:00', '2024-12-19 00:00:00');
INSERT INTO `order` VALUES ('ord001', '18888888888', 3998.00, '2024-12-20 10:00:00', '2024-12-21 15:00:00', '2024-12-20 09:30:00', NULL);
INSERT INTO `order` VALUES ('ord002', '18888888888', 12999.00, '2024-12-21 11:00:00', NULL, '2024-12-21 10:30:00', NULL);
INSERT INTO `order` VALUES ('ord003', '13333333333', 2097.00, '2024-12-22 14:00:00', '2024-12-23 16:00:00', '2024-12-22 13:30:00', NULL);
INSERT INTO `order` VALUES ('ord004', '13333333333', 1299.00, NULL, NULL, '2024-12-23 09:30:00', NULL);
INSERT INTO `order` VALUES ('ord005', '18888888888', 1398.00, '2024-12-24 10:30:00', '2024-12-25 14:20:00', '2024-12-24 09:00:00', NULL);
INSERT INTO `order` VALUES ('ord006', '13333333333', 2997.00, '2024-12-24 15:00:00', NULL, '2024-12-24 14:30:00', NULL);
INSERT INTO `order` VALUES ('ord007', '18888888888', 9.00, NULL, NULL, '2024-12-25 11:20:00', NULL);
INSERT INTO `order` VALUES ('ord008', '13333333333', 3998.00, '2024-12-26 09:40:00', '2024-12-27 10:30:00', '2024-12-26 09:00:00', NULL);
INSERT INTO `order` VALUES ('ord009', '18888888888', 2598.00, NULL, NULL, '2024-12-27 16:00:00', NULL);
INSERT INTO `order` VALUES ('ORD20241211', '13666666666', 7598.00, '2024-12-11 10:30:00', '2024-12-12 14:20:00', '2024-12-11 10:00:00', NULL);
INSERT INTO `order` VALUES ('ORD20241212', '13666666666', 2998.00, '2024-12-12 11:00:00', NULL, '2024-12-12 10:30:00', NULL);
INSERT INTO `order` VALUES ('ORD20241213', '13666666666', 899.00, NULL, NULL, '2024-12-13 14:00:00', NULL);
INSERT INTO `order` VALUES ('ORD20241214', '13777777777', 4599.00, '2024-12-14 09:30:00', '2024-12-15 14:20:00', '2024-12-14 09:00:00', NULL);
INSERT INTO `order` VALUES ('ORD20241215', '13777777777', 3598.00, '2024-12-15 15:30:00', NULL, '2024-12-15 15:00:00', NULL);
INSERT INTO `order` VALUES ('ORD20241216', '13777777777', 1198.00, NULL, NULL, '2024-12-16 10:00:00', NULL);
INSERT INTO `order` VALUES ('ORD20241217', '13888888888', 5999.00, '2024-12-17 14:20:00', '2024-12-18 16:40:00', '2024-12-17 14:00:00', NULL);
INSERT INTO `order` VALUES ('ORD20241218', '13888888888', 2798.00, '2024-12-18 09:30:00', NULL, '2024-12-18 09:00:00', NULL);
INSERT INTO `order` VALUES ('ORD20241219', '13888888888', 1398.00, NULL, NULL, '2024-12-19 11:20:00', NULL);

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details`  (
  `order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单id',
  `goods_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品id',
  `count` int NOT NULL COMMENT '数量',
  `sub_total` decimal(20, 2) NOT NULL COMMENT '小计',
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE,
  INDEX `idx_goods_id`(`goods_id` ASC) USING BTREE,
  CONSTRAINT `fk_od_goods` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_od_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_details
-- ----------------------------
INSERT INTO `order_details` VALUES ('5166c3e4ce0e4946bfc1f959fe0dda8b', '9bb58e794b9249e89886362da2b898fb', 4, 24.00);
INSERT INTO `order_details` VALUES ('ord001', 'a1b2c3d4e5f6', 2, 3998.00);
INSERT INTO `order_details` VALUES ('ord002', 'b2c3d4e5f6g7', 1, 12999.00);
INSERT INTO `order_details` VALUES ('ord003', 'c3d4e5f6g7h8', 3, 2097.00);
INSERT INTO `order_details` VALUES ('ord004', 'e5f6g7h8i9j0', 1, 1299.00);
INSERT INTO `order_details` VALUES ('ord005', 'c3d4e5f6g7h8', 2, 1398.00);
INSERT INTO `order_details` VALUES ('ord006', 'a1b2c3d4e5f6', 1, 1999.00);
INSERT INTO `order_details` VALUES ('ord006', 'e5f6g7h8i9j0', 1, 998.00);
INSERT INTO `order_details` VALUES ('ord007', 'd4e5f6g7h8i9', 3, 9.00);
INSERT INTO `order_details` VALUES ('ord008', 'a1b2c3d4e5f6', 2, 3998.00);
INSERT INTO `order_details` VALUES ('ord009', 'a1b2c3d4e5f6', 1, 1999.00);
INSERT INTO `order_details` VALUES ('ord009', 'e5f6g7h8i9j0', 1, 599.00);
INSERT INTO `order_details` VALUES ('ORD20241211', 'G101', 1, 5999.00);
INSERT INTO `order_details` VALUES ('ORD20241211', 'G104', 1, 999.00);
INSERT INTO `order_details` VALUES ('ORD20241211', 'G106', 1, 799.00);
INSERT INTO `order_details` VALUES ('ORD20241212', 'G105', 1, 1999.00);
INSERT INTO `order_details` VALUES ('ORD20241212', 'G108', 1, 599.00);
INSERT INTO `order_details` VALUES ('ORD20241212', 'G107', 1, 399.00);
INSERT INTO `order_details` VALUES ('ORD20241213', 'G110', 1, 899.00);
INSERT INTO `order_details` VALUES ('ORD20241214', 'G102', 1, 4599.00);
INSERT INTO `order_details` VALUES ('ORD20241215', 'G105', 1, 1999.00);
INSERT INTO `order_details` VALUES ('ORD20241215', 'G106', 2, 1599.00);
INSERT INTO `order_details` VALUES ('ORD20241216', 'G107', 1, 399.00);
INSERT INTO `order_details` VALUES ('ORD20241216', 'G108', 1, 599.00);
INSERT INTO `order_details` VALUES ('ORD20241216', 'G109', 1, 459.00);
INSERT INTO `order_details` VALUES ('ORD20241217', 'G101', 1, 5999.00);
INSERT INTO `order_details` VALUES ('ORD20241218', 'G103', 1, 2798.00);
INSERT INTO `order_details` VALUES ('ORD20241219', 'G106', 1, 799.00);
INSERT INTO `order_details` VALUES ('ORD20241219', 'G107', 1, 399.00);
INSERT INTO `order_details` VALUES ('ORD20241219', 'G109', 1, 459.00);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `real_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '真实姓名',
  `sex` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '性别',
  `birthday` date NOT NULL COMMENT '生日',
  `address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收货地址',
  `create_datetime` datetime NOT NULL COMMENT '创建时间',
  `update_datetime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`phone`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('13333333333', 'lisi', '1234', '李四', '男', '2024-11-02', '中国', '2024-11-12 00:00:00', '2024-11-12 00:00:00');
INSERT INTO `user` VALUES ('13555555555', 'zhoujiu', '123456', '周九', '男', '1994-07-08', '成都市武侯区', '2024-11-19 11:25:00', NULL);
INSERT INTO `user` VALUES ('13666666666', 'wangwu', '123456', '王五', '男', '1990-05-15', '北京市朝阳区', '2024-11-15 10:30:00', NULL);
INSERT INTO `user` VALUES ('13777777777', 'zhaoliu', '123456', '赵六', '女', '1995-08-20', '上海市浦东新区', '2024-11-16 14:20:00', NULL);
INSERT INTO `user` VALUES ('13888888888', 'qianqi', '123456', '钱七', '男', '1988-12-25', '广州市天河区', '2024-11-17 09:15:00', NULL);
INSERT INTO `user` VALUES ('13999999999', 'sunba', '123456', '孙八', '女', '1992-03-30', '深圳市南山区', '2024-11-18 16:40:00', NULL);
INSERT INTO `user` VALUES ('18888888888', 'zhangsan', '123', '张三', '女', '2024-11-01', '中国', '2024-11-12 00:00:00', '2024-11-13 00:00:00');

SET FOREIGN_KEY_CHECKS = 1;
