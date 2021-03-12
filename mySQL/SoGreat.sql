-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 11, 2021 at 10:00 AM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `SoGreat`
--

-- --------------------------------------------------------

--
-- Table structure for table `carTABLE`
--

CREATE TABLE `carTABLE` (
  `id` int(11) NOT NULL,
  `idShowroom` text COLLATE utf8_unicode_ci NOT NULL,
  `BrandName` text COLLATE utf8_unicode_ci NOT NULL,
  `ModelName` text COLLATE utf8_unicode_ci NOT NULL,
  `PathImage` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `carTABLE`
--

INSERT INTO `carTABLE` (`id`, `idShowroom`, `BrandName`, `ModelName`, `PathImage`) VALUES
(1, '$Showroom', '$BrandName', '$ModelName', '$PathImage'),
(2, '31', 'Benz AMG', 'Mercedes AMG C 43', '/SoGreat/Car/MercedesAMGC43.jpg'),
(3, '$idShowRoom', '$BandName', '$ModelName', '$PathImage'),
(4, '31', '', '', ''),
(5, '2', '', '', ''),
(6, '31', '', '', ''),
(7, '31', 'Benz AMG', 'Mercedes AMG C 44', '/SoGreat/Car/MercedesAMGC43.jpg'),
(8, '21', 'Ferrari', 'Ferrari abc', '/SoGreat/Car/MercedesAMGC43.jpg'),
(9, '32', 'Lamboghini', 'Lamboghini01', '-'),
(10, '32', 'Lamboghini', 'Lamboghini02', '-');

-- --------------------------------------------------------

--
-- Table structure for table `userTABLE`
--

CREATE TABLE `userTABLE` (
  `id` int(11) NOT NULL,
  `Name` text COLLATE utf8_unicode_ci NOT NULL,
  `User` text COLLATE utf8_unicode_ci NOT NULL,
  `Password` text COLLATE utf8_unicode_ci NOT NULL,
  `Phone` text COLLATE utf8_unicode_ci NOT NULL,
  `Gender` text COLLATE utf8_unicode_ci NOT NULL,
  `Country` text COLLATE utf8_unicode_ci NOT NULL,
  `URLImage` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `userTABLE`
--

INSERT INTO `userTABLE` (`id`, `Name`, `User`, `Password`, `Phone`, `Gender`, `Country`, `URLImage`) VALUES
(10, 'ฟฟฟฟฟฟ', 'LadyKaka@gmail.com', '1234', '11111111111', '', '', '/SoGreat/Profile/editProfile75955.jpg'),
(20, '$Name', '$User', '$Password', '$Phone', '', '', '$URLImage'),
(21, 'SexyLadyThailand', 'Bubee', '1234', '0841494979', 'Male', 'Thailand', '/SoGreat/Profile/editProfile7443.jpg'),
(22, '$Name', '$User', '$Password', '$Phone', '$Gender', '$Country', '$URLImage'),
(23, 'Nadol', 'Nadol', '1234', '0841494979', 'Male', 'England', 'http://192.168.64.2/SoGreat/Profile/editProfile94035.jpg'),
(24, 'iPhone', 'iPhone', '1234', 'null', 'null', 'null', 'http://192.168.64.2/SoGreat/Profile/profile153282.jpg'),
(25, 'tung', 'tung', '1234', 'null', 'null', 'null', 'http://192.168.64.2/SoGreat/Profile/profile208563.jpg'),
(26, 'tungjai', 'tungjai', '1234', 'null', 'null', 'null', 'http://192.168.64.2/SoGreat/Profile/profile315991.jpg'),
(27, 'bonus', 'bonus', '1111', 'null', 'null', 'null', 'https://a34b3b89f9fe.ngrok.io/SoGreat/Profile/profile171721.jpg'),
(28, 'bonus', 'bonus', '1111', 'null', 'null', 'null', 'https://a34b3b89f9fe.ngrok.io/SoGreat/Profile/profile81971.jpg'),
(29, 'bonus', 'bonus', '1111', 'null', 'null', 'null', 'https://a34b3b89f9fe.ngrok.io/SoGreat/Profile/profile840941.jpg'),
(30, 'bonus', 'bonus', '1111', 'null', 'null', 'null', 'https://a34b3b89f9fe.ngrok.io/SoGreat/Profile/profile236563.jpg'),
(31, 'bonus2', 'bonus2', '1234', '01234', 'Male', 'Thailand', '/SoGreat/Profile/profile644574.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carTABLE`
--
ALTER TABLE `carTABLE`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userTABLE`
--
ALTER TABLE `userTABLE`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carTABLE`
--
ALTER TABLE `carTABLE`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `userTABLE`
--
ALTER TABLE `userTABLE`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
