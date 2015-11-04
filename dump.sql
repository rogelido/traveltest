-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Temps de generació: 01-11-2015 a les 06:38:54
-- Versió del servidor: 5.5.28
-- Versió de PHP: 5.4.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de dades: `travel`
--

-- --------------------------------------------------------

--
-- Estructura de la taula `apartments`
--

CREATE TABLE IF NOT EXISTS `apartments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `availableRooms` smallint(5) unsigned NOT NULL,
  `adultCapacity` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Bolcant dades de la taula `apartments`
--

INSERT INTO `apartments` (`id`, `availableRooms`, `adultCapacity`) VALUES
(1, 10, 4),
(2, 50, 6),
(3, 25, 3);

-- --------------------------------------------------------

--
-- Estructura de la taula `hotels`
--

CREATE TABLE IF NOT EXISTS `hotels` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `stars` tinyint(1) unsigned NOT NULL DEFAULT '3',
  `standardRoom_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `standardRoom_id` (`standardRoom_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Bolcant dades de la taula `hotels`
--

INSERT INTO `hotels` (`id`, `stars`, `standardRoom_id`) VALUES
(1, 3, 3),
(2, 4, 2),
(3, 3, 1),
(4, 5, 2),
(5, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de la taula `stablishments`
--

CREATE TABLE IF NOT EXISTS `stablishments` (
  `id` mediumint(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `prov` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `type_id` smallint(5) unsigned NOT NULL,
  `concreteSt_id` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

--
-- Bolcant dades de la taula `stablishments`
--

INSERT INTO `stablishments` (`id`, `name`, `city`, `prov`, `type_id`, `concreteSt_id`) VALUES
(1, 'Azul', 'Valencia', 'Valencia', 2, 1),
(2, 'Beach', 'Almería', 'Almería', 1, 1),
(3, 'Blanco', 'Mojácar', 'Almería', 2, 2),
(4, 'Rojo', 'Sanlúcar', 'Cádiz', 2, 3),
(5, 'Sol y playa', 'Málaga', 'Málaga', 1, 2),
(6, 'Azucena', 'Dénia', 'Alicante', 2, 4),
(7, 'Azúcar', 'Castellón', 'Castellón', 2, 1),
(8, '烗猀珖', 'Beijing', 'Beiging', 2, 5),
(9, 'وايرلندا', 'Casablanca', 'Casablanca', 1, 3);

-- --------------------------------------------------------

--
-- Estructura de la taula `stablishtypes`
--

CREATE TABLE IF NOT EXISTS `stablishtypes` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `tableName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Bolcant dades de la taula `stablishtypes`
--

INSERT INTO `stablishtypes` (`id`, `name`, `tableName`) VALUES
(1, 'Apartamentos', 'apartments'),
(2, 'Hotel', 'hotels');

-- --------------------------------------------------------

--
-- Estructura de la taula `standardrooms`
--

CREATE TABLE IF NOT EXISTS `standardrooms` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `adultCapacity` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `individualUse` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `hasViews` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `hasHydro` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `hasSuppletory` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `hasMatrimonialBed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Bolcant dades de la taula `standardrooms`
--

INSERT INTO `standardrooms` (`id`, `description`, `adultCapacity`, `individualUse`, `hasViews`, `hasHydro`, `hasSuppletory`, `hasMatrimonialBed`) VALUES
(1, 'habitación sencilla', 1, 1, 0, 0, 0, 0),
(2, 'habitación doble', 2, 0, 0, 0, 0, 0),
(3, 'habitación doble con vistas', 2, 0, 1, 0, 0, 1);

--
-- Restriccions per taules bolcades
--

--
-- Restriccions per la taula `hotels`
--
ALTER TABLE `hotels`
  ADD CONSTRAINT `hotels_ibfk_1` FOREIGN KEY (`standardRoom_id`) REFERENCES `standardrooms` (`id`) ON UPDATE CASCADE;

--
-- Restriccions per la taula `stablishments`
--
ALTER TABLE `stablishments`
  ADD CONSTRAINT `stablishments_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `stablishtypes` (`id`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
