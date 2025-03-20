/*
 Navicat Premium Data Transfer

 Source Server         : tree
 Source Server Type    : MySQL
 Source Server Version : 80040
 Source Host           : localhost:3306
 Source Schema         : tourism_db

 Target Server Type    : MySQL
 Target Server Version : 80040
 File Encoding         : 65001

 Date: 27/12/2024 21:51:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for attraction_categories
-- ----------------------------
DROP TABLE IF EXISTS `attraction_categories`;
CREATE TABLE `attraction_categories`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of attraction_categories
-- ----------------------------
INSERT INTO `attraction_categories` VALUES (1, '自然风光', '山川、湖泊、森林等自然景观');
INSERT INTO `attraction_categories` VALUES (2, '人文古迹', '历史遗迹、古建筑、博物馆等');
INSERT INTO `attraction_categories` VALUES (3, '红色文化', '革命遗址、纪念馆等红色旅游景点');
INSERT INTO `attraction_categories` VALUES (4, '科技文化', '科技馆、航天基地等科技类景点');
INSERT INTO `attraction_categories` VALUES (5, '宗教寺庙', '寺院、道观等宗教场所');

-- ----------------------------
-- Table structure for attractions
-- ----------------------------
DROP TABLE IF EXISTS `attractions`;
CREATE TABLE `attractions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '绵阳',
  `category_id` int NULL DEFAULT NULL,
  `level` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `ticket_price` decimal(10, 2) NULL DEFAULT NULL,
  `opening_hours` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `suggested_duration` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_id`(`category_id` ASC) USING BTREE,
  CONSTRAINT `attractions_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `attraction_categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of attractions
-- ----------------------------
INSERT INTO `attractions` VALUES (1, '富乐山风景', '绵阳', 1, '4A', '富乐山是绵阳市区内的一座山峰，山势雄伟，景色秀丽。山上有富乐寺、观音阁等古迹，是绵阳市民休闲游玩的好去处。', 30.00, '08:00-17:30', 3);
INSERT INTO `attractions` VALUES (2, '涪江风光带', '绵阳', 1, '4A', '涪江穿城而过，沿江建有景观步道、休闲广场等设施，是市民休闲娱乐的好去处。', 0.00, '全天开放', 2);
INSERT INTO `attractions` VALUES (3, '九皇山古镇', '绵阳', 2, '4A', '九皇山古镇位于绵阳市安州区，是一座具有千年历史的古镇，保存着大量明清时期的建筑。', 60.00, '08:00-17:00', 4);
INSERT INTO `attractions` VALUES (4, '李白故里', '绵阳', 2, '4A', '位于江油市青莲乡，是唐代大诗人李白的出生地和少年时期生活的地方，现为全国重点文物保护单位。', 50.00, '08:30-17:30', 3);
INSERT INTO `attractions` VALUES (5, '中国科技城科技馆', '绵阳', 3, '4A', '展示了绵阳科技发展成就，设有航天科技、军民融合等主题展区。', 40.00, '09:00-17:00', 3);
INSERT INTO `attractions` VALUES (6, '绵阳中国科技城科普教育基地', '绵阳', 3, '4A', '集科普教育、研学旅行于一体的综合性基地。', 45.00, '09:00-16:30', 4);
INSERT INTO `attractions` VALUES (7, '中国(绵阳)科技城', '绵阳', 4, '5A', '是中国重要的科研基地和科技旅游目的地，可参观科技展览馆等场所。', 0.00, '09:00-17:00', 4);
INSERT INTO `attractions` VALUES (8, '绵阳科技馆', '绵阳', 4, '4A', '现代化科技场馆，设有多个互动体验区域。', 30.00, '09:00-17:00', 3);
INSERT INTO `attractions` VALUES (9, '报恩寺', '绵阳', 5, '3A', '始建于明朝，是绵阳市重要的佛教寺院之一。', 10.00, '08:00-17:00', 2);
INSERT INTO `attractions` VALUES (10, '玉皇观', '绵阳', 5, '3A', '位于富乐山上的道教宫观，建筑古朴，环境幽静。', 0.00, '08:00-17:00', 1);
INSERT INTO `attractions` VALUES (11, '平武报恩寺', '绵阳', 5, '4A', '始建于明朝万历年间，是川西北地区著名的佛教寺院。', 20.00, '08:00-17:00', 2);
INSERT INTO `attractions` VALUES (12, '窦圌山', '绵阳', 1, '4A', '位于绵阳市安州区，是著名的道教名山，风景优美。', 40.00, '08:00-17:30', 4);
INSERT INTO `attractions` VALUES (13, '绵阳博物馆', '绵阳', 2, '4A', '展示绵阳历史文化的综合性博物馆，收藏了大量文物。', 0.00, '09:00-17:00', 2);
INSERT INTO `attractions` VALUES (14, '北川羌城', '绵阳', 2, '4A', '展示羌族文化的特色景区，可以体验羌族风情。', 60.00, '08:30-17:30', 4);
INSERT INTO `attractions` VALUES (15, '江油战旗村', '绵阳', 3, '3A', '著名的革命老区，展示了红军长征时期的历史。', 20.00, '09:00-16:30', 2);

-- ----------------------------
-- Table structure for browsing_history
-- ----------------------------
DROP TABLE IF EXISTS `browsing_history`;
CREATE TABLE `browsing_history`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `attraction_id` int NOT NULL,
  `view_count` int NULL DEFAULT 1,
  `last_viewed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `attraction_id`(`attraction_id` ASC) USING BTREE,
  CONSTRAINT `browsing_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `browsing_history_ibfk_2` FOREIGN KEY (`attraction_id`) REFERENCES `attractions` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of browsing_history
-- ----------------------------
INSERT INTO `browsing_history` VALUES (1, 1, 1, 3, '2024-12-22 20:38:30');
INSERT INTO `browsing_history` VALUES (2, 1, 4, 2, '2024-12-22 20:38:30');
INSERT INTO `browsing_history` VALUES (3, 1, 7, 1, '2024-12-22 20:38:30');
INSERT INTO `browsing_history` VALUES (4, 2, 5, 4, '2024-12-22 20:38:30');
INSERT INTO `browsing_history` VALUES (5, 2, 6, 2, '2024-12-22 20:38:30');
INSERT INTO `browsing_history` VALUES (6, 2, 9, 1, '2024-12-22 20:38:30');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` datetime NULL DEFAULT NULL,
  `status` tinyint NULL DEFAULT 1 COMMENT '1:正常,0:禁用',
  `is_admin` tinyint NULL DEFAULT 0 COMMENT '1:管理员,0:普通用户',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'admin', '123456', 'admin@example.com', '2024-12-22 13:15:15', NULL, 1, 1);
INSERT INTO `t_user` VALUES (2, 'zhangsan', '123456', 'zhangsan@example.com', '2024-12-22 13:15:15', NULL, 1, 0);
INSERT INTO `t_user` VALUES (3, 'lisi', '123456', 'lisi@example.com', '2024-12-22 13:15:15', NULL, 1, 0);
INSERT INTO `t_user` VALUES (4, 'wangwu', '123456', 'wangwu@example.com', '2024-12-22 13:15:15', NULL, 1, 0);
INSERT INTO `t_user` VALUES (5, 'zhaoliu', '123456', 'zhaoliu@example.com', '2024-12-22 13:15:15', NULL, 1, 0);
INSERT INTO `t_user` VALUES (10, 'test', '123456', 'test@example.com', '2024-12-22 16:53:51', NULL, 1, 0);
INSERT INTO `t_user` VALUES (11, '张三', '123', 'wer@gag.cn', '2024-12-22 17:03:47', '2024-12-22 17:03:47', 1, 0);
INSERT INTO `t_user` VALUES (12, 'hhh', '123456', NULL, '2024-12-22 23:13:53', '2024-12-22 23:13:53', 1, 0);

-- ----------------------------
-- Table structure for user_favorites
-- ----------------------------
DROP TABLE IF EXISTS `user_favorites`;
CREATE TABLE `user_favorites`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `attraction_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_user_attraction`(`user_id` ASC, `attraction_id` ASC) USING BTREE,
  INDEX `attraction_id`(`attraction_id` ASC) USING BTREE,
  CONSTRAINT `user_favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_favorites_ibfk_2` FOREIGN KEY (`attraction_id`) REFERENCES `attractions` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_favorites
-- ----------------------------
INSERT INTO `user_favorites` VALUES (1, 1, 1, '2024-12-22 20:38:30');
INSERT INTO `user_favorites` VALUES (2, 1, 4, '2024-12-22 20:38:30');
INSERT INTO `user_favorites` VALUES (3, 1, 12, '2024-12-22 20:38:30');
INSERT INTO `user_favorites` VALUES (4, 2, 5, '2024-12-22 20:38:30');
INSERT INTO `user_favorites` VALUES (5, 2, 6, '2024-12-22 20:38:30');
INSERT INTO `user_favorites` VALUES (6, 2, 15, '2024-12-22 20:38:30');

-- ----------------------------
-- Table structure for user_interests
-- ----------------------------
DROP TABLE IF EXISTS `user_interests`;
CREATE TABLE `user_interests`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `category_id` int NOT NULL,
  `interest_level` int NULL DEFAULT 1 COMMENT '兴趣程度：1-5',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `category_id`(`category_id` ASC) USING BTREE,
  CONSTRAINT `user_interests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_interests_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `attraction_categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_interests
-- ----------------------------
INSERT INTO `user_interests` VALUES (1, 1, 1, 5, '2024-12-22 20:38:30');
INSERT INTO `user_interests` VALUES (2, 1, 2, 4, '2024-12-22 20:38:30');
INSERT INTO `user_interests` VALUES (3, 1, 4, 3, '2024-12-22 20:38:30');
INSERT INTO `user_interests` VALUES (4, 2, 3, 5, '2024-12-22 20:38:30');
INSERT INTO `user_interests` VALUES (5, 2, 5, 4, '2024-12-22 20:38:30');

SET FOREIGN_KEY_CHECKS = 1;
