/*
SQLyog Ultimate v12.4.3 (64 bit)
MySQL - 5.7.9-log : Database - fruitday
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`fruitday` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `fruitday`;

/*Table structure for table `fruits` */

DROP TABLE IF EXISTS `fruits`;

CREATE TABLE `fruits` (
  `fid` int(255) NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) DEFAULT NULL,
  `spec` varchar(255) DEFAULT NULL,
  `up` double(255,0) DEFAULT NULL,
  `t1` longtext,
  `t2` longtext,
  `inum` int(11) DEFAULT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `fruits` */

insert  into `fruits`(`fid`,`fname`,`spec`,`up`,`t1`,`t2`,`inum`) values 
(1,'佳沛新西兰绿奇异果','4+2盒',78,'产地 新西兰 销售规格 6个 商品单重 80-90g ','储藏方法 0-4度冷藏 营养元素 维生素C、叶酸 特别提醒存放4-5天，成熟后更甜 品牌 佳沛',3),
(3,'枣','2斤',23,'185-210g','储藏方法 0-4度冷藏 营养元素 膳食纤维，天然叶酸，VC，钙，铁',3),
(4,'菠萝','1个',59,'产地\r\n国产\r\n销售规格\r\n2斤/4斤\r\n商品单重\r\n250g以上','储藏方法\r\n0-4度冷藏保存\r\n营养元素\r\n维生素C，果胶，纤维素',4),
(8,'南非青提','2斤',68,'产地\r\n南非\r\n销售规格\r\n2斤','储藏方法\r\n0-4度冷藏\r\n营养元素\r\n白藜芦醇，B类维生素，花青素，钙，蛋白质，果糖',3),
(9,'里达葡萄','2斤',98,'185-210g','储藏方法 0-4度冷藏 营养元素 维生素C、叶酸 特别提醒存放4-5天，成熟后更甜 品牌 佳沛',4),
(10,'墨西哥牛油果','6个',40,'产地 墨西哥 销售规格 6个 商品单重 140g以上 ','储藏方法 0-4度冷藏  营养元素叶酸，钾，钙，磷',3),
(11,'美国华盛顿红地厘蛇果','6个',30,'产地\r\n美国销售规格\r\n6个\r\n商品单重\r\n185-210g','储藏方法\r\n0-4度冷藏保存\r\n营养元素\r\n维生素C，果胶，纤维素',3),
(14,'美国佛罗里达葡萄柚','6个',40,'产地 美国 销售规格 6个 商品单重 单个重240-310g','储藏方法 0-4度冷藏 营养元素 膳食纤维，天然叶酸，VC，钙，铁',3),
(16,'赣南红心脐橙','2斤/4斤',49,'产地\r\n国产\r\n销售规格\r\n2斤/4斤\r\n商品单重\r\n250g以上','储藏方法\r\n0-4度冷藏\r\n营养元素\r\n胡萝卜素，维生素C，花青素，钾，叶酸，纤维素',3),
(20,'紫薯','500g',11,'产地\r\n中国\r\n销售规格\r\n500g','储藏方法\r\n阴凉干燥处\r\n营养元素\r\n纤维素，花青素，硒\r\n烹饪方法\r\n蒸煮煨烤',3),
(21,'test1水果','6斤',24,'产地 中国','储藏方法 0-4度冷藏  营养元素叶酸，钾，钙，磷',4);

/*Table structure for table `hotfruits` */

DROP TABLE IF EXISTS `hotfruits`;

CREATE TABLE `hotfruits` (
  `fid` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `hotfruits` */

insert  into `hotfruits`(`fid`) values 
(1),
(3),
(4),
(8),
(9),
(10),
(11),
(14),
(16),
(20);

/*Table structure for table `shop` */

DROP TABLE IF EXISTS `shop`;

CREATE TABLE `shop` (
  `uid` int(11) NOT NULL,
  `fid` int(11) NOT NULL,
  `isStar` tinyint(1) NOT NULL,
  `isCart` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `shop` */

insert  into `shop`(`uid`,`fid`,`isStar`,`isCart`) values 
(1,1,1,0),
(1,11,1,0),
(1,14,1,1),
(2,1,0,1);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  `uname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`email`,`phone`,`pwd`,`uname`) values 
(1,'youwillsee2018@qq.com','15754326763','suhong1','youwillsee2018@qq.com'),
(2,'admin@qq.com','135','123','admin'),
(3,'admin@qq.com','13112345678','123','admin@qq.com');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
