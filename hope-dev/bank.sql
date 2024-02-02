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
