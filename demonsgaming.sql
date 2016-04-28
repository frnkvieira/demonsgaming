CREATE DATABASE  IF NOT EXISTS `ot` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `ot`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: 192.168.0.25    Database: ot
-- ------------------------------------------------------
-- Server version	5.7.12-0ubuntu1

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
-- Table structure for table `account_ban_history`
--

DROP TABLE IF EXISTS `account_ban_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_ban_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expired_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `banned_by` (`banned_by`),
  CONSTRAINT `account_ban_history_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `account_ban_history_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_ban_history`
--

LOCK TABLES `account_ban_history` WRITE;
/*!40000 ALTER TABLE `account_ban_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_ban_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_bans`
--

DROP TABLE IF EXISTS `account_bans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_bans` (
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL,
  PRIMARY KEY (`account_id`),
  KEY `banned_by` (`banned_by`),
  CONSTRAINT `account_bans_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `account_bans_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_bans`
--

LOCK TABLES `account_bans` WRITE;
/*!40000 ALTER TABLE `account_bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_bans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_viplist`
--

DROP TABLE IF EXISTS `account_viplist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_viplist` (
  `account_id` int(11) NOT NULL COMMENT 'id of account whose viplist entry it is',
  `player_id` int(11) NOT NULL COMMENT 'id of target player of viplist entry',
  `description` varchar(128) NOT NULL DEFAULT '',
  `icon` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `notify` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `account_player_index` (`account_id`,`player_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `account_viplist_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `account_viplist_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_viplist`
--

LOCK TABLES `account_viplist` WRITE;
/*!40000 ALTER TABLE `account_viplist` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_viplist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `password` char(40) NOT NULL,
  `secret` char(16) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '1',
  `premdays` int(11) NOT NULL DEFAULT '0',
  `lastday` int(10) unsigned NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL DEFAULT '',
  `creation` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'frnkvieira','99efc50a9206bde3d7a8e694aad8e138ca7dc3f7',NULL,5,0,0,'frank@frankvieira.com.br',1461806880);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guild_invites`
--

DROP TABLE IF EXISTS `guild_invites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_invites` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `guild_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`guild_id`),
  KEY `guild_id` (`guild_id`),
  CONSTRAINT `guild_invites_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  CONSTRAINT `guild_invites_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guild_invites`
--

LOCK TABLES `guild_invites` WRITE;
/*!40000 ALTER TABLE `guild_invites` DISABLE KEYS */;
/*!40000 ALTER TABLE `guild_invites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guild_membership`
--

DROP TABLE IF EXISTS `guild_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_membership` (
  `player_id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `nick` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`player_id`),
  KEY `guild_id` (`guild_id`),
  KEY `rank_id` (`rank_id`),
  CONSTRAINT `guild_membership_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `guild_membership_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `guild_membership_ibfk_3` FOREIGN KEY (`rank_id`) REFERENCES `guild_ranks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guild_membership`
--

LOCK TABLES `guild_membership` WRITE;
/*!40000 ALTER TABLE `guild_membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `guild_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guild_ranks`
--

DROP TABLE IF EXISTS `guild_ranks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_ranks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` int(11) NOT NULL COMMENT 'guild',
  `name` varchar(255) NOT NULL COMMENT 'rank name',
  `level` int(11) NOT NULL COMMENT 'rank level - leader, vice, member, maybe something else',
  PRIMARY KEY (`id`),
  KEY `guild_id` (`guild_id`),
  CONSTRAINT `guild_ranks_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guild_ranks`
--

LOCK TABLES `guild_ranks` WRITE;
/*!40000 ALTER TABLE `guild_ranks` DISABLE KEYS */;
/*!40000 ALTER TABLE `guild_ranks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guild_wars`
--

DROP TABLE IF EXISTS `guild_wars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_wars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild1` int(11) NOT NULL DEFAULT '0',
  `guild2` int(11) NOT NULL DEFAULT '0',
  `name1` varchar(255) NOT NULL,
  `name2` varchar(255) NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `started` bigint(15) NOT NULL DEFAULT '0',
  `ended` bigint(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `guild1` (`guild1`),
  KEY `guild2` (`guild2`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guild_wars`
--

LOCK TABLES `guild_wars` WRITE;
/*!40000 ALTER TABLE `guild_wars` DISABLE KEYS */;
/*!40000 ALTER TABLE `guild_wars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guilds`
--

DROP TABLE IF EXISTS `guilds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guilds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `creationdata` int(11) NOT NULL,
  `motd` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `ownerid` (`ownerid`),
  CONSTRAINT `guilds_ibfk_1` FOREIGN KEY (`ownerid`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guilds`
--

LOCK TABLES `guilds` WRITE;
/*!40000 ALTER TABLE `guilds` DISABLE KEYS */;
/*!40000 ALTER TABLE `guilds` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ot`@`%`*/ /*!50003 TRIGGER `oncreate_guilds` AFTER INSERT ON `guilds`
 FOR EACH ROW BEGIN
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('the Leader', 3, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Vice-Leader', 2, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Member', 1, NEW.`id`);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `guildwar_kills`
--

DROP TABLE IF EXISTS `guildwar_kills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guildwar_kills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `killer` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  `killerguild` int(11) NOT NULL DEFAULT '0',
  `targetguild` int(11) NOT NULL DEFAULT '0',
  `warid` int(11) NOT NULL DEFAULT '0',
  `time` bigint(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `warid` (`warid`),
  CONSTRAINT `guildwar_kills_ibfk_1` FOREIGN KEY (`warid`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guildwar_kills`
--

LOCK TABLES `guildwar_kills` WRITE;
/*!40000 ALTER TABLE `guildwar_kills` DISABLE KEYS */;
/*!40000 ALTER TABLE `guildwar_kills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `house_lists`
--

DROP TABLE IF EXISTS `house_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `house_lists` (
  `house_id` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `list` text NOT NULL,
  KEY `house_id` (`house_id`),
  CONSTRAINT `house_lists_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `house_lists`
--

LOCK TABLES `house_lists` WRITE;
/*!40000 ALTER TABLE `house_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `house_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `houses`
--

DROP TABLE IF EXISTS `houses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `houses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` int(11) NOT NULL,
  `paid` int(10) unsigned NOT NULL DEFAULT '0',
  `warnings` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `rent` int(11) NOT NULL DEFAULT '0',
  `town_id` int(11) NOT NULL DEFAULT '0',
  `bid` int(11) NOT NULL DEFAULT '0',
  `bid_end` int(11) NOT NULL DEFAULT '0',
  `last_bid` int(11) NOT NULL DEFAULT '0',
  `highest_bidder` int(11) NOT NULL DEFAULT '0',
  `size` int(11) NOT NULL DEFAULT '0',
  `beds` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  KEY `town_id` (`town_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `houses`
--

LOCK TABLES `houses` WRITE;
/*!40000 ALTER TABLE `houses` DISABLE KEYS */;
/*!40000 ALTER TABLE `houses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip_bans`
--

DROP TABLE IF EXISTS `ip_bans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_bans` (
  `ip` int(10) unsigned NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL,
  PRIMARY KEY (`ip`),
  KEY `banned_by` (`banned_by`),
  CONSTRAINT `ip_bans_ibfk_1` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip_bans`
--

LOCK TABLES `ip_bans` WRITE;
/*!40000 ALTER TABLE `ip_bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_bans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_history`
--

DROP TABLE IF EXISTS `market_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT '0',
  `itemtype` int(10) unsigned NOT NULL,
  `amount` smallint(5) unsigned NOT NULL,
  `price` int(10) unsigned NOT NULL DEFAULT '0',
  `expires_at` bigint(20) unsigned NOT NULL,
  `inserted` bigint(20) unsigned NOT NULL,
  `state` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`,`sale`),
  CONSTRAINT `market_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_history`
--

LOCK TABLES `market_history` WRITE;
/*!40000 ALTER TABLE `market_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_offers`
--

DROP TABLE IF EXISTS `market_offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_offers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT '0',
  `itemtype` int(10) unsigned NOT NULL,
  `amount` smallint(5) unsigned NOT NULL,
  `created` bigint(20) unsigned NOT NULL,
  `anonymous` tinyint(1) NOT NULL DEFAULT '0',
  `price` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sale` (`sale`,`itemtype`),
  KEY `created` (`created`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `market_offers_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_offers`
--

LOCK TABLES `market_offers` WRITE;
/*!40000 ALTER TABLE `market_offers` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_deaths`
--

DROP TABLE IF EXISTS `player_deaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_deaths` (
  `player_id` int(11) NOT NULL,
  `time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `killed_by` varchar(255) NOT NULL,
  `is_player` tinyint(1) NOT NULL DEFAULT '1',
  `mostdamage_by` varchar(100) NOT NULL,
  `mostdamage_is_player` tinyint(1) NOT NULL DEFAULT '0',
  `unjustified` tinyint(1) NOT NULL DEFAULT '0',
  `mostdamage_unjustified` tinyint(1) NOT NULL DEFAULT '0',
  KEY `player_id` (`player_id`),
  KEY `killed_by` (`killed_by`),
  KEY `mostdamage_by` (`mostdamage_by`),
  CONSTRAINT `player_deaths_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_deaths`
--

LOCK TABLES `player_deaths` WRITE;
/*!40000 ALTER TABLE `player_deaths` DISABLE KEYS */;
INSERT INTO `player_deaths` VALUES (5,1461815550,150,'Sorcerer',1,'Sorcerer',1,0,0),(4,1461815612,150,'Druid',1,'Druid',1,1,1),(4,1461815685,150,'Druid',1,'Druid',1,1,1),(4,1461815698,150,'Druid',1,'Sorcerer',1,1,1),(4,1461815874,150,'Druid',1,'Sorcerer',1,0,0),(4,1461815910,150,'Druid',1,'Druid',1,1,1),(5,1461816027,150,'Sorcerer',1,'Druid',1,1,1),(5,1461816120,150,'Druid',1,'Druid',1,1,1),(5,1461816192,150,'Sorcerer',1,'Druid',1,1,1),(3,1461816209,150,'Knight',1,'Knight',1,0,0),(3,1461816239,150,'Druid',1,'Sorcerer',1,1,1),(3,1461816248,150,'Druid',1,'Sorcerer',1,0,0),(3,1461816271,150,'Sorcerer',1,'Sorcerer',1,1,0),(5,1461816280,150,'Sorcerer',1,'Sorcerer',1,0,0),(2,1461816466,150,'Sorcerer',1,'Sorcerer',1,0,0),(2,1461816473,150,'Druid',1,'Druid',1,1,0),(2,1461816496,150,'Druid',1,'Druid',1,0,0),(2,1461816513,150,'Gaz\'haragoth',0,'Gaz\'haragoth',0,0,0),(3,1461816517,150,'Gaz\'haragoth',0,'Gaz\'haragoth',0,0,0),(2,1461816520,150,'Gaz\'haragoth',0,'Gaz\'haragoth',0,0,0);
/*!40000 ALTER TABLE `player_deaths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_depotitems`
--

DROP TABLE IF EXISTS `player_depotitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_depotitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'any given range eg 0-100 will be reserved for depot lockers and all > 100 will be then normal items inside depots',
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(6) NOT NULL,
  `count` smallint(5) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  CONSTRAINT `player_depotitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_depotitems`
--

LOCK TABLES `player_depotitems` WRITE;
/*!40000 ALTER TABLE `player_depotitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_depotitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_inboxitems`
--

DROP TABLE IF EXISTS `player_inboxitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_inboxitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(6) NOT NULL,
  `count` smallint(5) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  CONSTRAINT `player_inboxitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_inboxitems`
--

LOCK TABLES `player_inboxitems` WRITE;
/*!40000 ALTER TABLE `player_inboxitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_inboxitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_items`
--

DROP TABLE IF EXISTS `player_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_items` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `pid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(6) NOT NULL DEFAULT '0',
  `count` smallint(5) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  KEY `player_id` (`player_id`),
  KEY `sid` (`sid`),
  CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_items`
--

LOCK TABLES `player_items` WRITE;
/*!40000 ALTER TABLE `player_items` DISABLE KEYS */;
INSERT INTO `player_items` VALUES (3,1,101,9778,1,''),(3,2,102,8266,1,''),(3,3,103,10518,1,''),(3,4,104,21725,1,''),(3,5,105,16112,1,''),(3,6,106,18412,1,''),(3,7,107,18400,1,''),(3,8,108,2195,1,''),(3,103,109,6132,1,''),(3,103,110,6391,1,''),(3,103,111,10511,1,''),(3,103,112,10513,1,''),(3,103,113,10515,1,''),(3,103,114,20620,1,''),(3,114,115,2197,5,'\0'),(3,114,116,2003,1,''),(3,114,117,2167,1,'	\0'),(3,114,118,2002,1,''),(3,114,119,2100,1,''),(3,114,120,1998,1,''),(3,114,121,6300,1,'O\0'),(3,114,122,5926,1,''),(3,114,123,2291,1,''),(3,114,124,2002,1,''),(3,116,125,2197,5,'\0'),(3,116,126,2197,5,'\0'),(3,116,127,2197,5,'\0'),(3,116,128,2197,5,'\0'),(3,116,129,2197,5,'\0'),(3,116,130,2197,5,'\0'),(3,116,131,2197,5,'\0'),(3,116,132,2197,5,'\0'),(3,116,133,2197,5,'\0'),(3,116,134,2197,5,'\0'),(3,116,135,2197,5,'\0'),(3,116,136,2197,5,'\0'),(3,116,137,2197,5,'\0'),(3,116,138,2197,5,'\0'),(3,116,139,2197,5,'\0'),(3,116,140,2197,5,'\0'),(3,116,141,2197,5,'\0'),(3,116,142,2197,5,'\0'),(3,116,143,2197,5,'\0'),(3,116,144,2197,5,'\0'),(3,118,145,2167,1,''),(3,118,146,2167,1,''),(3,118,147,2167,1,''),(3,118,148,2167,1,''),(3,118,149,2167,1,''),(3,118,150,2167,1,''),(3,118,151,2167,1,''),(3,118,152,2167,1,''),(3,118,153,2167,1,''),(3,118,154,2167,1,''),(3,118,155,2167,1,''),(3,118,156,2167,1,''),(3,118,157,2167,1,''),(3,118,158,2167,1,''),(3,118,159,2167,1,''),(3,118,160,2167,1,''),(3,118,161,2167,1,''),(3,118,162,2167,1,''),(3,118,163,2167,1,''),(3,118,164,2167,1,''),(3,120,165,2100,1,''),(3,120,166,2100,1,''),(3,120,167,2100,1,''),(3,120,168,2100,1,''),(3,120,169,2100,1,''),(3,120,170,2100,1,''),(3,120,171,2100,1,''),(3,120,172,2100,1,''),(3,120,173,2100,1,''),(3,120,174,2100,1,''),(3,120,175,2100,1,''),(3,120,176,2100,1,''),(3,120,177,2100,1,''),(3,120,178,2100,1,''),(3,120,179,2100,1,''),(3,120,180,2100,1,''),(3,120,181,2100,1,''),(3,120,182,2100,1,''),(3,120,183,2100,1,''),(3,120,184,2100,1,''),(3,122,185,2164,20,'\0'),(3,122,186,2164,20,'\0'),(3,122,187,2164,20,'\0'),(3,122,188,2164,20,'\0'),(3,122,189,2164,20,'\0'),(3,122,190,2164,20,'\0'),(3,122,191,2164,20,'\0'),(3,122,192,2164,20,'\0'),(3,122,193,2164,20,'\0'),(3,122,194,2164,20,'\0'),(3,122,195,2169,1,'ð	\0'),(3,122,196,2169,1,''),(3,122,197,2169,1,''),(3,122,198,2169,1,''),(3,122,199,2169,1,''),(3,122,200,2169,1,''),(3,122,201,2169,1,''),(3,122,202,2169,1,''),(3,122,203,2169,1,''),(3,122,204,2169,1,''),(3,124,205,7590,100,'d'),(3,124,206,7590,100,'d'),(3,124,207,7590,100,'d'),(3,124,208,7590,100,'d'),(3,124,209,2262,100,'d'),(3,124,210,2286,100,'d'),(3,124,211,2305,100,'d'),(3,124,212,2269,100,'d'),(3,124,213,2269,100,'d'),(3,124,214,2278,100,'d'),(3,124,215,2278,100,'d'),(3,124,216,2293,100,'d'),(3,124,217,2293,100,'d'),(3,124,218,2268,100,'d'),(3,124,219,2268,100,'d'),(3,124,220,2268,100,'d'),(3,124,221,2268,100,'d'),(5,1,101,18403,1,''),(5,2,102,8266,1,''),(5,3,103,10521,1,''),(5,4,104,8889,1,''),(5,5,105,12644,1,''),(5,6,106,18465,1,''),(5,7,107,2504,1,''),(5,8,108,2195,1,''),(5,103,109,6132,1,''),(5,103,110,10511,1,''),(5,103,111,10513,1,''),(5,103,112,10515,1,''),(5,103,113,18410,1,''),(5,103,114,20620,1,''),(5,114,115,2100,1,''),(5,114,116,1998,1,''),(5,114,117,2207,1,''),(5,114,118,18394,1,''),(5,114,119,2291,1,''),(5,114,120,2000,1,''),(5,114,121,2273,1,''),(5,114,122,2002,1,''),(5,114,123,2169,1,'\Ø#	\0'),(5,114,124,5926,1,''),(5,114,125,2164,20,'\0'),(5,114,126,10519,1,''),(5,114,127,2197,1,'\0'),(5,114,128,2003,1,''),(5,116,129,2100,1,''),(5,116,130,2100,1,''),(5,116,131,2100,1,''),(5,116,132,2100,1,''),(5,116,133,2100,1,''),(5,116,134,2100,1,''),(5,116,135,2100,1,''),(5,116,136,2100,1,''),(5,116,137,2100,1,''),(5,116,138,2100,1,''),(5,116,139,2100,1,''),(5,116,140,2100,1,''),(5,116,141,2100,1,''),(5,116,142,2100,1,''),(5,116,143,2100,1,''),(5,116,144,2100,1,''),(5,116,145,2100,1,''),(5,116,146,2100,1,''),(5,116,147,2100,1,''),(5,116,148,2100,1,''),(5,118,149,2207,1,'Xs\0'),(5,118,150,2207,1,'Xs\0'),(5,118,151,2207,1,''),(5,118,152,2207,1,''),(5,118,153,2207,1,''),(5,118,154,2207,1,''),(5,118,155,2207,1,''),(5,118,156,2207,1,''),(5,118,157,2207,1,''),(5,118,158,2207,1,''),(5,118,159,2207,1,''),(5,118,160,2207,1,''),(5,118,161,2207,1,''),(5,118,162,2207,1,''),(5,118,163,2207,1,''),(5,118,164,2207,1,''),(5,118,165,2207,1,''),(5,118,166,2207,1,''),(5,118,167,2207,1,''),(5,118,168,2207,1,''),(5,120,169,2310,100,'d'),(5,120,170,2273,100,'d'),(5,120,171,2293,100,'d'),(5,120,172,2293,100,'d'),(5,120,173,2261,100,'d'),(5,120,174,2286,100,'d'),(5,120,175,2262,100,'d'),(5,120,176,2305,100,'d'),(5,122,177,8473,100,'d'),(5,122,178,8473,100,'d'),(5,122,179,8473,100,'d'),(5,122,180,8473,100,'d'),(5,122,181,8473,100,'d'),(5,122,182,8473,100,'d'),(5,122,183,8473,100,'d'),(5,122,184,8473,100,'d'),(5,122,185,8473,100,'d'),(5,122,186,8473,100,'d'),(5,122,187,7620,100,'d'),(5,122,188,7620,100,'d'),(5,122,189,7620,100,'d'),(5,122,190,7620,100,'d'),(5,122,191,7620,100,'d'),(5,122,192,7620,100,'d'),(5,122,193,7620,100,'d'),(5,122,194,7620,100,'d'),(5,122,195,7620,100,'d'),(5,122,196,7620,100,'d'),(5,124,197,2169,1,'ñ\0'),(5,124,198,2169,1,''),(5,124,199,2169,1,''),(5,124,200,2169,1,''),(5,124,201,2169,1,''),(5,124,202,2169,1,''),(5,124,203,2169,1,''),(5,124,204,2169,1,''),(5,124,205,2169,1,''),(5,124,206,2169,1,''),(5,124,207,2169,1,''),(5,124,208,2169,1,''),(5,124,209,2169,1,''),(5,124,210,2169,1,''),(5,124,211,2169,1,''),(5,124,212,2169,1,''),(5,124,213,2169,1,''),(5,124,214,2169,1,''),(5,124,215,2169,1,''),(5,124,216,2169,1,''),(5,126,217,2164,20,'\0'),(5,126,218,2164,20,'\0'),(5,126,219,2164,20,'\0'),(5,126,220,2164,20,'\0'),(5,126,221,2164,20,'\0'),(5,126,222,2164,20,'\0'),(5,126,223,2164,20,'\0'),(5,126,224,2164,20,'\0'),(5,126,225,2164,20,'\0'),(5,126,226,2164,20,'\0'),(5,126,227,2164,20,'\0'),(5,126,228,2164,20,'\0'),(5,126,229,2164,20,'\0'),(5,126,230,2164,20,'\0'),(5,126,231,2164,20,'\0'),(5,126,232,2164,20,'\0'),(5,126,233,2164,20,'\0'),(5,126,234,2164,20,'\0'),(5,126,235,2164,20,'\0'),(5,126,236,2164,20,'\0'),(5,128,237,2197,5,'\0'),(5,128,238,2197,5,'\0'),(5,128,239,2197,5,'\0'),(5,128,240,2197,5,'\0'),(5,128,241,2197,5,'\0'),(5,128,242,2197,5,'\0'),(5,128,243,2197,5,'\0'),(5,128,244,2197,5,'\0'),(5,128,245,2197,5,'\0'),(5,128,246,2197,5,'\0'),(5,128,247,2197,5,'\0'),(5,128,248,2197,5,'\0'),(5,128,249,2197,5,'\0'),(5,128,250,2197,5,'\0'),(5,128,251,2197,5,'\0'),(5,128,252,2197,5,'\0'),(5,128,253,2197,5,'\0'),(5,128,254,2197,5,'\0'),(5,128,255,2197,5,'\0'),(5,128,256,2197,5,'\0'),(2,1,101,9778,1,''),(2,2,102,8266,1,''),(2,3,103,2365,1,''),(2,4,104,8890,1,''),(2,5,105,16112,1,''),(2,6,106,8922,1,''),(2,7,107,18400,1,''),(2,8,108,2195,1,''),(2,103,109,6433,1,''),(2,103,110,10515,1,''),(2,103,111,10513,1,''),(2,103,112,10511,1,''),(2,103,113,2160,10,'\n'),(2,103,114,12643,1,''),(2,103,115,20620,1,''),(2,115,116,6300,1,'O\0'),(2,115,117,5926,1,''),(2,115,118,2167,1,''),(2,115,119,10519,1,''),(2,115,120,2100,1,''),(2,115,121,1998,1,''),(2,115,122,2197,5,'\0'),(2,115,123,2003,1,''),(2,115,124,2291,1,''),(2,115,125,2002,1,''),(2,117,126,2169,1,''),(2,117,127,2169,1,''),(2,117,128,2169,1,'h	\0'),(2,117,129,2169,1,''),(2,117,130,2169,1,''),(2,117,131,2169,1,''),(2,117,132,2169,1,''),(2,117,133,2169,1,''),(2,117,134,2169,1,''),(2,117,135,2169,1,''),(2,117,136,2164,20,'\0'),(2,117,137,2164,20,'\0'),(2,117,138,2164,20,'\0'),(2,117,139,2164,20,'\0'),(2,117,140,2164,20,'\0'),(2,117,141,2164,20,'\0'),(2,117,142,2164,20,'\0'),(2,117,143,2164,20,'\0'),(2,117,144,2164,20,'\0'),(2,117,145,2164,20,'\0'),(2,119,146,2167,1,''),(2,119,147,2167,1,''),(2,119,148,2167,1,''),(2,119,149,2167,1,''),(2,119,150,2167,1,''),(2,119,151,2167,1,''),(2,119,152,2167,1,''),(2,119,153,2167,1,''),(2,119,154,2167,1,''),(2,119,155,2167,1,''),(2,119,156,2167,1,''),(2,119,157,2167,1,''),(2,119,158,2167,1,''),(2,119,159,2167,1,''),(2,119,160,2167,1,''),(2,119,161,2167,1,''),(2,119,162,2167,1,''),(2,119,163,2167,1,''),(2,119,164,2167,1,''),(2,119,165,2167,1,''),(2,121,166,2100,1,''),(2,121,167,2100,1,''),(2,121,168,2100,1,''),(2,121,169,2100,1,''),(2,121,170,2100,1,''),(2,121,171,2100,1,''),(2,121,172,2100,1,''),(2,121,173,2100,1,''),(2,121,174,2100,1,''),(2,121,175,2100,1,''),(2,121,176,2100,1,''),(2,121,177,2100,1,''),(2,121,178,2100,1,''),(2,121,179,2100,1,''),(2,121,180,2100,1,''),(2,121,181,2100,1,''),(2,121,182,2100,1,''),(2,121,183,2100,1,''),(2,121,184,2100,1,''),(2,121,185,2100,1,''),(2,123,186,2197,5,'\0'),(2,123,187,2197,5,'\0'),(2,123,188,2197,5,'\0'),(2,123,189,2197,5,'\0'),(2,123,190,2197,5,'\0'),(2,123,191,2197,5,'\0'),(2,123,192,2197,5,'\0'),(2,123,193,2197,5,'\0'),(2,123,194,2197,5,'\0'),(2,123,195,2197,5,'\0'),(2,123,196,2197,5,'\0'),(2,123,197,2197,5,'\0'),(2,123,198,2197,5,'\0'),(2,123,199,2197,5,'\0'),(2,123,200,2197,5,'\0'),(2,123,201,2197,5,'\0'),(2,123,202,2197,5,'\0'),(2,123,203,2197,5,'\0'),(2,123,204,2197,5,'\0'),(2,123,205,2197,5,'\0'),(2,125,206,2310,100,'d'),(2,125,207,2286,100,'d'),(2,125,208,2261,100,'d'),(2,125,209,2305,100,'d'),(2,125,210,2273,50,'2'),(2,125,211,2273,100,'d'),(2,125,212,2293,100,'d'),(2,125,213,2293,100,'d'),(2,125,214,7590,100,'d'),(2,125,215,7590,100,'d'),(2,125,216,7590,100,'d'),(2,125,217,7590,100,'d'),(2,125,218,2268,100,'d'),(2,125,219,2268,100,'d'),(2,125,220,2268,100,'d'),(4,1,101,12645,1,''),(4,2,102,8266,1,''),(4,3,103,10521,1,''),(4,4,104,8888,1,''),(4,6,105,8851,1,''),(4,7,106,9777,1,''),(4,8,107,2195,1,''),(4,10,108,18435,100,'d'),(4,103,109,20620,1,''),(4,103,110,6132,1,''),(4,103,111,10515,1,''),(4,103,112,10513,1,''),(4,103,113,10511,1,''),(4,109,114,7367,1,''),(4,109,115,11119,1,''),(4,109,116,6529,1,''),(4,109,117,15646,1,''),(4,109,118,8473,1,''),(4,109,119,2000,1,''),(4,109,120,2164,20,'\0'),(4,109,121,5926,1,''),(4,109,122,2197,5,'\0'),(4,109,123,2003,1,''),(4,109,124,2100,1,''),(4,109,125,1998,1,''),(4,109,126,7590,1,''),(4,109,127,11243,1,''),(4,115,128,6391,1,''),(4,115,129,8885,1,''),(4,115,130,22417,1,''),(4,117,131,7368,100,'d'),(4,117,132,7368,100,'d'),(4,117,133,7368,100,'d'),(4,117,134,7368,100,'d'),(4,117,135,7368,100,'d'),(4,117,136,7368,100,'d'),(4,117,137,7368,100,'d'),(4,117,138,7368,100,'d'),(4,117,139,18435,100,'d'),(4,117,140,18435,100,'d'),(4,117,141,18435,100,'d'),(4,117,142,18435,100,'d'),(4,117,143,18435,100,'d'),(4,117,144,18435,100,'d'),(4,117,145,18304,100,'d'),(4,117,146,18304,100,'d'),(4,117,147,18304,100,'d'),(4,117,148,18304,100,'d'),(4,117,149,18304,100,'d'),(4,117,150,18304,100,'d'),(4,119,151,2273,100,'d'),(4,119,152,2273,100,'d'),(4,119,153,2310,100,'d'),(4,119,154,2293,100,'d'),(4,119,155,2293,100,'d'),(4,119,156,2268,100,'d'),(4,119,157,2268,100,'d'),(4,119,158,2286,100,'d'),(4,119,159,2262,100,'d'),(4,119,160,2261,100,'d'),(4,119,161,2305,100,'d'),(4,121,162,2164,20,'\0'),(4,121,163,2164,20,'\0'),(4,121,164,2164,20,'\0'),(4,121,165,2164,20,'\0'),(4,121,166,2164,20,'\0'),(4,121,167,2164,20,'\0'),(4,121,168,2164,20,'\0'),(4,121,169,2164,20,'\0'),(4,121,170,2164,20,'\0'),(4,121,171,2164,20,'\0'),(4,121,172,2164,20,'\0'),(4,121,173,2164,20,'\0'),(4,121,174,2164,20,'\0'),(4,121,175,2164,20,'\0'),(4,121,176,2164,20,'\0'),(4,121,177,2164,20,'\0'),(4,121,178,2164,20,'\0'),(4,121,179,2164,20,'\0'),(4,121,180,2164,20,'\0'),(4,121,181,2164,20,'\0'),(4,123,182,2197,5,'\0'),(4,123,183,2197,5,'\0'),(4,123,184,2197,5,'\0'),(4,123,185,2197,5,'\0'),(4,123,186,2197,5,'\0'),(4,123,187,2197,5,'\0'),(4,123,188,2197,5,'\0'),(4,123,189,2197,5,'\0'),(4,123,190,2197,5,'\0'),(4,123,191,2197,5,'\0'),(4,123,192,2197,5,'\0'),(4,123,193,2197,5,'\0'),(4,123,194,2197,5,'\0'),(4,123,195,2197,5,'\0'),(4,123,196,2197,5,'\0'),(4,123,197,2197,5,'\0'),(4,123,198,2197,5,'\0'),(4,123,199,2197,5,'\0'),(4,123,200,2197,5,'\0'),(4,123,201,2197,5,'\0'),(4,125,202,2100,1,''),(4,125,203,2100,1,''),(4,125,204,2100,1,''),(4,125,205,2100,1,''),(4,125,206,2100,1,''),(4,125,207,2100,1,''),(4,125,208,2100,1,''),(4,125,209,2100,1,''),(4,125,210,2100,1,''),(4,125,211,2100,1,''),(4,125,212,2100,1,''),(4,125,213,2100,1,''),(4,125,214,2100,1,''),(4,125,215,2100,1,''),(4,125,216,2100,1,''),(4,125,217,2100,1,''),(4,125,218,2100,1,''),(4,125,219,2100,1,''),(4,125,220,2100,1,''),(4,125,221,2100,1,''),(4,127,222,7589,100,'d'),(4,127,223,7589,100,'d'),(4,127,224,7589,100,'d'),(4,127,225,7589,100,'d'),(4,127,226,7589,100,'d'),(4,127,227,7589,100,'d'),(4,127,228,7589,100,'d'),(4,127,229,7589,100,'d'),(4,127,230,7589,100,'d'),(4,127,231,7589,100,'d'),(4,127,232,7589,100,'d'),(4,127,233,7589,100,'d'),(4,127,234,7589,100,'d'),(4,127,235,7589,100,'d'),(4,127,236,8472,100,'d'),(4,127,237,8472,100,'d'),(4,127,238,8472,100,'d'),(4,127,239,8472,100,'d'),(4,127,240,8472,100,'d'),(4,127,241,8472,100,'d');
/*!40000 ALTER TABLE `player_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_namelocks`
--

DROP TABLE IF EXISTS `player_namelocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_namelocks` (
  `player_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `namelocked_at` bigint(20) NOT NULL,
  `namelocked_by` int(11) NOT NULL,
  PRIMARY KEY (`player_id`),
  KEY `namelocked_by` (`namelocked_by`),
  CONSTRAINT `player_namelocks_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `player_namelocks_ibfk_2` FOREIGN KEY (`namelocked_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_namelocks`
--

LOCK TABLES `player_namelocks` WRITE;
/*!40000 ALTER TABLE `player_namelocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_namelocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_spells`
--

DROP TABLE IF EXISTS `player_spells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_spells` (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  KEY `player_id` (`player_id`),
  CONSTRAINT `player_spells_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_spells`
--

LOCK TABLES `player_spells` WRITE;
/*!40000 ALTER TABLE `player_spells` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_spells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_storage`
--

DROP TABLE IF EXISTS `player_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_storage` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `key` int(10) unsigned NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`key`),
  CONSTRAINT `player_storage_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_storage`
--

LOCK TABLES `player_storage` WRITE;
/*!40000 ALTER TABLE `player_storage` DISABLE KEYS */;
INSERT INTO `player_storage` VALUES (1,10002011,12),(3,30018,1),(4,30018,1),(5,30018,1);
/*!40000 ALTER TABLE `player_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT '1',
  `account_id` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `vocation` int(11) NOT NULL DEFAULT '0',
  `health` int(11) NOT NULL DEFAULT '150',
  `healthmax` int(11) NOT NULL DEFAULT '150',
  `experience` bigint(20) NOT NULL DEFAULT '0',
  `lookbody` int(11) NOT NULL DEFAULT '0',
  `lookfeet` int(11) NOT NULL DEFAULT '0',
  `lookhead` int(11) NOT NULL DEFAULT '0',
  `looklegs` int(11) NOT NULL DEFAULT '0',
  `looktype` int(11) NOT NULL DEFAULT '136',
  `lookaddons` int(11) NOT NULL DEFAULT '0',
  `maglevel` int(11) NOT NULL DEFAULT '0',
  `mana` int(11) NOT NULL DEFAULT '0',
  `manamax` int(11) NOT NULL DEFAULT '0',
  `manaspent` int(11) unsigned NOT NULL DEFAULT '0',
  `soul` int(10) unsigned NOT NULL DEFAULT '0',
  `town_id` int(11) NOT NULL DEFAULT '0',
  `posx` int(11) NOT NULL DEFAULT '0',
  `posy` int(11) NOT NULL DEFAULT '0',
  `posz` int(11) NOT NULL DEFAULT '0',
  `conditions` blob NOT NULL,
  `cap` int(11) NOT NULL DEFAULT '0',
  `sex` int(11) NOT NULL DEFAULT '0',
  `lastlogin` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lastip` int(10) unsigned NOT NULL DEFAULT '0',
  `save` tinyint(1) NOT NULL DEFAULT '1',
  `skull` tinyint(1) NOT NULL DEFAULT '0',
  `skulltime` int(11) NOT NULL DEFAULT '0',
  `lastlogout` bigint(20) unsigned NOT NULL DEFAULT '0',
  `blessings` tinyint(2) NOT NULL DEFAULT '0',
  `onlinetime` int(11) NOT NULL DEFAULT '0',
  `deletion` bigint(15) NOT NULL DEFAULT '0',
  `balance` bigint(20) unsigned NOT NULL DEFAULT '0',
  `offlinetraining_time` smallint(5) unsigned NOT NULL DEFAULT '43200',
  `offlinetraining_skill` int(11) NOT NULL DEFAULT '-1',
  `stamina` smallint(5) unsigned NOT NULL DEFAULT '2520',
  `skill_fist` int(10) unsigned NOT NULL DEFAULT '10',
  `skill_fist_tries` bigint(20) unsigned NOT NULL DEFAULT '0',
  `skill_club` int(10) unsigned NOT NULL DEFAULT '10',
  `skill_club_tries` bigint(20) unsigned NOT NULL DEFAULT '0',
  `skill_sword` int(10) unsigned NOT NULL DEFAULT '10',
  `skill_sword_tries` bigint(20) unsigned NOT NULL DEFAULT '0',
  `skill_axe` int(10) unsigned NOT NULL DEFAULT '10',
  `skill_axe_tries` bigint(20) unsigned NOT NULL DEFAULT '0',
  `skill_dist` int(10) unsigned NOT NULL DEFAULT '10',
  `skill_dist_tries` bigint(20) unsigned NOT NULL DEFAULT '0',
  `skill_shielding` int(10) unsigned NOT NULL DEFAULT '10',
  `skill_shielding_tries` bigint(20) unsigned NOT NULL DEFAULT '0',
  `skill_fishing` int(10) unsigned NOT NULL DEFAULT '10',
  `skill_fishing_tries` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `account_id` (`account_id`),
  KEY `vocation` (`vocation`),
  CONSTRAINT `players_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (1,'Aaurooraa',3,1,8,1,185,185,4200,0,0,0,0,140,3,0,40,40,0,0,1,1027,1034,7,'',470,0,1461816499,2442400201,1,0,0,1461816514,0,9865,0,0,43200,-1,2520,10,0,10,0,10,0,10,0,10,0,10,0,10,0),(2,'Sorcerer',1,1,150,5,795,795,54042300,0,0,0,0,136,0,80,3080,3750,2010,0,1,1032,1030,7,'\0\0\0\0\0\0\0Hù\0\Z\0\0\0\0\0\×\0\0\0\0\0\0X\0\'&\0þ',4700,0,1461816516,444820403,0,0,0,1461813532,0,2301,0,0,43200,-1,2520,10,0,10,0,10,0,10,0,10,0,27,0,10,0),(3,'Druid',1,1,150,6,795,795,54042300,0,0,0,0,136,0,80,3750,3750,0,0,1,1031,1029,7,'',4700,0,1461816251,321906867,0,0,0,1461813182,0,882,0,0,43200,-1,2520,10,0,10,0,10,0,10,0,10,0,27,0,10,0),(4,'Paladin',1,1,150,7,1605,1605,34963300,0,0,0,0,136,0,25,2170,2170,0,0,1,1041,1028,7,'',12000,0,1461816365,2442400201,0,0,0,1461813769,0,825,0,0,43200,-1,2520,10,0,10,0,10,0,10,0,100,0,85,0,10,0),(5,'Knight',1,1,150,8,2315,2315,54042300,0,0,0,0,136,0,8,750,750,0,0,1,1032,1030,7,'',10000,0,1461816194,2442400201,0,0,0,1461813185,0,1520,0,0,43200,-1,2520,10,0,100,0,100,0,100,0,10,0,102,0,10,0);
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`ot`@`%`*/ /*!50003 TRIGGER `ondelete_players` BEFORE DELETE ON `players`
 FOR EACH ROW BEGIN
    UPDATE `houses` SET `owner` = 0 WHERE `owner` = OLD.`id`;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `players_online`
--

DROP TABLE IF EXISTS `players_online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `players_online` (
  `player_id` int(11) NOT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players_online`
--

LOCK TABLES `players_online` WRITE;
/*!40000 ALTER TABLE `players_online` DISABLE KEYS */;
/*!40000 ALTER TABLE `players_online` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_config`
--

DROP TABLE IF EXISTS `server_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_config` (
  `config` varchar(50) NOT NULL,
  `value` varchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY (`config`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_config`
--

LOCK TABLES `server_config` WRITE;
/*!40000 ALTER TABLE `server_config` DISABLE KEYS */;
INSERT INTO `server_config` VALUES ('db_version','19'),('motd_hash',''),('motd_num','0'),('players_record','5');
/*!40000 ALTER TABLE `server_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tile_store`
--

DROP TABLE IF EXISTS `tile_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tile_store` (
  `house_id` int(11) NOT NULL,
  `data` longblob NOT NULL,
  KEY `house_id` (`house_id`),
  CONSTRAINT `tile_store_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tile_store`
--

LOCK TABLES `tile_store` WRITE;
/*!40000 ALTER TABLE `tile_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `tile_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ot'
--

--
-- Dumping routines for database 'ot'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-28  1:12:17
