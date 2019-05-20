SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


DROP TABLE IF EXISTS `dorm`;
CREATE TABLE IF NOT EXISTS `dorm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` mediumtext NOT NULL,
  `address` varchar(255) NOT NULL,
  `capacity` int(11) NOT NULL,
  `img` varchar(255) NOT NULL,
  `administrator` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

INSERT INTO `dorm` (`id`, `name`, `description`, `address`, `capacity`, `img`, `administrator`, `phone`, `email`) VALUES
(1, 'Dom Studencki AMICUS', 'Łączna liczba miejsc noclegowych wynosi 596. Pokoje dwuosobowe, połączone po 2 w tzw. boksy ze wspólnym węzłem sanitarnym, wyposażone w łącze internetowe.', 'ul. Chopina 55\r\n71-450 Szczecin', 596, '', 'mgr Teresa Towarnicka', '914496485', 'amicus@zut.edu.pl');

DROP TABLE IF EXISTS `floor`;
CREATE TABLE IF NOT EXISTS `floor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) NOT NULL,
  `img` varchar(255) NOT NULL,
  `dorm_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dorm_id` (`dorm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

INSERT INTO `floor` (`id`, `number`, `img`, `dorm_id`) VALUES
(1, 0, '', 1),
(2, 1, '', 1),
(3, 2, '', 1),
(4, 3, '', 1),
(5, 4, '', 1),
(6, 5, '', 1);

DROP TABLE IF EXISTS `room`;
CREATE TABLE IF NOT EXISTS `room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `type` int(11) NOT NULL,
  `floor_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `floor_id` (`floor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

INSERT INTO `room` (`id`, `number`, `capacity`, `status`, `type`, `floor_id`) VALUES
(1, 101, 2, 0, 0, 1),
(2, 102, 2, 1, 0, 1),
(3, 103, 2, 0, 0, 1),
(4, 104, 2, 1, 0, 1),
(5, 105, 2, 1, 0, 1),
(6, 106, 2, 1, 0, 1),
(7, 107, 2, 1, 0, 1),
(8, 108, 2, 0, 1, 1),
(9, 109, 2, 1, 0, 1),
(10, 110, 1, 1, 0, 1);

DROP TABLE IF EXISTS `room_details`;
CREATE TABLE IF NOT EXISTS `room_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fridge` tinyint(1) NOT NULL,
  `shared_bathroom` tinyint(1) NOT NULL,
  `shared_kitchen` tinyint(1) NOT NULL,
  `room_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `room_id` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

INSERT INTO `room_details` (`id`, `fridge`, `shared_bathroom`, `shared_kitchen`, `room_id`) VALUES
(1, 1, 1, 0, 1),
(2, 1, 1, 0, 2),
(3, 1, 1, 0, 3),
(4, 1, 1, 0, 4),
(5, 1, 1, 0, 5),
(6, 1, 1, 0, 6),
(7, 1, 1, 0, 7),
(8, 1, 1, 0, 8),
(9, 1, 1, 0, 9),
(10, 1, 1, 0, 10);


ALTER TABLE `floor`
  ADD CONSTRAINT `floor_ibfk_1` FOREIGN KEY (`dorm_id`) REFERENCES `dorm` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_2` FOREIGN KEY (`floor_id`) REFERENCES `floor` (`id`);

ALTER TABLE `room_details`
  ADD CONSTRAINT `room_details_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
