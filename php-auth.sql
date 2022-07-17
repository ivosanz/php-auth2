-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 17, 2022 at 06:46 PM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.3.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `php`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` mediumint(9) NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(250) NOT NULL,
  `phone` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `email`, `phone`) VALUES
(2, 'paul', 'paul@hotmail.com', ''),
(3, 'mark', 'mark@hotmail.com', ''),
(4, 'kris', 'kris@gmail.com', ''),
(5, 'ivan', 'ivan@gmail.com', ''),
(6, 'harry', 'harry@yahoo.com', ''),
(7, 'lion', 'lion@yahoo.com', ''),
(8, 'telma', 'telma@hotmail.com', ''),
(9, 'owen', 'owen@aol.com', ''),
(10, 'warren', 'warren@hotmail.com', ''),
(11, 'becky', 'becky@yahoo.com', ''),
(12, 'jack', 'jack@yahoo.com', ''),
(13, 'erin', 'erin@gmail.com', ''),
(14, 'sandy', 'sandy@aol.com', ''),
(15, 'zack', 'zack@hotmail.com', '');

-- --------------------------------------------------------

--
-- Table structure for table `contacts_personal`
--

CREATE TABLE `contacts_personal` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `contactsID` mediumint(8) UNSIGNED NOT NULL,
  `userID` mediumint(8) UNSIGNED NOT NULL,
  `dateAdded` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contacts_personal`
--

INSERT INTO `contacts_personal` (`id`, `contactsID`, `userID`, `dateAdded`) VALUES
(37, 6, 8, '2022-07-17 18:32:24'),
(39, 10, 8, '2022-07-17 18:32:29'),
(41, 14, 8, '2022-07-17 18:32:57'),
(44, 13, 8, '2022-07-17 18:34:12'),
(47, 8, 8, '2022-07-17 18:37:59'),
(50, 4, 8, '2022-07-17 18:42:48'),
(51, 2, 8, '2022-07-17 18:42:51');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(249) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `username` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `verified` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `resettable` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `roles_mask` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `registered` int(10) UNSIGNED NOT NULL,
  `last_login` int(10) UNSIGNED DEFAULT NULL,
  `force_logout` mediumint(7) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `username`, `status`, `verified`, `resettable`, `roles_mask`, `registered`, `last_login`, `force_logout`) VALUES
(8, 'ivosanz18@gmail.com', '$2y$10$uyZ93adXtsYsjTfGOQtvb.pXlqdzLNdDsTZO80vNapnBCZFfXlcQC', 'ivosanz', 0, 1, 1, 0, 1658075382, 1658075450, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users_confirmations`
--

CREATE TABLE `users_confirmations` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `email` varchar(249) COLLATE utf8mb4_unicode_ci NOT NULL,
  `selector` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `expires` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users_remembered`
--

CREATE TABLE `users_remembered` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user` int(10) UNSIGNED NOT NULL,
  `selector` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `expires` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users_resets`
--

CREATE TABLE `users_resets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user` int(10) UNSIGNED NOT NULL,
  `selector` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `expires` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users_throttling`
--

CREATE TABLE `users_throttling` (
  `bucket` varchar(44) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `tokens` float UNSIGNED NOT NULL,
  `replenished_at` int(10) UNSIGNED NOT NULL,
  `expires_at` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users_throttling`
--

INSERT INTO `users_throttling` (`bucket`, `tokens`, `replenished_at`, `expires_at`) VALUES
('cErkUtJuIk5x9xsMVlvVUCpE8Yf7Rw_PRkfxxKC09AE', 499, 1658075423, 1658248223),
('OMhkmdh1HUEdNPRi-Pe4279tbL5SQ-WMYf551VVvH8U', 19, 1658075423, 1658111423),
('xvGDpCSPQNi0cPqdALfFSWdSDuqrCE1ZUdOl7hdejsY', 29, 1658075383, 1658147383),
('We1C-SZl_Ta2FjbiX8txb5tARYIlClM9UJbVERt9hq0', 29, 1658075383, 1658147383),
('HIJQJPUQ2qyyTt0Q7_AuZA0pXm27czJnqpJsoA5IFec', 49, 1658075383, 1658147383),
('PZ3qJtO_NLbJfRIP-8b4ME4WA3xxc6n9nbCORSffyQ0', 4, 1658075383, 1658507383),
('QduM75nGblH2CDKFyk0QeukPOwuEVDAUFE54ITnHM38', 70.0189, 1658075450, 1658615450);

-- --------------------------------------------------------



--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contacts_personal`
--
ALTER TABLE `contacts_personal`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `contactsID` (`contactsID`,`userID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `users_confirmations`
--
ALTER TABLE `users_confirmations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `selector` (`selector`),
  ADD KEY `email_expires` (`email`,`expires`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users_remembered`
--
ALTER TABLE `users_remembered`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `selector` (`selector`),
  ADD KEY `user` (`user`);

--
-- Indexes for table `users_resets`
--
ALTER TABLE `users_resets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `selector` (`selector`),
  ADD KEY `user_expires` (`user`,`expires`);

--
-- Indexes for table `users_throttling`
--
ALTER TABLE `users_throttling`
  ADD PRIMARY KEY (`bucket`),
  ADD KEY `expires_at` (`expires_at`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `contacts_personal`
--
ALTER TABLE `contacts_personal`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users_confirmations`
--
ALTER TABLE `users_confirmations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users_remembered`
--
ALTER TABLE `users_remembered`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users_resets`
--
ALTER TABLE `users_resets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
