-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 10, 2023 at 07:56 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(50) NOT NULL,
  `name` text NOT NULL,
  `phone_num` int(50) NOT NULL,
  `msg` text NOT NULL,
  `date` date NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `phone_num`, `msg`, `date`, `email`) VALUES
(1, 'sddsf', 1234567890, 'fvfdgdgdf', '2023-01-01', 'firstpost@gmail.com'),
(18, 'test1', 2147483647, 'dsfdfd dssdf dsf sd fsdf ', '2023-01-02', 'dfsd@gmail.com'),
(19, 'test1', 2147483647, 'dsfsdfsdfsdfdsf', '2023-01-02', 'dfsd@gmail.com'),
(20, 'test1', 2147483647, 'dsfsdfsdfsdfdsf', '2023-01-02', 'dfsd@gmail.com'),
(21, 'test1', 2147483647, 'fdgdfgdgddg', '2023-01-02', 'dfsd@gmail.com'),
(22, 'dfsdfds', 1234567890, 'fgfgfdg g dfgd fgdfg ', '2023-01-02', 'dfsd@gmail.com'),
(23, 'test1', 1234567890, 'd f', '2023-01-02', 'sakhare@gmail.com'),
(24, 'test1', 0, 'dfdsffsdfdsf', '2023-01-02', 'test1@yaho.com'),
(25, 'test1', 2147483647, 'sdd sd asd sad ', '2023-01-02', 'dfsd@gmail.com'),
(26, 'test1', 2147483647, 'sdd sd asd sad ', '2023-01-02', 'dfsd@gmail.com'),
(27, 'dfsdfds', 1234567890, 'dds dsf dsf dsf ds fdf d ', '2023-01-02', 'dfsd@gmail.com'),
(28, 'dfsdfds', 1234567890, 'dds dsf dsf dsf ds fdf d ', '2023-01-02', 'dfsd@gmail.com'),
(29, 'test1', 1234567890, 'dfc  sdsd sdf', '2023-01-02', 'sakhare@gmail.com'),
(30, 'test1', 1234567890, 'dfc  sdsd sdf', '2023-01-02', 'sakhare@gmail.com'),
(31, 'test1', 2147483647, 'ddsf  fdsg', '2023-01-02', 'dfsd@gmail.com'),
(32, 'test1', 2147483647, 'ddsf  fdsg', '2023-01-02', 'dfsd@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `slug` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `tagline` text NOT NULL,
  `img_file` varchar(30) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `slug`, `content`, `tagline`, `img_file`, `date`) VALUES
(1, 'let\'s learn about stock maket', 'first-post', 'In finance, stock (also capital stock) consists of all the shares by which ownership of a corporation or company is divided.[1] (Especially in American English, the word \"stocks\" is also used to refer to shares.)[1][2] A single share of the stock means fractional ownership of the corporation in proportion to the total number of shares. This typically entitles the shareholder (stockholder) to that fraction of the company\'s earnings, proceeds from liquidation of assets (after discharge of all senior claims such as secured and unsecured debt),[3] or voting power, often dividing these up in proportion to the amount of money each stockholder has invested. Not all stock is necessarily equal, as certain classes of stock may be issued for example without voting rights, with enhanced voting rights, or with a certain priority to receive profits or liquidation proceeds before or after other classes of shareholders.', 'coolest post ever', 'about-bg.jpg', '2023-01-02'),
(2, 'This is second post', 'second-post', 'A template contains variables and/or expressions, which get replaced with values when a template is rendered; and tags, which control the logic of the template. The template syntax is heavily inspired by Django and Python.\r\n\r\nBelow is a minimal template that illustrates a few basics using the default Jinja configuration. We will cover the details later in this document:', 'awesome post', 'home-bg.jpg', '2023-01-03'),
(3, 'third post', 'third-post', 'You can mess around with the variables in templates provided they are passed in by the application. Variables may have attributes or elements on them you can access too. What attributes a variable has depends heavily on the application providing that variable.', 'nice post ever', '', '2023-01-03'),
(4, 'fourth post', 'fourth-post', 'For the sake of convenience, foo.bar in Jinja does the following things on the Python layer:\r\n\r\ncheck for an attribute called bar on foo (getattr(foo, \'bar\'))\r\n\r\nif there is not, check for an item \'bar\' in foo (foo.__getitem__(\'bar\'))\r\n\r\nif there is not, return an undefined object.\r\n\r\nfoo[\'bar\'] works mostly the same with a small difference in sequence:\r\n\r\ncheck for an item \'bar\' in foo. (foo.__getitem__(\'bar\'))\r\n\r\nif there is not, check for an attribute called bar on foo. (getattr(foo, \'bar\'))\r\n\r\nif there is not, return an undefined object.\r\n\r\nThis is important if an object has an item and attribute with the same name. Additionally, the attr() filter only looks up attributes.', 'good post', '', '2023-01-03'),
(7, 'sdfgh', 'sdfgh', 'sdfghj', 'sdfgh', 'sdfghjk', '2023-01-08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
