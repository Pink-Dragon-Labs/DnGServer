-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 192.168.1.58    Database: realmdb
-- ------------------------------------------------------
-- Server version	5.5.5-10.0.34-MariaDB-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access`
--

DROP TABLE IF EXISTS `access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverID` tinyint(4) NOT NULL,
  `type` enum('login','logout') NOT NULL,
  `date` date DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `login` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '0',
  `IP` int(11) NOT NULL DEFAULT '0',
  `accountID` tinyint(3) DEFAULT NULL,
  `logout` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `key1` (`accountID`),
  KEY `key3` (`accountID`,`serverID`,`type`,`date`),
  KEY `idx_access_login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access`
--

LOCK TABLES `access` WRITE;
/*!40000 ALTER TABLE `access` DISABLE KEYS */;
INSERT INTO `access` VALUES (1,0,'login',NULL,'2018-03-25 22:10:22','1522015717',-1062731510,1,'1522015822');
/*!40000 ALTER TABLE `access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accountLocks`
--

DROP TABLE IF EXISTS `accountLocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountLocks` (
  `accountID` int(11) NOT NULL,
  `server` smallint(6) NOT NULL,
  UNIQUE KEY `accountKey` (`accountID`),
  KEY `serverKey` (`server`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountLocks`
--

