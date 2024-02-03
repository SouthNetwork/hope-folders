-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.32-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para hope
CREATE DATABASE IF NOT EXISTS `hope` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `hope`;

-- Copiando estrutura para tabela hope.accounts
CREATE TABLE IF NOT EXISTS `accounts` (
  `whitelist` tinyint(1) NOT NULL DEFAULT 0,
  `chars` int(10) NOT NULL DEFAULT 1,
  `gems` int(20) NOT NULL DEFAULT 0,
  `premium` int(20) NOT NULL DEFAULT 0,
  `priority` int(3) NOT NULL DEFAULT 0,
  `discord` varchar(50) NOT NULL DEFAULT '0',
  `steam` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`steam`) USING BTREE,
  KEY `steam` (`steam`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela hope.accounts: ~1 rows (aproximadamente)
INSERT INTO `accounts` (`whitelist`, `chars`, `gems`, `premium`, `priority`, `discord`, `steam`) VALUES
	(1, 1, 240, 1709473782, 50, '0', '11000015b9c8ce1');

-- Copiando estrutura para tabela hope.almirante_carry
CREATE TABLE IF NOT EXISTS `almirante_carry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police` varchar(255) DEFAULT '0',
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `nuser_name` varchar(255) DEFAULT '0',
  `date` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela hope.almirante_carry: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela hope.almirante_prison
CREATE TABLE IF NOT EXISTS `almirante_prison` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police` varchar(255) DEFAULT '0',
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `services` int(11) NOT NULL DEFAULT 0,
  `fines` int(20) NOT NULL DEFAULT 0,
  `text` longtext DEFAULT NULL,
  `ongoingServices` int(11) NOT NULL DEFAULT 0,
  `date` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela hope.almirante_prison: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela hope.almirante_wanted
CREATE TABLE IF NOT EXISTS `almirante_wanted` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police` varchar(255) DEFAULT '0',
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `nuser_name` varchar(50) DEFAULT 'Indigente',
  `description` longtext DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `date` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela hope.almirante_wanted: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela hope.bank
CREATE TABLE IF NOT EXISTS `bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(20) NOT NULL DEFAULT 0,
  `value` int(20) NOT NULL DEFAULT 0,
  `mode` varchar(50) DEFAULT 'Private',
  `owner` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela hope.bank: ~0 rows (aproximadamente)
INSERT INTO `bank` (`id`, `user_id`, `value`, `mode`, `owner`) VALUES
	(1, 1, 55000, 'Private', 1);

-- Copiando estrutura para tabela hope.banneds
CREATE TABLE IF NOT EXISTS `banneds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(50) NOT NULL,
  `time` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela hope.banneds: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela hope.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(50) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `serial` varchar(6) DEFAULT NULL,
  `name` varchar(50) DEFAULT 'Individuo',
  `name2` varchar(50) DEFAULT 'Indigente',
  `locate` varchar(10) NOT NULL DEFAULT 'Sul',
  `sex` varchar(1) NOT NULL DEFAULT 'M',
  `blood` int(1) NOT NULL DEFAULT 1,
  `fines` int(20) NOT NULL DEFAULT 0,
  `garage` int(3) NOT NULL DEFAULT 3,
  `prison` int(11) NOT NULL DEFAULT 0,
  `port` int(1) NOT NULL DEFAULT 0,
  `deleted` int(1) NOT NULL DEFAULT 0,
  `paypal` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela hope.characters: ~0 rows (aproximadamente)
INSERT INTO `characters` (`id`, `steam`, `phone`, `serial`, `name`, `name2`, `locate`, `sex`, `blood`, `fines`, `garage`, `prison`, `port`, `deleted`, `paypal`) VALUES
	(1, '11000015b9c8ce1', '261-124', 'AOF872', 'Klaus', 'Hargreeves', 'Sul', 'M', 2, 0, 3, 0, 0, 0, 0);

-- Copiando estrutura para tabela hope.chests
CREATE TABLE IF NOT EXISTS `chests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `weight` int(10) NOT NULL DEFAULT 0,
  `perm` varchar(50) NOT NULL,
  `logs` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela hope.chests: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela hope.entitydata
CREATE TABLE IF NOT EXISTS `entitydata` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`dkey`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela hope.entitydata: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela hope.fidentity
CREATE TABLE IF NOT EXISTS `fidentity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `name2` varchar(50) NOT NULL DEFAULT '',
  `locate` varchar(10) NOT NULL DEFAULT 'Sul',
  `port` int(1) NOT NULL DEFAULT 1,
  `blood` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela hope.fidentity: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela hope.investments
CREATE TABLE IF NOT EXISTS `investments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL DEFAULT 0,
  `Liquid` int(20) NOT NULL DEFAULT 0,
  `Monthly` int(20) NOT NULL DEFAULT 0,
  `Deposit` int(20) NOT NULL DEFAULT 0,
  `Last` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela hope.investments: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela hope.invoices
CREATE TABLE IF NOT EXISTS `invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL DEFAULT 0,
  `Received` int(10) NOT NULL DEFAULT 0,
  `Type` varchar(50) NOT NULL,
  `Reason` longtext NOT NULL,
  `Holder` varchar(50) NOT NULL,
  `Value` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela hope.invoices: ~0 rows (aproximadamente)
INSERT INTO `invoices` (`id`, `user_id`, `Received`, `Type`, `Reason`, `Holder`, `Value`) VALUES
	(11, 1, 1, 'received', 'Teste', 'Klaus Hargreeves', 1500),
	(12, 1, 1, 'sent', 'Teste', 'Você', 1500);

-- Copiando estrutura para tabela hope.playerdata
CREATE TABLE IF NOT EXISTS `playerdata` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`user_id`,`dkey`),
  KEY `user_id` (`user_id`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela hope.playerdata: ~0 rows (aproximadamente)
INSERT INTO `playerdata` (`user_id`, `dkey`, `dvalue`) VALUES
	(1, 'Barbershop', '[0,0,0,0,0,0,0,0,21,29,34,0,0,0,0,0,0,2,10,0,3,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21]'),
	(1, 'Clothings', '{"glass":{"texture":0,"item":0},"shoes":{"texture":0,"item":0},"tshirt":{"texture":0,"item":1},"arms":{"texture":0,"item":0},"decals":{"texture":0,"item":0},"watch":{"texture":0,"item":-1},"accessory":{"texture":0,"item":0},"hat":{"texture":0,"item":-1},"ear":{"texture":0,"item":-1},"bracelet":{"texture":0,"item":-1},"backpack":{"texture":0,"item":0},"mask":{"texture":0,"item":0},"vest":{"texture":0,"item":0},"pants":{"texture":0,"item":0},"torso":{"texture":0,"item":0}}'),
	(1, 'Datatable', '{"weight":30,"armour":100,"inventory":{"7":{"amount":1,"item":"emptybottle"},"6":{"amount":461,"item":"dollars"},"1":{"amount":2,"item":"water"},"3":{"amount":1,"item":"cellphone-1706873013"},"2":{"amount":2,"item":"sandwich"},"5":{"amount":100,"item":"gemstone"},"4":{"amount":1,"item":"identity-1"}},"hunger":100,"skin":1885233650,"thirst":100,"experience":0,"health":200,"stress":2,"oxigen":100,"perm":{"Admin":true},"position":{"z":74.22,"y":-178.68,"x":914.02}}'),
	(1, 'weaponAmmos', '[]'),
	(1, 'weaponAttachs', '[]');

-- Copiando estrutura para tabela hope.prison
CREATE TABLE IF NOT EXISTS `prison` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police` varchar(255) DEFAULT '0',
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `services` int(11) NOT NULL DEFAULT 0,
  `fines` int(20) NOT NULL DEFAULT 0,
  `text` longtext DEFAULT NULL,
  `date` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela hope.prison: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela hope.propertys
CREATE TABLE IF NOT EXISTS `propertys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT 'Homes0001',
  `interior` varchar(50) NOT NULL DEFAULT 'Middle',
  `tax` int(20) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `price` int(20) NOT NULL DEFAULT 0,
  `residents` int(1) NOT NULL DEFAULT 1,
  `vault` int(10) NOT NULL DEFAULT 1,
  `fridge` int(10) NOT NULL DEFAULT 1,
  `owner` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela hope.propertys: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela hope.races
CREATE TABLE IF NOT EXISTS `races` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `raceid` int(3) NOT NULL DEFAULT 0,
  `user_id` int(5) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT 'Individuo Indigente',
  `vehicle` varchar(50) NOT NULL DEFAULT 'Sultan RS',
  `points` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela hope.races: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela hope.taxs
CREATE TABLE IF NOT EXISTS `taxs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL DEFAULT 0,
  `Name` varchar(50) NOT NULL,
  `Date` varchar(50) NOT NULL,
  `Hour` varchar(50) NOT NULL,
  `Value` int(11) NOT NULL,
  `Message` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela hope.taxs: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela hope.transactions
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL DEFAULT 0,
  `Type` varchar(50) NOT NULL,
  `Date` varchar(50) NOT NULL,
  `Value` int(11) NOT NULL,
  `Balance` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47003 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela hope.transactions: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela hope.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `tax` int(20) NOT NULL DEFAULT 0,
  `plate` varchar(20) DEFAULT NULL,
  `rental` int(20) NOT NULL DEFAULT 0,
  `rendays` int(11) NOT NULL DEFAULT 0,
  `arrest` int(20) NOT NULL DEFAULT 0,
  `engine` int(4) NOT NULL DEFAULT 1000,
  `body` int(4) NOT NULL DEFAULT 1000,
  `fuel` int(3) NOT NULL DEFAULT 100,
  `nitro` int(3) NOT NULL DEFAULT 0,
  `work` varchar(5) NOT NULL DEFAULT 'false',
  `doors` varchar(254) NOT NULL,
  `windows` varchar(254) NOT NULL,
  `tyres` varchar(254) NOT NULL,
  PRIMARY KEY (`user_id`,`vehicle`),
  KEY `user_id` (`user_id`),
  KEY `vehicle` (`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela hope.vehicles: ~1 rows (aproximadamente)
INSERT INTO `vehicles` (`user_id`, `vehicle`, `tax`, `plate`, `rental`, `rendays`, `arrest`, `engine`, `body`, `fuel`, `nitro`, `work`, `doors`, `windows`, `tyres`) VALUES
	(1, 'acuransx', 1707484279, '17CGE774', 1709471479, 0, 0, 805, 865, 93, 0, 'false', '{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false}', '{"1":1,"2":false,"3":false,"4":false,"5":false,"0":1}', '{"1":false,"2":true,"3":true,"4":true,"5":true,"6":true,"7":true,"0":true}'),
	(1, 'taxi', 1707488088, '96XPS866', 0, 0, 0, 943, 936, 89, 0, 'true', '{"1":false,"2":false,"3":false,"4":false,"5":false,"0":false}', '{"1":1,"2":1,"3":1,"4":false,"5":false,"0":1}', '{"1":false,"2":true,"3":true,"4":false,"5":false,"6":false,"7":false,"0":false}');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
