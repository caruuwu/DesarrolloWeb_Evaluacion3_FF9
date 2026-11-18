-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: inv_ff9
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `activa_pj`
--

DROP TABLE IF EXISTS `activa_pj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activa_pj` (
  `Act_Pj_ID` int NOT NULL AUTO_INCREMENT,
  `Pj_ID` int NOT NULL,
  `Hab_Act_ID` int NOT NULL,
  PRIMARY KEY (`Act_Pj_ID`),
  KEY `fk_Act_Pj_ID` (`Pj_ID`),
  KEY `fk_Act_Hab_ID` (`Hab_Act_ID`),
  CONSTRAINT `fk_Act_Hab_ID` FOREIGN KEY (`Hab_Act_ID`) REFERENCES `habilidad_activa` (`Hab_ID`),
  CONSTRAINT `fk_Act_Pj_ID` FOREIGN KEY (`Pj_ID`) REFERENCES `personaje` (`Pj_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activa_pj`
--

LOCK TABLES `activa_pj` WRITE;
/*!40000 ALTER TABLE `activa_pj` DISABLE KEYS */;
INSERT INTO `activa_pj` VALUES (1,1,73),(2,1,74),(3,1,75),(4,1,76),(5,1,77),(6,1,78),(7,1,79),(8,1,80),(9,2,89),(10,2,90),(11,2,91),(12,2,92),(13,2,93),(14,2,94),(15,2,95),(16,2,96),(17,2,97),(18,2,98),(19,2,99),(20,2,100),(21,3,1),(22,3,2),(23,3,3),(24,3,4),(25,3,5),(26,3,6),(27,3,7),(28,3,8),(29,3,9),(30,3,10),(31,3,11),(32,3,12),(33,3,13),(34,3,14),(35,3,15),(36,3,16),(37,3,17),(38,3,18),(39,3,19),(40,3,20),(41,3,21),(42,3,22),(43,3,23),(44,3,24),(45,4,25),(46,4,26),(47,4,27),(48,4,28),(49,4,29),(50,4,31),(51,4,32),(52,4,33),(53,4,35),(54,4,36),(55,4,38),(56,4,40),(57,4,41),(58,4,42),(59,4,43),(60,4,44),(61,4,45),(62,4,47),(63,4,109),(64,4,110),(65,4,111),(66,4,112),(67,4,113),(68,4,114),(69,4,115),(70,4,116),(71,5,81),(72,5,82),(73,5,83),(74,5,84),(75,5,85),(76,5,86),(77,5,87),(78,5,88),(79,6,49),(80,6,50),(81,6,51),(82,6,52),(83,6,53),(84,6,54),(85,6,55),(86,6,56),(87,6,57),(88,6,58),(89,6,59),(90,6,60),(91,6,61),(92,6,62),(93,6,63),(94,6,64),(95,6,65),(96,6,66),(97,6,67),(98,6,68),(99,6,69),(100,6,70),(101,6,71),(102,6,72),(103,7,25),(104,7,26),(105,7,27),(106,7,28),(107,7,29),(108,7,30),(109,7,32),(110,7,33),(111,7,34),(112,7,35),(113,7,36),(114,7,37),(115,7,39),(116,7,40),(117,7,44),(118,7,45),(119,7,48),(120,7,117),(121,7,118),(122,7,119),(123,7,120),(124,8,101),(125,8,102),(126,8,103),(127,8,104),(128,8,105),(129,8,106),(130,8,107),(131,8,108);
/*!40000 ALTER TABLE `activa_pj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `atributo`
--

DROP TABLE IF EXISTS `atributo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `atributo` (
  `Atr_ID` int NOT NULL AUTO_INCREMENT,
  `Atr_Ata` int NOT NULL,
  `Atr_Def_Fís` int NOT NULL,
  `Atr_Def_Mág` int NOT NULL,
  `Atr_Eva_Fís` int NOT NULL,
  `Atr_Eva_Mág` int NOT NULL,
  `Atr_Rap` int NOT NULL,
  `Atr_Fue` int NOT NULL,
  `Atr_Mag` int NOT NULL,
  `Atr_Esp` int NOT NULL,
  `Atr_Res_Ele` int DEFAULT NULL,
  `Atr_Inm_Ele` int DEFAULT NULL,
  `Atr_Abs_Ele` int DEFAULT NULL,
  `Atr_Bon_Ele` int DEFAULT NULL,
  `Atr_Dañ_Ele` int DEFAULT NULL,
  `Atr_Def_Est_Alt` int DEFAULT NULL,
  `Atr_Inf_Est_Alt` int DEFAULT NULL,
  `Atr_Pas_Est_Alt` int DEFAULT NULL,
  PRIMARY KEY (`Atr_ID`),
  KEY `fk_Res_Ele` (`Atr_Res_Ele`),
  KEY `fk_Inm_Ele` (`Atr_Inm_Ele`),
  KEY `fk_Abs_Ele` (`Atr_Abs_Ele`),
  KEY `fk_Bon_Ele` (`Atr_Bon_Ele`),
  KEY `fk_Dañ_Ele` (`Atr_Dañ_Ele`),
  KEY `fk_Def_Est` (`Atr_Def_Est_Alt`),
  KEY `fk_Inf_Est` (`Atr_Inf_Est_Alt`),
  KEY `fk_Pas_Est` (`Atr_Pas_Est_Alt`),
  CONSTRAINT `fk_Abs_Ele` FOREIGN KEY (`Atr_Abs_Ele`) REFERENCES `elemento` (`Elemento_ID`),
  CONSTRAINT `fk_Bon_Ele` FOREIGN KEY (`Atr_Bon_Ele`) REFERENCES `elemento` (`Elemento_ID`),
  CONSTRAINT `fk_Dañ_Ele` FOREIGN KEY (`Atr_Dañ_Ele`) REFERENCES `elemento` (`Elemento_ID`),
  CONSTRAINT `fk_Def_Est` FOREIGN KEY (`Atr_Def_Est_Alt`) REFERENCES `estado_alterado` (`Est_Alt_ID`),
  CONSTRAINT `fk_Inf_Est` FOREIGN KEY (`Atr_Inf_Est_Alt`) REFERENCES `estado_alterado` (`Est_Alt_ID`),
  CONSTRAINT `fk_Inm_Ele` FOREIGN KEY (`Atr_Inm_Ele`) REFERENCES `elemento` (`Elemento_ID`),
  CONSTRAINT `fk_Pas_Est` FOREIGN KEY (`Atr_Pas_Est_Alt`) REFERENCES `estado_alterado` (`Est_Alt_ID`),
  CONSTRAINT `fk_Res_Ele` FOREIGN KEY (`Atr_Res_Ele`) REFERENCES `elemento` (`Elemento_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atributo`
--

LOCK TABLES `atributo` WRITE;
/*!40000 ALTER TABLE `atributo` DISABLE KEYS */;
INSERT INTO `atributo` VALUES (1,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(2,14,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0),(3,18,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(4,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0),(5,24,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0),(6,30,0,0,0,0,1,0,0,0,0,0,0,0,0,0,5,0),(7,31,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,0),(8,37,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,0),(9,42,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0),(10,44,0,0,0,0,0,0,0,0,0,0,0,0,0,0,14,0),(11,53,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0),(12,62,0,0,0,0,0,0,2,0,0,0,0,0,0,0,19,0),(13,71,0,0,0,0,1,0,0,0,0,0,0,0,0,0,9,0),(14,86,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0),(15,100,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0),(16,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(17,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(18,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(19,24,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(20,35,0,0,0,0,0,0,0,0,0,0,0,2,2,0,10,0),(21,38,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(22,42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(23,46,0,0,0,0,0,0,0,0,0,0,0,1,1,0,3,0),(24,57,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0),(25,65,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(26,74,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0),(27,77,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0),(28,87,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,0),(29,108,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0),(30,23,0,0,0,0,0,0,0,1,0,0,0,0,7,0,0,0),(31,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(32,16,0,0,0,0,0,0,1,0,0,0,0,1,1,0,7,0),(33,16,0,0,0,0,0,0,1,0,0,0,0,2,2,0,5,0),(34,16,0,0,0,0,0,0,1,0,0,0,0,3,3,0,11,0),(35,23,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,0),(36,27,0,0,0,0,0,0,0,0,0,0,0,0,0,0,14,0),(37,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,0),(38,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0),(39,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0),(40,11,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0),(41,14,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0),(42,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(43,23,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(44,27,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0),(45,31,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(46,36,0,0,0,0,0,0,2,1,0,0,0,0,0,0,0,0),(47,18,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(48,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(49,25,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(50,31,0,0,0,0,0,0,0,0,0,0,0,2,2,0,10,0),(51,37,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0),(52,42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,0),(53,52,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0),(54,62,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0),(55,71,0,0,0,0,0,0,0,0,0,0,0,0,0,0,14,0),(56,77,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(57,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(58,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0),(59,42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(60,53,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,0),(61,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0),(62,77,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,0),(63,17,0,0,0,0,0,0,2,1,0,0,0,0,0,0,0,0),(64,21,0,0,0,0,0,0,0,1,0,0,0,0,0,0,16,0),(65,24,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0),(66,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0),(67,30,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0),(68,33,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0),(69,23,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(70,33,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,0),(71,39,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(72,45,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0),(73,53,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0),(74,62,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(75,70,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0),(76,75,0,0,0,0,0,0,0,0,0,0,0,5,5,0,17,0),(77,79,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,0),(78,83,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0),(79,13,0,0,0,0,0,0,0,0,0,0,0,5,5,0,0,0),(80,17,0,0,0,0,0,0,0,0,0,0,0,5,5,0,0,0),(81,23,0,0,0,0,0,0,0,0,0,0,0,7,5,0,0,0),(82,27,0,0,0,0,0,0,0,0,0,0,0,5,5,0,0,0),(83,35,0,0,0,0,0,0,0,0,0,0,0,5,5,0,0,0),(84,45,0,0,0,0,0,0,0,0,0,0,0,5,5,0,0,0),(85,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(86,0,2,6,0,0,0,0,0,0,4,0,0,0,0,0,0,0),(87,0,0,7,0,0,0,0,0,1,0,0,0,5,0,0,0,0),(88,0,0,9,0,0,0,1,0,0,0,0,0,0,0,0,0,0),(89,0,0,10,0,0,0,0,0,0,0,0,0,2,0,0,0,0),(90,0,0,12,2,0,1,0,0,1,0,0,0,0,0,0,0,0),(91,0,0,14,0,0,0,0,1,0,0,0,0,0,0,0,0,0),(92,0,0,16,0,0,0,1,1,0,0,0,0,0,0,0,0,0),(93,0,0,17,0,0,0,1,0,0,0,0,0,0,0,0,0,0),(94,0,0,19,0,0,0,0,1,1,0,0,0,0,0,0,0,0),(95,0,0,20,0,0,1,1,0,0,0,0,0,0,0,0,0,0),(96,0,0,32,0,0,0,0,2,0,0,0,0,0,0,0,0,0),(97,0,0,34,0,0,1,0,0,0,0,0,0,0,0,0,0,0),(98,0,0,36,0,0,0,0,1,2,0,0,0,0,0,0,0,0),(99,0,0,38,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(100,0,0,45,0,0,2,0,0,0,0,0,0,0,0,0,0,0),(101,0,4,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(102,0,7,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(103,0,8,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0),(104,0,9,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(105,0,14,11,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(106,0,16,12,0,0,0,1,0,0,0,0,0,0,0,0,0,0),(107,0,20,14,0,0,0,0,2,0,0,0,0,0,0,0,0,0),(108,0,23,16,0,0,0,0,0,2,0,0,0,0,0,0,0,0),(109,0,29,18,0,0,0,2,0,0,0,0,0,0,0,0,0,0),(110,0,33,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(111,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(112,0,7,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0),(113,0,9,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0),(114,0,12,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0),(115,0,14,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0),(116,0,17,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0),(117,0,20,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0),(118,0,23,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0),(119,0,27,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0),(120,0,31,0,0,0,0,0,1,0,8,0,0,0,0,0,0,0),(121,0,35,0,0,0,1,0,0,0,0,0,8,0,0,0,0,0),(122,0,37,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0),(123,0,39,1,2,3,0,0,0,0,0,3,0,0,0,0,0,0),(124,0,42,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0),(125,0,10,2,0,0,0,1,1,0,0,0,0,0,0,0,0,0),(126,0,16,2,0,0,0,1,1,0,0,0,0,0,0,0,0,0),(127,0,15,2,0,0,0,0,1,0,0,0,0,2,0,0,0,0),(128,0,21,3,0,0,0,0,2,0,0,0,0,0,0,0,0,0),(129,0,25,2,0,0,0,0,0,0,0,0,6,6,0,0,0,0),(130,0,42,4,0,0,0,0,2,0,0,0,0,7,0,0,0,0),(131,0,43,4,0,0,0,0,2,0,0,0,0,8,0,0,0,0),(132,0,41,4,0,0,0,1,1,0,0,0,0,0,0,0,0,0),(133,0,41,6,0,0,0,1,1,1,0,0,0,7,0,0,0,0),(134,0,46,5,0,0,1,1,1,1,0,5,0,0,0,0,0,0),(135,0,9,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0),(136,0,10,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0),(137,0,12,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0),(138,0,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0),(139,0,17,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0),(140,0,19,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0),(141,0,23,5,0,0,0,0,0,0,1,0,0,0,0,0,0,0),(142,0,27,0,0,0,0,0,0,0,0,0,8,8,0,0,0,0),(143,0,33,2,0,0,0,1,1,0,0,0,0,0,0,0,0,0),(144,0,34,1,0,0,0,1,2,0,0,0,0,0,0,0,0,0),(145,0,36,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0),(146,0,39,1,0,1,0,0,1,0,0,0,0,0,0,0,0,0),(147,0,42,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0),(148,0,45,1,0,0,0,0,2,0,0,0,0,0,0,0,0,0),(149,0,54,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0),(150,0,59,0,0,0,0,1,0,0,5,0,0,0,0,0,0,0),(151,0,62,27,32,17,0,0,0,0,0,0,0,0,0,0,0,0),(152,0,1,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0),(153,0,1,0,5,0,0,0,0,1,0,0,0,0,0,0,0,0),(154,0,2,0,7,0,0,0,2,0,0,0,0,0,0,0,0,0),(155,0,2,0,9,0,0,2,0,2,0,0,0,0,0,0,0,0),(156,0,2,0,12,0,0,0,1,0,4,0,0,0,0,0,0,0),(157,0,2,0,14,0,0,2,0,0,0,0,0,0,0,0,0,0),(158,0,3,0,15,0,0,1,0,0,0,0,0,0,0,0,0,0),(159,0,0,1,25,0,0,0,0,0,0,0,0,0,0,0,0,0),(160,0,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0),(161,0,0,1,12,0,0,0,0,0,0,0,0,0,0,0,0,0),(162,0,0,0,14,0,0,0,0,1,0,0,0,0,0,0,0,0),(163,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0),(164,0,0,1,19,0,0,1,0,0,0,0,0,0,0,0,0,0),(165,0,0,0,23,0,0,0,2,0,0,0,0,0,0,0,0,0),(166,0,0,2,25,0,0,2,0,0,0,0,0,0,0,0,0,0),(167,0,0,1,27,0,0,0,0,0,0,0,0,0,0,0,0,0),(168,0,0,3,30,0,0,0,0,0,0,0,0,0,0,0,0,0),(169,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(170,0,0,0,0,4,0,0,1,0,0,0,0,0,0,0,0,0),(171,0,0,1,0,0,0,0,1,0,1,0,0,1,0,0,0,0),(172,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0),(173,0,0,0,0,0,0,0,0,1,0,2,0,2,0,0,0,0),(174,0,0,0,0,0,0,1,0,0,0,1,0,1,0,0,0,0),(175,0,0,0,2,0,0,0,0,1,0,4,0,4,0,0,0,0),(176,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0),(177,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0),(178,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0),(179,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0),(180,0,2,0,10,0,0,0,1,1,0,0,0,0,0,0,0,0),(181,0,2,0,15,0,1,2,0,0,0,0,0,0,0,0,0,0),(182,0,2,0,17,0,0,2,2,0,0,0,0,0,0,0,0,0),(183,0,0,0,0,3,0,0,0,0,0,6,0,0,0,0,0,0),(184,0,0,0,0,4,2,0,0,0,0,0,0,0,0,0,0,21),(185,0,2,2,0,0,0,3,0,0,0,0,0,0,0,0,0,0),(186,0,2,2,0,0,0,0,0,2,0,0,0,0,0,0,0,0),(187,0,1,2,0,0,0,0,2,1,0,0,0,0,0,0,0,0),(188,0,1,1,0,2,0,0,2,0,0,0,3,3,0,0,0,0),(189,0,0,2,0,4,0,0,2,0,0,0,0,5,0,0,0,0),(190,0,0,0,0,0,0,0,2,2,0,0,0,2,0,0,0,0),(191,0,0,0,0,2,0,2,0,0,0,0,0,0,0,0,0,0),(192,0,2,4,0,3,0,0,0,1,1,0,0,0,0,0,0,0),(193,0,0,2,0,0,0,0,0,4,0,7,0,7,0,0,0,0),(194,0,0,0,0,0,0,0,2,2,0,0,0,0,0,0,0,27),(195,0,1,1,2,3,0,1,0,0,0,0,0,0,0,0,0,0),(196,0,1,3,0,1,0,1,1,1,0,0,0,0,0,0,0,0),(197,0,3,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(198,0,1,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `atributo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elemento`
--

DROP TABLE IF EXISTS `elemento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elemento` (
  `Elemento_ID` int NOT NULL,
  `Elemento_Nombre` varchar(15) NOT NULL,
  PRIMARY KEY (`Elemento_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elemento`
--

LOCK TABLES `elemento` WRITE;
/*!40000 ALTER TABLE `elemento` DISABLE KEYS */;
INSERT INTO `elemento` VALUES (0,'Non Elemental'),(1,'Fire'),(2,'Ice'),(3,'Lightning'),(4,'Water'),(5,'Wind'),(6,'Earth'),(7,'Holy'),(8,'Shadow');
/*!40000 ALTER TABLE `elemento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipo`
--

DROP TABLE IF EXISTS `equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo` (
  `Equipo_ID` int NOT NULL AUTO_INCREMENT,
  `Equipo_Obj_ID` int DEFAULT NULL,
  `Equipo_Atr_ID` int DEFAULT NULL,
  PRIMARY KEY (`Equipo_ID`),
  KEY `fk_Atr_ID` (`Equipo_Atr_ID`),
  KEY `fk_Obj_ID` (`Equipo_Obj_ID`),
  CONSTRAINT `fk_Atr_ID` FOREIGN KEY (`Equipo_Atr_ID`) REFERENCES `atributo` (`Atr_ID`),
  CONSTRAINT `fk_Obj_ID` FOREIGN KEY (`Equipo_Obj_ID`) REFERENCES `objeto` (`Objeto_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipo`
--

LOCK TABLES `equipo` WRITE;
/*!40000 ALTER TABLE `equipo` DISABLE KEYS */;
INSERT INTO `equipo` VALUES (1,21,1),(2,22,2),(3,23,3),(4,24,4),(5,25,5),(6,26,6),(7,27,7),(8,28,8),(9,29,9),(10,30,10),(11,31,11),(12,32,12),(13,33,13),(14,34,14),(15,35,15),(16,36,16),(17,37,17),(18,38,18),(19,39,19),(20,40,20),(21,41,21),(22,42,22),(23,43,23),(24,44,24),(25,45,25),(26,46,26),(27,47,27),(28,48,28),(29,49,29),(30,50,30),(31,51,31),(32,52,32),(33,53,33),(34,54,34),(35,55,35),(36,56,36),(37,57,37),(38,58,38),(39,59,39),(40,60,40),(41,61,41),(42,62,42),(43,63,43),(44,64,44),(45,65,45),(46,66,46),(47,67,47),(48,68,48),(49,69,49),(50,70,50),(51,71,51),(52,72,52),(53,73,53),(54,74,54),(55,75,55),(56,76,56),(57,77,57),(58,78,58),(59,79,59),(60,80,60),(61,81,61),(62,82,62),(63,83,63),(64,84,64),(65,85,65),(66,86,66),(67,87,67),(68,88,68),(69,89,69),(70,90,70),(71,91,71),(72,92,72),(73,93,73),(74,94,74),(75,95,75),(76,96,76),(77,97,77),(78,98,78),(79,99,79),(80,100,80),(81,101,81),(82,102,82),(83,103,83),(84,104,84),(85,105,84);
/*!40000 ALTER TABLE `equipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipo_habilidad_activa`
--

DROP TABLE IF EXISTS `equipo_habilidad_activa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo_habilidad_activa` (
  `Equipo_Hab_Act_ID` int NOT NULL AUTO_INCREMENT,
  `Equipo_ID` int DEFAULT NULL,
  `Hab_Act_ID` int DEFAULT NULL,
  PRIMARY KEY (`Equipo_Hab_Act_ID`),
  KEY `fk_Act_Equipo_ID` (`Equipo_ID`),
  KEY `fk_Hab_Act_ID` (`Hab_Act_ID`),
  CONSTRAINT `fk_Act_Equipo_ID` FOREIGN KEY (`Equipo_ID`) REFERENCES `equipo` (`Equipo_ID`),
  CONSTRAINT `fk_Hab_Act_ID` FOREIGN KEY (`Hab_Act_ID`) REFERENCES `habilidad_activa` (`Hab_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipo_habilidad_activa`
--

LOCK TABLES `equipo_habilidad_activa` WRITE;
/*!40000 ALTER TABLE `equipo_habilidad_activa` DISABLE KEYS */;
INSERT INTO `equipo_habilidad_activa` VALUES (1,1,73),(2,2,73),(3,2,74),(4,3,0),(5,4,75),(6,4,39),(7,5,76),(8,6,76),(9,6,79),(10,7,78),(11,7,79),(12,8,79),(13,9,73),(14,10,80),(15,11,76),(16,12,76),(17,13,74),(18,14,79),(19,14,80),(20,15,73),(21,16,0),(22,17,90),(23,18,93),(24,19,89),(25,20,94),(26,21,96),(27,22,0),(28,23,95),(29,24,91),(30,25,97),(31,26,98),(32,27,99),(33,28,97),(34,28,100),(35,29,98),(36,29,99),(37,29,100),(38,30,99),(39,31,1),(40,32,2),(41,32,4),(42,33,5),(43,33,6),(44,33,8),(45,34,9),(46,34,10),(47,34,13),(48,35,12),(49,35,14),(50,35,16),(51,36,17),(52,36,19),(53,36,20),(54,37,3),(55,37,7),(56,37,11),(57,38,15),(58,38,22),(59,39,24),(60,40,25),(61,40,32),(62,41,26),(63,41,35),(64,41,36),(65,42,44),(66,42,40),(67,43,27),(68,43,29),(69,43,34),(70,44,39),(71,44,41),(72,44,38),(73,45,27),(74,45,29),(75,45,35),(76,45,36),(77,46,27),(78,46,30),(79,47,81),(80,48,82),(81,49,81),(82,50,84),(83,51,85),(84,52,88),(85,53,87),(86,54,87),(87,54,82),(88,55,88),(89,55,87),(90,55,84),(91,56,88),(92,57,0),(93,58,0),(94,59,0),(95,60,0),(96,61,0),(97,62,0),(98,63,26),(99,63,29),(100,64,38),(101,64,44),(102,64,33),(103,65,34),(104,65,37),(105,65,40),(106,66,26),(107,66,46),(108,66,47),(109,67,30),(110,67,45),(111,67,34),(112,68,48),(113,68,34),(114,68,27),(115,69,102),(116,70,108),(117,71,102),(118,72,101),(119,73,106),(120,74,107),(121,75,105),(122,76,103),(123,77,101),(124,77,106),(125,78,108),(126,78,105),(127,78,107),(128,79,31),(129,80,35),(130,80,36),(131,80,43),(132,81,42),(133,81,40),(134,81,26),(135,82,40),(136,82,35),(137,82,36),(138,83,38),(139,83,46),(140,84,45);
/*!40000 ALTER TABLE `equipo_habilidad_activa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipo_habilidad_pasiva`
--

DROP TABLE IF EXISTS `equipo_habilidad_pasiva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo_habilidad_pasiva` (
  `Equipo_Hab_Pas_ID` int NOT NULL AUTO_INCREMENT,
  `Equipo_ID` int DEFAULT NULL,
  `Hab_Pas_ID` int DEFAULT NULL,
  PRIMARY KEY (`Equipo_Hab_Pas_ID`),
  KEY `fk_Pas_Equipo_ID` (`Equipo_ID`),
  KEY `fk_Hab_Pas_ID` (`Hab_Pas_ID`),
  CONSTRAINT `fk_Hab_Pas_ID` FOREIGN KEY (`Hab_Pas_ID`) REFERENCES `habilidad_pasiva` (`Hab_ID`),
  CONSTRAINT `fk_Pas_Equipo_ID` FOREIGN KEY (`Equipo_ID`) REFERENCES `equipo` (`Equipo_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipo_habilidad_pasiva`
--

LOCK TABLES `equipo_habilidad_pasiva` WRITE;
/*!40000 ALTER TABLE `equipo_habilidad_pasiva` DISABLE KEYS */;
INSERT INTO `equipo_habilidad_pasiva` VALUES (1,1,0),(2,2,0),(3,3,63),(4,4,39),(5,5,0),(6,6,0),(7,7,0),(8,8,0),(9,9,0),(10,10,0),(11,11,51),(12,12,0),(13,13,0),(14,14,0),(15,15,0),(16,16,20),(17,17,0),(18,18,0),(19,19,0),(20,20,0),(21,21,0),(22,22,0),(23,23,0),(24,24,0),(25,25,0),(26,26,0),(27,27,0),(28,28,0),(29,29,0),(30,30,0),(31,31,0),(32,32,0),(33,33,0),(34,34,0),(35,35,0),(36,36,0),(37,37,0),(38,38,0),(39,39,0),(40,40,0),(41,41,0),(42,42,0),(43,43,0),(44,44,0),(45,45,0),(46,46,0),(47,47,0),(48,48,0),(49,49,49),(50,50,0),(51,51,0),(52,52,0),(53,53,43),(54,54,0),(55,55,0),(56,56,0),(57,57,0),(58,58,36),(59,59,49),(60,60,27),(61,61,37),(62,62,0),(63,63,4),(64,64,59),(65,65,0),(66,66,0),(67,67,0),(68,68,0),(69,69,0),(70,70,0),(71,71,37),(72,72,0),(73,73,0),(74,74,20),(75,75,0),(76,76,19),(77,77,0),(78,78,0),(79,79,0),(80,80,0),(81,81,0),(82,82,0),(83,83,0),(84,84,12);
/*!40000 ALTER TABLE `equipo_habilidad_pasiva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipo_por_personaje`
--

DROP TABLE IF EXISTS `equipo_por_personaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo_por_personaje` (
  `Equipo_Pj_ID` int NOT NULL AUTO_INCREMENT,
  `Pj_ID` int NOT NULL,
  `Equipo_ID` int NOT NULL,
  PRIMARY KEY (`Equipo_Pj_ID`),
  KEY `fk_Equipo_Pj_ID` (`Pj_ID`),
  KEY `fk_Equipo_ID` (`Equipo_ID`),
  CONSTRAINT `fk_Equipo_ID` FOREIGN KEY (`Equipo_ID`) REFERENCES `equipo` (`Equipo_ID`),
  CONSTRAINT `fk_Equipo_Pj_ID` FOREIGN KEY (`Pj_ID`) REFERENCES `personaje` (`Pj_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipo_por_personaje`
--

LOCK TABLES `equipo_por_personaje` WRITE;
/*!40000 ALTER TABLE `equipo_por_personaje` DISABLE KEYS */;
INSERT INTO `equipo_por_personaje` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,2,16),(17,2,17),(18,2,18),(19,2,19),(20,2,20),(21,2,21),(22,2,22),(23,2,23),(24,2,24),(25,2,25),(26,2,26),(27,2,27),(28,2,28),(29,2,29),(30,3,31),(31,3,32),(32,3,33),(33,3,34),(34,3,35),(35,3,36),(36,3,37),(37,3,38),(38,3,39),(39,4,40),(40,4,41),(41,4,42),(42,4,43),(43,4,44),(44,4,45),(45,4,46),(46,4,79),(47,4,80),(48,4,81),(49,4,82),(50,4,83),(51,4,84),(52,5,47),(53,5,48),(54,5,49),(55,5,50),(56,5,51),(57,5,52),(58,5,53),(59,5,54),(60,5,55),(61,5,56),(62,6,57),(63,6,58),(64,6,59),(65,6,60),(66,6,61),(67,6,62),(68,7,63),(69,7,64),(70,7,65),(71,7,66),(72,7,67),(73,7,68),(74,7,79),(75,7,80),(76,7,81),(77,7,82),(78,7,83),(79,7,84),(80,8,69),(81,8,70),(82,8,71),(83,8,72),(84,8,73),(85,8,74),(86,8,75),(87,8,76),(88,8,77),(89,8,78);
/*!40000 ALTER TABLE `equipo_por_personaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_alterado`
--

DROP TABLE IF EXISTS `estado_alterado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_alterado` (
  `Est_Alt_ID` int NOT NULL,
  `Est_Alt_Nombre` varchar(15) NOT NULL,
  PRIMARY KEY (`Est_Alt_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_alterado`
--

LOCK TABLES `estado_alterado` WRITE;
/*!40000 ALTER TABLE `estado_alterado` DISABLE KEYS */;
INSERT INTO `estado_alterado` VALUES (0,'None'),(1,'KO'),(2,'Near Death'),(3,'Heat'),(4,'Mini'),(5,'Slow'),(6,'Stop'),(7,'Sleep'),(8,'Virus'),(9,'Venom'),(10,'Freeze'),(11,'Poison'),(12,'Zombie'),(13,'Berserk'),(14,'Confuse'),(15,'Petrify'),(16,'Silence'),(17,'Trouble'),(18,'Darkness'),(19,'Doom'),(20,'Gradual Petrify'),(21,'Haste'),(22,'Regen'),(23,'Float'),(24,'Shell'),(25,'Vanish'),(26,'Protect'),(27,'Reflect'),(28,'Auto-Life');
/*!40000 ALTER TABLE `estado_alterado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habilidad_activa`
--

DROP TABLE IF EXISTS `habilidad_activa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `habilidad_activa` (
  `Hab_ID` int NOT NULL,
  `Hab_Descripción` varchar(200) NOT NULL,
  `Hab_Nombre` varchar(15) NOT NULL,
  `Hab_Coste_PH` int NOT NULL,
  `Hab_Coste_PM` int DEFAULT NULL,
  `Hab_Poder` float DEFAULT NULL,
  PRIMARY KEY (`Hab_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habilidad_activa`
--

LOCK TABLES `habilidad_activa` WRITE;
/*!40000 ALTER TABLE `habilidad_activa` DISABLE KEYS */;
INSERT INTO `habilidad_activa` VALUES (0,'None','None',0,0,0),(1,'Causes Fire damage to single/multiple targets.','Fire',25,6,14),(2,'Causes a lot of Fire damage to single/multiple targets.','Fira',50,12,29),(3,'Causes big-time Fire damage to single/multiple targets.','Firaga',75,24,72),(4,'Puts single/multiple targets to sleep.','Sleep',20,6,0),(5,'Causes Ice damage to single/multiple targets.','Blizzard',25,6,14),(6,'Causes a lot of Ice damage to single/multiple targets.','Blizzara',50,12,29),(7,'Causes big-time Ice damage to single/multiple targets.','Blizzaga',72,24,85),(8,'Slows down ATB Gauge.','Slow',20,6,0),(9,'Causes Thunder damage to single/multiple targets.','Thunder',25,6,14),(10,'Causes a lot of Thunder damage to single/multiple targets.','Thundara',50,12,29),(11,'Causes big-time Thunder damage to single/multiple targets.','Thundaga',80,24,72),(12,'Stops targets from taking any action.','Stop',25,8,0),(13,'Causes Poison to single/multiple targets.','Poison',35,8,0),(14,'Causes Non-elemental damage and Poison to single/multiple targets.','Bio',40,18,42),(15,'Absorbs MP from the target and transfers it to the spell caster.','Osmose',70,2,15),(16,'Drains HP from the target and transfers it to the spell caster.','Drain',60,14,32),(17,'Amount of damage depends on the target\'s HP.','Demi',30,18,30),(18,'Causes Non-elemental damage.','Comet',55,16,56),(19,'KOs the target.','Death',45,20,0),(20,'Causes Petrify.','Break',30,18,0),(21,'Causes Water damage to single/multiple targets.','Water',55,22,64),(22,'Causes Non-elemental damage to all enemies.','Meteor',95,42,88),(23,'Causes Non-elemental damage.','Flare',95,40,119),(24,'Causes Shadow damage to all targets.','Doomsday',150,72,150),(25,'Restores HP of single/multiple targets.','Cure',20,6,16),(26,'Restores a lot of HP of single/multiple targets.','Cura',40,10,38),(27,'Restores big-time HP of single/multiple targets.','Curaga',80,22,107),(28,'Gradually restores HP.','Regen',25,14,0),(29,'Recover from KO.','Life',30,35,0),(30,'Recover from KO with full HP.','Full-Life',90,24,0),(31,'Scan enemy to determine HP, MP, and weaknesses.','Scan',25,4,0),(32,'Removes Venom and Poison.','Panacea',15,4,0),(33,'Removes Petrify and Gradual Petrify.','Stona',25,8,0),(34,'Removes various abnormal status effects.','Stona',80,20,0),(35,'Reduces damage from magic attacks.','Shell',20,6,0),(36,'Reduces damage from physical attacks.','Protect',20,6,0),(37,'Speeds up ATB Gauge.','Haste',30,8,0),(38,'Causes Silence, which disables magic in single/multiple targets.','Silence',25,8,0),(39,'Makes single/multiple targets smaller.','Mini',35,8,0),(40,'Reflects magic attacks back onto caster.','Reflect',25,6,0),(41,'Causes Confuse, which makes single/multiple targets erratic.','Confuse',35,8,0),(42,'Causes single/multiple targets to attack uncontrollably.','Berserk',30,6,0),(43,'Causes Darkness, which hinders accuracy of physical attacks.','Blind',40,6,0),(44,'Allows single/multiple targets to float in the air.','Float',25,6,0),(45,'Removes abnormal status caused by magic attacks.','Dispel',35,16,0),(46,'Raises physical attack power.','Might',25,14,0),(47,'Extracts Ore from a target.','Jewel',50,4,0),(48,'Causes Holy damage.','Holy',110,36,113),(49,'Causes Non-elemental damage to the enemy.','Goblin Punch',0,4,0),(50,'KOs all enemies whose LEVELs are multiples of 5.','LV5 Death',0,20,0),(51,'Causes Holy damage to enemies whose LEVELs are multiples of 4.','LV4 Holy',0,22,0),(52,'Reduces Defense of enemies whose LEVELs are multiples of 3.','LV3 Def-less',0,12,0),(53,'Casts Doom on the target.','Doom',0,12,0),(54,'Randomly KOs a target.','Roulette',0,18,0),(55,'Causes Water damage to all enemies.','Aqua Breath',0,14,0),(56,'Casts Shell and Protect on all party members.','Mighty Guard',0,64,0),(57,'Reduces the target\'s HP to 1.','Matra Magic',0,8,0),(58,'Causes Confuse, Darkness, Poison, Slow, and Mini to the enemy.','Bad Breath',0,16,0),(59,'Causes Non-elemental damage to the target when your HP is 1.','Limit Glove',0,10,0),(60,'Reduces the enemy\'s HP by 1,000.','1,000 Needles',0,8,0),(61,'Damages with the difference between your max HP and current HP.','Pumpkin Head',0,12,0),(62,'Causes Sleep to all targets.','Night',0,14,0),(63,'Causes Wind damage to all enemies.','Twister',0,22,55),(64,'Causes Earth damage to all enemies.','Earth Shake',0,20,75),(65,'Uses Remedy on all party members.','Angel Snack',0,4,0),(66,'Amount of damage depends on the number of frogs you have caught.','Frog Drop',0,10,0),(67,'Restores HP of all party members.','Frog Drop',0,14,0),(68,'Makes a party member disappear.','Vanish',0,8,0),(69,'Causes Freeze to the enemy.','Frost',0,8,0),(70,'Causes Heat to the enemy.','Mustard Bomb',0,10,0),(71,'Reduces the enemy\'s MP.','Magic Hammer',0,2,0),(72,'Casts Life when KO\'d.','Auto-Life',0,14,0),(73,'Escape from battle with high probability.','Flee',40,0,0),(74,'See the enemy\'s items.','Detect',40,0,0),(75,'Allows back attack.','What\'s That!?',40,2,0),(76,'Draws out the hidden power in thief swords.','Soul Blade',35,6,0),(77,'Causes Trouble to the target.','Annoy',50,4,0),(78,'Sacrifice yourself to restore HP and MP to the other party members.','Sacrifice',55,32,0),(79,'Deal physical damage by luck.','Lucky Seven',85,6,0),(80,'Deal physical damage to the target.','Thievery',100,8,0),(81,'Reduces the enemy\'s HP and MP.','Lancer',20,10,1.2),(82,'Grants Regen on all party members.','Reis\'s Wind',40,12,0),(83,'Reduces HP of all enemies.','Dragon Breath',205,78,0),(84,'Restores MP of all party members.','White Draw',90,36,0),(85,'Causes Berserk to all targets.','Luna',30,12,0),(86,'See for yourself.','Six Dragons',25,28,0),(87,'Causes Non-elemental damage to all enemies.','Cherry Blossom',40,46,1.5),(88,'Deals physical damage to the enemy.','Dragon\'s Crest',45,16,0),(89,'Reduces your HP to cause Shadow damage to the enemy.','Darkside',30,0,0),(90,'Damages with the difference between your max HP and current HP.','Minus Strike',35,8,0),(91,'Knocks Out the target.','Iai Strike',40,16,0),(92,'Reduces the enemy\'s Attack Pwr.','Power Break',40,8,0),(93,'Reduces the enemy\'s Defense.','Armor Break',30,4,0),(94,'Reduces the enemy\'s Magic Def.','Mental Break',45,8,0),(95,'Reduces the enemy\'s Magic.','Magic Break',25,4,0),(96,'Makes all Near Death party members \'Attack\'.','Charge!',30,10,0),(97,'Causes Thunder damage to the enemy.','Thunder Slash',30,24,0),(98,'Causes Non-elemental damage to all enemies.','Stock Break',35,26,1.5),(99,'Causes Non-elemental damage to all enemies.','Climhazzard',70,32,2),(100,'Deals physical damage to the enemy.','Shock',60,46,3),(101,'Casts Auto-Life and Regen on one party member.','Aura',25,12,0),(102,'Restores HP and MP of one party member.','Chakra',30,4,0),(103,'Casts Doom on the enemy.','Countdown',40,16,0),(104,'Makes the enemy weak against some elemental property.','Curse',20,12,0),(105,'Amount of damage depends on the enemy\'s HP.','Demi Shock',50,20,0),(106,'Causes Non-elemental damage to the enemy.','No Mercy',25,12,1.7),(107,'Recover from KO.','Revive',35,20,0),(108,'Causes Non-elemental damage to the enemy by using Gil.','Spare Change',90,0,0),(109,'Causes Ice damage to all enemies.','Shiva',20,24,36),(110,'Causes Fire damage to all enemies.','Ifrit',20,26,42),(111,'Causes Lightning damage to all enemies.','Ramuh',30,22,32),(112,'Reduces all enemies\' HP by a percentage based on its Attack Power. It will not work on bosses.','Atomos',25,32,0),(113,'Causes KO to all enemies.','Odin',30,28,0),(114,'Causes Water damage to all enemies.','Leviathan',40,42,59),(115,'Causes non-elemental damage to all enemies.','Bahamut',80,56,88),(116,'Causes Shadow damage to all enemies.','Ark',100,80,106),(117,'Causes Earth damage to all enemies.','Fenrir',30,30,42),(118,'Causes Fire damage to all enemies and revives all KO\'ed party members.','Phoenix',40,32,40),(119,'Casts Reflect on the party.','Ruby',35,24,0),(120,'Causes Holy damage to all enemies.','Madeen',120,54,71);
/*!40000 ALTER TABLE `habilidad_activa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habilidad_pasiva`
--

DROP TABLE IF EXISTS `habilidad_pasiva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `habilidad_pasiva` (
  `Hab_ID` int NOT NULL,
  `Hab_Descripción` varchar(200) NOT NULL,
  `Hab_Nombre` varchar(15) NOT NULL,
  `Hab_Coste_PH` int NOT NULL,
  `Hab_Coste_PieMag` int DEFAULT NULL,
  PRIMARY KEY (`Hab_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habilidad_pasiva`
--

LOCK TABLES `habilidad_pasiva` WRITE;
/*!40000 ALTER TABLE `habilidad_pasiva` DISABLE KEYS */;
INSERT INTO `habilidad_pasiva` VALUES (0,'None','None',0,0),(1,'Automatically casts Reflect in battle.','Auto-Reflect',95,15),(2,'Automatically casts Float in battle.','Auto-Float',20,6),(3,'Automatically casts Haste in battle.','Auto-Haste',55,9),(4,'Automatically casts Regen in battle.','Auto-Regen',25,10),(5,'Automatically casts Life in battle.','Auto-Life',130,12),(6,'Increases HP by 10%.','HP+10%',20,4),(7,'Increases HP by 20%.','HP+20%',40,8),(8,'Increases MP by 10%.','MP+10%',35,4),(9,'Increases MP by 20%.','MP+20%',30,8),(10,'Raises physical attack accuracy.','Accuracy+',30,2),(11,'Lowers enemy’s physical attack accuracy.','Distract',30,5),(12,'Back row attacks like front row.','Long Reach',170,16),(13,'Uses own MP to raise Attack Pwr.','MP Attack',45,5),(14,'Deals lethal damage to flying enemies.','Bird Killer',20,3),(15,'Deals lethal damage to insects.','Bug Killer',35,2),(16,'Deals lethal damage to stone enemies.','Stone Killer',30,4),(17,'Deals lethal damage to undead enemies.','Undead Killer',45,2),(18,'Deals lethal damage to dragons.','Dragon Killer',70,3),(19,'Deals lethal damage to demons.','Devil Killer',25,2),(20,'Deals lethal damage to beasts.','Beast Killer',30,4),(21,'Deals lethal damage to humans.','Man Eater',25,2),(22,'Jump higher to raise jump attack power.','High Jump',75,4),(23,'Steal better items.','Master Thief',50,5),(24,'Steal Gil along with items.','Steal Gil',40,5),(25,'Restores target\'s HP.','Healer',20,2),(26,'Adds weapon\'s status effect (Add ST) when you Attack.','Add Status',35,3),(27,'Raises Defense occasionally.','Gamble Defense',20,1),(28,'Doubles the potency of medicinal items.','Chemist',15,4),(29,'Raises the strength of Throw.','Power Throw',125,19),(30,'Raises the strength of Chakra.','Power Up',30,3),(31,'Nullifies Reflect and attacks.','Reflect-Null',30,7),(32,'Doubles the strength of spells by using Reflect.','Reflectx2',110,17),(33,'Nullifies magic element.','Mag Elem Null',115,13),(34,'Raises the strength of spells.','Concentrate',80,10),(35,'Cuts MP use by half in battle.','Half MP',140,11),(36,'Allows you to Trance faster.','High Tide',35,8),(37,'Counter-attacks when physically attacked.','Counter',70,8),(38,'You take damage in place of an ally.','Cover',20,6),(39,'You take damage in place of a girl.','Protect Girls',35,4),(40,'Raises Counter activation rate.','Eye 4 Eye',60,5),(41,'Prevents Freeze and Heat.','Body Temp',25,4),(42,'Prevents back attacks.','Alert',40,4),(43,'Raises the chance of first strike.','Initiative',95,5),(44,'Characters level up faster.','Level Up',75,7),(45,'Characters learn abilities faster.','Ability Up',95,3),(46,'Receive more Gil after battle.','Millionaire',100,5),(47,'Receive Gil even when running from battle.','Flee-Gil',45,3),(48,'Mog protects with unseen forces.','Guardian Mog',30,3),(49,'Prevents Sleep.','Insomniac',30,5),(50,'Prevents Poison and Venom.','Antibody',20,4),(51,'Prevents Darkness.','Bright Eyes',35,4),(52,'Prevents Silence.','Loudmouth',40,4),(53,'Restores HP automatically when Near Death.','Restore HP',85,8),(54,'Prevents Petrify and Gradual Petrify.','Jelly',35,4),(55,'Returns magic used by enemy.','Return Magic',90,9),(56,'Absorbs MP used by enemy.','Absorb MP',80,6),(57,'Automatically uses Potion when damaged.','Auto-Potion',30,3),(58,'Prevents Stop.','Locomotion',30,4),(59,'Prevents Confusion.','Clear Headed',25,5),(60,'Raises strength of eidolons.','Boost',190,12),(61,'Attacks with eidolon Odin.','Odin\'s Sword',50,12),(62,'Damages enemy when you Steal.','Mug',65,3),(63,'Raises success rate of Steal.','Bandit',40,5);
/*!40000 ALTER TABLE `habilidad_pasiva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario` (
  `Inv_ID` int NOT NULL AUTO_INCREMENT,
  `Inv_Sección_ID` int NOT NULL,
  `Inv_Pj_ID` int NOT NULL,
  `Inv_Tiempo` time NOT NULL,
  `Inv_Dinero` int NOT NULL,
  `Inv_Locación` int NOT NULL,
  PRIMARY KEY (`Inv_ID`),
  KEY `fk_Inv_Sec` (`Inv_Sección_ID`),
  KEY `fk_Inv_Pj` (`Inv_Pj_ID`),
  KEY `fk_Inv_Loc` (`Inv_Locación`),
  CONSTRAINT `fk_Inv_Loc` FOREIGN KEY (`Inv_Locación`) REFERENCES `locación` (`Locación_ID`),
  CONSTRAINT `fk_Inv_Pj` FOREIGN KEY (`Inv_Pj_ID`) REFERENCES `personaje` (`Pj_ID`),
  CONSTRAINT `fk_Inv_Sec` FOREIGN KEY (`Inv_Sección_ID`) REFERENCES `sección` (`Sección_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (1,2,1,'00:05:21',500,2),(2,3,1,'00:05:24',500,2),(3,2,3,'00:45:12',1200,1),(4,4,3,'00:45:16',1200,1),(5,3,2,'01:15:04',2100,1),(6,2,4,'03:40:55',3450,5),(7,4,4,'03:40:58',3450,5),(8,1,3,'10:38:47',4760,7);
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locación`
--

DROP TABLE IF EXISTS `locación`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locación` (
  `Locación_ID` int NOT NULL AUTO_INCREMENT,
  `Locación_Nombre` varchar(40) NOT NULL,
  `Locación_Continente` varchar(30) NOT NULL,
  PRIMARY KEY (`Locación_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locación`
--

LOCK TABLES `locación` WRITE;
/*!40000 ALTER TABLE `locación` DISABLE KEYS */;
INSERT INTO `locación` VALUES (1,'Alexandria Castle & Town','Mist Continent'),(2,'Theater Ship Prima Vista','Mist Continent'),(3,'Evil Forest','Mist Continent'),(4,'Ice Cavern','Mist Continent'),(5,'Village of Dali','Mist Continent'),(6,'Grand City of Lindblum','Mist Continent'),(7,'Qu\'s Marsh','Mist Continent'),(8,'Gizamaluke\'s Grotto','Mist Continent'),(9,'South Gate','Mist Continent'),(10,'Burmecia (Kingdom of Rain)','Mist Continent'),(11,'Treno','Mist Continent'),(12,'Cleyra\'s Trunk & Settlement','Mist Continent'),(13,'Gargan Roo','Mist Continent'),(14,'Pinnacle Rocks','Mist Continent'),(15,'Conde Petie Mountain Path','Outer Continent'),(16,'Village of Conde Petie','Outer Continent'),(17,'Black Mage Village','Outer Continent'),(18,'Iifa Tree','Outer Continent'),(19,'Madain Sari (Village of Lost Summons)','Outer Continent'),(20,'Ipsen\'s Castle','Forgotten Continent'),(21,'Oeilvert','Forgotten Continent'),(22,'Desert Palace','Forgotten Continent'),(23,'Esto Gaza','Lost Continent'),(24,'Mount Gulug','Lost Continent'),(25,'Daguerreo','Forgotten Continent'),(26,'Pandemonium','Terra'),(27,'Memoria','Space-Time'),(28,'The Crystal World','Space-Time');
/*!40000 ALTER TABLE `locación` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objeto`
--

DROP TABLE IF EXISTS `objeto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `objeto` (
  `Objeto_ID` int NOT NULL AUTO_INCREMENT,
  `Objeto_Tipo_ID` int NOT NULL,
  `Objeto_Nombre` varchar(20) NOT NULL,
  `Objeto_Descripción` varchar(100) NOT NULL,
  PRIMARY KEY (`Objeto_ID`),
  KEY `fk_Obj_tipo` (`Objeto_Tipo_ID`),
  CONSTRAINT `fk_Obj_tipo` FOREIGN KEY (`Objeto_Tipo_ID`) REFERENCES `tipo` (`Tipo_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=275 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objeto`
--

LOCK TABLES `objeto` WRITE;
/*!40000 ALTER TABLE `objeto` DISABLE KEYS */;
INSERT INTO `objeto` VALUES (1,1,'Potion','Restores 150 HP. The effect decreases if used in the field.'),(2,1,'Hi-Potion','Restores 450 HP. The effect decreases if used in the field.'),(3,1,'Ether','Restores 150 MP. The effect decreases if used in the field.'),(4,1,'Elixir','Fully restores HP and MP.'),(5,1,'Phoenix Down','Cures KO.'),(6,1,'Echo Screen','Cures Silence.'),(7,1,'Soft','Cures Petrify and Gradual Petrify.'),(8,1,'Antidote','Cures Poison and Venom.'),(9,1,'Eye Drops','Cures Darkness.'),(10,1,'Remedy','Cures various status abnormalities.'),(11,1,'Annoyntment','Cures Trouble.'),(12,1,'Vaccine','Cures Virus.'),(13,1,'Magic Tag','Cures Zombie.'),(14,1,'Tent','Restores HP and MP. If you ask a save moogle, he will restore everyone\'s HP and MP.'),(15,1,'Gysahl Greens','Cures Berserk. Item has not effect in the field. Chocobo\'s favorite food.'),(16,1,'Dead Pepper','Deals damage to the target. If you give it to a chocobo...'),(17,1,'Ore','Can be used in battle. Potency varies.'),(18,1,'Pinwheel','Throwing weapon for Amarant.'),(19,1,'Rising Sun','Throwing weapon for Amarant.'),(20,1,'Wing Edge','Throwing weapon for Amarant.'),(21,2,'Dagger','Standard thief sword.'),(22,2,'Mage Masher','Inflicts Silence. Effective against mages.'),(23,2,'Mythril Dagger','Standard thief sword.'),(24,2,'Butterfly Sword','Thief sword with a beautiful design.'),(25,2,'The Ogre','Powerful thief sword.'),(26,2,'Gladius','Thief sword with a wind property.'),(27,2,'Exploda','Thief sword made of high-quality steel.'),(28,2,'Rune Tooth','Thief sword with magical patterns.'),(29,2,'Zorlin Shape','Thief sword with an intricate shape.'),(30,2,'Angel Bless','Inflicts Confuse.'),(31,2,'Sargatanas','Inflicts Petrify.'),(32,2,'Masamune','Legendary thief sword with a high critical rate.'),(33,2,'Orichalcon','Thief sword with high physical attack power.'),(34,2,'The Tower','Thief sword shrouded in mystery.'),(35,2,'Ultima Weapon','Zidane\'s ultimate weapon.'),(36,2,'Broadsword','Standard knight sword.'),(37,2,'Iron Sword','Knight sword made of iron.'),(38,2,'Mythril Sword','Knight sword made of mythril.'),(39,2,'Blood Sword','Drains HP from the target.'),(40,2,'Ice Brand','Causes Ice damage.'),(41,2,'Coral Sword','Causes Thunder damage.'),(42,2,'Diamond Sword','Knight sword made of diamond.'),(43,2,'Flame Saber','Causes Fire damage.'),(44,2,'Rune Blade','Knight sword with magic properties.'),(45,2,'Defender','Knight sword that raises physical defense.'),(46,2,'Ultima Sword','Powerful knight sword.'),(47,2,'Excalibur','Causes Holy damage.'),(48,2,'Ragnarok','Inflicts Slow.'),(49,2,'Excalibur II','Steiner\'s ultimate weapon.'),(50,2,'Save the Queen','Beatrix\'s sword.'),(51,2,'Mage Staff','Standard black mage staff.'),(52,2,'Flame Staff','Raises Fire elemental power.'),(53,2,'Ice Staff','Raises Ice elemental power.'),(54,2,'Lightning Staff','Raises Thunder elemental power.'),(55,2,'Oak Staff','Standard black mage staff.'),(56,2,'Cypress Pile','Black mage staff made of cypress.'),(57,2,'Octagon Rod','Protects from Water and Wind attacks.'),(58,2,'High Mage Staff','Black mage staff with high magic power.'),(59,2,'Mace of Zeus','Vivi\'s ultimate weapon.'),(60,2,'Rod','Standard white mage rod.'),(61,2,'Mythril Rod','White mage rod made of mythril.'),(62,2,'Stardust Rod','Raises Reflect power.'),(63,2,'Healing Rod','Restores HP when attacking.'),(64,2,'Asura\'s Rod','Causes Holy damage.'),(65,2,'Wizard Rod','White mage rod with high magic power.'),(66,2,'Whale Whisker','Dagger\'s ultimate weapon.'),(67,2,'Javelin','Standard dragon knight spear.'),(68,2,'Mythril Spear','Spear made of mythril.'),(69,2,'Partisan','Powerful dragon knight spear.'),(70,2,'Ice Lance','Causes Ice damage.'),(71,2,'Trident','Causes Thunder damage.'),(72,2,'Heavy Lance','Powerful dragon knight spear.'),(73,2,'Obelisk','Spear made of high-quality steel.'),(74,2,'Holy Lance','Causes Holy damage.'),(75,2,'Kain\'s Lance','Legendary dragon knight spear.'),(76,2,'Dragon\'s Hair','Freya\'s ultimate weapon.'),(77,2,'Fork','Standard fork.'),(78,2,'Needle Fork','Inflicts Petrify.'),(79,2,'Mythril Fork','Fork made of mythril.'),(80,2,'Silver Fork','Fork with high physical attack power.'),(81,2,'Bistro Fork','Quina\'s ultimate weapon.'),(82,2,'Gastro Fork','Legendary fork with high physical attack power.'),(83,2,'Golem\'s Flute','Inflicts Auto-Regen on the user.'),(84,2,'Lamia\'s Flute','Inflicts Confuse.'),(85,2,'Fairy Flute','Inflicts Auto-Regen on the user.'),(86,2,'Hamelin','Flute that holds powerful magic.'),(87,2,'Siren\'s Flute','Inflicts Auto-Regen on the user.'),(88,2,'Angel Flute','Eiko\'s ultimate weapon.'),(89,2,'Cat\'s Claws','Weapon used by a bounty hunter.'),(90,2,'Poison Knuckles','Inflicts Poison.'),(91,2,'Mythril Claws','Claws made of mythril.'),(92,2,'Scissor Fangs','Inflicts Venom.'),(93,2,'Dragon\'s Claws','Weapon with a water property.'),(94,2,'Tiger Fangs','Powerful bounty hunter weapon.'),(95,2,'Avenger','Inflicts Counter on the user.'),(96,2,'Kaiser Knuckles','Weapon with a wind property.'),(97,2,'Duel Claws','Powerful bounty hunter weapon.'),(98,2,'Rune Claws','Amarant\'s ultimate weapon.'),(99,2,'Air Racket','Long-range racket. Wind-attribute weapon.'),(100,2,'Multina Racket','Long-range racket. Ought to increase your status values.'),(101,2,'Magic Racket','Long-range racket. Ought to increase your magic power.'),(102,2,'Mythril Racket','Long-range weapon made of mythril.'),(103,2,'Priest\'s Racket','Long-range holy racket.'),(104,2,'Tiger Racket','Long-range racket. Great weapon containing immense power.'),(105,3,'Leather Hat','Standard leather hat.'),(106,3,'Feather Hat','Hat with a feather accent.'),(107,3,'Steepled Hat','Standard mage hat.'),(108,3,'Headband','Raises physical attack power.'),(109,3,'Magus Hat','Raises ice elemental power.'),(110,3,'Bandana','Raises speed.'),(111,3,'Mage\'s Hat','Raises fire elemental power.'),(112,3,'Lamia\'s Tiara','Protects against confusion.'),(113,3,'Ritual Hat','Raises physical attack power.'),(114,3,'Twist Headband','Raises physical attack power.'),(115,3,'Green Beret','Raises speed.'),(116,3,'Mantra Band','Raises magic power.'),(117,3,'Dark Hat','Raises thunder elemental power.'),(118,3,'Coronet','Raises wind elemental power.'),(119,3,'Golden Hairpin','Raises water elemental power.'),(120,3,'Flash Hat','Raises speed and magic power.'),(121,3,'Adaman Hat','Protects against thunder.'),(122,3,'Thief\'s Hat','Raises speed.'),(123,3,'Holy Mitre','Raises magic power.'),(124,3,'Golden Skullcap','Raises physical defense.'),(125,3,'Circlet','Standard hat.'),(126,3,'Bronze Helm','Standard bronze helm.'),(127,3,'Iron Helm','Standard iron helm.'),(128,3,'Barbut','Standard helm.'),(129,3,'Mythril Helm','Raises spirit.'),(130,3,'Gold Helm','Protects against water.'),(131,3,'Cross Helm','Raises physical defense.'),(132,3,'Diamond Helm','Protects against water.'),(133,3,'Platina Helm','Protects against stone status.'),(134,3,'Kaiser Helm','Raises physical attack power.'),(135,3,'Genji Helm','Legendary helm.'),(136,4,'Leather Shirt','Standard leather shirt.'),(137,4,'Silk Shirt','Protects against thunder.'),(138,4,'Leather Cloak','Standard cloak.'),(139,4,'Bronze Vest','Standard bronze vest.'),(140,4,'Chain Mail','Protects against wind.'),(141,4,'Power Vest','Raises physical attack power.'),(142,4,'Mythril Vest','Protects against water.'),(143,4,'Adaman Vest','Raises physical defense.'),(144,4,'Magician Cloak','Raises magic power.'),(145,4,'Survival Vest','Raises spirit.'),(146,4,'Brigandine','Raises physical attack power.'),(147,4,'Judogens','Raises speed.'),(148,4,'Rubber Suit','Protects against thunder.'),(149,4,'Minerva\'s Plate','Women-only armor.'),(150,4,'Ninja Gear','Raises speed.'),(151,4,'Gaia Gear','Raises earth elemental power.'),(152,4,'Shield Armor','Protects against fire, ice, and thunder.'),(153,4,'Brave Suit','Raises physical attack power.'),(154,4,'Black Garb','Raises speed.'),(155,4,'Mirage Vest','Standard vest.'),(156,4,'Silk Robe','Raises magic power.'),(157,4,'Magician Robe','Raises magic power.'),(158,4,'Glutton\'s Robe','Standard robe.'),(159,4,'White Robe','Raises holy and ice power.'),(160,4,'Black Robe','Raises fire, ice, and thunder power.'),(161,4,'Light Robe','Standard robe.'),(162,4,'Robe of Lords','Legendary robe.'),(163,4,'Bronze Armor','Standard bronze armor.'),(164,4,'Iron Armor','Standard iron armor.'),(165,4,'Mythril Armor','Standard mythril armor.'),(166,4,'Gold Armor','Protects against petrify status.'),(167,4,'Diamond Armor','Standard armor.'),(168,4,'Platina Armor','Standard armor.'),(169,4,'Carabini Mail','Raises speed.'),(170,4,'Dragon Mail','Raises physical attack power.'),(171,4,'Genji Armor','Legendary armor.'),(172,4,'Grand Armor','Prevents faint status.'),(173,5,'Leather Wrist','Standard leather wrist.'),(174,5,'Glass Armlet','Protects against water.'),(175,5,'Bone Wrist','Raises earth elemental power.'),(176,5,'Mythril Armlet','Standard armlet.'),(177,5,'Magic Armlet','Raises magic power.'),(178,5,'Chimera Armlet','Protects against holy.'),(179,5,'Egoist\'s Armlet','Protects against shadow.'),(180,5,'N-Kai Armlet','Protects against water.'),(181,5,'Jade Armlet','Raises wind elemental power.'),(182,5,'Lapis Armlet','Standard armlet.'),(183,5,'Dragon Wrist','Standard wrist.'),(184,5,'Thief\'s Gloves','Raises speed.'),(185,5,'Bracer','Raises physical attack power.'),(186,5,'Gauntlets','Standard gauntlets.'),(187,5,'Mythril Gloves','Standard gloves.'),(188,5,'Thunder Gloves','Protects against thunder.'),(189,5,'Diamond Gloves','Standard gloves.'),(190,5,'Venetia Shield','Protects against fire and ice.'),(191,5,'Defense Gloves','Standard gloves.'),(192,5,'Genji Gloves','Legendary gloves.'),(193,5,'Aegis Gloves','Standard gloves.'),(194,5,'Grand Gloves','Standard gloves.'),(195,5,'Bronze Gloves','Standard bronze gloves.'),(196,5,'Iron Gloves','Standard iron gloves.'),(197,6,'Desert Boots','Raises earth elemental power.'),(198,6,'Magician Shoes','Raises magic power.'),(199,6,'Germinas Boots','Raises speed.'),(200,6,'Feather Boots','Raises earth elemental power.'),(201,6,'Black Belt','Raises physical attack power.'),(202,6,'Madain\'s Ring','Protects against ice.'),(203,6,'Rosetta Ring','Raises physical defense.'),(204,6,'Reflect Ring','Inflicts Auto-Reflect.'),(205,6,'Coral Ring','Protects against thunder.'),(206,6,'Promist Ring','Raises physical attack power.'),(207,6,'Running Shoes','Inflicts Auto-Haste.'),(208,6,'Rebirth Ring','Inflicts Auto-Life.'),(209,6,'Angel Earrings','Women-only accessories.'),(210,6,'Dark Matter','Deals damage to the target. Equip as an Add-on.'),(211,6,'Phoenix Pinion','Cures KO. It cannot be used in the field.'),(212,6,'Garnet','Raises water elemental power.'),(213,6,'Amethyst','Raises atomos power.'),(214,6,'Aquamarine','Raises leviathan power.'),(215,6,'Diamond','Raises physical defense.'),(216,6,'Emerald','Raises haste power.'),(217,6,'Moonstone','Standard gem.'),(218,6,'Peridot','Raises ramuh power.'),(219,6,'Opal','Raises shiva power.'),(220,6,'Ruby','Raises carbuncle power.'),(221,6,'Sapphire','Raises fenrir power.'),(222,6,'Topaz','Raises ifrit power.'),(223,6,'Lapis Lazuli','Raises ark power.'),(224,6,'Ankh Earrings','Standard earrings.'),(225,6,'Cachusha','Raises spirit.'),(226,6,'Barette','Raises physical attack power.'),(227,6,'Extension','Raises physical attack power.'),(228,6,'Ribbon','Legendary accessory.'),(229,6,'Power Belt','Raises physical attack power.'),(230,6,'Gold Choker','Raises magic power.'),(231,6,'Key to Success','Standard accessory.'),(232,6,'Protect Ring','Raises physical defense.'),(233,6,'Pumice Piece','Standard accessory.'),(234,6,'Pumice','Summons Ark.'),(235,6,'Yellow Scarf','Standard scarf.'),(236,6,'Glass Buckle','Standard buckle.'),(237,6,'Pearl Rogue','Women-only accessories.'),(238,6,'Ancient Aroma','Raises physical attack power.'),(239,7,'Aries','Stellazzio with an Aries engraving.'),(240,7,'Taurus','Stellazzio with a Taurus engraving.'),(241,7,'Gemini','Stellazzio with a Gemini engraving.'),(242,7,'Cancer','Stellazzio with a Cancer engraving.'),(243,7,'Leo','Stellazzio with a Leo engraving.'),(244,7,'Virgo','Stellazzio with a Virgo engraving.'),(245,7,'Libra','Stellazzio with a Libra engraving.'),(246,7,'Scorpio','Stellazzio with a Scorpio engraving.'),(247,7,'Sagittarius','Stellazzio with a Sagittarius engraving.'),(248,7,'Capricorn','Stellazzio with a Capricorn engraving.'),(249,7,'Aquarius','Stellazzio with an Aquarius engraving.'),(250,7,'Pisces','Stellazzio with a Pisces engraving.'),(251,7,'Ophiuchus','Stellazzio with an Ophiuchus engraving.'),(252,7,'Morrid\'s Coffee','Coffee selected by Morrid.'),(253,7,'Moccha Coffee','Coffee bean with a unique aroma.'),(254,7,'Kirman Coffee','Coffee bean with a rich aroma.'),(255,7,'Burman Coffee','Legendary coffee bean.'),(256,7,'Doga\'s Artifact','Artifact from another world.'),(257,7,'Une\'s Mirror','Mirror from another world.'),(258,7,'Rat Tail','Shimmering accessory.'),(259,7,'Griffin\'s Heart','Jewel that glows like fire.'),(260,7,'Magical Fingertip','Mysterious artificial finger.'),(261,7,'Autograph','Zidane\'s autograph.'),(262,7,'Moogle\'s Cloak','Cloak that smells like a Moogle.'),(263,7,'Gate Pass','Pass used to open the South Gate.'),(264,7,'Superslick','Special oil used for machinery.'),(265,7,'Strategy Guide','Thick book on battle strategy.'),(266,7,'Passport','Pass to enter the Falcon Claw.'),(267,7,'Gulug Stone','Mysterious stone found in Oeilvert.'),(268,7,'Master Room Key','Key to the master room at the inn.'),(269,7,'Athlete Queen','Award for the fastest runner in Alexandria.'),(270,7,'Rank S Medal','Medal given to a legendary treasure hunter.'),(271,7,'Mini-Cid','Moving doll made by a master craftsman.'),(272,7,'Mini-Burmecia','Detailed model of the Burmecian Kingdom.'),(273,7,'Mini-Prima Vista','Detailed model of the theater ship.'),(274,7,'Provinces Map','Map of the Mist Continent.');
/*!40000 ALTER TABLE `objeto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pasiva_pj`
--

DROP TABLE IF EXISTS `pasiva_pj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pasiva_pj` (
  `Pas_Pj_ID` int NOT NULL AUTO_INCREMENT,
  `Pj_ID` int NOT NULL,
  `Hab_Pas_ID` int NOT NULL,
  PRIMARY KEY (`Pas_Pj_ID`),
  KEY `fk_Pas_Pj_ID` (`Pj_ID`),
  KEY `fk_Pas_Hab_ID` (`Hab_Pas_ID`),
  CONSTRAINT `fk_Pas_Hab_ID` FOREIGN KEY (`Hab_Pas_ID`) REFERENCES `habilidad_pasiva` (`Hab_ID`),
  CONSTRAINT `fk_Pas_Pj_ID` FOREIGN KEY (`Pj_ID`) REFERENCES `personaje` (`Pj_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pasiva_pj`
--

LOCK TABLES `pasiva_pj` WRITE;
/*!40000 ALTER TABLE `pasiva_pj` DISABLE KEYS */;
INSERT INTO `pasiva_pj` VALUES (1,1,3),(2,1,4),(3,1,6),(4,1,7),(5,1,10),(6,1,11),(7,1,13),(8,1,14),(9,1,15),(10,1,16),(11,1,17),(12,1,18),(13,1,19),(14,1,20),(15,1,21),(16,1,23),(17,1,24),(18,1,26),(19,1,28),(20,1,36),(21,1,37),(22,1,39),(23,1,41),(24,1,42),(25,1,43),(26,1,44),(27,1,45),(28,1,47),(29,1,49),(30,1,50),(31,1,51),(32,1,54),(33,1,57),(34,1,59),(35,1,62),(36,1,63),(37,2,1),(38,2,3),(39,2,4),(40,2,6),(41,2,7),(42,2,10),(43,2,11),(44,2,13),(45,2,14),(46,2,15),(47,2,16),(48,2,17),(49,2,18),(50,2,19),(51,2,20),(52,2,21),(53,2,26),(54,2,27),(55,2,36),(56,2,37),(57,2,38),(58,2,40),(59,2,41),(60,2,44),(61,2,45),(62,2,49),(63,2,50),(64,2,51),(65,2,54),(66,2,57),(67,2,58),(68,2,59),(69,3,1),(70,3,3),(71,3,4),(72,3,8),(73,3,9),(74,3,28),(75,3,31),(76,3,32),(77,3,33),(78,3,34),(79,3,35),(80,3,36),(81,3,41),(82,3,44),(83,3,45),(84,3,49),(85,3,50),(86,3,52),(87,3,53),(88,3,55),(89,3,56),(90,3,58),(91,3,59),(92,4,1),(93,4,2),(94,4,3),(95,4,4),(96,4,8),(97,4,9),(98,4,25),(99,4,28),(100,4,32),(101,4,34),(102,4,35),(103,4,36),(104,4,41),(105,4,44),(106,4,45),(107,4,49),(108,4,50),(109,4,52),(110,4,53),(111,4,59),(112,4,60),(113,5,3),(114,5,4),(115,5,6),(116,5,7),(117,5,10),(118,5,11),(119,5,13),(120,5,14),(121,5,15),(122,5,16),(123,5,17),(124,5,18),(125,5,19),(126,5,20),(127,5,21),(128,5,22),(129,5,26),(130,5,36),(131,5,37),(132,5,38),(133,5,41),(134,5,43),(135,5,44),(136,5,45),(137,5,49),(138,5,50),(139,5,51),(140,5,54),(141,5,57),(142,5,59),(143,6,1),(144,6,3),(145,6,4),(146,6,6),(147,6,7),(148,6,8),(149,6,9),(150,6,13),(151,6,14),(152,6,15),(153,6,16),(154,6,17),(155,6,18),(156,6,19),(157,6,20),(158,6,21),(159,6,26),(160,6,35),(161,6,36),(162,6,37),(163,6,41),(164,6,44),(165,6,45),(166,6,46),(167,6,49),(168,6,50),(169,6,51),(170,6,54),(171,6,57),(172,6,59),(173,7,1),(174,7,3),(175,7,4),(176,7,8),(177,7,9),(178,7,25),(179,7,28),(180,7,32),(181,7,34),(182,7,35),(183,7,36),(184,7,41),(185,7,44),(186,7,45),(187,7,48),(188,7,49),(189,7,50),(190,7,52),(191,7,53),(192,7,59),(193,7,60),(194,7,61),(195,8,2),(196,8,3),(197,8,4),(198,8,6),(199,8,7),(200,8,10),(201,8,11),(202,8,12),(203,8,13),(204,8,14),(205,8,15),(206,8,16),(207,8,17),(208,8,18),(209,8,19),(210,8,20),(211,8,21),(212,8,26),(213,8,29),(214,8,30),(215,8,36),(216,8,37),(217,8,40),(218,8,41),(219,8,44),(220,8,45),(221,8,49),(222,8,50),(223,8,51),(224,8,54),(225,8,57),(226,8,58),(227,8,59);
/*!40000 ALTER TABLE `pasiva_pj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personaje`
--

DROP TABLE IF EXISTS `personaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personaje` (
  `Pj_ID` int NOT NULL,
  `Pj_Nombre` varchar(8) NOT NULL,
  `Pj_Vit_Max` int NOT NULL,
  `Pj_PM_Max` int NOT NULL,
  `Pj_PieMag_Max` int NOT NULL,
  PRIMARY KEY (`Pj_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personaje`
--

LOCK TABLES `personaje` WRITE;
/*!40000 ALTER TABLE `personaje` DISABLE KEYS */;
INSERT INTO `personaje` VALUES (1,'Zidane',105,36,12),(2,'Steiner',120,24,10),(3,'Vivi',85,50,16),(4,'Garnet',90,44,14),(5,'Freya',110,30,11),(6,'Quina',100,32,10),(7,'Eiko',80,48,15),(8,'Amarant',115,28,11);
/*!40000 ALTER TABLE `personaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sección`
--

DROP TABLE IF EXISTS `sección`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sección` (
  `Sección_ID` int NOT NULL AUTO_INCREMENT,
  `Sección_Nombre` varchar(15) NOT NULL,
  PRIMARY KEY (`Sección_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sección`
--

LOCK TABLES `sección` WRITE;
/*!40000 ALTER TABLE `sección` DISABLE KEYS */;
INSERT INTO `sección` VALUES (1,'Main'),(2,'Objetos'),(3,'Habilidad'),(4,'Equipo');
/*!40000 ALTER TABLE `sección` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo`
--

DROP TABLE IF EXISTS `tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo` (
  `Tipo_ID` int NOT NULL AUTO_INCREMENT,
  `Tipo_Nombre` varchar(20) NOT NULL,
  PRIMARY KEY (`Tipo_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo`
--

LOCK TABLES `tipo` WRITE;
/*!40000 ALTER TABLE `tipo` DISABLE KEYS */;
INSERT INTO `tipo` VALUES (1,'Consumible'),(2,'Arma'),(3,'Sombrero/Casco'),(4,'Armadura'),(5,'Brazal/Guantelete'),(6,'Accesorio/Gema'),(7,'Objeto Clave');
/*!40000 ALTER TABLE `tipo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-15 16:46:01
