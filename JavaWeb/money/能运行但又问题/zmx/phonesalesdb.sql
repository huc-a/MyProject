/*
 Navicat Premium Data Transfer

 Source Server         : MYSQL
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : localhost:3306
 Source Schema         : phonesalesdb

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 21/12/2024 21:27:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_delivery
-- ----------------------------
DROP TABLE IF EXISTS `t_delivery`;
CREATE TABLE `t_delivery`  (
  `deliveryid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `useraccount` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户账号',
  `country` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '国家',
  `province` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '省',
  `city` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '城市',
  `detailaddr` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '详细地址',
  `contactphone1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系电话1',
  `contactphone2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系电话2',
  PRIMARY KEY (`deliveryid`) USING BTREE,
  INDEX `fk_delivery_useraccount`(`useraccount`) USING BTREE,
  CONSTRAINT `fk_delivery_useraccount` FOREIGN KEY (`useraccount`) REFERENCES `t_user` (`useraccount`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_delivery
-- ----------------------------
INSERT INTO `t_delivery` VALUES (11, '123455', '中国', '云南', '昆明', '杨林镇', '123123123', '123412341');
INSERT INTO `t_delivery` VALUES (12, NULL, '中国', '云南', '昆明', '嵩明', '123456', NULL);
INSERT INTO `t_delivery` VALUES (16, '123444', '中国', '河南', '郑州', '新郑', '123456789', '123456456');
INSERT INTO `t_delivery` VALUES (18, '123333', '中国', '云南', '昆明', '官渡区', '12345454', '123456654');
INSERT INTO `t_delivery` VALUES (19, NULL, '中国', '云南', '昆明', '官渡', NULL, NULL);

-- ----------------------------
-- Table structure for t_orderrecord
-- ----------------------------
DROP TABLE IF EXISTS `t_orderrecord`;
CREATE TABLE `t_orderrecord`  (
  `saleid` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售ID',
  `productid` int(11) NOT NULL COMMENT '产品ID',
  `salequantity` int(11) DEFAULT NULL COMMENT '销售数量',
  `saleamount` decimal(10, 2) DEFAULT NULL COMMENT '销售金额',
  `saletime` datetime(0) DEFAULT NULL COMMENT '销售时间',
  `useraccount` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '购买人账号',
  `recordstatus` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '记录状态',
  PRIMARY KEY (`saleid`) USING BTREE,
  INDEX `fk_orderrecord_productid`(`productid`) USING BTREE,
  INDEX `fk_orderrecord_useraccount`(`useraccount`) USING BTREE,
  CONSTRAINT `fk_orderrecord_productid` FOREIGN KEY (`productid`) REFERENCES `t_product` (`productid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_orderrecord_useraccount` FOREIGN KEY (`useraccount`) REFERENCES `t_user` (`useraccount`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_orderrecord
-- ----------------------------
INSERT INTO `t_orderrecord` VALUES (1, 1, 10, 54990.00, '2024-11-21 10:10:17', '123333', '运输');
INSERT INTO `t_orderrecord` VALUES (2, 2, 20, 129980.00, '2024-11-22 10:11:17', '123444', '下单');
INSERT INTO `t_orderrecord` VALUES (3, 5, 10, 52990.00, '2024-11-19 10:12:04', '123455', '完成');

-- ----------------------------
-- Table structure for t_product
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product`  (
  `productid` int(11) NOT NULL COMMENT '产品ID',
  `productname` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '产品名称',
  `brand` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '品牌',
  `memory` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '内存',
  `price` decimal(10, 2) DEFAULT NULL COMMENT '销售价格',
  `colortype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '颜色种类',
  `productlmage` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '产品图片',
  PRIMARY KEY (`productid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES (1, 'HUAWEI Mate 60', '华为', '12GB', 5499.00, '雅川青，白沙银，南糯紫，雅丹黑', NULL);
INSERT INTO `t_product` VALUES (2, 'vivo X100 Ultra', 'vivo', '12GB', 6499.00, '钛色，白月光，深空灰', NULL);
INSERT INTO `t_product` VALUES (5, ' 小米15 Pro', '小米', '12GB', 5299.00, '岩石灰，白色，银杉绿，亮银版', NULL);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `useraccount` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录密码',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `utid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '类型',
  `idnumber` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '身份证号码',
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '手机号码',
  PRIMARY KEY (`useraccount`) USING BTREE,
  INDEX `useraccount`(`useraccount`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('123333', '777777', '小兰', '会员', '123456777897894563', '12345677897');
INSERT INTO `t_user` VALUES ('123444', '888888', '小明', '管理员', '111222333344445555', '12344556677');
INSERT INTO `t_user` VALUES ('123455', '666666', '小红', '会员', '112233445566778899', '12345678999');

-- ----------------------------
-- View structure for v_orderrecord
-- ----------------------------
DROP VIEW IF EXISTS `v_orderrecord`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `v_orderrecord` AS select `t_orderrecord`.`saleid` AS `saleid`,`t_orderrecord`.`productid` AS `productid`,`t_orderrecord`.`salequantity` AS `salequantity`,`t_orderrecord`.`saleamount` AS `saleamount`,`t_orderrecord`.`saletime` AS `saletime`,`t_orderrecord`.`useraccount` AS `useraccount`,`t_orderrecord`.`recordstatus` AS `recordstatus`,`t_product`.`productname` AS `productname`,`t_product`.`brand` AS `brand`,`t_product`.`memory` AS `memory`,`t_product`.`price` AS `price`,`t_product`.`colortype` AS `colortype`,`t_product`.`productlmage` AS `productlmage`,`t_user`.`pwd` AS `pwd`,`t_user`.`username` AS `username`,`t_user`.`utid` AS `utid`,`t_user`.`idnumber` AS `idnumber`,`t_user`.`mobile` AS `mobile` from ((`t_orderrecord` join `t_product` on((`t_orderrecord`.`productid` = `t_product`.`productid`))) join `t_user` on((`t_orderrecord`.`useraccount` = `t_user`.`useraccount`)));

SET FOREIGN_KEY_CHECKS = 1;
