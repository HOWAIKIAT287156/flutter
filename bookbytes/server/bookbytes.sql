-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 21, 2023 at 04:19 PM
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
-- Table structure for table `tbl_books`
--

CREATE TABLE `tbl_books` (
  `book_id` int(5) NOT NULL,
  `user_id` varchar(5) NOT NULL,
  `book_isbn` varchar(17) NOT NULL,
  `book_title` varchar(200) NOT NULL,
  `book_desc` varchar(2000) NOT NULL,
  `book_author` varchar(100) NOT NULL,
  `book_price` decimal(6,2) NOT NULL,
  `book_qty` int(5) NOT NULL,
  `book_status` varchar(10) NOT NULL,
  `book_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_books`
--

INSERT INTO `tbl_books` (`book_id`, `user_id`, `book_isbn`, `book_title`, `book_desc`, `book_author`, `book_price`, `book_qty`, `book_status`, `book_date`) VALUES
(1, 'U001', '978-3-16-148410-0', 'Mysteries of the Cosmos', 'Exploring the universe and its wonders.', 'Jane Doe', 25.99, 10, 'New', '2023-01-10 10:00:00.000000'),
(2, 'U002', '978-3-16-148410-1', 'Deep Sea Adventures', 'A journey into the depths of the ocean.', 'John Smith', 15.99, 5, 'Used', '2023-02-15 11:00:00.000000'),
(3, 'U003', '978-3-16-148410-2', 'Mountain Peaks', 'Climbing the world\'s highest mountains.', 'Alice Johnson', 30.50, 7, 'New', '2023-03-20 09:30:00.000000'),
(4, 'U004', '978-3-16-148410-3', 'Ancient Civilizations', 'Discovering the secrets of ancient societies.', 'Bob Brown', 22.50, 4, 'Used', '2023-04-25 08:45:00.000000'),
(5, 'U005', '978-3-16-148410-4', 'Future Tech', 'Innovations that will shape the future.', 'Clara Bell', 40.00, 8, 'New', '2023-05-30 12:30:00.000000'),
(6, 'U006', '978-3-16-148410-5', 'The Art of Cooking', 'Culinary skills and recipes.', 'Daniel Green', 18.75, 6, 'Used', '2023-06-05 14:00:00.000000'),
(7, 'U007', '978-3-16-148410-6', 'World Politics', 'A comprehensive guide to global politics.', 'Eva White', 35.00, 5, 'New', '2023-07-10 16:00:00.000000'),
(8, 'U008', '978-3-16-148410-7', 'Digital Marketing', 'Strategies for online marketing success.', 'Frank Black', 29.99, 3, 'Used', '2023-08-15 17:30:00.000000'),
(9, 'U009', '978-3-16-148410-8', 'Space Exploration', 'Mankind\'s journey into space.', 'Gina Yellow', 45.00, 12, 'New', '2023-09-20 18:45:00.000000'),
(10, 'U010', '978-3-16-148410-9', 'Artificial Intelligence', 'The rise of AI and its impact.', 'Harry Blue', 55.00, 9, 'Used', '2023-10-25 19:00:00.000000'),
(11, 'U011', '978-3-16-148411-0', 'Gardening Basics', 'Fundamentals of gardening and plant care.', 'Irene Violet', 20.00, 10, 'New', '2023-11-30 20:30:00.000000'),
(12, 'U012', '978-3-16-148411-1', 'Photography Tips', 'Mastering the art of photography.', 'Jack Orange', 17.99, 7, 'Used', '2023-12-05 21:45:00.000000'),
(13, 'U013', '978-3-16-148411-2', 'Fitness Fundamentals', 'Guides for staying fit and healthy.', 'Kathy Grey', 23.50, 5, 'New', '2024-01-10 22:00:00.000000'),
(14, 'U014', '978-3-16-148411-3', 'Mindfulness and You', 'Exploring the practice of mindfulness.', 'Leo Red', 16.75, 8, 'Used', '2024-02-15 23:15:00.000000'),
(15, 'U015', '978-3-16-148411-4', 'Urban Gardening', 'Growing plants in urban settings.', 'Mia Pink', 21.25, 6, 'New', '2024-03-20 13:00:00.000000'),
(16, 'U016', '978-3-16-148411-5', 'The History of Music', 'Evolution of music through the ages.', 'Nolan Teal', 32.00, 4, 'Used', '2024-04-25 14:30:00.000000'),
(17, 'U017', '978-3-16-148411-6', 'Programming Basics', 'Introduction to computer programming.', 'Olivia Cyan', 27.99, 9, 'New', '2024-05-30 15:45:00.000000'),
(18, 'U018', '978-3-16-148411-7', 'World Religions', 'A study of various world religions.', 'Paul Maroon', 19.95, 11, 'Used', '2024-06-05 16:00:00.000000'),
(19, 'U019', '978-3-16-148411-8', 'Sustainable Living', 'Practices for a sustainable lifestyle.', 'Quinn Indigo', 33.75, 3, 'New', '2024-07-10 17:15:00.000000'),
(20, 'U020', '978-3-16-148411-9', 'Economic Theories', 'Understanding different economic models.', 'Rachel Lime', 26.50, 2, 'Used', '2024-08-15 18:30:00.000000'),
(21, 'U021', '978-3-16-148412-0', 'Travel the World', 'A guide to globe-trotting adventures.', 'Steve Amber', 29.99, 7, 'New', '2024-09-20 19:45:00.000000'),
(22, 'U022', '978-3-16-148412-1', 'Philosophy Today', 'Modern philosophical thoughts and ideas.', 'Tina Bronze', 24.00, 5, 'Used', '2024-10-25 20:00:00.000000'),
(23, 'U023', '978-3-16-148412-2', 'Mastering Chess', 'Advanced strategies in chess.', 'Uma Chartreuse', 31.25, 8, 'New', '2024-11-30 21:15:00.000000'),
(24, 'U024', '978-3-16-148412-3', 'Baking for Beginners', 'Easy baking recipes for beginners.', 'Victor Fuchsia', 18.50, 10, 'Used', '2024-12-05 22:30:00.000000'),
(25, 'U025', '978-3-16-148412-4', 'Creative Writing', 'Techniques for imaginative writing.', 'Wendy Azure', 34.99, 4, 'New', '2025-01-10 23:45:00.000000');

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
(6, 'heykiat755@gmail.com', '0185767397', 'ThomasHo5', '8cb2237d0679ca88db6464eac60da96345513964', '2023-12-09 18:49:51.516247'),
(14, 'heykiat756@gmail.com', '0185767397', 'ThomasHo6', '20eabe5d64b0e216796e834f52d61fd0b70332fc', '2023-12-09 20:33:53.818513'),
(15, 'heykiat757@gmail.com', '0185767399', 'ThomasHo7', '8cb2237d0679ca88db6464eac60da96345513964', '2023-12-14 18:11:58.160139');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_books`
--
ALTER TABLE `tbl_books`
  ADD PRIMARY KEY (`book_id`),
  ADD UNIQUE KEY `book_isbn` (`book_isbn`);

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
-- AUTO_INCREMENT for table `tbl_books`
--
ALTER TABLE `tbl_books`
  MODIFY `book_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
