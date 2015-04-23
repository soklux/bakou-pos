/*
SQLyog Ultimate v8.82 
MySQL - 5.5.40-0ubuntu0.14.04.1 : Database - bakou_pos
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `AuthAssignment` */

DROP TABLE IF EXISTS `AuthAssignment`;

CREATE TABLE `AuthAssignment` (
  `itemname` varchar(64) CHARACTER SET latin1 NOT NULL,
  `userid` varchar(64) CHARACTER SET latin1 NOT NULL,
  `bizrule` text CHARACTER SET latin1,
  `data` text CHARACTER SET latin1,
  PRIMARY KEY (`itemname`,`userid`),
  CONSTRAINT `FK_AuthAssignment` FOREIGN KEY (`itemname`) REFERENCES `AuthItem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `AuthAssignment` */

insert  into `AuthAssignment`(`itemname`,`userid`,`bizrule`,`data`) values ('client.create','2',NULL,NULL),('client.create','3',NULL,NULL),('client.delete','2',NULL,NULL),('client.delete','3',NULL,NULL),('client.index','2',NULL,NULL),('client.index','3',NULL,NULL),('client.update','2',NULL,NULL),('client.update','3',NULL,NULL),('employee.create','2',NULL,NULL),('employee.create','3',NULL,NULL),('employee.delete','2',NULL,NULL),('employee.delete','3',NULL,NULL),('employee.index','2',NULL,NULL),('employee.index','3',NULL,NULL),('employee.update','2',NULL,NULL),('employee.update','3',NULL,NULL),('invoice.delete','3',NULL,NULL),('invoice.index','3',NULL,NULL),('invoice.print','3',NULL,NULL),('item.create','2',NULL,NULL),('item.create','3',NULL,NULL),('item.delete','2',NULL,NULL),('item.delete','3',NULL,NULL),('item.index','2',NULL,NULL),('item.index','3',NULL,NULL),('item.update','2',NULL,NULL),('item.update','3',NULL,NULL),('payment.index','3',NULL,NULL),('receiving.edit','2',NULL,NULL),('report.index','2',NULL,NULL),('report.index','3',NULL,NULL),('sale.discount','2',NULL,NULL),('sale.discount','3',NULL,NULL),('sale.edit','2',NULL,NULL),('sale.edit','3',NULL,NULL),('sale.editprice','2',NULL,NULL),('sale.editprice','3',NULL,NULL),('store.update','2',NULL,NULL),('store.update','3',NULL,NULL),('supplier.create','2',NULL,NULL),('supplier.create','3',NULL,NULL),('supplier.delete','2',NULL,NULL),('supplier.delete','3',NULL,NULL),('supplier.index','2',NULL,NULL),('supplier.index','3',NULL,NULL),('supplier.update','2',NULL,NULL),('supplier.update','3',NULL,NULL),('transaction.adjustin','3',NULL,NULL),('transaction.adjustout','3',NULL,NULL),('transaction.count','3',NULL,NULL),('transaction.receive','3',NULL,NULL),('transaction.return','3',NULL,NULL),('transaction.transfer','3',NULL,NULL);

/*Table structure for table `AuthItem` */

DROP TABLE IF EXISTS `AuthItem`;

CREATE TABLE `AuthItem` (
  `name` varchar(64) CHARACTER SET latin1 NOT NULL,
  `type` int(11) NOT NULL,
  `description` text CHARACTER SET latin1,
  `bizrule` text CHARACTER SET latin1,
  `data` text CHARACTER SET latin1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `AuthItem` */

insert  into `AuthItem`(`name`,`type`,`description`,`bizrule`,`data`) values ('client.create',0,'Create Client',NULL,'N;'),('client.delete',0,'Delete Client',NULL,'N;'),('client.index',0,'List Client',NULL,'N;'),('client.update',0,'Update Client',NULL,'N;'),('employee.create',0,'Create Employee',NULL,NULL),('employee.delete',0,'Delete Employee',NULL,NULL),('employee.index',0,'List Employee',NULL,NULL),('employee.update',0,'Update Employee',NULL,NULL),('invoice.delete',0,'Cancel Invoice',NULL,'N;'),('invoice.index',0,'List Invoice',NULL,'N;'),('invoice.print',0,'Re-print Invoice',NULL,'N;'),('invoice.update',0,'Update Invoice',NULL,'N;'),('item.create',0,'Create Item',NULL,NULL),('item.delete',0,'Delete Item',NULL,NULL),('item.index',0,'List Item',NULL,NULL),('item.update',0,'Update Item',NULL,NULL),('itemAdmin',1,'Administer Item',NULL,'N;'),('payment.index',0,'Invoice Payment (Debt)',NULL,NULL),('receiving.edit',0,'Process Purchase orders',NULL,'N;'),('report.index',0,'View and generate reports',NULL,'N;'),('sale.discount',0,'Sale Give Discount',NULL,'N;'),('sale.edit',0,'Edit Sale',NULL,'N;'),('sale.editprice',0,'Edit Sale Price',NULL,'N;'),('setting.exchangerate',0,'Exchange Rate',NULL,NULL),('setting.receipt',0,'Receipt Setting',NULL,NULL),('setting.sale',0,'Sale Setting',NULL,NULL),('setting.site',0,'Shop Setting',NULL,NULL),('setting.system',0,'System Setting',NULL,NULL),('store.update',0,'Change the store\'s configuration',NULL,'N;'),('supplier.create',0,'Create Supplier',NULL,NULL),('supplier.delete',0,'Delete Supplier',NULL,NULL),('supplier.index',0,'List Supplier',NULL,NULL),('supplier.update',0,'Update Supplier',NULL,NULL),('transaction.adjustin',0,'Adjustment In',NULL,NULL),('transaction.adjustout',0,'Adjustment Out',NULL,NULL),('transaction.count',0,'Physical Count',NULL,NULL),('transaction.receive',0,'Receive from Supplier',NULL,NULL),('transaction.return',0,'Return to Supplier',NULL,NULL),('transaction.transfer',0,'Transfer to (Another Branch)',NULL,NULL);

/*Table structure for table `AuthItemChild` */

DROP TABLE IF EXISTS `AuthItemChild`;

CREATE TABLE `AuthItemChild` (
  `parent` varchar(64) CHARACTER SET latin1 NOT NULL,
  `child` varchar(64) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `AuthItemChild` */

/*Table structure for table `account` */

DROP TABLE IF EXISTS `account`;

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

/*Data for the table `account` */

/*Table structure for table `account_receivable` */

DROP TABLE IF EXISTS `account_receivable`;

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

/*Data for the table `account_receivable` */

/*Table structure for table `account_receivable_supplier` */

DROP TABLE IF EXISTS `account_receivable_supplier`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `account_receivable_supplier` */

/*Table structure for table `account_supplier` */

DROP TABLE IF EXISTS `account_supplier`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `account_supplier` */

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `category` */

/*Table structure for table `client` */

DROP TABLE IF EXISTS `client`;

CREATE TABLE `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `last_name` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `mobile_no` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `address1` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `address2` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `country_code` varchar(2) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `notes` text CHARACTER SET utf8,
  `status` varchar(1) CHARACTER SET utf8 DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `client` */

/*Table structure for table `currency_type` */

DROP TABLE IF EXISTS `currency_type`;

CREATE TABLE `currency_type` (
  `code` int(11) NOT NULL AUTO_INCREMENT,
  `currency_id` char(3) CHARACTER SET utf8 NOT NULL,
  `currency_name` varchar(70) CHARACTER SET utf8 NOT NULL,
  `currency_symbol` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `currency_type` */

insert  into `currency_type`(`code`,`currency_id`,`currency_name`,`currency_symbol`,`sort_order`) values (1,'USD','United States Dollar','$',NULL),(2,'KHR','Kampuchea Riel','៛',NULL),(3,'THB','Thai Baht','฿',NULL);

/*Table structure for table `employee` */

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `mobile_no` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `adddress1` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `address2` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `country_code` varchar(2) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `notes` text CHARACTER SET utf8,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `employee` */

insert  into `employee`(`id`,`first_name`,`last_name`,`mobile_no`,`adddress1`,`address2`,`city_id`,`country_code`,`email`,`notes`) values (1,'Owner','System','012999068','','',NULL,'','',''),(2,'super','pos','012878878','super addresss1','super address',NULL,'','','');

/*Table structure for table `employee_image` */

DROP TABLE IF EXISTS `employee_image`;

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

/*Data for the table `employee_image` */

/*Table structure for table `exchange_rate` */

DROP TABLE IF EXISTS `exchange_rate`;

CREATE TABLE `exchange_rate` (
  `base_currency` varchar(3) NOT NULL,
  `to_currency` varchar(3) NOT NULL,
  `base_cur_val` double(15,2) NOT NULL,
  `to_cur_val` double(15,2) NOT NULL,
  PRIMARY KEY (`base_currency`,`to_currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `exchange_rate` */

/*Table structure for table `inventory` */

DROP TABLE IF EXISTS `inventory`;

CREATE TABLE `inventory` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_items` int(11) NOT NULL,
  `trans_user` int(11) NOT NULL,
  `trans_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trans_comment` text CHARACTER SET utf8 NOT NULL,
  `trans_inventory` double(15,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`trans_id`),
  KEY `FK_inventory_item_id` (`trans_items`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `inventory` */

/*Table structure for table `item` */

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `item_number` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `cost_price` double(15,4) DEFAULT NULL,
  `unit_price` double(15,4) DEFAULT NULL,
  `quantity` double(15,2) NOT NULL,
  `reorder_level` double(15,2) DEFAULT NULL,
  `location` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `allow_alt_description` tinyint(1) DEFAULT NULL,
  `is_serialized` tinyint(1) DEFAULT NULL,
  `description` text CHARACTER SET utf8,
  `status` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `created_date` datetime DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `is_expire` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_item_category_id` (`category_id`),
  KEY `FK_item_supplier_id` (`supplier_id`),
  CONSTRAINT `FK_item` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `item` */

/*Table structure for table `item_expire` */

DROP TABLE IF EXISTS `item_expire`;

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

/*Data for the table `item_expire` */

insert  into `item_expire`(`id`,`item_id`,`mfd_date`,`expire_date`,`quantity`) values (5,3,NULL,'1970-01-01','2.00'),(6,8,NULL,'1970-01-01','19.00'),(7,1,NULL,'0000-00-00','10.00'),(8,3,NULL,'2020-01-20','1.00'),(9,5,NULL,'2019-01-20','1.00'),(10,14,NULL,'2020-01-01','1.00'),(11,41,NULL,'2020-01-01','10.00');

/*Table structure for table `item_expire_dt` */

DROP TABLE IF EXISTS `item_expire_dt`;

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

/*Data for the table `item_expire_dt` */

insert  into `item_expire_dt`(`id`,`item_expire_id`,`trans_id`,`trans_qty`,`trans_comment`,`modified_date`,`employee_id`) values (5,5,27,'2.00','Receive from Supplier 27','2014-10-28 04:00:41',38),(6,6,27,'19.00','Receive from Supplier 27','2014-10-28 04:00:41',38),(7,7,28,'10.00','Receive from Supplier 28','2014-10-28 04:03:01',38),(8,8,29,'1.00','Receive from Supplier 29','2014-10-28 04:04:50',38),(9,9,29,'1.00','Receive from Supplier 29','2014-10-28 04:04:50',38),(10,10,30,'1.00','Receive from Supplier 30','2014-11-09 00:20:20',38),(11,11,34,'10.00','Receive from Supplier 34','2014-11-11 02:44:59',38);

/*Table structure for table `item_image` */

DROP TABLE IF EXISTS `item_image`;

CREATE TABLE `item_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `photo` blob NOT NULL,
  `thumbnail` blob,
  `filename` varchar(30) CHARACTER SET latin1 NOT NULL,
  `filetype` varchar(15) CHARACTER SET latin1 DEFAULT NULL,
  `path` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `width` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `height` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_item_image_item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `item_image` */

/*Table structure for table `item_price` */

DROP TABLE IF EXISTS `item_price`;

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `item_price` */

insert  into `item_price`(`id`,`item_id`,`employee_id`,`old_price`,`new_price`,`modified_date`) values (5,1,38,1.5000,2.5000,NULL),(6,2,38,1.7000,2.7000,NULL),(7,3,38,0.7000,0.9000,'2014-10-28 03:59:09'),(8,4,38,0.7000,0.1400,'2014-10-28 03:59:09'),(9,8,38,3.0000,5.0000,'2014-10-28 04:00:41');

/*Table structure for table `item_price_promo` */

DROP TABLE IF EXISTS `item_price_promo`;

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

/*Data for the table `item_price_promo` */

/*Table structure for table `item_price_promo_dt` */

DROP TABLE IF EXISTS `item_price_promo_dt`;

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

/*Data for the table `item_price_promo_dt` */

/*Table structure for table `item_price_tier` */

DROP TABLE IF EXISTS `item_price_tier`;

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

/*Data for the table `item_price_tier` */

/*Table structure for table `price_tier` */

DROP TABLE IF EXISTS `price_tier`;

CREATE TABLE `price_tier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tier_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `status` varchar(4) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `price_tier` */

insert  into `price_tier`(`id`,`tier_name`,`modified_date`,`deleted`) values (1,'Corporate','2014-10-21 00:05:59',0),(2,'Organization','2014-10-21 00:41:46',0);

/*Table structure for table `rbac_user` */

DROP TABLE IF EXISTS `rbac_user`;

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

/*Data for the table `rbac_user` */

insert  into `rbac_user`(`id`,`user_name`,`group_id`,`employee_id`,`user_password`,`deleted`,`status`,`date_entered`,`modified_date`,`created_by`) values (2,'admin',NULL,1,'$2a$08$6Bpd5qGSPhB5dehzcrje4eYbfeTmxKI6WI8AgnamWSJyC4nAYNES6',0,1,NULL,'2014-02-15 11:31:55',NULL),(3,'super',NULL,2,'$2a$08$/BW7UO.1LsTvZc5kfMtcyeFYbod45/8vM7ECJ6cYfnp8FFQ81NBlG',0,1,'2013-10-10 09:44:04','2014-05-06 16:35:34',NULL);

/*Table structure for table `receiving` */

DROP TABLE IF EXISTS `receiving`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `receiving` */

/*Table structure for table `receiving_item` */

DROP TABLE IF EXISTS `receiving_item`;

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

/*Data for the table `receiving_item` */

insert  into `receiving_item`(`receive_id`,`item_id`,`description`,`line`,`quantity`,`cost_price`,`unit_price`,`price`,`discount_amount`,`discount_type`) values (13,3,NULL,3,10.00,0.5000,0.7000,0.7000,0.00,'%'),(13,5,NULL,5,10.00,1.5000,2.0000,2.0000,0.00,'%'),(20,1,NULL,1,20.00,2.0000,1.5000,2.5000,0.00,'%'),(20,2,NULL,2,20.00,2.0000,1.7000,2.7000,0.00,'%'),(21,1,NULL,1,3.00,2.0000,2.5000,2.5000,0.00,'%'),(21,2,NULL,2,5.00,2.0000,2.7000,2.7000,0.00,'%'),(22,1,NULL,1,2.00,2.0000,2.5000,2.5000,0.00,'%'),(22,2,NULL,2,2.00,2.0000,2.7000,2.7000,0.00,'%'),(23,1,NULL,1,10.00,2.0000,2.5000,2.5000,0.00,'%'),(23,4,NULL,4,10.00,0.5000,0.7000,0.7000,0.00,'%'),(24,3,NULL,3,2.00,0.5000,0.7000,0.7000,0.00,'%'),(24,5,NULL,5,1.00,1.5000,2.0000,2.0000,0.00,'%'),(25,2,NULL,2,3.00,2.0000,2.7000,2.7000,0.00,'%'),(25,3,NULL,3,4.00,0.5000,0.7000,0.7000,0.00,'%'),(25,4,NULL,4,2.00,0.5000,0.7000,0.7000,0.00,'%'),(25,5,NULL,5,1.00,1.5000,2.0000,2.0000,0.00,'%'),(26,1,NULL,1,1.00,2.0000,2.5000,2.5000,0.00,'%'),(26,3,NULL,3,1.00,0.8000,0.7000,0.9000,0.00,'%'),(26,4,NULL,4,10.00,0.9000,0.7000,0.1400,0.00,'%'),(27,3,NULL,3,2.00,0.8000,0.9000,0.9000,0.00,'%'),(27,8,NULL,8,19.00,2.0000,3.0000,5.0000,0.00,'%'),(28,1,NULL,1,10.00,2.0000,2.5000,2.5000,0.00,'%'),(29,3,NULL,3,1.00,0.8000,0.9000,0.9000,0.00,'%'),(29,5,NULL,5,1.00,1.5000,2.0000,2.0000,0.00,'%'),(30,13,NULL,13,1.00,3.2000,5.5000,5.5000,0.00,'%'),(30,14,NULL,14,1.00,1.4000,2.2000,2.2000,0.00,'%'),(31,7,NULL,7,1.00,4.5000,5.5000,5.5000,0.00,'%'),(31,58,NULL,58,1.00,3.2000,3.8000,3.8000,0.00,'%'),(32,29,NULL,29,1.00,1.8000,2.7000,2.7000,0.00,'%'),(32,65,NULL,65,1.00,3.3000,5.5000,5.5000,0.00,'%'),(33,58,NULL,58,1.00,3.2000,3.8000,3.8000,0.00,'%'),(33,63,NULL,63,1.00,2.2000,3.5000,3.5000,0.00,'%'),(34,5,NULL,5,50.00,2.0000,4.5000,4.5000,0.00,'%'),(34,41,NULL,41,10.00,2.5000,3.5000,3.5000,0.00,'%'),(34,48,NULL,48,20.00,2.5000,3.5000,3.5000,0.00,'%'),(34,58,NULL,58,40.00,3.2000,3.8000,3.8000,0.00,'%'),(34,65,NULL,65,30.00,3.3000,5.5000,5.5000,0.00,'%');

/*Table structure for table `sale` */

DROP TABLE IF EXISTS `sale`;

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
  PRIMARY KEY (`id`),
  KEY `FK_sale_emp_id` (`employee_id`),
  KEY `FK_sale_client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `sale` */

/*Table structure for table `sale_client_cookie` */

DROP TABLE IF EXISTS `sale_client_cookie`;

CREATE TABLE `sale_client_cookie` (
  `client_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `description` text,
  `quantity` double(15,2) NOT NULL,
  `cost_price` double(15,4) DEFAULT NULL,
  `unit_price` double(15,4) DEFAULT NULL,
  `price` double(15,4) DEFAULT NULL,
  `discount_amount` decimal(15,2) DEFAULT NULL,
  `discount_type` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`client_id`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sale_client_cookie` */

/*Table structure for table `sale_item` */

DROP TABLE IF EXISTS `sale_item`;

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

/*Data for the table `sale_item` */

/*Table structure for table `sale_payment` */

DROP TABLE IF EXISTS `sale_payment`;

CREATE TABLE `sale_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_id` int(11) NOT NULL,
  `payment_type` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `payment_amount` double NOT NULL,
  `give_away` double DEFAULT NULL,
  `date_paid` datetime DEFAULT NULL,
  `note` text CHARACTER SET utf8,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sale_payment_sale_id` (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `sale_payment` */

/*Table structure for table `sale_suspended` */

DROP TABLE IF EXISTS `sale_suspended`;

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

/*Data for the table `sale_suspended` */

/*Table structure for table `sale_suspended_item` */

DROP TABLE IF EXISTS `sale_suspended_item`;

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

/*Data for the table `sale_suspended_item` */

/*Table structure for table `sale_suspended_payment` */

DROP TABLE IF EXISTS `sale_suspended_payment`;

CREATE TABLE `sale_suspended_payment` (
  `sale_id` int(11) NOT NULL,
  `payment_type` varchar(40) CHARACTER SET utf8 NOT NULL,
  `payment_amount` double NOT NULL,
  PRIMARY KEY (`sale_id`,`payment_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `sale_suspended_payment` */

/*Table structure for table `settings` */

DROP TABLE IF EXISTS `settings`;

CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT 'system',
  `key` varchar(255) CHARACTER SET utf8 NOT NULL,
  `value` text CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_key` (`category`,`key`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `settings` */

insert  into `settings`(`id`,`category`,`key`,`value`) values (32,'exchange_rate','USD2KHR','s:4:\"4000\";'),(33,'site','companyName','s:12:\"Bakou System\";'),(34,'site','companyAddress','s:26:\"St. Fortune, Ratana Plazza\";'),(35,'site','companyPhone','s:11:\"85512777007\";'),(36,'site','currencySymbol','s:1:\"$\";'),(37,'site','email','s:14:\"yoyo@gmail.com\";'),(38,'site','returnPolicy','s:93:\"ទំនិញដែលទិញហើយមិនអាចដូរវិញបានទេ\";'),(39,'system','language','s:2:\"en\";'),(40,'system','decimalPlace','s:1:\"2\";'),(41,'sale','saleCookie','s:1:\"0\";'),(42,'sale','receiptPrint','s:1:\"1\";'),(43,'sale','receiptPrintDraftSale','s:0:\"\";'),(44,'sale','touchScreen','s:0:\"\";'),(45,'sale','discount','s:6:\"hidden\";'),(46,'receipt','printcompanyLogo','s:1:\"1\";'),(47,'receipt','printcompanyName','s:1:\"1\";'),(48,'receipt','printcompanyAddress','s:1:\"1\";'),(49,'receipt','printcompanyPhone','s:1:\"1\";'),(50,'receipt','printtransactionTime','s:0:\"\";'),(51,'receipt','printSignature','s:0:\"\";'),(52,'site','companyAddress1','s:20:\"Phnom Penh, Cambodia\";'),(53,'receipt','printcompanyAddress1','s:1:\"1\";'),(54,'item','itemNumberPerPage','s:2:\"20\";'),(55,'item','itemExpireDate','s:0:\"\";'),(56,'sale','disableConfirmation','s:1:\"1\";');

/*Table structure for table `supplier` */

DROP TABLE IF EXISTS `supplier`;

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `supplier` */

/*Table structure for table `tbl_audit_logs` */

DROP TABLE IF EXISTS `tbl_audit_logs`;

CREATE TABLE `tbl_audit_logs` (
  `username` varchar(50) CHARACTER SET latin1 NOT NULL,
  `ipaddress` varchar(50) CHARACTER SET latin1 NOT NULL,
  `logtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `controller` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `action` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `details` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `tbl_audit_logs` */

/*Table structure for table `transactions` */

DROP TABLE IF EXISTS `transactions`;

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

/*Data for the table `transactions` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
