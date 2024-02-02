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