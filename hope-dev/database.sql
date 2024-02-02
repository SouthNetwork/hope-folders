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

CREATE TABLE IF NOT EXISTS `almirante_carry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police` varchar(255) DEFAULT '0',
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `nuser_name` varchar(255) DEFAULT '0',
  `date` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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

CREATE TABLE IF NOT EXISTS `bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(20) NOT NULL DEFAULT 0,
  `value` int(20) NOT NULL DEFAULT 0,
  `mode` varchar(50) DEFAULT 'Private',
  `owner` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE IF NOT EXISTS `banneds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(50) NOT NULL,
  `time` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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

CREATE TABLE IF NOT EXISTS `chests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `weight` int(10) NOT NULL DEFAULT 0,
  `perm` varchar(50) NOT NULL,
  `logs` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE IF NOT EXISTS `entitydata` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`dkey`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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

CREATE TABLE IF NOT EXISTS `playerdata` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`user_id`,`dkey`),
  KEY `user_id` (`user_id`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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