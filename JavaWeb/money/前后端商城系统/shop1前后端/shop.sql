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

 Date: 27/12/2024 22:25:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user`  (
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `real_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '真实姓名',
  `sex` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '性别',
  `birthday` date NOT NULL COMMENT '生日',
  `create_datetime` datetime NOT NULL COMMENT '创建日期',
  `update_datetime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '管理员用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES ('admin', 'admin', '超级管理员', '男', '2024-11-10', '2024-11-10 15:23:17', '2024-11-10 15:23:35');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键id',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `brand` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '品牌',
  `price` decimal(20, 2) NOT NULL COMMENT '价格',
  `stock` int NOT NULL DEFAULT 0 COMMENT '库存',
  `file_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '简介',
  `is_delete` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '是否删除',
  `create_datetime` datetime NOT NULL COMMENT '创建时间',
  `update_datetime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品表' ROW_FORMAT = DYNAMIC;

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

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键id',
  `user_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `total_price` decimal(20, 2) NOT NULL COMMENT '总价格',
  `issue_datetime` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `received_datetime` datetime NULL DEFAULT NULL COMMENT '签收时间',
  `create_datetime` datetime NOT NULL COMMENT '创建日期',
  `update_datetime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('5166c3e4ce0e4946bfc1f959fe0dda8b', '18888888888', 24.00, '2024-12-19 00:00:00', NULL, '2024-12-18 00:00:00', '2024-12-19 00:00:00');
INSERT INTO `order` VALUES ('ord001', '18888888888', 3998.00, '2024-12-20 10:00:00', '2024-12-21 15:00:00', '2024-12-20 09:30:00', NULL);
INSERT INTO `order` VALUES ('ord002', '18888888888', 12999.00, '2024-12-21 11:00:00', NULL, '2024-12-21 10:30:00', NULL);
INSERT INTO `order` VALUES ('ord003', '13333333333', 2097.00, '2024-12-22 14:00:00', '2024-12-23 16:00:00', '2024-12-22 13:30:00', NULL);
INSERT INTO `order` VALUES ('ord004', '13333333333', 1299.00, NULL, NULL, '2024-12-23 09:30:00', NULL);

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details`  (
  `order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单id',
  `goods_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品id',
  `count` int NOT NULL COMMENT '数量',
  `sub_total` decimal(20, 2) NOT NULL COMMENT '小计'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单详情表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_details
-- ----------------------------
INSERT INTO `order_details` VALUES ('5166c3e4ce0e4946bfc1f959fe0dda8b', '9bb58e794b9249e89886362da2b898fb', 4, 24.00);
INSERT INTO `order_details` VALUES ('ord001', 'a1b2c3d4e5f6', 2, 3998.00);
INSERT INTO `order_details` VALUES ('ord002', 'b2c3d4e5f6g7', 1, 12999.00);
INSERT INTO `order_details` VALUES ('ord003', 'c3d4e5f6g7h8', 3, 2097.00);
INSERT INTO `order_details` VALUES ('ord004', 'e5f6g7h8i9j0', 1, 1299.00);

-- ----------------------------
-- Table structure for shop_car
-- ----------------------------
DROP TABLE IF EXISTS `shop_car`;
CREATE TABLE `shop_car`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `goods_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品id',
  `count` int NOT NULL COMMENT '数量',
  `create_user` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建人',
  `create_datetime` datetime NOT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '购物车表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_car
-- ----------------------------
INSERT INTO `shop_car` VALUES (2, '591dcc65036a43bbb0a3db99d3c4a0e8', 1, '13333333333', '2024-12-27 00:00:00');
INSERT INTO `shop_car` VALUES (3, 'a1b2c3d4e5f6', 2, '18888888888', '2024-12-26 15:30:00');
INSERT INTO `shop_car` VALUES (4, 'b2c3d4e5f6g7', 1, '18888888888', '2024-12-26 15:35:00');
INSERT INTO `shop_car` VALUES (5, 'c3d4e5f6g7h8', 3, '13333333333', '2024-12-26 16:00:00');
INSERT INTO `shop_car` VALUES (6, 'd4e5f6g7h8i9', 6, '13333333333', '2024-12-26 16:10:00');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `real_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '真实姓名',
  `sex` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '性别',
  `birthday` date NOT NULL COMMENT '生日',
  `address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '收货地址',
  `create_datetime` datetime NOT NULL COMMENT '创建时间',
  `update_datetime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`phone`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('13333333333', 'lisi', '1234', '李四', '男', '2024-11-02', '中国', '2024-11-12 00:00:00', '2024-11-12 00:00:00');
INSERT INTO `user` VALUES ('18888888888', 'zhangsan', '123', '张三', '女', '2024-11-01', '中国', '2024-11-12 00:00:00', '2024-11-13 00:00:00');

SET FOREIGN_KEY_CHECKS = 1;
