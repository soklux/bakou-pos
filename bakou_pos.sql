-- MySQL dump 10.13  Distrib 5.6.22, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: bakou_pos
-- ------------------------------------------------------
-- Server version	5.6.22-1+deb.sury.org~trusty+1

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
-- Table structure for table `AuthAssignment`
--

DROP TABLE IF EXISTS `AuthAssignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuthAssignment` (
  `itemname` varchar(64) CHARACTER SET latin1 NOT NULL,
  `userid` varchar(64) CHARACTER SET latin1 NOT NULL,
  `bizrule` text CHARACTER SET latin1,
  `data` text CHARACTER SET latin1,
  PRIMARY KEY (`itemname`,`userid`),
  CONSTRAINT `FK_AuthAssignment` FOREIGN KEY (`itemname`) REFERENCES `AuthItem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuthAssignment`
--

LOCK TABLES `AuthAssignment` WRITE;
/*!40000 ALTER TABLE `AuthAssignment` DISABLE KEYS */;
INSERT INTO `AuthAssignment` VALUES ('client.create','3',NULL,NULL),('client.delete','3',NULL,NULL),('client.index','3',NULL,NULL),('client.update','3',NULL,NULL),('employee.create','3',NULL,NULL),('employee.delete','3',NULL,NULL),('employee.index','3',NULL,NULL),('employee.update','3',NULL,NULL),('invoice.delete','3',NULL,NULL),('invoice.index','3',NULL,NULL),('invoice.print','3',NULL,NULL),('invoice.update','3',NULL,NULL),('item.create','3',NULL,NULL),('item.delete','3',NULL,NULL),('item.index','3',NULL,NULL),('item.update','3',NULL,NULL),('payment.index','3',NULL,NULL),('report.index','3',NULL,NULL),('sale.discount','3',NULL,NULL),('sale.edit','3',NULL,NULL),('sale.editprice','3',NULL,NULL),('store.update','3',NULL,NULL),('supplier.create','3',NULL,NULL),('supplier.delete','3',NULL,NULL),('supplier.index','3',NULL,NULL),('supplier.update','3',NULL,NULL),('transaction.count','3',NULL,NULL),('transaction.editcost','3',NULL,NULL),('transaction.editprice','3',NULL,NULL),('transaction.receive','3',NULL,NULL),('transaction.return','3',NULL,NULL);
/*!40000 ALTER TABLE `AuthAssignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AuthItem`
--

DROP TABLE IF EXISTS `AuthItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuthItem` (
  `name` varchar(64) CHARACTER SET latin1 NOT NULL,
  `type` int(11) NOT NULL,
  `description` text CHARACTER SET latin1,
  `bizrule` text CHARACTER SET latin1,
  `data` text CHARACTER SET latin1,
  `sort_order` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuthItem`
--

LOCK TABLES `AuthItem` WRITE;
/*!40000 ALTER TABLE `AuthItem` DISABLE KEYS */;
INSERT INTO `AuthItem` VALUES ('client.create',0,'Create',NULL,'N;',2),('client.delete',0,'Delete',NULL,'N;',4),('client.index',0,'View',NULL,'N;',1),('client.update',0,'Update',NULL,'N;',3),('employee.create',0,'Create',NULL,NULL,2),('employee.delete',0,'Delete',NULL,NULL,4),('employee.index',0,'View',NULL,NULL,1),('employee.update',0,'Update',NULL,NULL,3),('invoice.delete',0,'Cancel',NULL,'N;',4),('invoice.index',0,'View',NULL,'N;',1),('invoice.print',0,'Re-print',NULL,'N;',2),('invoice.update',0,'Edit',NULL,'N;',3),('item.create',0,'Create',NULL,NULL,2),('item.delete',0,'Delete',NULL,NULL,4),('item.index',0,'View',NULL,NULL,1),('item.update',0,'Update',NULL,NULL,3),('itemAdmin',1,'Administer Item',NULL,'N;',NULL),('payment.index',0,'Invoice Payment (Debt)',NULL,NULL,NULL),('receiving.edit',0,'Process Purchase orders',NULL,'N;',NULL),('report.index',0,'View and generate reports',NULL,'N;',NULL),('sale.discount',0,'Discount',NULL,'N;',NULL),('sale.edit',0,'Normal Sale',NULL,'N;',NULL),('sale.editprice',0,'Edit Price',NULL,'N;',NULL),('setting.exchangerate',0,'Exchange Rate',NULL,NULL,NULL),('setting.receipt',0,'Receipt Setting',NULL,NULL,NULL),('setting.sale',0,'Sale Setting',NULL,NULL,NULL),('setting.site',0,'Shop Setting',NULL,NULL,NULL),('setting.system',0,'System Setting',NULL,NULL,NULL),('store.update',0,'Change the store\'s configuration',NULL,'N;',NULL),('supplier.create',0,'Create',NULL,NULL,2),('supplier.delete',0,'Delete',NULL,NULL,4),('supplier.index',0,'View',NULL,NULL,1),('supplier.update',0,'Update',NULL,NULL,3),('transaction.count',0,'Physical Count',NULL,NULL,3),('transaction.editcost',0,'Edit Buy Price',NULL,NULL,5),('transaction.editprice',0,'Edit Sell Price',NULL,NULL,4),('transaction.receive',0,'Receive from Supplier',NULL,NULL,1),('transaction.return',0,'Return to Supplier',NULL,NULL,2);
/*!40000 ALTER TABLE `AuthItem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AuthItemChild`
--

DROP TABLE IF EXISTS `AuthItemChild`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuthItemChild` (
  `parent` varchar(64) CHARACTER SET latin1 NOT NULL,
  `child` varchar(64) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuthItemChild`
--

LOCK TABLES `AuthItemChild` WRITE;
/*!40000 ALTER TABLE `AuthItemChild` DISABLE KEYS */;
/*!40000 ALTER TABLE `AuthItemChild` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `current_balance` decimal(15,4) DEFAULT '0.0000',
  `status` varchar(1) DEFAULT '1',
  `date_created` datetime DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`id`),
  KEY `FK_account_client_id` (`client_id`),
  CONSTRAINT `FK_account` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_receivable`
--

DROP TABLE IF EXISTS `account_receivable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_receivable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `trans_id` int(11) NOT NULL,
  `trans_amount` decimal(15,4) DEFAULT NULL,
  `trans_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trans_datetime` datetime DEFAULT NULL,
  `trans_status` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT 'N',
  `note` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `FK_transactions_account_id` (`account_id`),
  KEY `FK_transactions_employee_id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_receivable`
--

LOCK TABLES `account_receivable` WRITE;
/*!40000 ALTER TABLE `account_receivable` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_receivable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_receivable_supplier`
--

DROP TABLE IF EXISTS `account_receivable_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_receivable_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `trans_id` int(11) NOT NULL,
  `trans_amount` decimal(15,4) DEFAULT NULL,
  `trans_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trans_datetime` datetime DEFAULT NULL,
  `trans_status` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT 'N',
  `note` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_receivable_supplier`
--

LOCK TABLES `account_receivable_supplier` WRITE;
/*!40000 ALTER TABLE `account_receivable_supplier` DISABLE KEYS */;
INSERT INTO `account_receivable_supplier` VALUES (1,1,2,1,100.0000,'CHRECV','2015-07-09 11:49:22','N',NULL);
/*!40000 ALTER TABLE `account_receivable_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_supplier`
--

DROP TABLE IF EXISTS `account_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` int(11) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `current_balance` decimal(15,4) DEFAULT '0.0000',
  `status` varchar(1) DEFAULT '1',
  `date_created` datetime DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`id`),
  KEY `FK_account_supplier_supplier_id` (`supplier_id`),
  CONSTRAINT `FK_account_supplier_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_supplier`
--

LOCK TABLES `account_supplier` WRITE;
/*!40000 ALTER TABLE `account_supplier` DISABLE KEYS */;
INSERT INTO `account_supplier` VALUES (1,1,'ABC',100.0000,NULL,'2015-07-09 11:49:21',NULL);
/*!40000 ALTER TABLE `account_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cash_register_balance`
--

DROP TABLE IF EXISTS `cash_register_balance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cash_register_balance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `begin_cash` double(15,2) DEFAULT NULL,
  `sale_cash` double(15,2) DEFAULT NULL,
  `sale_credit_card` double(15,2) DEFAULT NULL,
  `sale_on_credit` double(15,2) DEFAULT NULL,
  `cash_received` double(15,2) DEFAULT NULL,
  `cash_total` double(15,2) DEFAULT NULL,
  `counted_total` double(15,2) DEFAULT NULL,
  `over_short` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cash_register_balance`
--

LOCK TABLES `cash_register_balance` WRITE;
/*!40000 ALTER TABLE `cash_register_balance` DISABLE KEYS */;
/*!40000 ALTER TABLE `cash_register_balance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` int(11) DEFAULT NULL,
  `price_tier_id` int(11) DEFAULT NULL,
  `first_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `last_name` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `mobile_no` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address1` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `address2` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `country_code` varchar(2) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `fax` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text CHARACTER SET utf8,
  `status` varchar(1) CHARACTER SET utf8 DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_price_tier`
--

DROP TABLE IF EXISTS `client_price_tier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_price_tier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `price_tier_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_price_tier`
--

LOCK TABLES `client_price_tier` WRITE;
/*!40000 ALTER TABLE `client_price_tier` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_price_tier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `last_name` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `mobile_no` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `address1` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `address2` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `country_code` varchar(2) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `fax` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text CHARACTER SET utf8,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (1,'Pheap Contact','','','','',NULL,NULL,NULL,NULL,NULL,'2015-06-09 17:52:00','2015-06-09 18:26:24'),(2,'Lux Contact','','','','',NULL,NULL,NULL,NULL,NULL,'2015-06-09 18:08:34','2015-06-09 18:25:30'),(3,'Ravy Contact','','','','',NULL,NULL,NULL,NULL,NULL,'2015-06-09 18:24:56','2015-06-09 18:24:56'),(4,'Rado Contact','','017775776','','',NULL,NULL,NULL,NULL,NULL,'2015-06-09 18:26:45','2015-06-09 18:26:58'),(5,'','','','','',NULL,NULL,NULL,NULL,NULL,'2015-06-23 05:23:55','2015-06-23 05:23:55'),(6,'','','','','',NULL,NULL,NULL,NULL,NULL,'2015-07-08 09:17:15','2015-07-08 09:17:15');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency_type`
--

DROP TABLE IF EXISTS `currency_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency_type` (
  `code` int(11) NOT NULL AUTO_INCREMENT,
  `currency_id` char(3) CHARACTER SET utf8 NOT NULL,
  `currency_name` varchar(70) CHARACTER SET utf8 NOT NULL,
  `currency_symbol` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_type`
--

LOCK TABLES `currency_type` WRITE;
/*!40000 ALTER TABLE `currency_type` DISABLE KEYS */;
INSERT INTO `currency_type` VALUES (1,'USD','United States Dollar','$',NULL),(2,'KHR','Kampuchea Riel','៛',NULL),(3,'THB','Thai Baht','฿',NULL);
/*!40000 ALTER TABLE `currency_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `dob` date DEFAULT NULL,
  `mobile_no` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `adddress1` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `address2` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `country_code` varchar(2) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `notes` text CHARACTER SET utf8,
  `status` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Owner','System',NULL,'012999068','','',NULL,'','','','1'),(2,'Super','super','1970-01-01','016999963','super addresss1','super address',NULL,'','','','1');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_image`
--

DROP TABLE IF EXISTS `employee_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `photo` blob NOT NULL,
  `thumbnail` blob,
  `filename` varchar(30) CHARACTER SET latin1 NOT NULL,
  `filetype` varchar(15) CHARACTER SET latin1 DEFAULT NULL,
  `path` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `width` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `height` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_employee_image_emp_id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_image`
--

LOCK TABLES `employee_image` WRITE;
/*!40000 ALTER TABLE `employee_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `error_og`
--

DROP TABLE IF EXISTS `error_og`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `error_og` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `create_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `error_og`
--

LOCK TABLES `error_og` WRITE;
/*!40000 ALTER TABLE `error_og` DISABLE KEYS */;
/*!40000 ALTER TABLE `error_og` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_rate`
--

DROP TABLE IF EXISTS `exchange_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchange_rate` (
  `base_currency` varchar(3) NOT NULL,
  `to_currency` varchar(3) NOT NULL,
  `base_cur_val` double(15,2) NOT NULL,
  `to_cur_val` double(15,2) NOT NULL,
  PRIMARY KEY (`base_currency`,`to_currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_rate`
--

LOCK TABLES `exchange_rate` WRITE;
/*!40000 ALTER TABLE `exchange_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `exchange_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_items` int(11) NOT NULL,
  `trans_user` int(11) NOT NULL,
  `trans_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trans_comment` text CHARACTER SET utf8 NOT NULL,
  `trans_inventory` double(15,2) NOT NULL DEFAULT '0.00',
  `trans_qty` double(15,2) DEFAULT NULL,
  `qty_b4_trans` double(15,2) DEFAULT NULL,
  `qty_af_trans` double(15,2) DEFAULT NULL,
  PRIMARY KEY (`trans_id`),
  KEY `FK_inventory_item_id` (`trans_items`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,1,2,'2015-07-09 04:49:22','Receive from Supplier 1',100.00,100.00,0.00,100.00),(2,1,2,'2015-07-09 04:49:48','POS 1',-10.00,10.00,100.00,90.00),(3,1,2,'2015-07-09 04:50:31','Physical Count 2',110.00,200.00,90.00,200.00),(4,1,2,'2015-08-01 08:40:49','POS 2',-1.00,1.00,200.00,199.00);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `item_number` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `cost_price` double(15,4) DEFAULT NULL,
  `unit_price` double(15,4) DEFAULT NULL,
  `quantity` double(15,2) NOT NULL,
  `unit_measurable_id` int(11) DEFAULT NULL COMMENT 'unit of measurable',
  `reorder_level` double(15,2) DEFAULT NULL,
  `location` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `allow_alt_description` tinyint(1) DEFAULT NULL,
  `is_serialized` tinyint(1) DEFAULT NULL,
  `description` text CHARACTER SET utf8,
  `status` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `created_date` datetime DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `is_expire` tinyint(1) DEFAULT '0',
  `count_interval` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `item_number` (`item_number`),
  KEY `FK_item_category_id` (`category_id`),
  KEY `FK_item_supplier_id` (`supplier_id`),
  KEY `FK_item_um_id` (`unit_measurable_id`),
  CONSTRAINT `FK_item_cat_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_item_um_id` FOREIGN KEY (`unit_measurable_id`) REFERENCES `unit_measurable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'Kadoa','0001',NULL,NULL,1.0000,2.0000,199.00,NULL,100.00,'',NULL,NULL,'','1','2015-07-09 11:47:47','2015-08-01 15:40:48',0,NULL);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_count_schedule`
--

DROP TABLE IF EXISTS `item_count_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_count_schedule` (
  `item_id` int(11) NOT NULL,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` double(15,2) DEFAULT NULL,
  `first_count_date` datetime DEFAULT NULL,
  `next_count_date` datetime DEFAULT NULL,
  `count_interval` smallint(6) DEFAULT NULL,
  `modified_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `employee_id` int(11) DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_count_schedule`
--

LOCK TABLES `item_count_schedule` WRITE;
/*!40000 ALTER TABLE `item_count_schedule` DISABLE KEYS */;
INSERT INTO `item_count_schedule` VALUES (403,'Bacchus (Suger Free)',6.00,'2015-01-15 18:14:43',NULL,NULL,'2015-01-15 18:14:43',2,NULL),(443,'Cacao Chocolate Pic',1.00,'2015-01-14 19:56:43',NULL,NULL,'2015-01-14 19:56:43',2,NULL),(578,'LATASOY PLAIN',1.00,'2015-01-11 16:15:00',NULL,NULL,'2015-01-11 16:15:00',2,NULL),(666,' Mini Nico\'s chocolate 90g',-17.00,'2015-02-16 00:02:19',NULL,NULL,'2015-02-16 00:38:31',2,NULL),(823,'Citra ultmate white400ml',2.00,'2015-01-15 19:18:16',NULL,NULL,'2015-01-15 19:18:16',2,NULL),(998,'Red Bull (គោជល់)',-31.00,'2015-01-15 18:24:13',NULL,NULL,'2015-01-15 18:24:13',2,NULL),(1120,'Nivea Men Cool Kick Roll-on 12ml',1.00,'2015-01-15 19:17:16',NULL,NULL,'2015-01-15 19:17:16',2,NULL),(1181,'Angkor (Bottle) white',-10.00,'2015-01-13 12:51:24',NULL,NULL,'2015-01-13 12:51:24',2,NULL),(1366,'testingitem',-4.00,'2015-01-11 14:29:17','2015-01-17 09:58:35',1,'2015-01-16 09:58:35',2,NULL),(1367,'Shouhern Grap 1x36Pcs (40g)',0.00,'2015-01-11 16:58:24',NULL,NULL,'2015-01-11 16:58:24',2,NULL),(1368,'Viger Power',0.00,'2015-01-16 19:28:47',NULL,NULL,'2015-01-16 19:28:47',2,NULL),(1369,'viger ice',0.00,'2015-01-16 19:30:14',NULL,NULL,'2015-01-16 19:30:14',2,NULL),(1370,'Aloe King OKF  250ML',0.00,'2015-01-24 16:06:06','2015-01-31 16:06:06',7,'2015-01-24 16:06:06',2,NULL),(1371,'Mini Nico\'s chocolate 90g',0.00,'2015-01-24 19:48:30','2015-01-31 19:48:30',7,'2015-01-24 19:48:30',2,NULL),(1372,'test',0.00,'2015-03-12 19:49:59',NULL,NULL,'2015-03-12 19:49:59',2,NULL);
/*!40000 ALTER TABLE `item_count_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_count_schedule_dt`
--

DROP TABLE IF EXISTS `item_count_schedule_dt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_count_schedule_dt` (
  `item_id` int(11) NOT NULL,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` double(15,2) DEFAULT NULL,
  `first_count_date` datetime DEFAULT NULL,
  `next_count_date` datetime DEFAULT NULL,
  `count_interval` smallint(6) DEFAULT NULL,
  `modified_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `employee_id` int(11) DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_count_schedule_dt`
--

LOCK TABLES `item_count_schedule_dt` WRITE;
/*!40000 ALTER TABLE `item_count_schedule_dt` DISABLE KEYS */;
INSERT INTO `item_count_schedule_dt` VALUES (1366,'testingitem',0.00,'2015-01-11 14:29:17','2015-01-12 14:29:17',1,'2015-01-11 14:29:17',38,'CU ITEM'),(578,'LATASOY PLAIN',1.00,'2015-01-11 16:15:00',NULL,NULL,'2015-01-11 16:15:00',38,'CU ITEM'),(1367,'Shouhern Grap 1x36Pcs (40g)',0.00,'2015-01-11 16:58:24',NULL,NULL,'2015-01-11 16:58:24',38,'CU ITEM'),(1181,'Angkor (Bottle) white',-10.00,'2015-01-13 12:51:24',NULL,NULL,'2015-01-13 12:51:24',38,'CU ITEM'),(443,'Cacao Chocolate Pic',1.00,'2015-01-14 19:56:43',NULL,NULL,'2015-01-14 19:56:43',38,'CU ITEM'),(403,'Bacchus (Suger Free)',6.00,'2015-01-15 18:14:43',NULL,NULL,'2015-01-15 18:14:43',38,'CU ITEM'),(998,'Red Bull (គោជល់)',-31.00,'2015-01-15 18:24:13',NULL,NULL,'2015-01-15 18:24:13',38,'CU ITEM'),(1120,'Nivea Men Cool Kick Roll-on 12ml',1.00,'2015-01-15 19:17:16',NULL,NULL,'2015-01-15 19:17:16',38,'CU ITEM'),(823,'Citra ultmate white400ml',2.00,'2015-01-15 19:18:16',NULL,NULL,'2015-01-15 19:18:16',38,'CU ITEM'),(1366,'testingitem',-4.00,'2015-01-11 14:29:17','2015-01-17 09:58:35',1,'2015-01-16 09:58:35',38,NULL),(1368,'Viger Power',0.00,'2015-01-16 19:28:47',NULL,NULL,'2015-01-16 19:28:47',38,'CU ITEM'),(1369,'viger ice',0.00,'2015-01-16 19:30:14',NULL,NULL,'2015-01-16 19:30:14',38,'CU ITEM'),(1370,'Aloe King OKF  250ML',0.00,'2015-01-24 16:06:06','2015-01-31 16:06:06',7,'2015-01-24 16:06:06',38,'CU ITEM'),(1371,'Mini Nico\'s chocolate 90g',0.00,'2015-01-24 19:48:30','2015-01-31 19:48:30',7,'2015-01-24 19:48:30',38,'CU ITEM'),(666,' Mini Nico\'s chocolate 90g',-17.00,'2015-02-16 00:02:19',NULL,NULL,'2015-02-16 00:02:19',38,'CU ITEM'),(666,' Mini Nico\'s chocolate 90g',-17.00,'2015-02-16 00:02:19',NULL,NULL,'2015-02-16 00:05:36',38,'CU ITEM'),(666,' Mini Nico\'s chocolate 90g',-17.00,'2015-02-16 00:02:19',NULL,NULL,'2015-02-16 00:22:25',38,'CU ITEM'),(666,' Mini Nico\'s chocolate 90g',-17.00,'2015-02-16 00:02:19',NULL,NULL,'2015-02-16 00:35:03',38,'CU ITEM'),(666,' Mini Nico\'s chocolate 90g',-17.00,'2015-02-16 00:02:19',NULL,NULL,'2015-02-16 00:38:31',38,'CU ITEM'),(1372,'test',0.00,'2015-03-12 19:49:59',NULL,NULL,'2015-03-12 19:49:59',38,'CU ITEM');
/*!40000 ALTER TABLE `item_count_schedule_dt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_expire`
--

DROP TABLE IF EXISTS `item_expire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_expire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `mfd_date` date DEFAULT NULL,
  `expire_date` date NOT NULL,
  `quantity` decimal(15,2) DEFAULT '0.00',
  PRIMARY KEY (`id`,`item_id`,`expire_date`),
  UNIQUE KEY `item_expire` (`item_id`,`expire_date`),
  KEY `FK_item_expire_item_id` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_expire`
--

LOCK TABLES `item_expire` WRITE;
/*!40000 ALTER TABLE `item_expire` DISABLE KEYS */;
INSERT INTO `item_expire` VALUES (5,3,NULL,'1970-01-01',2.00),(6,8,NULL,'1970-01-01',19.00),(7,1,NULL,'0000-00-00',10.00),(8,3,NULL,'2020-01-20',1.00),(9,5,NULL,'2019-01-20',1.00),(10,14,NULL,'2020-01-01',1.00),(11,41,NULL,'2020-01-01',10.00);
/*!40000 ALTER TABLE `item_expire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_expire_dt`
--

DROP TABLE IF EXISTS `item_expire_dt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_expire_dt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_expire_id` int(11) NOT NULL,
  `trans_id` int(11) NOT NULL,
  `trans_qty` decimal(15,2) NOT NULL,
  `trans_comment` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_item_expire_dt` (`item_expire_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_expire_dt`
--

LOCK TABLES `item_expire_dt` WRITE;
/*!40000 ALTER TABLE `item_expire_dt` DISABLE KEYS */;
INSERT INTO `item_expire_dt` VALUES (5,5,27,2.00,'Receive from Supplier 27','2014-10-28 04:00:41',38),(6,6,27,19.00,'Receive from Supplier 27','2014-10-28 04:00:41',38),(7,7,28,10.00,'Receive from Supplier 28','2014-10-28 04:03:01',38),(8,8,29,1.00,'Receive from Supplier 29','2014-10-28 04:04:50',38),(9,9,29,1.00,'Receive from Supplier 29','2014-10-28 04:04:50',38),(10,10,30,1.00,'Receive from Supplier 30','2014-11-09 00:20:20',38),(11,11,34,10.00,'Receive from Supplier 34','2014-11-11 02:44:59',38);
/*!40000 ALTER TABLE `item_expire_dt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_image`
--

DROP TABLE IF EXISTS `item_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `photo` blob,
  `thumbnail` blob,
  `filename` varchar(50) CHARACTER SET latin1 NOT NULL,
  `filetype` varchar(15) CHARACTER SET latin1 DEFAULT NULL,
  `path` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `width` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `height` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_item_image_item_id` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_image`
--

LOCK TABLES `item_image` WRITE;
/*!40000 ALTER TABLE `item_image` DISABLE KEYS */;
INSERT INTO `item_image` VALUES (1,666,NULL,NULL,'4747_bright_smiling_sunflower_sun.jpg','image/jpeg','/ximages/item/666',17072,NULL,NULL);
/*!40000 ALTER TABLE `item_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_price`
--

DROP TABLE IF EXISTS `item_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `old_price` double(15,4) DEFAULT NULL,
  `new_price` double(15,4) DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_item_price_item_id` (`item_id`),
  KEY `FK_item_price_emp_id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_price`
--

LOCK TABLES `item_price` WRITE;
/*!40000 ALTER TABLE `item_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_price_promo`
--

DROP TABLE IF EXISTS `item_price_promo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_price_promo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `unit_price` double(15,4) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `item_id_udx` (`item_id`),
  CONSTRAINT `FK_item_price_promo_id` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_price_promo`
--

LOCK TABLES `item_price_promo` WRITE;
/*!40000 ALTER TABLE `item_price_promo` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_price_promo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_price_promo_dt`
--

DROP TABLE IF EXISTS `item_price_promo_dt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_price_promo_dt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_price_promo_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `unit_price` double(15,4) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_price_promo_dt`
--

LOCK TABLES `item_price_promo_dt` WRITE;
/*!40000 ALTER TABLE `item_price_promo_dt` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_price_promo_dt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_price_tier`
--

DROP TABLE IF EXISTS `item_price_tier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_price_tier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `price_tier_id` int(11) NOT NULL,
  `price` double(15,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`item_id`,`price_tier_id`),
  KEY `FK_item_price_tier_item_id` (`item_id`),
  KEY `FK_item_price_tier_id` (`price_tier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_price_tier`
--

LOCK TABLES `item_price_tier` WRITE;
/*!40000 ALTER TABLE `item_price_tier` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_price_tier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_history`
--

DROP TABLE IF EXISTS `payment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `payment_amount` double(15,2) NOT NULL,
  `give_away` double DEFAULT '0',
  `date_paid` datetime DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `employee_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_payment_history_cid` (`client_id`),
  CONSTRAINT `FK_payment_history_cid` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_history`
--

LOCK TABLES `payment_history` WRITE;
/*!40000 ALTER TABLE `payment_history` DISABLE KEYS */;
INSERT INTO `payment_history` VALUES (1,NULL,20.00,0,'2015-07-09 11:49:48',NULL,2),(2,NULL,2.00,0,'2015-08-01 15:40:48',NULL,2);
/*!40000 ALTER TABLE `payment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_history_recv`
--

DROP TABLE IF EXISTS `payment_history_recv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_history_recv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` int(11) DEFAULT NULL,
  `payment_amount` double(15,2) NOT NULL,
  `give_away` double DEFAULT '0',
  `date_paid` datetime DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `employee_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_payment_history_rec_id` (`supplier_id`),
  CONSTRAINT `FK_payment_history_rec_id` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_history_recv`
--

LOCK TABLES `payment_history_recv` WRITE;
/*!40000 ALTER TABLE `payment_history_recv` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_history_recv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price_tier`
--

DROP TABLE IF EXISTS `price_tier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `price_tier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tier_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `status` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_tier`
--

LOCK TABLES `price_tier` WRITE;
/*!40000 ALTER TABLE `price_tier` DISABLE KEYS */;
/*!40000 ALTER TABLE `price_tier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_user`
--

DROP TABLE IF EXISTS `rbac_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(60) CHARACTER SET utf8 NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `employee_id` int(11) NOT NULL,
  `user_password` varchar(128) CHARACTER SET utf8 NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  `date_entered` datetime DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_indx` (`user_name`),
  KEY `FK_rbac_user_group_id` (`group_id`),
  KEY `FK_rbac_user_employee_id` (`employee_id`),
  CONSTRAINT `FK_rbac_user_emp_id` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_user`
--

LOCK TABLES `rbac_user` WRITE;
/*!40000 ALTER TABLE `rbac_user` DISABLE KEYS */;
INSERT INTO `rbac_user` VALUES (2,'admin',NULL,1,'$2a$08$mVfZ0ZgpzQkw9zDRYFKzUunVTh8pxTBhJoikVwjoQ9TVGb4zDtIMS',0,1,NULL,'2015-02-15 16:08:19',NULL),(3,'super',NULL,2,'$2a$08$FyizoJZyZAE7.FiumWcHOerQydWMvSKO/onI2aqke.g2x.R4V09ZW',0,1,'2013-10-10 09:44:04','2015-06-03 10:26:38',NULL);
/*!40000 ALTER TABLE `rbac_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receiving`
--

DROP TABLE IF EXISTS `receiving`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receiving` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receive_time` datetime NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `sub_total` double(15,4) DEFAULT NULL,
  `payment_type` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `status` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `remark` text CHARACTER SET utf8,
  `discount_amount` decimal(15,4) DEFAULT NULL,
  `discount_type` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sale_emp_id` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receiving`
--

LOCK TABLES `receiving` WRITE;
/*!40000 ALTER TABLE `receiving` DISABLE KEYS */;
INSERT INTO `receiving` VALUES (1,'2015-07-09 11:49:22',1,2,100.0000,'','Receive from Supplier',NULL,0.0000,'%'),(2,'2015-07-09 11:50:31',NULL,2,200.0000,'','Physical Count','Count see 200',0.0000,'%');
/*!40000 ALTER TABLE `receiving` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receiving_item`
--

DROP TABLE IF EXISTS `receiving_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receiving_item` (
  `receive_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `description` text CHARACTER SET utf8,
  `line` int(11) DEFAULT NULL,
  `quantity` double(15,2) DEFAULT NULL,
  `cost_price` double(15,4) DEFAULT NULL,
  `unit_price` double(15,4) DEFAULT NULL,
  `price` double(15,4) DEFAULT NULL,
  `discount_amount` double(15,2) DEFAULT NULL,
  `discount_type` varchar(2) CHARACTER SET utf8 DEFAULT '%',
  PRIMARY KEY (`receive_id`,`item_id`),
  KEY `FK_sale_item_item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receiving_item`
--

LOCK TABLES `receiving_item` WRITE;
/*!40000 ALTER TABLE `receiving_item` DISABLE KEYS */;
INSERT INTO `receiving_item` VALUES (1,1,NULL,1,100.00,1.0000,2.0000,2.0000,0.00,'%'),(2,1,NULL,1,200.00,1.0000,2.0000,2.0000,0.00,'%');
/*!40000 ALTER TABLE `receiving_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receiving_payment`
--

DROP TABLE IF EXISTS `receiving_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receiving_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receive_id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `payment_type` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `payment_amount` double NOT NULL,
  `give_away` double DEFAULT '0',
  `date_paid` datetime DEFAULT NULL,
  `note` text CHARACTER SET utf8,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `receving_payment_indx` (`payment_id`),
  CONSTRAINT `receving_payment_indx` FOREIGN KEY (`payment_id`) REFERENCES `payment_history_recv` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receiving_payment`
--

LOCK TABLES `receiving_payment` WRITE;
/*!40000 ALTER TABLE `receiving_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `receiving_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale`
--

DROP TABLE IF EXISTS `sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_time` datetime NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `sub_total` decimal(15,4) DEFAULT NULL,
  `payment_type` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `remark` text CHARACTER SET utf8,
  `discount_amount` decimal(15,2) DEFAULT '0.00',
  `discount_type` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount_due` decimal(15,4) DEFAULT '0.0000',
  `vat` decimal(15,2) DEFAULT '0.00',
  `salerep_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sale_emp_id` (`employee_id`),
  KEY `FK_sale_client_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale`
--

LOCK TABLES `sale` WRITE;
/*!40000 ALTER TABLE `sale` DISABLE KEYS */;
INSERT INTO `sale` VALUES (1,'2015-07-09 11:49:48',NULL,2,20.0000,'Cash: 20<br />','1',NULL,0.00,'%',0.0000,0.00,NULL),(2,'2015-08-01 15:40:48',NULL,2,2.0000,'Cash: 2<br />','1',NULL,0.00,'%',0.0000,0.00,NULL);
/*!40000 ALTER TABLE `sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_item`
--

DROP TABLE IF EXISTS `sale_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_item` (
  `sale_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `description` text CHARACTER SET utf8,
  `line` int(11) DEFAULT NULL,
  `quantity` double(15,2) DEFAULT NULL,
  `cost_price` double(15,4) DEFAULT NULL,
  `unit_price` double(15,4) DEFAULT NULL,
  `price` double(15,4) DEFAULT NULL,
  `discount_amount` double(15,2) DEFAULT NULL,
  `discount_type` varchar(2) CHARACTER SET utf8 DEFAULT '%',
  PRIMARY KEY (`sale_id`,`item_id`),
  KEY `FK_sale_item_item_id` (`item_id`),
  CONSTRAINT `FK_sale_item_sale_id` FOREIGN KEY (`sale_id`) REFERENCES `sale` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_item`
--

LOCK TABLES `sale_item` WRITE;
/*!40000 ALTER TABLE `sale_item` DISABLE KEYS */;
INSERT INTO `sale_item` VALUES (1,1,NULL,1,10.00,1.0000,2.0000,2.0000,0.00,'%'),(2,1,NULL,1,1.00,1.0000,2.0000,2.0000,0.00,'%');
/*!40000 ALTER TABLE `sale_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_item_log`
--

DROP TABLE IF EXISTS `sale_item_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_item_log` (
  `sale_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `description` text CHARACTER SET utf8,
  `line` int(11) DEFAULT NULL,
  `quantity` double(15,2) DEFAULT NULL,
  `cost_price` double(15,4) DEFAULT NULL,
  `unit_price` double(15,4) DEFAULT NULL,
  `price` double(15,4) DEFAULT NULL,
  `discount_amount` double(15,2) DEFAULT NULL,
  `discount_type` varchar(2) CHARACTER SET utf8 DEFAULT '%'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_item_log`
--

LOCK TABLES `sale_item_log` WRITE;
/*!40000 ALTER TABLE `sale_item_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_item_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_payment`
--

DROP TABLE IF EXISTS `sale_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `payment_type` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `payment_amount` double NOT NULL,
  `give_away` double DEFAULT '0',
  `date_paid` datetime DEFAULT NULL,
  `note` text CHARACTER SET utf8,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sale_payment_sale_id` (`sale_id`),
  KEY `FK_sale_payment_id` (`payment_id`),
  CONSTRAINT `FK_sale_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `payment_history` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_payment`
--

LOCK TABLES `sale_payment` WRITE;
/*!40000 ALTER TABLE `sale_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_suspended`
--

DROP TABLE IF EXISTS `sale_suspended`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_suspended` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_time` datetime NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `sub_total` double(15,4) DEFAULT NULL,
  `payment_type` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `remark` text CHARACTER SET utf8,
  PRIMARY KEY (`id`),
  KEY `FK_sale_suspended_client_id` (`client_id`),
  KEY `FK_sale_suspended_emp_Id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_suspended`
--

LOCK TABLES `sale_suspended` WRITE;
/*!40000 ALTER TABLE `sale_suspended` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_suspended` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_suspended_item`
--

DROP TABLE IF EXISTS `sale_suspended_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_suspended_item` (
  `sale_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `description` text CHARACTER SET utf8,
  `line` int(11) DEFAULT NULL,
  `quantity` double(15,2) DEFAULT NULL,
  `cost_price` double(15,4) DEFAULT NULL,
  `unit_price` double(15,4) DEFAULT NULL,
  `price` double(15,4) DEFAULT NULL,
  `discount_amount` double(15,2) DEFAULT NULL,
  `discount_type` varchar(2) CHARACTER SET utf8 DEFAULT '%',
  KEY `FK_sale_suspended_item_sale_id` (`sale_id`),
  KEY `FK_sale_suspended_item_item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_suspended_item`
--

LOCK TABLES `sale_suspended_item` WRITE;
/*!40000 ALTER TABLE `sale_suspended_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_suspended_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_suspended_payment`
--

DROP TABLE IF EXISTS `sale_suspended_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_suspended_payment` (
  `sale_id` int(11) NOT NULL,
  `payment_type` varchar(40) CHARACTER SET utf8 NOT NULL,
  `payment_amount` double NOT NULL,
  PRIMARY KEY (`sale_id`,`payment_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_suspended_payment`
--

LOCK TABLES `sale_suspended_payment` WRITE;
/*!40000 ALTER TABLE `sale_suspended_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_suspended_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire` int(11) DEFAULT NULL,
  `data` longblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('4hu8gubbfb7en8lvnsbs4v9km2',1438420893,'a68718e231e0297c261b39522b39c28c__isAdmin|b:0;employeeid|s:1:\"2\";userid|s:1:\"3\";emp_fullname|s:11:\"Super super\";unique_id|s:13:\"55bc85d639a42\";a68718e231e0297c261b39522b39c28c__id|s:1:\"3\";a68718e231e0297c261b39522b39c28c__name|s:5:\"super\";a68718e231e0297c261b39522b39c28c__states|a:0:{}rpt_saleinv_period|s:9:\"thismonth\";cart|a:1:{i:1;a:9:{s:7:\"item_id\";s:1:\"1\";s:4:\"name\";s:5:\"Kadoa\";s:11:\"item_number\";s:4:\"0001\";s:8:\"quantity\";i:1;s:5:\"price\";d:2;s:8:\"discount\";s:1:\"0\";s:11:\"expire_date\";N;s:11:\"description\";s:0:\"\";s:15:\"unit_measurable\";N;}}payments|a:0:{}totaldiscount|N;totalgst|N;customer|N;salerep|N;saleid|N;pricetier|N;');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT 'system',
  `key` varchar(255) CHARACTER SET utf8 NOT NULL,
  `value` text CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_key` (`category`,`key`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (32,'exchange_rate','USD2KHR','s:4:\"4050\";'),(33,'site','companyName','s:19:\"H-Mart & Restaurant\";'),(34,'site','companyAddress','s:96:\"Telaវេងស្រេង កែងផ្លូវ371ទៅ​BayonTV ស.មានជ័យ \";'),(35,'site','companyPhone','s:9:\"016999963\";'),(36,'site','currencySymbol','s:1:\"$\";'),(37,'site','email','s:14:\"yoyo@gmail.com\";'),(38,'site','returnPolicy','s:93:\"ទំនិញដែលទិញហើយមិនអាចដូរវិញបានទេ\";'),(39,'system','language','s:2:\"en\";'),(40,'system','decimalPlace','s:1:\"2\";'),(41,'sale','saleCookie','s:1:\"1\";'),(42,'sale','receiptPrint','s:1:\"1\";'),(43,'sale','receiptPrintDraftSale','s:0:\"\";'),(44,'sale','touchScreen','s:0:\"\";'),(45,'sale','discount','s:6:\"hidden\";'),(46,'receipt','printcompanyLogo','s:1:\"1\";'),(47,'receipt','printcompanyName','s:1:\"1\";'),(48,'receipt','printcompanyAddress','s:1:\"1\";'),(49,'receipt','printcompanyPhone','s:1:\"1\";'),(50,'receipt','printtransactionTime','s:0:\"\";'),(51,'receipt','printSignature','s:0:\"\";'),(52,'site','companyAddress1','s:0:\"\";'),(53,'receipt','printcompanyAddress1','s:0:\"\";'),(54,'item','itemNumberPerPage','s:2:\"20\";'),(55,'item','itemExpireDate','s:0:\"\";'),(56,'sale','disableConfirmation','s:1:\"1\";'),(57,'site','altcurrencySymbol','s:3:\"៛\";'),(58,'site','priceTax','s:0:\"\";'),(59,'site','tax1Rate','s:0:\"\";');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(60) CHARACTER SET utf8 NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8 NOT NULL,
  `last_name` varchar(30) CHARACTER SET utf8 NOT NULL,
  `mobile_no` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `address1` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `address2` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `country_code` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `notes` text CHARACTER SET utf8,
  `status` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'ABC','ABC','ABC','','','',NULL,NULL,NULL,'','1','2015-07-09 11:49:21','2015-07-09 11:49:21');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_audit_logs`
--

DROP TABLE IF EXISTS `tbl_audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_audit_logs` (
  `unique_id` varbinary(30) DEFAULT NULL,
  `username` varchar(50) CHARACTER SET latin1 NOT NULL,
  `ipaddress` varchar(50) CHARACTER SET latin1 NOT NULL,
  `logtime` datetime NOT NULL,
  `controller` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `action` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `details` text COLLATE utf8mb4_unicode_ci,
  `employee_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_audit_logs`
--

LOCK TABLES `tbl_audit_logs` WRITE;
/*!40000 ALTER TABLE `tbl_audit_logs` DISABLE KEYS */;
INSERT INTO `tbl_audit_logs` VALUES ('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:47:27','dashboard','view',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:47:28','dashboard','AjaxRefresh',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:47:31','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:47:35','item','createImage',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:47:48','item','createImage',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:47:52','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:47:55','item','delete',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:47:55','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:47:57','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:00','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:00','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:05','item','delete',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:05','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:06','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:08','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:17','saleItem','index',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:19','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:21','receivingItem','index',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:24','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:26','receivingItem','index',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:28','receivingItem','index',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:30','request','suggestItemRecv',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:30','request','suggestItemRecv',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:31','request','suggestItemRecv',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:32','request','suggestItemRecv',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:33','request','suggestItemRecv',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:35','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:37','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:39','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:39','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:40','saleItem','index',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:42','request','suggestItem',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:44','saleItem','add',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:48','saleItem','editItem',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:50','saleItem','editItem',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:52','request','suggestClient',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:58','saleItem','AddPayment',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:48:59','saleItem','completeSale',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:02','client','Create',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:05','receivingItem','index',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:08','receivingItem','index',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:10','request','suggestItemRecv',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:10','request','suggestItemRecv',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:10','receivingItem','add',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:12','receivingItem','editItem',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:15','supplier','Create',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:21','receivingItem','index',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:22','receivingItem','index',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:24','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:36','saleItem','index',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:40','saleItem','editItem',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:42','saleItem','AddPayment',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:42','saleItem','completeSale',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:45','saleItem','DeletePayment',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:46','saleItem','AddPayment',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:48','saleItem','completeSale',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:50','saleItem','index',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:49:53','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:50:05','item','admin',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:50:09','item','updateImage',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:50:14','receivingItem','index',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:50:15','request','suggestItemRecv',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:50:15','request','suggestItemRecv',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:50:16','receivingItem','add',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:50:21','receivingItem','editItem',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:50:29','receivingItem','SetComment',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:50:31','receivingItem','index',NULL,2),('559dfcdcc91c5','super','192.168.10.1','2015-07-09 11:50:33','item','admin',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:50:24','dashboard','view',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:50:28','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:50:38','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:50:48','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:50:59','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:51:09','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:51:19','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:51:30','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:51:40','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:51:50','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:52:00','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:52:11','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:52:21','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:52:31','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:52:41','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:52:52','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:53:02','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:53:12','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:53:22','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:53:32','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:53:42','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:53:53','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:54:03','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:54:14','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:54:24','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:54:34','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:54:44','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:54:54','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:55:05','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:55:15','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:55:25','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:55:35','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:55:45','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:55:56','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:56:06','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:56:16','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:56:26','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:56:37','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:56:47','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:56:57','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:57:07','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:57:17','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:57:28','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:57:38','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:57:48','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:57:58','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:58:08','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:58:19','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:58:29','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:58:39','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:58:49','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:58:59','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:59:10','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:59:20','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:59:31','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:59:41','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 00:59:51','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:00:01','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:00:11','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:00:22','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:00:32','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:00:42','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:00:52','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:01:03','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:01:13','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:01:23','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:01:33','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:01:43','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:01:54','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:02:04','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:02:14','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:02:24','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:02:34','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:02:45','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:02:55','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:03:05','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:03:16','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:03:26','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:03:36','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:03:46','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:03:57','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:04:07','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:04:18','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:04:28','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:04:38','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:04:49','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:04:59','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:05:09','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:05:20','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:05:30','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:05:40','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:05:50','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:06:01','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:06:11','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:06:21','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:06:31','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:06:41','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:06:52','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:07:02','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:07:12','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:07:22','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:07:33','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:07:43','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:07:53','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:08:03','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:08:13','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:08:24','dashboard','AjaxRefresh',NULL,2),('55a69d5e07f08','super','192.168.10.1','2015-07-16 01:08:34','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:48:19','dashboard','view',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:48:20','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:48:31','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:48:41','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:48:51','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:49:01','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:49:12','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:49:22','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:49:32','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:49:42','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:49:52','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:50:02','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:50:12','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:50:23','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:50:33','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:50:43','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:50:53','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:51:03','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:51:13','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:51:24','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:51:34','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:51:44','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:51:54','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:52:04','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:52:14','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:52:25','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:52:35','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:52:45','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:52:55','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:53:05','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:53:15','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:53:25','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:53:36','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:53:46','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:53:56','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:54:06','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:54:16','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:54:26','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:54:36','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:54:47','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:54:57','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:55:07','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:55:17','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:55:27','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:55:37','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:55:48','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:55:58','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:56:08','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:56:18','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:56:28','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:56:39','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:56:49','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:56:59','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:57:09','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:57:19','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:57:29','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:57:40','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:57:50','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:58:00','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:58:10','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:58:20','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:58:30','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:58:40','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:58:51','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:59:01','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:59:11','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:59:21','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:59:32','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:59:42','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 12:59:52','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:00:02','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:00:12','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:00:22','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:00:32','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:00:43','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:00:53','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:01:03','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:01:13','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:01:23','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:01:33','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:01:44','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:01:54','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:02:04','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:02:14','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:02:24','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:02:36','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:02:46','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:02:56','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:03:06','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:03:16','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:03:27','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:03:37','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:03:47','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:03:57','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:04:07','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:04:17','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:04:28','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:04:38','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:04:48','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:04:58','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:05:08','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:05:18','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:05:29','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:05:39','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:05:49','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:05:59','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:06:09','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:06:19','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:06:29','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:06:40','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:06:50','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:07:00','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:07:10','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:07:20','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:07:30','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:07:40','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:07:51','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:08:01','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:08:11','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:08:21','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:08:31','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:08:41','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:08:52','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:09:02','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:09:12','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:09:22','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:09:32','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:09:42','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:09:53','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:10:03','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:10:13','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:10:23','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:10:33','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:10:43','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:10:53','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:11:04','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:11:14','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:11:24','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:11:34','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:11:44','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:11:54','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:12:04','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:12:15','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:12:25','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:12:35','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:12:45','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:12:55','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:13:05','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:13:16','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:13:26','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:13:36','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:13:46','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:13:56','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:14:06','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:14:17','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:14:27','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:14:37','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:14:47','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:14:57','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:15:07','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:15:17','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:15:28','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:15:38','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:15:48','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:15:58','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:16:08','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:16:18','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:16:29','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:16:39','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:16:49','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:16:59','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:17:09','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:17:19','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:17:29','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:17:40','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:17:50','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:18:00','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:18:10','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:18:20','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:18:30','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:18:40','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:18:51','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:19:01','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:19:11','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:19:21','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:19:31','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:19:41','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:19:52','dashboard','AjaxRefresh',NULL,2),('55af2ea12bc17','super','192.168.10.1','2015-07-22 13:20:02','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:58:35','dashboard','view',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:58:39','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:58:44','item','admin',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:58:49','receivingItem','index',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:58:52','request','suggestItemRecv',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:58:54','receivingItem','add',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:59:01','receivingItem','deleteItem',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:59:02','item','admin',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:59:05','item','createImage',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:59:13','item','admin',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:59:22','item','admin',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:59:23','item','admin',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:59:24','item','admin',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:59:27','item','admin',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:59:32','item','admin',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:59:33','item','admin',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:59:33','item','admin',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:59:48','receivingItem','index',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:59:50','item','admin',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:59:53','saleItem','index',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 05:59:57','salePayment','index',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:00:01','report','SaleInvoice',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:00:07','report','outstandingInvoice',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:00:12','report','SaleItemSummary',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:00:17','report','SaleReportTab',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:00:20','report','itemExpiry',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:00:32','item','admin',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:00:46','saleItem','index',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:00:49','request','suggestItem',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:00:51','saleItem','add',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:00:53','saleItem','DeleteItem',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:08:43','site','about',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:08:49','dashboard','view',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:08:51','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:08:52','item','admin',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:08:56','salePayment','index',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:08:58','saleItem','index',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:09:00','dashboard','view',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:09:01','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:09:11','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:09:21','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:09:31','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:09:42','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:09:52','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:10:02','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:10:12','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:10:22','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:10:33','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:10:43','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:10:53','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:11:03','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:11:13','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:11:23','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:11:34','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:11:44','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:11:54','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:12:04','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:12:14','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:12:25','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:12:35','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:12:45','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:12:55','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:13:06','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:13:16','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:13:29','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:13:39','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:13:49','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:13:59','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:14:09','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:14:20','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:14:30','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:14:40','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:14:50','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:15:00','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:15:11','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:15:21','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:15:31','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:15:41','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:15:52','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:16:02','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:16:12','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:16:22','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:16:32','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:16:43','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:16:53','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:17:03','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:17:13','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:17:24','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:17:34','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:17:44','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:17:54','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:18:04','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:18:15','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:18:25','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:18:38','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:18:48','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:18:58','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:19:08','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:19:19','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:19:29','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:19:39','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:19:49','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:20:00','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:20:10','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:20:20','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:20:30','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:20:40','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:20:50','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:21:01','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:21:11','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:21:22','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:21:33','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:21:43','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:21:53','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:22:04','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:22:14','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:22:24','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:22:34','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:22:44','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:22:55','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:23:05','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:23:15','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:23:26','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:23:36','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:23:47','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:23:57','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:24:07','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:24:18','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:24:28','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:24:38','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:24:48','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:24:59','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:25:09','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:25:19','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:25:29','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:25:39','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:25:50','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:26:00','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:26:10','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:26:20','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:26:31','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:26:41','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:26:51','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:27:01','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:27:11','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:27:22','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:27:32','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:27:42','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:27:52','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:28:02','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:28:13','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:28:23','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:28:34','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:28:44','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:28:54','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:29:04','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:29:14','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:29:25','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:29:35','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:29:45','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:29:55','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:30:06','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:30:16','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:30:26','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:30:36','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:30:46','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:30:57','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:31:07','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:31:17','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:31:28','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:31:38','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:31:48','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:31:58','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:32:08','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:32:19','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:32:29','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:32:39','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:32:49','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:32:59','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:33:10','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:33:20','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:33:30','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:33:41','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:33:51','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:34:02','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:34:12','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:34:22','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:34:32','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:34:43','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:34:53','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:35:03','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:35:13','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:35:23','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:35:33','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:35:44','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:35:54','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:36:04','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:36:14','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:36:24','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:36:35','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:36:45','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:36:55','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:37:05','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:37:15','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:37:25','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:37:36','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:37:46','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:37:56','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:38:06','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:38:17','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:38:27','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:38:37','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:38:48','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:38:58','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:39:08','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:39:18','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:39:29','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:39:39','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:39:49','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:39:59','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:40:09','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:40:20','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:40:30','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:40:40','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:40:50','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:41:00','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:41:10','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:41:21','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:41:31','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:41:41','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:41:51','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:42:02','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:42:12','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:42:22','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:42:32','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:42:42','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:42:53','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:43:03','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:43:13','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:43:23','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:43:35','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:43:45','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:43:55','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:44:05','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:44:15','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:44:26','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:44:36','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:44:46','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:44:56','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:45:06','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:45:16','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:45:27','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:45:37','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:45:47','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:45:57','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:46:07','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:46:18','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:46:28','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:46:38','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:46:48','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:46:58','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:47:09','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:47:19','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:47:29','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:47:39','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:47:49','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:48:00','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:48:10','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:48:20','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:48:30','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:48:41','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:48:52','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:49:02','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:49:12','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:49:22','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:49:33','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:49:43','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:49:53','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:50:03','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:50:13','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:50:24','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:50:34','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:50:44','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:50:54','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:51:04','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:51:15','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:51:25','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:51:35','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:51:45','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:51:55','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:52:06','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:52:16','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:52:26','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:52:36','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:52:47','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:52:57','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:53:07','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:53:17','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:53:27','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:53:38','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:53:49','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:53:59','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:54:09','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:54:19','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:54:30','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:54:40','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:54:50','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:55:00','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:55:10','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:55:20','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:55:31','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:55:41','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:55:51','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:56:01','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:56:11','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:56:22','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:56:32','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:56:42','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:56:52','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:57:02','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:57:13','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:57:23','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:57:33','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:57:43','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:57:53','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:58:03','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:58:14','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:58:24','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:58:34','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:58:45','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:58:55','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:59:05','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:59:16','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:59:26','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:59:36','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:59:46','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 06:59:57','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:00:07','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:00:17','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:00:27','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:00:37','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:00:48','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:00:58','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:01:08','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:01:18','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:01:28','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:01:38','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:01:49','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:01:59','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:02:09','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:02:19','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:02:30','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:02:40','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:02:50','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:03:00','dashboard','AjaxRefresh',NULL,2),('55b8091928932','super','192.168.10.1','2015-07-29 07:03:11','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:39:53','dashboard','view',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:39:54','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:00','item','admin',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:03','saleItem','index',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:09','report','SaleReportTab',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:12','report','SaleSummary',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:24','report','SaleSummary',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:27','report','SaleSummary',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:35','report','SaleInvoice',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:38','report','SaleInvoice',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:39','report','SaleInvoice',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:42','saleItem','index',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:43','request','suggestItem',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:44','saleItem','add',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:46','saleItem','AddPayment',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:49','saleItem','completeSale',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:51','saleItem','index',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:54','report','SaleReportTab',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:40:57','report','SaleSummary',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:41:07','report','SaleSummarybySaleRep',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:41:15','report','SaleSummarybySaleRep',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:41:20','report','SaleSummarybySaleRep',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:41:28','report','SaleSummarybySaleRep',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:41:29','report','SaleSummarybySaleRep',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:41:29','report','SaleSummarybySaleRep',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:41:30','report','SaleSummarybySaleRep',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:41:31','item','admin',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:41:32','saleItem','index',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:41:34','request','suggestItem',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:41:34','saleItem','add',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:41:35','site','error',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:42:35','report','SaleSummary',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:42:35','report','SaleSummary',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:42:36','report','SaleSummary',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:42:36','report','SaleSummary',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:42:38','report','SaleSummary',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:43:06','report','SaleSummary',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:48:13','report','SaleReportTab',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:48:49','report','SaleSummary',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:50:28','report','SaleSummary',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:51:28','report','SaleSummary',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:51:45','report','SaleSummarybySaleRep',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:52:18','saleItem','index',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:52:19','site','error',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:52:51','site','error',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:53:00','saleItem','ListSuspendedSale',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:53:15','saleItem','index',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:53:16','dashboard','view',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:53:17','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:53:27','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:53:37','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:53:46','dashboard','view',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:53:46','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:53:57','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:53:58','dashboard','view',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:53:58','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:54:06','dashboard','view',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:54:06','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:54:17','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:54:27','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:54:37','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:54:47','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:54:57','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:54:58','dashboard','view',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:54:58','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:55:09','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:55:13','saleItem','index',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:55:16','report','SaleInvoice',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:55:18','report','SaleReportTab',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:55:19','report','outstandingInvoice',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:56:01','report','itemExpiry',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:56:03','report','Inventory',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:56:06','report','SaleItemSummary',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:56:07','report','SaleInvoice',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:56:10','item','admin',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:56:11','dashboard','view',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:56:11','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:56:22','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:56:32','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:56:42','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:56:52','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:57:02','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:57:12','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:57:23','dashboard','AjaxRefresh',NULL,2),('55bc85d639a42','super','192.168.10.1','2015-08-01 15:57:33','dashboard','AjaxRefresh',NULL,2);
/*!40000 ALTER TABLE `tbl_audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `colomn_id` int(2) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `col1` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  KEY `colomn_id` (`colomn_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (01,'Hello4'),(02,'Hello4'),(03,'Hello4'),(04,'Hello4'),(05,'Hello4'),(06,'Hello4'),(07,'Hello4'),(08,'Hello4'),(09,'Hello4'),(10,'Hello4'),(11,'Hello4'),(12,'Hello4'),(13,'Hello4'),(14,'Hello4');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `trans_amount` decimal(15,4) DEFAULT NULL,
  `trans_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trans_datetime` datetime DEFAULT NULL,
  `trans_status` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT 'N',
  `note` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `FK_transactions_account_id` (`account_id`),
  KEY `FK_transactions_employee_id` (`employee_id`),
  CONSTRAINT `FK_transactions_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FK_transactions_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_measurable`
--

DROP TABLE IF EXISTS `unit_measurable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_measurable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_measurable`
--

LOCK TABLES `unit_measurable` WRITE;
/*!40000 ALTER TABLE `unit_measurable` DISABLE KEYS */;
INSERT INTO `unit_measurable` VALUES (1,'KG',NULL,NULL),(2,'ML','2015-06-10 06:26:47','2015-06-10 06:26:47');
/*!40000 ALTER TABLE `unit_measurable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_log`
--

DROP TABLE IF EXISTS `user_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_log` (
  `unique_id` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sessoin_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `login_time` datetime NOT NULL,
  `logout_time` datetime DEFAULT NULL,
  `last_action` timestamp NULL DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `modified_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_log`
--

LOCK TABLES `user_log` WRITE;
/*!40000 ALTER TABLE `user_log` DISABLE KEYS */;
INSERT INTO `user_log` VALUES ('559dfcdcc91c5','hug89eorqrbea08o4s7hkui307',3,2,'2015-07-09 11:47:24','2015-07-09 11:50:54','2015-07-09 04:50:33',0,'2015-07-09 04:50:54','super'),('55a69d5e07f08','brqs2onbutjkek7i3l73ac36t4',3,2,'2015-07-16 00:50:22','2015-07-16 01:08:38','2015-07-15 18:08:34',0,'2015-07-15 18:08:38','super'),('55af2ea12bc17','8dnu7p9erggdssoeed80eqoop1',3,2,'2015-07-22 12:48:17',NULL,'2015-07-22 06:20:02',1,'2015-07-22 05:48:17','super'),('55b8091928932','lt6gro1pm4c4dhv2h28moq5ug0',3,2,'2015-07-29 05:58:33',NULL,'2015-07-29 00:03:11',1,'2015-07-28 22:58:33','super'),('55bc85d639a42','qor0385ph4agj4h397pl2d5lm2',3,2,'2015-08-01 15:39:50',NULL,'2015-08-01 08:57:33',1,'2015-08-01 08:39:50','super');
/*!40000 ALTER TABLE `user_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_outstanding_inv`
--

DROP TABLE IF EXISTS `v_outstanding_inv`;
/*!50001 DROP VIEW IF EXISTS `v_outstanding_inv`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_outstanding_inv` AS SELECT 
 1 AS `client_id`,
 1 AS `client_name`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `invoices`,
 1 AS `balance`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_receiving`
--

DROP TABLE IF EXISTS `v_receiving`;
/*!50001 DROP VIEW IF EXISTS `v_receiving`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_receiving` AS SELECT 
 1 AS `id`,
 1 AS `receive_time`,
 1 AS `supplier_id`,
 1 AS `employee_id`,
 1 AS `sub_total`,
 1 AS `status`,
 1 AS `remark`,
 1 AS `discount_amount`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_receiving_item_sum`
--

DROP TABLE IF EXISTS `v_receiving_item_sum`;
/*!50001 DROP VIEW IF EXISTS `v_receiving_item_sum`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_receiving_item_sum` AS SELECT 
 1 AS `receive_id`,
 1 AS `quantity`,
 1 AS `cost_price`,
 1 AS `unit_price`,
 1 AS `price`,
 1 AS `profit`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_receiving_payment`
--

DROP TABLE IF EXISTS `v_receiving_payment`;
/*!50001 DROP VIEW IF EXISTS `v_receiving_payment`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_receiving_payment` AS SELECT 
 1 AS `receive_id`,
 1 AS `payment_amount`,
 1 AS `give_away`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_sale`
--

DROP TABLE IF EXISTS `v_sale`;
/*!50001 DROP VIEW IF EXISTS `v_sale`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_sale` AS SELECT 
 1 AS `id`,
 1 AS `sale_time`,
 1 AS `client_id`,
 1 AS `employee_id`,
 1 AS `sub_total`,
 1 AS `discount_amount`,
 1 AS `vat`,
 1 AS `vat_amount`,
 1 AS `total`,
 1 AS `status`,
 1 AS `status_f`,
 1 AS `remark`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_sale_item_sum`
--

DROP TABLE IF EXISTS `v_sale_item_sum`;
/*!50001 DROP VIEW IF EXISTS `v_sale_item_sum`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_sale_item_sum` AS SELECT 
 1 AS `sale_id`,
 1 AS `quantity`,
 1 AS `cost_price`,
 1 AS `unit_price`,
 1 AS `price`,
 1 AS `profit`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_sale_payment`
--

DROP TABLE IF EXISTS `v_sale_payment`;
/*!50001 DROP VIEW IF EXISTS `v_sale_payment`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_sale_payment` AS SELECT 
 1 AS `sale_id`,
 1 AS `payment_amount`,
 1 AS `give_away`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_sale_sub`
--

DROP TABLE IF EXISTS `v_sale_sub`;
/*!50001 DROP VIEW IF EXISTS `v_sale_sub`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_sale_sub` AS SELECT 
 1 AS `id`,
 1 AS `sale_time`,
 1 AS `client_id`,
 1 AS `employee_id`,
 1 AS `salerep_id`,
 1 AS `sub_total`,
 1 AS `status`,
 1 AS `status_f`,
 1 AS `remark`,
 1 AS `discount_amount`,
 1 AS `vat`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_sale_summary`
--

DROP TABLE IF EXISTS `v_sale_summary`;
/*!50001 DROP VIEW IF EXISTS `v_sale_summary`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_sale_summary` AS SELECT 
 1 AS `sale_id`,
 1 AS `quantity`,
 1 AS `cost_price`,
 1 AS `unit_price`,
 1 AS `price`,
 1 AS `sum((price-cost_price)*quantity)`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_outstanding_inv`
--

/*!50001 DROP VIEW IF EXISTS `v_outstanding_inv`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`sys`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_outstanding_inv` AS select `s`.`client_id` AS `client_id`,concat(`c`.`first_name`,' ',`c`.`last_name`) AS `client_name`,`c`.`first_name` AS `first_name`,`c`.`last_name` AS `last_name`,count(`s`.`id`) AS `invoices`,sum((`s`.`total` - ifnull(`sp`.`payment_amount`,0))) AS `balance` from ((`v_sale` `s` join `client` `c` on((`s`.`client_id` = `c`.`id`))) left join `v_sale_payment` `sp` on((`sp`.`sale_id` = `s`.`id`))) where ((`s`.`status` = '1') and ((`s`.`total` - ifnull(`sp`.`payment_amount`,0)) > 0)) group by concat(`c`.`first_name`,' ',`c`.`last_name`),`s`.`client_id`,`c`.`first_name`,`c`.`last_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_receiving`
--

/*!50001 DROP VIEW IF EXISTS `v_receiving`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_receiving` AS select `receiving`.`id` AS `id`,`receiving`.`receive_time` AS `receive_time`,`receiving`.`supplier_id` AS `supplier_id`,`receiving`.`employee_id` AS `employee_id`,`receiving`.`sub_total` AS `sub_total`,`receiving`.`status` AS `status`,`receiving`.`remark` AS `remark`,(case when (`receiving`.`discount_type` = '%') then ((`receiving`.`sub_total` * ifnull(`receiving`.`discount_amount`,0)) / 100) else ifnull(`receiving`.`discount_amount`,0) end) AS `discount_amount` from `receiving` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_receiving_item_sum`
--

/*!50001 DROP VIEW IF EXISTS `v_receiving_item_sum`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_receiving_item_sum` AS select `receiving_item`.`receive_id` AS `receive_id`,sum(`receiving_item`.`quantity`) AS `quantity`,sum(`receiving_item`.`cost_price`) AS `cost_price`,sum(`receiving_item`.`unit_price`) AS `unit_price`,sum(`receiving_item`.`price`) AS `price`,sum(((`receiving_item`.`price` - `receiving_item`.`cost_price`) * `receiving_item`.`quantity`)) AS `profit` from `receiving_item` group by `receiving_item`.`receive_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_receiving_payment`
--

/*!50001 DROP VIEW IF EXISTS `v_receiving_payment`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE 
/*!50001 VIEW `v_receiving_payment` AS select `receiving_payment`.`receive_id` AS `receive_id`,sum(`receiving_payment`.`payment_amount`) AS `payment_amount`,sum(`receiving_payment`.`give_away`) AS `give_away` from `receiving_payment` group by `receiving_payment`.`receive_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_sale`
--

/*!50001 DROP VIEW IF EXISTS `v_sale`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE 
/*!50001 VIEW `v_sale` AS select `v_sale_sub`.`id` AS `id`,`v_sale_sub`.`sale_time` AS `sale_time`,`v_sale_sub`.`client_id` AS `client_id`,(case when (`v_sale_sub`.`salerep_id` is not null) then `v_sale_sub`.`salerep_id` else `v_sale_sub`.`employee_id` end) AS `employee_id`,`v_sale_sub`.`sub_total` AS `sub_total`,`v_sale_sub`.`discount_amount` AS `discount_amount`,`v_sale_sub`.`vat` AS `vat`,(((`v_sale_sub`.`sub_total` - `v_sale_sub`.`discount_amount`) * `v_sale_sub`.`vat`) / 100) AS `vat_amount`,((`v_sale_sub`.`sub_total` - `v_sale_sub`.`discount_amount`) + (((`v_sale_sub`.`sub_total` - `v_sale_sub`.`discount_amount`) * `v_sale_sub`.`vat`) / 100)) AS `total`,`v_sale_sub`.`status` AS `status`,`v_sale_sub`.`status_f` AS `status_f`,`v_sale_sub`.`remark` AS `remark` from `v_sale_sub` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_sale_item_sum`
--

/*!50001 DROP VIEW IF EXISTS `v_sale_item_sum`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE 
/*!50001 VIEW `v_sale_item_sum` AS select `sale_item`.`sale_id` AS `sale_id`,sum(`sale_item`.`quantity`) AS `quantity`,sum(`sale_item`.`cost_price`) AS `cost_price`,sum(`sale_item`.`unit_price`) AS `unit_price`,sum(`sale_item`.`price`) AS `price`,sum(((`sale_item`.`price` - `sale_item`.`cost_price`) * `sale_item`.`quantity`)) AS `profit` from `sale_item` group by `sale_item`.`sale_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_sale_payment`
--

/*!50001 DROP VIEW IF EXISTS `v_sale_payment`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE 
/*!50001 VIEW `v_sale_payment` AS select `sale_payment`.`sale_id` AS `sale_id`,sum(`sale_payment`.`payment_amount`) AS `payment_amount`,sum(`sale_payment`.`give_away`) AS `give_away` from `sale_payment` group by `sale_payment`.`sale_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_sale_sub`
--

/*!50001 DROP VIEW IF EXISTS `v_sale_sub`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE 
/*!50001 VIEW `v_sale_sub` AS select `sale`.`id` AS `id`,`sale`.`sale_time` AS `sale_time`,`sale`.`client_id` AS `client_id`,`sale`.`employee_id` AS `employee_id`,`sale`.`salerep_id` AS `salerep_id`,`sale`.`sub_total` AS `sub_total`,`sale`.`status` AS `status`,(case when (`sale`.`status` = '1') then 'Completed' when (`sale`.`status` = '2') then 'Suspended' when (`sale`.`status` = '0') then 'Canceled' else `sale`.`status` end) AS `status_f`,`sale`.`remark` AS `remark`,(case when (`sale`.`discount_type` = '%') then ((`sale`.`sub_total` * ifnull(`sale`.`discount_amount`,0)) / 100) else ifnull(`sale`.`discount_amount`,0) end) AS `discount_amount`,ifnull(`sale`.`vat`,0) AS `vat` from `sale` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_sale_summary`
--

/*!50001 DROP VIEW IF EXISTS `v_sale_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE 
/*!50001 VIEW `v_sale_summary` AS select `sale_item`.`sale_id` AS `sale_id`,sum(`sale_item`.`quantity`) AS `quantity`,sum(`sale_item`.`cost_price`) AS `cost_price`,sum(`sale_item`.`unit_price`) AS `unit_price`,sum(`sale_item`.`price`) AS `price`,sum(((`sale_item`.`price` - `sale_item`.`cost_price`) * `sale_item`.`quantity`)) AS `sum((price-cost_price)*quantity)` from `sale_item` group by `sale_item`.`sale_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-08-02  7:05:09
