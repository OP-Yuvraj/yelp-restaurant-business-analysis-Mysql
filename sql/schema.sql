-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: yelp_db
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `business`
--

DROP TABLE IF EXISTS `business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business` (
  `business_id` text,
  `name` text,
  `address` text,
  `city` text,
  `state` text,
  `postal_code` text,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `stars` double DEFAULT NULL,
  `review_count` bigint DEFAULT NULL,
  `is_open` bigint DEFAULT NULL,
  `attributes` text,
  `categories` text,
  `hours` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checkin`
--

DROP TABLE IF EXISTS `checkin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checkin` (
  `business_id` text,
  `date` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clean_user`
--

DROP TABLE IF EXISTS `clean_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clean_user` (
  `user_id` text,
  `name` text,
  `review_count` bigint DEFAULT NULL,
  `yelping_since` text,
  `useful` bigint DEFAULT NULL,
  `funny` bigint DEFAULT NULL,
  `cool` bigint DEFAULT NULL,
  `elite` longtext,
  `friends` longtext,
  `fans` bigint DEFAULT NULL,
  `average_stars` double DEFAULT NULL,
  `compliment_hot` bigint DEFAULT NULL,
  `compliment_more` bigint DEFAULT NULL,
  `compliment_profile` bigint DEFAULT NULL,
  `compliment_cute` bigint DEFAULT NULL,
  `compliment_list` bigint DEFAULT NULL,
  `compliment_note` bigint DEFAULT NULL,
  `compliment_plain` bigint DEFAULT NULL,
  `compliment_cool` bigint DEFAULT NULL,
  `compliment_funny` bigint DEFAULT NULL,
  `compliment_writer` bigint DEFAULT NULL,
  `compliment_photos` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `restaurant_business`
--

DROP TABLE IF EXISTS `restaurant_business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_business` (
  `business_id` text,
  `name` text,
  `city` text,
  `state` text,
  `stars` double DEFAULT NULL,
  `review_count` bigint DEFAULT NULL,
  `categories` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `restaurant_checkin`
--

DROP TABLE IF EXISTS `restaurant_checkin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_checkin` (
  `business_id` text,
  `date` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `restaurant_review`
--

DROP TABLE IF EXISTS `restaurant_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_review` (
  `review_id` text,
  `user_id` text,
  `business_id` text,
  `stars` bigint DEFAULT NULL,
  `useful` bigint DEFAULT NULL,
  `funny` bigint DEFAULT NULL,
  `cool` bigint DEFAULT NULL,
  `text` longtext,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `restaurant_tip`
--

DROP TABLE IF EXISTS `restaurant_tip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_tip` (
  `user_id` text,
  `business_id` text,
  `text` text,
  `date` datetime DEFAULT NULL,
  `compliment_count` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` text,
  `user_id` text,
  `business_id` text,
  `stars` bigint DEFAULT NULL,
  `useful` bigint DEFAULT NULL,
  `funny` bigint DEFAULT NULL,
  `cool` bigint DEFAULT NULL,
  `text` longtext,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tip`
--

DROP TABLE IF EXISTS `tip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tip` (
  `user_id` text,
  `business_id` text,
  `text` text,
  `date` datetime DEFAULT NULL,
  `compliment_count` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` text,
  `name` text,
  `review_count` bigint DEFAULT NULL,
  `yelping_since` text,
  `useful` bigint DEFAULT NULL,
  `funny` bigint DEFAULT NULL,
  `cool` bigint DEFAULT NULL,
  `elite` longtext,
  `friends` longtext,
  `fans` bigint DEFAULT NULL,
  `average_stars` double DEFAULT NULL,
  `compliment_hot` bigint DEFAULT NULL,
  `compliment_more` bigint DEFAULT NULL,
  `compliment_profile` bigint DEFAULT NULL,
  `compliment_cute` bigint DEFAULT NULL,
  `compliment_list` bigint DEFAULT NULL,
  `compliment_note` bigint DEFAULT NULL,
  `compliment_plain` bigint DEFAULT NULL,
  `compliment_cool` bigint DEFAULT NULL,
  `compliment_funny` bigint DEFAULT NULL,
  `compliment_writer` bigint DEFAULT NULL,
  `compliment_photos` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-02 21:00:23
