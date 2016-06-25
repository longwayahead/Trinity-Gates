-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 25, 2016 at 11:05 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 7.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `open_gate`
--

-- --------------------------------------------------------

--
-- Table structure for table `dates`
--

CREATE TABLE `dates` (
  `id` smallint(6) NOT NULL,
  `date_from` date NOT NULL,
  `date_until` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dates`
--

INSERT INTO `dates` (`id`, `date_from`, `date_until`) VALUES
(1, '1970-01-01', '1970-12-31'),
(2, '1970-06-01', '1970-09-30'),
(3, '1970-10-01', '1970-12-31'),
(4, '1970-01-01', '1970-05-31');

-- --------------------------------------------------------

--
-- Table structure for table `days`
--

CREATE TABLE `days` (
  `id` int(10) UNSIGNED NOT NULL,
  `sun` tinyint(1) NOT NULL DEFAULT '0',
  `mon` tinyint(1) NOT NULL DEFAULT '0',
  `tue` tinyint(1) NOT NULL DEFAULT '0',
  `wed` tinyint(1) NOT NULL DEFAULT '0',
  `thu` tinyint(1) NOT NULL DEFAULT '0',
  `fri` tinyint(1) NOT NULL DEFAULT '0',
  `sat` tinyint(1) NOT NULL DEFAULT '0',
  `hol` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `days`
--

INSERT INTO `days` (`id`, `sun`, `mon`, `tue`, `wed`, `thu`, `fri`, `sat`, `hol`) VALUES
(1, 0, 1, 1, 1, 1, 1, 0, 0),
(2, 1, 0, 0, 0, 0, 0, 1, 1),
(3, 1, 0, 0, 0, 0, 0, 1, 0),
(4, 0, 0, 0, 0, 0, 0, 1, 0),
(5, 1, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `gates`
--

CREATE TABLE `gates` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(30) NOT NULL,
  `latitude` decimal(9,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gates`
--

INSERT INTO `gates` (`id`, `name`, `latitude`, `longitude`) VALUES
(1, 'Front Gate', '53.3444390', '-6.2593630'),
(2, 'Arts Building/Nassau Street', '53.3429625', '-6.2577151'),
(3, 'Lincoln Place', '53.3421640', '-6.2515790'),
(4, 'Pearse Street Gate West', '53.3454510', '-6.2559670'),
(5, 'Moyne Institute', '53.3419420', '-6.2532770'),
(6, 'Pearse Street Gate East', '53.3442870', '-6.2502120');

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `holidays`
--

INSERT INTO `holidays` (`id`, `date`, `name`) VALUES
(1, '2016-01-01', 'New Year''s Day'),
(2, '2016-03-17', 'St. Patrick''s Day'),
(3, '2016-03-27', 'Easter'),
(4, '2016-03-28', 'Easter Monday'),
(5, '2016-05-02', 'Early May Bank Holiday'),
(6, '2016-05-02', 'Labour Day'),
(7, '2016-06-06', 'June Holiday'),
(8, '2016-08-01', 'August Holiday'),
(9, '2016-08-01', 'Summer Bank Holiday'),
(10, '2016-10-31', 'October Holiday'),
(11, '2016-12-25', 'Christmas Day'),
(12, '2016-12-26', 'St. Stephen''s Day'),
(13, '2016-12-27', 'Christmas Day Holiday'),
(14, '2017-01-01', 'New Year''s Day'),
(15, '2017-03-17', 'St. Patrick''s Day'),
(16, '2017-04-16', 'Easter'),
(17, '2017-04-17', 'Easter Monday'),
(18, '2017-05-01', 'Early May Bank Holiday'),
(19, '2017-05-01', 'Labour Day'),
(20, '2017-06-05', 'June Holiday'),
(21, '2017-08-07', 'August Holiday'),
(22, '2017-08-07', 'Summer Bank Holiday'),
(23, '2017-10-30', 'October Holiday'),
(24, '2017-12-25', 'Christmas Day'),
(25, '2017-12-26', 'St. Stephen''s Day'),
(26, '2018-01-01', 'New Year''s Day'),
(27, '2018-03-17', 'St. Patrick''s Day'),
(28, '2018-04-01', 'Easter'),
(29, '2018-04-02', 'Easter Monday'),
(30, '2018-05-07', 'Early May Bank Holiday'),
(31, '2018-05-07', 'Labour Day'),
(32, '2018-06-04', 'June Holiday'),
(33, '2018-08-06', 'August Holiday'),
(34, '2018-08-06', 'Summer Bank Holiday'),
(35, '2018-10-29', 'October Holiday'),
(36, '2018-12-25', 'Christmas Day'),
(37, '2018-12-26', 'St. Stephen''s Day'),
(38, '2019-01-01', 'New Year''s Day'),
(39, '2019-03-17', 'St. Patrick''s Day'),
(40, '2019-04-21', 'Easter'),
(41, '2019-04-22', 'Easter Monday'),
(42, '2019-05-06', 'Early May Bank Holiday'),
(43, '2019-05-06', 'Labour Day'),
(44, '2019-06-03', 'June Holiday'),
(45, '2019-08-05', 'August Holiday'),
(46, '2019-08-05', 'Summer Bank Holiday'),
(47, '2019-10-28', 'October Holiday'),
(48, '2019-12-25', 'Christmas Day'),
(49, '2019-12-26', 'St. Stephen''s Day'),
(50, '2020-01-01', 'New Year''s Day'),
(51, '2020-03-17', 'St. Patrick''s Day'),
(52, '2020-04-12', 'Easter'),
(53, '2020-04-13', 'Easter Monday'),
(54, '2020-05-04', 'Early May Bank Holiday'),
(55, '2020-05-04', 'Labour Day'),
(56, '2020-06-01', 'June Holiday'),
(57, '2020-08-03', 'August Holiday'),
(58, '2020-08-03', 'Summer Bank Holiday'),
(59, '2020-10-26', 'October Holiday'),
(60, '2020-12-25', 'Christmas Day'),
(61, '2020-12-26', 'St. Stephen''s Day'),
(62, '2021-01-01', 'New Year''s Day'),
(63, '2021-03-17', 'St. Patrick''s Day'),
(64, '2021-04-04', 'Easter'),
(65, '2021-04-05', 'Easter Monday'),
(66, '2021-05-03', 'Early May Bank Holiday'),
(67, '2021-05-03', 'Labour Day'),
(68, '2021-06-07', 'June Holiday'),
(69, '2021-08-02', 'August Holiday'),
(70, '2021-08-02', 'Summer Bank Holiday'),
(71, '2021-10-25', 'October Holiday'),
(72, '2021-12-25', 'Christmas Day'),
(73, '2021-12-26', 'St. Stephen''s Day'),
(74, '2021-12-27', 'Christmas Day Holiday');

-- --------------------------------------------------------

--
-- Table structure for table `times`
--

CREATE TABLE `times` (
  `id` int(10) UNSIGNED NOT NULL,
  `gate_id` int(11) NOT NULL,
  `date` mediumint(4) NOT NULL,
  `day` tinyint(2) NOT NULL,
  `time` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `times`
--

INSERT INTO `times` (`id`, `gate_id`, `date`, `day`, `time`) VALUES
(1, 1, 1, 1, 1),
(2, 1, 1, 2, 2),
(5, 2, 1, 1, 3),
(6, 2, 1, 4, 11),
(7, 2, 2, 5, 4),
(8, 2, 3, 5, 5),
(9, 3, 1, 1, 1),
(10, 3, 1, 2, 11),
(11, 4, 1, 1, 6),
(12, 4, 1, 2, 7),
(13, 5, 1, 1, 2),
(14, 6, 1, 1, 8),
(15, 6, 1, 4, 9),
(16, 6, 1, 5, 10),
(18, 2, 4, 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `time_blocks`
--

CREATE TABLE `time_blocks` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `time_from` time NOT NULL,
  `time_until` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `time_blocks`
--

INSERT INTO `time_blocks` (`id`, `time_from`, `time_until`) VALUES
(1, '07:00:00', '23:59:59'),
(2, '08:00:00', '17:59:59'),
(3, '08:00:00', '22:29:59'),
(4, '09:30:00', '23:59:59'),
(5, '11:30:00', '23:59:59'),
(6, '08:00:00', '09:59:59'),
(7, '16:00:00', '18:29:59'),
(8, '06:45:00', '23:29:59'),
(9, '08:00:00', '23:29:59'),
(10, '08:00:00', '18:59:59'),
(11, '08:00:00', '23:59:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dates`
--
ALTER TABLE `dates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `days`
--
ALTER TABLE `days`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gates`
--
ALTER TABLE `gates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `times`
--
ALTER TABLE `times`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `time_blocks`
--
ALTER TABLE `time_blocks`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dates`
--
ALTER TABLE `dates`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `days`
--
ALTER TABLE `days`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `gates`
--
ALTER TABLE `gates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;
--
-- AUTO_INCREMENT for table `times`
--
ALTER TABLE `times`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `time_blocks`
--
ALTER TABLE `time_blocks`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
