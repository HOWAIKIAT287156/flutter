-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2023 at 12:12 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookbytes`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id` int(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `contact` varchar(30) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`id`, `email`, `contact`, `username`, `password`, `date`) VALUES
(1, 'heykiat750@gmail.com', '0185767392', 'ThomasHo', '8cb2237d0679ca88db6464eac60da96345513964', '2023-12-07 21:51:20.699673'),
(2, 'heykiat751@gmail.com', '0185767393', 'ThomasHo', '8cb2237d0679ca88db6464eac60da96345513964', '2023-12-08 18:06:14.411119'),
(3, 'heykiat752@gmail.com', '0185767394', 'ThomasHo2', '8cb2237d0679ca88db6464eac60da96345513964', '2023-12-08 20:16:24.694550'),
(4, 'heykiat753@gmail.com', '0185767395', 'ThomasHo3', '8cb2237d0679ca88db6464eac60da96345513964', '2023-12-08 22:56:19.510458'),
(5, 'heykiat754@gmail.com', '0185767396', 'ThomasHo4', '8cb2237d0679ca88db6464eac60da96345513964', '2023-12-09 13:18:02.646443'),
(6, 'heykiat755@gmail.com', '0185767397', 'ThomasHo5', '8cb2237d0679ca88db6464eac60da96345513964', '2023-12-09 18:49:51.516247');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
