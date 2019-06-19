/*
SQLyog Enterprise v12.09 (64 bit)
MySQL - 5.5.40 : Database - test
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`test` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `test`;

/*Table structure for table `class` */

DROP TABLE IF EXISTS `class`;

CREATE TABLE `class` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `caption` varchar(32) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `class` */

insert  into `class`(`cid`,`caption`) values (1,'三年二班'),(2,'三年三班'),(3,'一年二班'),(4,'二年九班');

/*Table structure for table `course` */

DROP TABLE IF EXISTS `course`;

CREATE TABLE `course` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(16) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `course` */

insert  into `course`(`cid`,`cname`,`teacher_id`) values (1,'生物',1),(2,'物理',2),(3,'体育',3),(4,'美术',2);

/*Table structure for table `score` */

DROP TABLE IF EXISTS `score`;

CREATE TABLE `score` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `corse_id` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

/*Data for the table `score` */

insert  into `score`(`sid`,`student_id`,`corse_id`,`number`) values (1,1,1,10),(2,1,2,9),(5,1,4,66),(6,2,1,8),(8,2,3,68),(9,2,4,99),(10,3,1,77),(11,3,2,66),(12,3,3,87),(13,3,4,99),(14,4,1,79),(15,4,2,11),(16,4,3,67),(17,4,4,100),(18,5,1,79),(19,5,2,11),(20,5,3,67),(21,5,4,100),(22,6,1,9),(23,6,2,100),(24,6,3,67),(25,6,4,100),(26,7,1,9),(27,7,2,100),(28,7,3,67),(29,7,4,88),(30,8,1,9),(31,8,2,100),(32,8,3,67),(33,8,4,88),(34,9,1,91),(35,9,2,88),(36,9,3,67),(37,9,4,22),(38,10,1,90),(39,10,2,77),(40,10,3,43),(41,10,4,87),(42,11,1,90),(43,11,2,77),(44,11,3,43),(45,11,4,87),(46,12,1,90),(47,12,2,77),(48,12,3,43),(49,12,4,87),(52,13,3,87);

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `gender` varchar(8) NOT NULL,
  `class_id` int(11) NOT NULL,
  `sname` varchar(32) NOT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `student` */

insert  into `student`(`sid`,`gender`,`class_id`,`sname`) values (1,'男',1,'理解'),(2,'女',1,'钢蛋'),(3,'男',1,'张三'),(4,'男',1,'张一'),(5,'女',1,'张二'),(6,'男',1,'张四'),(7,'女',2,'铁锤'),(8,'男',2,'李三'),(9,'男',2,'李一'),(10,'女',2,'李二'),(11,'男',2,'李四'),(12,'女',3,'如花'),(13,'男',3,'刘三'),(14,'男',3,'刘一'),(15,'女',3,'刘二'),(16,'男',3,'刘四');

/*Table structure for table `teacher` */

DROP TABLE IF EXISTS `teacher`;

CREATE TABLE `teacher` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `tname` varchar(32) NOT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `teacher` */

insert  into `teacher`(`tid`,`tname`) values (1,'张磊老师'),(2,'李平老师'),(3,'刘海燕老师'),(4,'朱云海老师'),(5,'李杰老师');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
