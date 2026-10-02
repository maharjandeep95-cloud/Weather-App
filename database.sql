-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Generation Time: May 23, 2026 at 04:22 AM
-- Server version: 11.4.10-MariaDB
-- PHP Version: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `weather_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `weather`
--

CREATE TABLE `weather` (
  `cityName` varchar(100) NOT NULL,
  `timedate` timestamp NOT NULL DEFAULT current_timestamp(),
  `temperature` float NOT NULL,
  `description` varchar(255) NOT NULL,
  `humidity` float NOT NULL,
  `pressure` float NOT NULL,
  `windspeed` float NOT NULL,
  `direction` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `weather`
--

INSERT INTO `weather` (`cityName`, `timedate`, `temperature`, `description`, `humidity`, `pressure`, `windspeed`, `direction`) VALUES
('Bhaktapur', '2026-05-09 12:35:48', 18.08, 'light rain', 94, 1012, 1.03, '0'),
('Dudley', '2026-05-23 04:12:21', 13.56, 'broken clouds', 90, 1025, 1.44, '296'),
('Goa', '2026-05-20 05:00:12', 29.21, 'overcast clouds', 64, 1011, 2.94, '223'),
('Kathmandu', '2026-05-09 12:35:59', 18.12, 'broken clouds', 94, 1012, 1.03, '0'),
('London', '2026-05-23 05:54:24', 19.32, 'broken clouds', 76, 1025, 2.06, '220'),
('Patan', '2026-05-09 12:35:54', 18.21, 'light rain', 94, 1012, 1.03, '0'),
('Seoul', '2026-05-20 05:00:22', 15.76, 'moderate rain', 100, 1009, 5.14, '80'),
('Sydney', '2026-05-23 08:11:04', 16.55, 'drizzle', 91, 1025, 0.45, '221');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `weather`
--
ALTER TABLE `weather`
  ADD UNIQUE KEY `cityName` (`cityName`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
