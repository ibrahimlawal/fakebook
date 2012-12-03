-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 03, 2012 at 06:50 PM
-- Server version: 5.1.44
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `fakebook`
--

-- --------------------------------------------------------

--
-- Table structure for table `friend`
--

CREATE TABLE IF NOT EXISTS `friend` (
  `user_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`friend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `friend`
--

INSERT INTO `friend` (`user_id`, `friend_id`, `timestamp`) VALUES
(1, 7, '2012-12-03 19:19:42'),
(8, 1, '2012-12-03 19:28:09');

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE IF NOT EXISTS `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `status` enum('Read','Unread') NOT NULL DEFAULT 'Unread',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`id`, `sender_id`, `recipient_id`, `message`, `status`, `timestamp`) VALUES
(1, 1, 1, 'test', 'Read', '2012-12-03 14:00:35'),
(2, 1, 1, 'test', 'Read', '2012-12-03 14:15:19'),
(3, 1, 1, 'null', 'Read', '2012-12-03 16:24:08'),
(4, 1, 1, 'testg', 'Read', '2012-12-03 16:25:59'),
(5, 1, 1, 'testg', 'Read', '2012-12-03 16:28:16'),
(6, 1, 1, 'gege', 'Read', '2012-12-03 16:28:25'),
(7, 1, 1, 'cgsv', 'Unread', '2012-12-03 16:37:16'),
(8, 1, 8, 'cgsv', 'Read', '2012-12-03 16:37:16'),
(9, 8, 1, 'olodo', 'Unread', '2012-12-03 16:38:07'),
(10, 8, 1, 'olodo', 'Unread', '2012-12-03 16:45:05'),
(11, 8, 1, 'grow', 'Read', '2012-12-03 16:45:49'),
(12, 1, 8, 'up', 'Read', '2012-12-03 16:45:58'),
(13, 8, 1, 'down', 'Read', '2012-12-03 16:46:09');

-- --------------------------------------------------------

--
-- Table structure for table `note`
--

CREATE TABLE IF NOT EXISTS `note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `body` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `note`
--

INSERT INTO `note` (`id`, `user_id`, `title`, `body`, `timestamp`) VALUES
(2, 1, 'test', 'test', '2012-12-03 13:46:31'),
(3, 8, 'note', 'thsi is ao so', '2012-12-03 16:57:32');

-- --------------------------------------------------------

--
-- Table structure for table `profile`
--

CREATE TABLE IF NOT EXISTS `profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(75) NOT NULL,
  `password` varchar(100) NOT NULL,
  `firstname` varchar(40) NOT NULL,
  `lastname` varchar(40) NOT NULL,
  `address` varchar(200) NOT NULL,
  `phone` varchar(75) NOT NULL,
  `security_question` varchar(100) NOT NULL,
  `security_answer` varchar(75) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `profile`
--

INSERT INTO `profile` (`id`, `email`, `password`, `firstname`, `lastname`, `address`, `phone`, `security_question`, `security_answer`) VALUES
(1, 'test@test.te', 'testpwd', 'all', 'fields', 'have', 'changed', 'what am i', 'test'),
(8, 'saubanlawal@yahoo.com', 'whereami', 'sauban', 'lawal', 'hungary', '01920', 'what is your name?', 'shile'),
(7, 'testpmo@cop.lawal.me', 'x', 'y', 'z', 'd', 'c', 'a', 'b');

-- --------------------------------------------------------

--
-- Table structure for table `research_interest`
--

CREATE TABLE IF NOT EXISTS `research_interest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(70) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `research_interest`
--

INSERT INTO `research_interest` (`id`, `name`, `description`) VALUES
(1, 'C in the French language', ''),
(2, 'G in the English language', '');

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE IF NOT EXISTS `subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(70) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`id`, `name`, `description`) VALUES
(1, 'French', ''),
(2, 'English', '');

-- --------------------------------------------------------

--
-- Table structure for table `user_research_interest`
--

CREATE TABLE IF NOT EXISTS `user_research_interest` (
  `user_id` int(11) NOT NULL,
  `research_interest_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`research_interest_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_research_interest`
--

INSERT INTO `user_research_interest` (`user_id`, `research_interest_id`) VALUES
(1, 2),
(7, 2),
(8, 1),
(8, 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_subject`
--

CREATE TABLE IF NOT EXISTS `user_subject` (
  `user_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`subject_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_subject`
--

INSERT INTO `user_subject` (`user_id`, `subject_id`) VALUES
(1, 1),
(8, 1),
(8, 2);