LOCK TABLES `accountLocks` WRITE;
/*!40000 ALTER TABLE `accountLocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `accountLocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accountLog`
--

DROP TABLE IF EXISTS `accountLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountLog` (
  `id` int(11) NOT NULL,
  `loginNameID` int(11) NOT NULL,
  `date` date NOT NULL DEFAULT '0000-00-00',
  `time` time NOT NULL DEFAULT '00:00:00',
  `type` enum('unknown','gmcmd','impcmd','setpass','settitle','erasechar','createchar','disabled','suspended','enabled','lostchar','renewal','removed','cancelled','upd-reg','upd-bill','syscmd','banned') NOT NULL DEFAULT 'unknown',
  `text` text CHARACTER SET ascii,
  `server` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `accountIdx` (`loginNameID`),
  KEY `typeIdx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountLog`
--

LOCK TABLES `accountLog` WRITE;
/*!40000 ALTER TABLE `accountLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `accountLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accountOwners`
--

DROP TABLE IF EXISTS `accountOwners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountOwners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `fullName` varchar(128) NOT NULL,
  `streetAddress` varchar(128) NOT NULL,
  `city` varchar(128) NOT NULL,
  `state` varchar(128) NOT NULL,
  `countryCode` char(2) NOT NULL,
  `postalCode` varchar(64) NOT NULL,
  `emailID` int(11) NOT NULL,
  `maidenName` varchar(64) NOT NULL,
  `spamPrefs` set('realm','corporate') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accountIdx` (`accountID`),
  KEY `creationIdx` (`date`),
  KEY `key3` (`emailID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountOwners`
--

LOCK TABLES `accountOwners` WRITE;
/*!40000 ALTER TABLE `accountOwners` DISABLE KEYS */;
/*!40000 ALTER TABLE `accountOwners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) NOT NULL DEFAULT '0',
  `type` enum('inactive','monthly','yearly','comp') NOT NULL,
  `billingStatus` enum('unpaid','paid','trial','error') NOT NULL,
  `creationDate` timestamp NULL DEFAULT NULL,
  `disciplineExpiration` timestamp NULL DEFAULT NULL,
  `billingDate` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `loginNameID` int(11) NOT NULL,
  `password` char(16) NOT NULL,
  `rights` enum('normal','guide','moderator','implementor','prophet','cs','teleport','basic teleport','shutdown','log chat','toon change','conjure','disable','ambush','heal','buy free','log acoard moderator','gmcmd','impcmd','setpass','settitle','erasechar','createchar','disabled','suspended','enabled','lostchar','renewal','removed','cancelled','upd-reg','upd-bill','syscmd','banned') DEFAULT NULL,
  `status` enum('normal','revoked','gagged','suspended','purged','disabled') DEFAULT NULL,
  `productOrderID` int(11) NOT NULL,
  `validationTime` timestamp NULL DEFAULT NULL,
  `nCoppers` int(11) NOT NULL,
  `nCredits` int(11) NOT NULL,
  `reason` char(16) DEFAULT NULL,
  `actionTimer` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `loginNameIdx` (`loginNameID`),
  KEY `namePassIdx` (`loginNameID`,`password`),
  KEY `billingIdx` (`billingDate`),
  KEY `creationIdx` (`creationDate`),
  KEY `billingStatusIdx` (`billingStatus`),
  KEY `productOrderKey` (`productOrderID`),
  KEY `validationTimeKey` (`validationTime`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=ascii;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,1,'yearly','paid','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'1234','prophet','normal',2018,'0000-00-00 00:00:00',0,0,'','');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_correctdate`
--

DROP TABLE IF EXISTS `accounts_correctdate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_correctdate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) NOT NULL DEFAULT '0',
  `type` enum('inactive','monthly','yearly','comp') NOT NULL,
  `billingStatus` enum('unpaid','paid','trial','error') NOT NULL,
  `creationDate` date DEFAULT NULL,
  `disciplineExpiration` date DEFAULT NULL,
  `billingDate` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `loginNameID` int(11) NOT NULL,
  `password` char(16) NOT NULL,
  `rights` enum('normal',' guide',' moderator',' implementor',' prophet',' cs',' teleport',' basic teleport',' shutdown',' log chat',' toon change',' conjure',' disable',' ambush',' heal',' buy free',' log account',' updated',' board moderator','gmcmd','impcmd','setpass','settitle','erasechar','createchar','disabled','suspended','enabled','lostchar','renewal','removed','cancelled','upd-reg','upd-bill','syscmd','banned)') NOT NULL DEFAULT 'normal',
  `status` enum('normal','revoked','gagged','suspended','disabled','revoked','gagged','suspended','disabled','revoked','gagged','suspended','disabled','revoked','gagged','suspended','disabled','revoked','gagged','suspended','disabled') DEFAULT 'normal',
  `productOrderID` int(11) NOT NULL,
  `validationTime` datetime NOT NULL,
  `nCoppers` int(11) NOT NULL,
  `nCredits` int(11) NOT NULL,
  `reason` char(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `loginNameIdx` (`loginNameID`),
  KEY `billingIdx` (`billingDate`),
  KEY `billingStatusIdx` (`billingStatus`),
  KEY `creationIdx` (`creationDate`),
  KEY `namePassIdx` (`loginNameID`,`password`),
  KEY `productOrderKey` (`productOrderID`),
  KEY `validationTimeKey` (`validationTime`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_correctdate`
--

LOCK TABLES `accounts_correctdate` WRITE;
/*!40000 ALTER TABLE `accounts_correctdate` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_correctdate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badOfferCodes`
--

DROP TABLE IF EXISTS `badOfferCodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badOfferCodes` (
  `id` int(11) NOT NULL,
  `code` varchar(10) NOT NULL,
  `ip` varchar(36) NOT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ipIdx` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badOfferCodes`
--

LOCK TABLES `badOfferCodes` WRITE;
/*!40000 ALTER TABLE `badOfferCodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `badOfferCodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blames`
--

DROP TABLE IF EXISTS `blames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blames` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `complainID` int(11) NOT NULL DEFAULT '1',
  `characterNameID` int(11) NOT NULL DEFAULT '1',
  `accountID` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `characterIdx` (`characterNameID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blames`
--

LOCK TABLES `blames` WRITE;
/*!40000 ALTER TABLE `blames` DISABLE KEYS */;
/*!40000 ALTER TABLE `blames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bumChecks`
--

DROP TABLE IF EXISTS `bumChecks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bumChecks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountNumber` varchar(32) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key1` (`accountNumber`),
  KEY `key2` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bumChecks`
--

LOCK TABLES `bumChecks` WRITE;
/*!40000 ALTER TABLE `bumChecks` DISABLE KEYS */;
/*!40000 ALTER TABLE `bumChecks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `characterNames`
--

DROP TABLE IF EXISTS `characterNames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `characterNames` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=ascii ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characterNames`
--

LOCK TABLES `characterNames` WRITE;
/*!40000 ALTER TABLE `characterNames` DISABLE KEYS */;
INSERT INTO `characterNames` VALUES (1,'God');
/*!40000 ALTER TABLE `characterNames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `characters`
--

DROP TABLE IF EXISTS `characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) DEFAULT NULL,
  `characterNameID` int(11) NOT NULL,
  `data` mediumtext,
  `spells` text CHARACTER SET utf8,
  `quests` mediumtext CHARACTER SET utf8,
  `crimes` text CHARACTER SET utf8,
  `size` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nameIdx` (`characterNameID`),
  KEY `loginIdx` (`accountID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=ascii ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characters`
--

LOCK TABLES `characters` WRITE;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
INSERT INTO `characters` VALUES (1,1,1,'god\n1522015795\nMaleAdventurer\nGod\n \n1:1\n0\n3\n-1\n10\n10\n10\n12\n18\n54\n54\n0\n0\n128\n750\n50\n0\n0200000001050050100000000000512\n110110010011100000001000000000000000000000000000000000000000000000000000000000000100101100000000000001000000000000000000000000000000000000000000000\n0\n0\n0\n0\n1\n0\n0\n0\n1\n0\n0\n0\n1\n0\n13\n4\n7\n0\n0\n5029:0\n350\n292\n0\nEnter personal information about your character here.\n100\n100\n1\n0\n5\n17 0 0 -1 0\n67 0 0 -1 0\n72 0 0 -1 0\n83 0 3 -1 0\n84 0 3 -1 0\n14\nNewbieLeatherPants\n\n99\n0\n10\n10\n125\n0\n0\n0\n3\n2 2 0 -1 0\n3 2 0 -1 0\n11 2 0 -1 0\n1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nNewbieLeatherShirt\n\n99\n0\n8\n8\n80\n0\n0\n0\n3\n2 2 0 -1 0\n3 2 0 -1 0\n11 2 0 -1 0\n1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nNewbieSword\n\n104\n0\n10\n10\n200\n0\n0\n0\n5\n1 2 0 -1 0\n2 2 0 -1 0\n3 2 0 -1 0\n0 0 0 -1 0\n11 3 0 -1 0\n-1\n1\n-1\n-1\n-1\n\n-1\n\n-1\nNewbieSmallShield\n\n74\n0\n8\n8\n200\n0\n0\n0\n3\n2 2 0 -1 0\n3 2 0 -1 0\n1 2 0 -1 0\n1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nNewbieLeatherBoots\n\n99\n0\n6\n6\n150\n0\n0\n0\n3\n2 2 0 -1 0\n3 2 0 -1 0\n11 2 0 -1 0\n1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nNewbieLeatherCowl\n\n99\n0\n4\n4\n70\n0\n0\n0\n3\n2 2 0 -1 0\n3 2 0 -1 0\n11 2 0 -1 0\n1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nBread\n\n0\n0\n4\n4\n0\n0\n0\n0\n0\n-1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nBread\n\n0\n0\n4\n4\n0\n0\n0\n0\n0\n-1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nWaterBottle\n\n0\n0\n3\n3\n0\n0\n0\n0\n0\n-1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nWaterBottle\n\n0\n0\n3\n3\n0\n0\n0\n0\n0\n-1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nrEternalNourishment\n\n99\n0\n2000\n2000\n600\n0\n0\n0\n4\n1 2 0 -1 0\n2 2 0 -1 0\n3 2 0 -1 0\n4 2 0 -1 0\n1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nbCarrying\n\n49\n0\n5500\n5500\n150\n0\n0\n0\n3\n2 2 0 -1 0\n3 2 0 -1 0\n11 2 0 -1 0\n1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nImplementorBaldric\n\n98\n0\n0\n0\n40\n0\n0\n0\n7\n2 2 0 -1 0\n3 2 0 -1 0\n11 2 0 -1 0\n1 2 0 -1 0\n4 2 0 -1 0\n99 0 5 -1 0\n99 0 5 -1 0\n1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nRareCrown\n\n83\n0\n1250\n1250\n350\n0\n0\n0\n5\n2 2 0 -1 0\n3 2 0 -1 0\n11 2 0 -1 0\n99 0 5 -1 0\n99 0 5 -1 0\n0\n-1\n-1\n-1\n-1\n\n-1\n\n-1\n0\n0\n0\n250\n1522015822\n\0',NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `characterstest`
--

DROP TABLE IF EXISTS `characterstest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `characterstest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) DEFAULT NULL,
  `characterNameID` int(11) NOT NULL,
  `data` text,
  `spells` text CHARACTER SET utf8,
  `quests` text CHARACTER SET utf8,
  `crimes` text CHARACTER SET utf8,
  `size` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nameIdx` (`characterNameID`),
  KEY `loginIdx` (`accountID`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characterstest`
--

LOCK TABLES `characterstest` WRITE;
/*!40000 ALTER TABLE `characterstest` DISABLE KEYS */;
/*!40000 ALTER TABLE `characterstest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classes` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complains`
--

DROP TABLE IF EXISTS `complains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('unknown','profanity','harassment') NOT NULL,
  `accountID` int(11) NOT NULL DEFAULT '1',
  `text` text,
  `reason` text,
  `creationDate` datetime NOT NULL,
  `resolvedDate` datetime NOT NULL,
  `resolveNote` text,
  `employeeID` int(11) DEFAULT '1',
  `server` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `loginIdx` (`accountID`),
  KEY `resolvedIdx` (`resolvedDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complains`
--

LOCK TABLES `complains` WRITE;
/*!40000 ALTER TABLE `complains` DISABLE KEYS */;
/*!40000 ALTER TABLE `complains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversionLog`
--

DROP TABLE IF EXISTS `conversionLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversionLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `yearLogin` varchar(16) NOT NULL,
  `yearPassword` varchar(16) NOT NULL,
  `trialLogin` varchar(16) NOT NULL,
  `trialPassword` varchar(16) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `key1` (`yearLogin`),
  KEY `key2` (`trialLogin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversionLog`
--

LOCK TABLES `conversionLog` WRITE;
/*!40000 ALTER TABLE `conversionLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `conversionLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countryCodes`
--

DROP TABLE IF EXISTS `countryCodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countryCodes` (
  `name` varchar(64) NOT NULL,
  `code` char(2) NOT NULL,
  UNIQUE KEY `key1` (`name`),
  UNIQUE KEY `key2` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countryCodes`
--

LOCK TABLES `countryCodes` WRITE;
/*!40000 ALTER TABLE `countryCodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `countryCodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crasher`
--

DROP TABLE IF EXISTS `crasher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crasher` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crasher`
--

LOCK TABLES `crasher` WRITE;
/*!40000 ALTER TABLE `crasher` DISABLE KEYS */;
/*!40000 ALTER TABLE `crasher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deferredCharges`
--

DROP TABLE IF EXISTS `deferredCharges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deferredCharges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) NOT NULL,
  `paymentMethodID` int(11) NOT NULL,
  `transaction` enum('charge','credit') DEFAULT NULL,
  `date` datetime NOT NULL,
  `amount` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accountIdx` (`accountID`),
  KEY `creationIdx` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deferredCharges`
--

LOCK TABLES `deferredCharges` WRITE;
/*!40000 ALTER TABLE `deferredCharges` DISABLE KEYS */;
/*!40000 ALTER TABLE `deferredCharges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `downtimeMsgs`
--

DROP TABLE IF EXISTS `downtimeMsgs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `downtimeMsgs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `active` enum('yes','no') NOT NULL DEFAULT 'no',
  `server` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `key1` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `downtimeMsgs`
--

LOCK TABLES `downtimeMsgs` WRITE;
/*!40000 ALTER TABLE `downtimeMsgs` DISABLE KEYS */;
/*!40000 ALTER TABLE `downtimeMsgs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emailAddresses`
--

DROP TABLE IF EXISTS `emailAddresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emailAddresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emailAddresses`
--

LOCK TABLES `emailAddresses` WRITE;
/*!40000 ALTER TABLE `emailAddresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `emailAddresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` char(16) NOT NULL,
  `password` char(16) DEFAULT '',
  `realName` char(32) DEFAULT '',
  `rights` enum('disabled','view','normal','supervisor','admin') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loginIdx` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engraveTable`
--

DROP TABLE IF EXISTS `engraveTable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engraveTable` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `loginNameID` int(11) NOT NULL DEFAULT '0',
  `characterNameID` int(11) NOT NULL DEFAULT '0',
  `engraved` linestring NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engraveTable`
--

LOCK TABLES `engraveTable` WRITE;
/*!40000 ALTER TABLE `engraveTable` DISABLE KEYS */;
/*!40000 ALTER TABLE `engraveTable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engraveTabletest`
--

DROP TABLE IF EXISTS `engraveTabletest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engraveTabletest` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `loginNameID` int(11) NOT NULL DEFAULT '0',
  `characterNameID` int(11) NOT NULL DEFAULT '0',
  `engraved` linestring NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engraveTabletest`
--

LOCK TABLES `engraveTabletest` WRITE;
/*!40000 ALTER TABLE `engraveTabletest` DISABLE KEYS */;
/*!40000 ALTER TABLE `engraveTabletest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `foes`
--

DROP TABLE IF EXISTS `foes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `foes` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `characterNameID` int(11) NOT NULL,
  `FoeNameID` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foes`
--

LOCK TABLES `foes` WRITE;
/*!40000 ALTER TABLE `foes` DISABLE KEYS */;
/*!40000 ALTER TABLE `foes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `foestest`
--

DROP TABLE IF EXISTS `foestest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `foestest` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `characterNameID` int(11) NOT NULL,
  `FoeNameID` int(11) NOT NULL,
  `FriendNameID` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foestest`
--

LOCK TABLES `foestest` WRITE;
/*!40000 ALTER TABLE `foestest` DISABLE KEYS */;
/*!40000 ALTER TABLE `foestest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friends`
--

DROP TABLE IF EXISTS `friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `characterNameID` int(11) NOT NULL,
  `FriendNameID` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friends`
--

LOCK TABLES `friends` WRITE;
/*!40000 ALTER TABLE `friends` DISABLE KEYS */;
/*!40000 ALTER TABLE `friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friendstest`
--

DROP TABLE IF EXISTS `friendstest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friendstest` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `characterNameID` int(11) NOT NULL,
  `FriendNameID` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friendstest`
--

LOCK TABLES `friendstest` WRITE;
/*!40000 ALTER TABLE `friendstest` DISABLE KEYS */;
/*!40000 ALTER TABLE `friendstest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `houses`
--

DROP TABLE IF EXISTS `houses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `houses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) DEFAULT NULL,
  `characterNameID` int(11) DEFAULT NULL,
  `data` mediumtext,
  `size` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=ascii ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `houses`
--

LOCK TABLES `houses` WRITE;
/*!40000 ALTER TABLE `houses` DISABLE KEYS */;
INSERT INTO `houses` VALUES (1,1,1,'1\n3\n3300\nGod\'s Livingroom\n23\n2001\n595\n35\n0\n2001\n457\n14\n0\n2001\n221\n21\n0\n2002\n527\n38\n0\n2013\n363\n14\n0\n2013\n318\n21\n0\n2013\n125\n19\n0\n2014\n346\n30\n0\n2014\n40\n46\n0\n2087\n617\n172\n0\n2593\n558\n147\n0\n2086\n104\n159\n0\n2592\n117\n133\n0\n2116\n294\n101\n0\n2599\n371\n267\n0\n2164\n295\n94\n0\n2165\n529\n102\n0\n2467\n215\n171\n40\n34989\n-81\n232\n0\n2111\n217\n142\n-35\n2111\n217\n152\n0\n34989\n48\n193\n0\n2131\n213\n165\n0\n7\nPlankDoor\n\n0\n2\n0\n0\n0\n461\n181\n1\n0\n-1\n-1\n0\n-1\n3\n\n-1\n\n-1\nPlankDoor\n\n0\n2\n0\n0\n0\n348\n181\n0\n0\n-1\n-1\n0\n-1\n2\n\n-1\n\n-1\nChair\n\n0\n0\n0\n0\n0\n325\n252\n0\n0\n-1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nChair\n\n0\n0\n0\n0\n0\n367\n249\n2\n0\n-1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nChair\n\n0\n0\n0\n0\n0\n409\n251\n1\n0\n-1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nChair\n\n0\n0\n0\n0\n0\n609\n209\n1\n0\n-1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nFirePlace\n\n0\n0\n0\n0\n0\n1\n210\n1\n0\n-1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\n3300\nGod\'s Bedroom\n20\n2001\n595\n83\n0\n2002\n521\n85\n0\n2013\n36\n55\n0\n2086\n3\n177\n0\n2592\n16\n151\n0\n2165\n614\n158\n0\n2467\n154\n215\n25\n2221\n423\n210\n0\n2002\n428\n71\n0\n2425\n266\n216\n30\n2421\n289\n216\n2\n2427\n217\n217\n35\n2025\n316\n52\n0\n2026\n199\n62\n0\n2166\n331\n140\n0\n2599\n113\n273\n0\n2025\n138\n52\n0\n2112\n135\n209\n0\n2088\n143\n163\n0\n2594\n122\n147\n0\n8\nChair\n\n0\n0\n0\n0\n0\n60\n254\n0\n0\n-1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nChair\n\n0\n0\n0\n0\n0\n114\n250\n2\n0\n-1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nChair\n\n0\n0\n0\n0\n0\n173\n260\n1\n0\n-1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nChair\n\n0\n0\n0\n0\n0\n360\n251\n0\n0\n-1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nChair\n\n0\n0\n0\n0\n0\n450\n268\n1\n0\n-1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nBed\n\n0\n0\n0\n0\n0\n295\n215\n2\n0\n-1\n-1\n-1\n-1\n-1\n\n-1\n\n-1\nPlankDoor\n\n0\n2\n0\n0\n0\n548\n242\n1\n0\n-1\n-1\n0\n-1\n1\n\n-1\n\n-1\nStrongBox\n\n0\n2\n0\n0\n0\n320\n250\n0\n0\n-1\n-1\n0\n-1\n-1\n1234\n-1\n\n0\n3201\nOutside God\'s House\n37\n2501\n435\n12\n0\n2501\n556\n30\n0\n2502\n486\n34\n0\n2513\n341\n32\n20\n2513\n208\n34\n0\n2514\n276\n83\n50\n2508\n59\n20\n0\n2621\n296\n40\n20\n2623\n270\n52\n30\n2627\n479\n47\n30\n2628\n508\n63\n40\n2999\n314\n136\n0\n2997\n454\n241\n-20\n2997\n394\n179\n-20\n2997\n406\n201\n-20\n2997\n463\n221\n-20\n35719\n41\n187\n0\n2952\n10\n173\n-20\n2955\n139\n185\n-20\n2953\n577\n216\n0\n2956\n367\n222\n-20\n2954\n594\n238\n0\n2957\n375\n259\n0\n2586\n226\n174\n20\n2592\n201\n136\n0\n2587\n102\n158\n0\n2593\n91\n139\n0\n2593\n432\n120\n0\n2587\n443\n159\n20\n2974\n274\n116\n0\n2520\n699\n12\n0\n2614\n604\n120\n100\n35382\n164\n124\n100\n2957\n363\n212\n-20\n2711\n401\n172\n0\n2717\n48\n204\n0\n2717\n439\n193\n0\n1\nPWDoor\n\n0\n2\n0\n0\n0\n328\n178\n0\n0\n-1\n-1\n0\n-1\n0\n1234\n-1\n\n-1\n1\n\0',0);
/*!40000 ALTER TABLE `houses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `housestest`
--

DROP TABLE IF EXISTS `housestest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `housestest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) DEFAULT NULL,
  `characterNameID` int(11) DEFAULT NULL,
  `data` mediumtext,
  `size` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `housestest`
--

LOCK TABLES `housestest` WRITE;
/*!40000 ALTER TABLE `housestest` DISABLE KEYS */;
/*!40000 ALTER TABLE `housestest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loginNames`
--

DROP TABLE IF EXISTS `loginNames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loginNames` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key1` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loginNames`
--

LOCK TABLES `loginNames` WRITE;
/*!40000 ALTER TABLE `loginNames` DISABLE KEYS */;
INSERT INTO `loginNames` VALUES (1,'god');
/*!40000 ALTER TABLE `loginNames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messageData`
--

DROP TABLE IF EXISTS `messageData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messageData` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bExists` int(11) DEFAULT '1',
  `accountID` int(11) DEFAULT NULL,
  `characterID` int(11) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  `body` varchar(255) DEFAULT NULL,
  `referralID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messageData`
--

LOCK TABLES `messageData` WRITE;
/*!40000 ALTER TABLE `messageData` DISABLE KEYS */;
/*!40000 ALTER TABLE `messageData` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messageDatatest`
--

DROP TABLE IF EXISTS `messageDatatest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messageDatatest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bExists` int(11) DEFAULT '1',
  `accountID` int(11) DEFAULT NULL,
  `characterID` int(11) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  `body` varchar(255) DEFAULT NULL,
  `referralID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messageDatatest`
--

LOCK TABLES `messageDatatest` WRITE;
/*!40000 ALTER TABLE `messageDatatest` DISABLE KEYS */;
/*!40000 ALTER TABLE `messageDatatest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messageLink`
--

DROP TABLE IF EXISTS `messageLink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messageLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bExists` int(11) DEFAULT '1',
  `accountID` int(11) DEFAULT NULL,
  `characterID` int(11) DEFAULT NULL,
  `bDeleted` int(11) DEFAULT '0',
  `viewerID` int(11) DEFAULT NULL,
  `msgID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messageLink`
--

LOCK TABLES `messageLink` WRITE;
/*!40000 ALTER TABLE `messageLink` DISABLE KEYS */;
/*!40000 ALTER TABLE `messageLink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messageLinktest`
--

DROP TABLE IF EXISTS `messageLinktest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messageLinktest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bExists` int(11) DEFAULT '1',
  `accountID` int(11) DEFAULT NULL,
  `characterID` int(11) DEFAULT NULL,
  `bDeleted` int(11) DEFAULT '0',
  `viewerID` int(11) DEFAULT NULL,
  `msgID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messageLinktest`
--

LOCK TABLES `messageLinktest` WRITE;
/*!40000 ALTER TABLE `messageLinktest` DISABLE KEYS */;
/*!40000 ALTER TABLE `messageLinktest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `serverID` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) DEFAULT 'Welcome to the Realm.',
  `type` enum('downtime','login') DEFAULT NULL,
  PRIMARY KEY (`serverID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) NOT NULL,
  `employeeID` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accountIdx` (`accountID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `osVersion`
--

DROP TABLE IF EXISTS `osVersion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `osVersion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) NOT NULL,
  `major` int(11) NOT NULL,
  `minor` int(11) NOT NULL,
  `build` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accountIdx` (`accountID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `osVersion`
--

LOCK TABLES `osVersion` WRITE;
/*!40000 ALTER TABLE `osVersion` DISABLE KEYS */;
INSERT INTO `osVersion` VALUES (1,1,6,1,7601,2);
/*!40000 ALTER TABLE `osVersion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymentMethods`
--

DROP TABLE IF EXISTS `paymentMethods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentMethods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) NOT NULL,
  `type` enum('check','credit-card') DEFAULT NULL,
  `date` datetime NOT NULL,
  `accountNumber` varchar(64) NOT NULL,
  `expMonth` tinyint(4) NOT NULL,
  `expYear` smallint(6) NOT NULL,
  `name` varchar(128) NOT NULL,
  `address` varchar(128) NOT NULL,
  `city` varchar(64) NOT NULL,
  `state` varchar(64) NOT NULL,
  `country` char(2) NOT NULL,
  `zipCode` varchar(64) NOT NULL,
  `emailID` int(11) NOT NULL,
  `productOrderID` int(11) NOT NULL,
  `cancelled` enum('yes','no') NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`),
  KEY `key1` (`accountID`),
  KEY `key2` (`date`),
  KEY `key3` (`accountNumber`),
  KEY `key4` (`name`),
  KEY `key5` (`address`),
  KEY `key6` (`city`),
  KEY `key7` (`state`),
  KEY `key8` (`country`),
  KEY `key9` (`zipCode`),
  KEY `key10` (`emailID`),
  KEY `key11` (`productOrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymentMethods`
--

LOCK TABLES `paymentMethods` WRITE;
/*!40000 ALTER TABLE `paymentMethods` DISABLE KEYS */;
/*!40000 ALTER TABLE `paymentMethods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pendingCharges`
--

DROP TABLE IF EXISTS `pendingCharges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pendingCharges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) NOT NULL,
  `employeeID` int(11) NOT NULL,
  `transaction` enum('charge','credit') DEFAULT NULL,
  `date` datetime NOT NULL,
  `amount` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accountIdx` (`accountID`),
  KEY `creationIdx` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pendingCharges`
--

LOCK TABLES `pendingCharges` WRITE;
/*!40000 ALTER TABLE `pendingCharges` DISABLE KEYS */;
/*!40000 ALTER TABLE `pendingCharges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productOrders`
--

DROP TABLE IF EXISTS `productOrders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productOrders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(20) NOT NULL,
  `accountOwnerID` int(11) NOT NULL,
  `accountID` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `state` enum('incomplete','processing','complete') NOT NULL DEFAULT 'incomplete',
  `trialAllowed` enum('yes','no') NOT NULL DEFAULT 'yes',
  `type` enum('check','credit-card','special-offer') NOT NULL DEFAULT 'credit-card',
  `satisfied` enum('yes','no') NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key1` (`number`),
  KEY `key2` (`date`),
  KEY `key3` (`accountOwnerID`),
  KEY `key4` (`accountID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productOrders`
--

LOCK TABLES `productOrders` WRITE;
/*!40000 ALTER TABLE `productOrders` DISABLE KEYS */;
/*!40000 ALTER TABLE `productOrders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotions` (
  `id` int(11) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions`
--

LOCK TABLES `promotions` WRITE;
/*!40000 ALTER TABLE `promotions` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservedCharacterNames`
--

DROP TABLE IF EXISTS `reservedCharacterNames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservedCharacterNames` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginNameID` int(11) NOT NULL,
  `characterNameID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `key1` (`loginNameID`),
  KEY `key2` (`characterNameID`),
  KEY `key3` (`loginNameID`,`characterNameID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservedCharacterNames`
--

LOCK TABLES `reservedCharacterNames` WRITE;
/*!40000 ALTER TABLE `reservedCharacterNames` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservedCharacterNames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservedName`
--

DROP TABLE IF EXISTS `reservedName`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservedName` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservedName`
--

LOCK TABLES `reservedName` WRITE;
/*!40000 ALTER TABLE `reservedName` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservedName` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retrieverRecords`
--

DROP TABLE IF EXISTS `retrieverRecords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retrieverRecords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authCode` varchar(32) NOT NULL,
  `account` varchar(32) NOT NULL,
  `timeStamp` datetime NOT NULL,
  `transaction` enum('charge','credit') NOT NULL,
  `amount` float NOT NULL,
  `refNumber` varchar(32) NOT NULL,
  `batch` varchar(32) DEFAULT NULL,
  `expiration` int(11) NOT NULL,
  `accountID` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key7` (`refNumber`,`timeStamp`),
  KEY `key1` (`authCode`),
  KEY `key2` (`amount`),
  KEY `key3` (`account`),
  KEY `key4` (`timeStamp`),
  KEY `key5` (`transaction`),
  KEY `key6` (`accountID`),
  KEY `key8` (`refNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retrieverRecords`
--

LOCK TABLES `retrieverRecords` WRITE;
/*!40000 ALTER TABLE `retrieverRecords` DISABLE KEYS */;
/*!40000 ALTER TABLE `retrieverRecords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serialNumbers`
--

DROP TABLE IF EXISTS `serialNumbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serialNumbers` (
  `number` int(11) NOT NULL DEFAULT '1',
  `accountID` int(11) NOT NULL,
  UNIQUE KEY `key1` (`accountID`,`number`),
  KEY `key2` (`number`),
  KEY `key3` (`accountID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serialNumbers`
--

LOCK TABLES `serialNumbers` WRITE;
/*!40000 ALTER TABLE `serialNumbers` DISABLE KEYS */;
/*!40000 ALTER TABLE `serialNumbers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serverList`
--

DROP TABLE IF EXISTS `serverList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serverList` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `ip` varchar(32) NOT NULL,
  `port` mediumint(9) NOT NULL,
  `characterTable` varchar(128) NOT NULL,
  `houseTable` varchar(128) NOT NULL,
  `active` enum('yes','no') NOT NULL DEFAULT 'no',
  `isUp` enum('up','down') NOT NULL DEFAULT 'down',
  `userCount` int(11) NOT NULL,
  `engraveTable` varchar(128) NOT NULL,
  `mailData` varchar(128) NOT NULL,
  `mailLink` varchar(128) NOT NULL,
  `friendTable` varchar(128) NOT NULL,
  `foeTable` varchar(128) NOT NULL,
  `crasher` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serverList`
--

LOCK TABLES `serverList` WRITE;
/*!40000 ALTER TABLE `serverList` DISABLE KEYS */;
INSERT INTO `serverList` VALUES (0,'Your Home Server','192.168.1.55',6008,'characters','houses','yes','up',0,'engraveTable','messageData','messageLink','friends','foes','2980'),(1,'Your Home Serve Test','192.168.1.55',6009,'characterstest','housestest','yes','down',0,'engraveTabletest','messageDatatest','messageLinktest','friendstest','foestest','1');
/*!40000 ALTER TABLE `serverList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specialOffers`
--

DROP TABLE IF EXISTS `specialOffers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `specialOffers` (
  `id` int(11) NOT NULL,
  `number` varchar(10) NOT NULL,
  `accountID` int(11) NOT NULL DEFAULT '1',
  `promotionID` int(11) NOT NULL DEFAULT '0',
  `expirationDate` date NOT NULL,
  `daysFree` int(11) NOT NULL DEFAULT '30',
  `accountDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numIdx` (`number`),
  KEY `acctIdx` (`accountID`),
  KEY `promoIdx` (`promotionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialOffers`
--

LOCK TABLES `specialOffers` WRITE;
/*!40000 ALTER TABLE `specialOffers` DISABLE KEYS */;
/*!40000 ALTER TABLE `specialOffers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testaccessLog`
--

DROP TABLE IF EXISTS `testaccessLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testaccessLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) NOT NULL,
  `serverID` tinyint(4) NOT NULL,
  `type` enum('login','logout') NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `key1` (`accountID`),
  KEY `key2` (`date`),
  KEY `key3` (`accountID`,`serverID`,`type`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testaccessLog`
--

LOCK TABLES `testaccessLog` WRITE;
/*!40000 ALTER TABLE `testaccessLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `testaccessLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testcharacters`
--

DROP TABLE IF EXISTS `testcharacters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testcharacters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) NOT NULL DEFAULT '1',
  `characterNameID` int(11) NOT NULL,
  `data` blob NOT NULL,
  `spells` blob,
  `quests` blob,
  `crimes` blob,
  `spells_copy` longtext CHARACTER SET utf8 NOT NULL,
  `quests_copy` longtext CHARACTER SET utf8 NOT NULL,
  `crimes_copy` longtext CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nameIdx` (`characterNameID`),
  KEY `loginIdx` (`accountID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testcharacters`
--

LOCK TABLES `testcharacters` WRITE;
/*!40000 ALTER TABLE `testcharacters` DISABLE KEYS */;
/*!40000 ALTER TABLE `testcharacters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testcrimes`
--

DROP TABLE IF EXISTS `testcrimes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testcrimes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `characterNameID` int(11) NOT NULL DEFAULT '0',
  `crimes` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testcrimes`
--

LOCK TABLES `testcrimes` WRITE;
/*!40000 ALTER TABLE `testcrimes` DISABLE KEYS */;
/*!40000 ALTER TABLE `testcrimes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testengraveTable`
--

DROP TABLE IF EXISTS `testengraveTable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testengraveTable` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `loginNameID` int(11) NOT NULL DEFAULT '0',
  `characterNameID` int(11) NOT NULL DEFAULT '0',
  `engraved` linestring NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testengraveTable`
--

LOCK TABLES `testengraveTable` WRITE;
/*!40000 ALTER TABLE `testengraveTable` DISABLE KEYS */;
/*!40000 ALTER TABLE `testengraveTable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testfoes`
--

DROP TABLE IF EXISTS `testfoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testfoes` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `characterNameID` int(11) NOT NULL,
  `FoeNameID` int(11) NOT NULL,
  `FriendNameID` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testfoes`
--

LOCK TABLES `testfoes` WRITE;
/*!40000 ALTER TABLE `testfoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `testfoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testfriends`
--

DROP TABLE IF EXISTS `testfriends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testfriends` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `characterNameID` int(11) NOT NULL,
  `FriendNameID` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testfriends`
--

LOCK TABLES `testfriends` WRITE;
/*!40000 ALTER TABLE `testfriends` DISABLE KEYS */;
/*!40000 ALTER TABLE `testfriends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testhouses`
--

DROP TABLE IF EXISTS `testhouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testhouses` (
  `primerID` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) DEFAULT NULL,
  `characterNameID` int(11) DEFAULT NULL,
  `data` blob,
  PRIMARY KEY (`id`),
  KEY `accountIdx` (`accountID`),
  KEY `characterIdx` (`characterNameID`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testhouses`
--

LOCK TABLES `testhouses` WRITE;
/*!40000 ALTER TABLE `testhouses` DISABLE KEYS */;
/*!40000 ALTER TABLE `testhouses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testmessageData`
--

DROP TABLE IF EXISTS `testmessageData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testmessageData` (
  `primer` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL DEFAULT '0',
  `bExists` tinyint(1) DEFAULT NULL,
  `subject` text,
  `characterID` int(11) DEFAULT NULL,
  `accountID` int(11) DEFAULT NULL,
  `body` blob,
  `referralID` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `accountID` (`accountID`),
  KEY `characterID` (`characterID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testmessageData`
--

LOCK TABLES `testmessageData` WRITE;
/*!40000 ALTER TABLE `testmessageData` DISABLE KEYS */;
/*!40000 ALTER TABLE `testmessageData` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testmessageLink`
--

DROP TABLE IF EXISTS `testmessageLink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testmessageLink` (
  `primer` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL,
  `toCharacterID` int(11) DEFAULT NULL,
  `fromCharacterID` int(11) DEFAULT NULL,
  `msgID` int(11) DEFAULT NULL,
  `characterID` int(11) DEFAULT NULL,
  `viewerID` int(11) DEFAULT NULL,
  `bExists` tinyint(1) DEFAULT NULL,
  `bDeleted` tinyint(1) DEFAULT NULL,
  `accountID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `accountID` (`accountID`),
  KEY `characterID` (`characterID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testmessageLink`
--

LOCK TABLES `testmessageLink` WRITE;
/*!40000 ALTER TABLE `testmessageLink` DISABLE KEYS */;
/*!40000 ALTER TABLE `testmessageLink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testquests`
--

DROP TABLE IF EXISTS `testquests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testquests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `characterNameID` int(11) NOT NULL DEFAULT '0',
  `quests` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testquests`
--

LOCK TABLES `testquests` WRITE;
/*!40000 ALTER TABLE `testquests` DISABLE KEYS */;
/*!40000 ALTER TABLE `testquests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testspells`
--

DROP TABLE IF EXISTS `testspells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testspells` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `characterNameID` int(11) NOT NULL DEFAULT '0',
  `spells` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testspells`
--

LOCK TABLES `testspells` WRITE;
/*!40000 ALTER TABLE `testspells` DISABLE KEYS */;
/*!40000 ALTER TABLE `testspells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tmRealRecords`
--

DROP TABLE IF EXISTS `tmRealRecords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tmRealRecords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction` enum('charge','credit','preauth') NOT NULL,
  `amount` float NOT NULL,
  `account` varchar(32) NOT NULL,
  `expiration` int(11) NOT NULL,
  `address` varchar(128) DEFAULT NULL,
  `zipCode` varchar(32) DEFAULT NULL,
  `sequenceNumber` varchar(32) NOT NULL,
  `comment` varchar(32) NOT NULL,
  `authorizationCode` varchar(64) NOT NULL,
  `timeStamp` datetime NOT NULL,
  `accountID` int(11) NOT NULL,
  `poNumber` varchar(32) DEFAULT NULL,
  `errorCode` varchar(32) DEFAULT NULL,
  UNIQUE KEY `key7` (`transaction`,`timeStamp`,`amount`,`account`,`expiration`,`sequenceNumber`),
  KEY `key6` (`id`),
  KEY `key1` (`transaction`),
  KEY `key2` (`amount`),
  KEY `key3` (`account`),
  KEY `key4` (`accountID`),
  KEY `key5` (`timeStamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tmRealRecords`
--

LOCK TABLES `tmRealRecords` WRITE;
/*!40000 ALTER TABLE `tmRealRecords` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmRealRecords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trialReferrals`
--

DROP TABLE IF EXISTS `trialReferrals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trialReferrals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` int(11) NOT NULL,
  `timeStamp` datetime NOT NULL,
  `source` enum('unspecified','friend','magazine ad','banner ad','news story','internet search','magazine cd','other','codemasters pc product','codemasters','cmr2','insane','snooker','direct email','pcgamer','pcformat','pczone','pcgw','pcgameplay','gamesgazette','gamespotus','gamespotuk','vogue','handbag','musicgenerator','gamesdomain','dailyradar','pennyclickban','gamespotukban','gamespotusban','handbagban','vogueban','free','trial','offer','demodisk','pczone2','pcgear','netmag','advisor','thetimes','guardian','indynetwork','metro','ft','promo','promotion','ukcompetition','freebie') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key1` (`accountID`),
  KEY `key2` (`timeStamp`),
  KEY `key3` (`source`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trialReferrals`
--

LOCK TABLES `trialReferrals` WRITE;
/*!40000 ALTER TABLE `trialReferrals` DISABLE KEYS */;
/*!40000 ALTER TABLE `trialReferrals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `whatsnew`
--

DROP TABLE IF EXISTS `whatsnew`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whatsnew` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `posted` date DEFAULT NULL,
  `message` varchar(4096) DEFAULT NULL,
  `serverID` varchar(255) DEFAULT NULL,
  `DESC` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `DESC` (`DESC`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=ascii;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `whatsnew`
--

LOCK TABLES `whatsnew` WRITE;
/*!40000 ALTER TABLE `whatsnew` DISABLE KEYS */;
INSERT INTO `whatsnew` VALUES (1,'2017-04-23','Update as you go.','0','0');
/*!40000 ALTER TABLE `whatsnew` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-26  3:55:18
