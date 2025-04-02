-- MariaDB dump 10.19  Distrib 10.5.11-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: school
-- ------------------------------------------------------
-- Server version	10.5.11-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `community`
--

DROP TABLE IF EXISTS `community`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `community` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `writeday` date DEFAULT NULL,
  `cla` int(11) DEFAULT NULL,
  `readnum` int(11) DEFAULT 0,
  `ofname` varchar(100) DEFAULT NULL,
  `sfname` varchar(100) DEFAULT NULL,
  `userid` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `community`
--

LOCK TABLES `community` WRITE;
/*!40000 ALTER TABLE `community` DISABLE KEYS */;
INSERT INTO `community` VALUES (1,'이번주에 특별 감사가 실시될 예정입니다.','하하하\r\n\r\n모두 열심히 준비하세요','2025-03-31',1,0,NULL,NULL,'admin'),(2,'오늘은 즐거운 월요일입니다.','열심히 공부합시다\r\n\r\n하하하','2025-03-31',2,0,NULL,NULL,'admin'),(3,'MyUtil파일을 올립니다.','참고하세요\r\n\r\n하하하','2025-03-31',3,0,'MyUtil.java','MyUtil.java','admin'),(4,'홍길동이 알려드립니다.','오늘은 월요일입니다.\r\n\r\n하ㅏㅎ하','2025-03-31',2,0,NULL,NULL,'hong'),(5,'홍길동이가 좋아하는 사진입니다.','이쁘죠\r\n\r\n하ㅏ핳','2025-03-31',3,0,'b3.jpg','b3.jpg','hong'),(6,'배트맨이 알려드립니다.','오늘 점심은 돈까스입니다.\r\n\r\n하하하','2025-03-31',2,0,NULL,NULL,'batman'),(7,'배트맨은 이 사진을 좋아합니다.','천천히!!\r\n\r\n공부도 천천히 열심히!!','2025-03-31',3,0,'b1.jpg','b1.jpg','batman');
/*!40000 ALTER TABLE `community` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` int(11) DEFAULT NULL,
  `ban` int(11) DEFAULT NULL,
  `userid` char(10) NOT NULL,
  `pwd` char(10) DEFAULT NULL,
  `name` char(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` char(20) DEFAULT NULL,
  `writeday` date DEFAULT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (1,100,0,'admin','1234','관리자',NULL,NULL,'2025-03-31'),(3,50,2,'batman','1234','배트맨',NULL,NULL,'2025-03-31'),(2,80,1,'hong','1234','홍길동',NULL,NULL,'2025-03-31');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-31 14:10:02
