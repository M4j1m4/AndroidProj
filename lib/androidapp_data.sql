-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 26, 2024 at 07:37 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `androidapp_data`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`id`, `username`, `password`) VALUES
(1, 'khenabesamis', 'khen1421001');

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `id` int(11) NOT NULL,
  `subjectCode` varchar(100) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `Units` int(11) NOT NULL,
  `Prelim` int(11) NOT NULL,
  `Midterm` int(11) NOT NULL,
  `Prefinals` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grades`
--

INSERT INTO `grades` (`id`, `subjectCode`, `Description`, `Units`, `Prelim`, `Midterm`, `Prefinals`) VALUES
(1, 'CPE224', 'Software Design - Systems Analysis & Design', 4, 88, 86, 90),
(2, 'CPE321', 'Computer Networks & Security', 4, 89, 91, 90),
(4, 'CPE322', 'Microprocessor & Microcontroller Systems', 4, 90, 88, 90),
(5, 'CPE323', 'CPE Laws, Contracts, Ethics & Prof Practice', 3, 85, 92, 90),
(6, 'ELE321a', 'Elective 3 - Software Engineering', 3, 92, 100, 90),
(7, 'ESC005', 'Occupational Health & Safety Engineering', 3, 92, 92, 90),
(8, 'ESC006', 'Technopreneurship', 3, 96, 94, 90);

-- --------------------------------------------------------

--
-- Table structure for table `irregstudents`
--

CREATE TABLE `irregstudents` (
  `id` int(11) NOT NULL,
  `age` int(11) NOT NULL,
  `name` int(11) NOT NULL,
  `year_level` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `khen_studyplan`
--

CREATE TABLE `khen_studyplan` (
  `id` int(11) NOT NULL,
  `courseCode` varchar(100) NOT NULL,
  `courseTitle` varchar(100) NOT NULL,
  `units` int(11) NOT NULL,
  `LEC` int(11) NOT NULL,
  `LAB` int(11) NOT NULL,
  `Prerequisite/Corequisite` varchar(100) NOT NULL,
  `Grade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `khen_studyplan`
--

INSERT INTO `khen_studyplan` (`id`, `courseCode`, `courseTitle`, `units`, `LEC`, `LAB`, `Prerequisite/Corequisite`, `Grade`) VALUES
(1, 'ESC005', 'OCCUPATIONAL HEALTH & SAFETY ENGINEERING', 3, 3, 3, 'None', 92),
(2, 'CPE321', 'COMPUTER NETWORKS & SECURITY', 4, 3, 3, 'CPE312', 94),
(3, 'CPE322', 'MICROPROCESSOR & MICROCONTROLLER SYSTEMS', 4, 3, 3, 'CPE311', 91),
(4, 'ESC006', 'TECHNOPRENEURSHIP', 3, 3, 0, 'None', 90),
(5, 'CPE323', 'CPE LAWS, CONTRACTS, ETHICS & PROF PRACTICE', 3, 3, 0, 'None', 93),
(6, 'ELE321', 'SOFTWARE ENGINEERING', 3, 2, 3, 'None', 95),
(7, 'CPE224', 'SOFTWARE DESIGN', 4, 3, 3, 'None', 94),
(8, 'CPE323', 'Microprocessor & Microcontroller Systems', 4, 3, 3, 'None', 96);

-- --------------------------------------------------------

--
-- Table structure for table `regstudents`
--

CREATE TABLE `regstudents` (
  `id` int(11) NOT NULL,
  `age` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `year_level` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `regstudents`
--

INSERT INTO `regstudents` (`id`, `age`, `name`, `year_level`) VALUES
(1, 21, 'Khen Abesamis', '3rd Year');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `id` int(11) NOT NULL,
  `subjectCode` varchar(100) NOT NULL,
  `section` int(11) NOT NULL,
  `description` text NOT NULL,
  `day` varchar(20) NOT NULL,
  `from` int(11) NOT NULL,
  `to` int(11) NOT NULL,
  `room` varchar(50) NOT NULL,
  `faculty` text NOT NULL,
  `blockNo` varchar(50) NOT NULL,
  `classType` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`id`, `subjectCode`, `section`, `description`, `day`, `from`, `to`, `room`, `faculty`, `blockNo`, `classType`) VALUES
(1, 'CPE224', 1, 'Software Design - Systems Analysis & Design', 'W', 700, 1000, 'M201', 'RONALD FERNANDEZ', '232-BSCOE-31', 'F2F'),
(2, 'CPE224', 1, 'Software Design - Systems Analysis & Design', 'TF', 1430, 1600, 'M205', 'RONALD FERNANDEZ', '232-BSCOE-31', 'F2F'),
(3, 'CPE321', 1, 'Computer Networks & Security', 'S', 1730, 2030, 'N305', 'DOROTHY JOY TONGOL', '232-BSCOE-31', 'F2F'),
(4, 'CPE322', 1, 'Microprocessor & Microcontroller Systems', 'S', 1030, 1330, 'N305', 'KARL ANGEL GAMBOA', '232-BSCOE-31', 'F2F'),
(5, 'CPE323', 1, 'CPE Laws, Contracts, Ethics & Prof Practice', 'W', 1030, 1330, 'N305', 'LHORELIE ARCEGA', '232-BSCOE-31', 'F2F'),
(6, 'ELE321a', 1, 'Elective 3 - Software Engineering', 'MTh', 730, 830, 'N305', 'ELSA PASCUAL', '232-BSCOE-31', 'F2F'),
(7, 'ESC005', 1, 'Occupational Health & Safety Engineering', 'MTh', 1000, 1130, 'N305', 'PALMER DE LEON', '232-BSCOE-31', 'F2F');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `khen_studyplan`
--
ALTER TABLE `khen_studyplan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `regstudents`
--
ALTER TABLE `regstudents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `grades`
--
ALTER TABLE `grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `khen_studyplan`
--
ALTER TABLE `khen_studyplan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `regstudents`
--
ALTER TABLE `regstudents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
