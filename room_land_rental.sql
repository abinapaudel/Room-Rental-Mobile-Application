-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 08, 2022 at 08:12 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `room_land_rental`
--

-- --------------------------------------------------------

--
-- Table structure for table `feedbacks`
--

CREATE TABLE `feedbacks` (
  `id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `feedback` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `lands`
--

CREATE TABLE `lands` (
  `id` int(5) NOT NULL,
  `land_title` varchar(50) NOT NULL,
  `location` varchar(40) NOT NULL,
  `land_desc` varchar(1000) NOT NULL,
  `rent` int(5) NOT NULL,
  `area` int(5) NOT NULL,
  `owner_firstname` varchar(50) NOT NULL,
  `owner_lastname` varchar(50) NOT NULL,
  `phone_no` varchar(20) NOT NULL,
  `email` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `lands`
--

INSERT INTO `lands` (`id`, `land_title`, `location`, `land_desc`, `rent`, `area`, `owner_firstname`, `owner_lastname`, `phone_no`, `email`) VALUES
(1, 'Beautiful Plots', 'Simalchaur, Pokhara', 'A bright and spacious land located in simalchaur. The land measured at 564 Sq Feet and comprises of a reception room with an open place integrated kitchen, there are built in wardrobers bedroom and modern bathroom.', 20000, 48, 'Binod', 'Paudel', '9841230020', 'binod@gmail.com'),
(2, 'Land for sale', 'Lakeside, Pokhara -8', '1 ropani residential land having 13 feet road access is on sale at lakeside.', 350000, 30, 'Avinish ', 'Adhikari', '9826178790', 'Avinishadhkri54@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `land_bookings`
--

CREATE TABLE `land_bookings` (
  `id` int(5) NOT NULL,
  `land_id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `token` varchar(100) NOT NULL,
  `status` varchar(20) NOT NULL,
  `date` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `land_images`
--

CREATE TABLE `land_images` (
  `id` int(5) NOT NULL,
  `land_id` int(5) NOT NULL,
  `path` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `land_images`
--

INSERT INTO `land_images` (`id`, `land_id`, `path`) VALUES
(8, 1, 'images/image_picker733027592995466012016487909331.jpg'),
(9, 2, 'images/image_picker867488644696608027716509821072.png'),
(10, 2, 'images/image_picker286925451350514387116509821072.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(5) NOT NULL,
  `room_title` varchar(50) NOT NULL,
  `bedroom_no` int(3) NOT NULL,
  `kitchen_no` int(3) NOT NULL,
  `hall_no` int(3) NOT NULL,
  `location` varchar(40) NOT NULL,
  `room_desc` varchar(1000) NOT NULL,
  `rent` int(5) NOT NULL,
  `isBalcony` int(1) NOT NULL,
  `isParking` int(1) NOT NULL,
  `owner_firstname` varchar(50) NOT NULL,
  `owner_lastname` varchar(50) NOT NULL,
  `phone_no` varchar(20) NOT NULL,
  `email` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `room_title`, `bedroom_no`, `kitchen_no`, `hall_no`, `location`, `room_desc`, `rent`, `isBalcony`, `isParking`, `owner_firstname`, `owner_lastname`, `phone_no`, `email`) VALUES
(7, '2BHK(Furnished room', 2, 1, 1, 'Simalchaur, Pokhara', 'A bright and spacious 2 bedroom flat located on the second floor in simalchaur. The furnished apartment measured at 564 So Feet and comprises of a reception room with an open place integrated kitchen, there are built in wardrobers bedroom and modern bathroom.', 15000, 1, 1, 'Abina', 'Paudel', '9805897886', 'abinapaudel10@gmail.com'),
(8, 'Suitable Flat', 2, 1, 2, 'Lamachaur, Pokhara', 'A bright and spacious 2 bedroom flat located on the second floor in simalchaur. The furnished apartment measured at 564 So Feet and comprises of a reception room with an open place integrated kitchen, there are built in wardrobers bedroom and modern bathroom.', 21000, 1, 1, 'Jasmine', 'Thapa', '9865748375', 'jasmine@gmail.com'),
(9, 'Apartment Room', 3, 1, 2, 'Srijana Chowk', 'A bright and spacious 2 bedroom flat located on the second floor in simalchaur. The furnished apartment measured at 564 So Feet and comprises of a reception room with an open place integrated kitchen, there are built in wardrobers bedroom and modern bathroom.', 24500, 1, 1, 'Binod', 'Password', '9805897886', 'binod@gmail.com'),
(10, 'Large Double Rooms', 2, 1, 0, 'Srijanachowk', 'DOUBLE ROOMS AVAILABLE *An extremely modern, bright bedroom * Very clean & friendly housemates * Brand new carpets throughout * On street parking available * A lovely modern kitchen * Large double room', 15000, 0, 1, 'Manisha', 'Dhital', '9836283667', 'manishadhital20@gmail.com'),
(11, 'Luxury one bed apartment', 1, 1, 1, 'Malepatan-5', 'Elite Rooms Belfast brings to you a 1 bed fully furnished luxury ground floor apartment,located on malepatan just off the kalika petrol pump with local shops, restaurant and coffee shops.', 17000, 0, 1, 'Smriti', 'Baral', '9887652727', 'smritibaral12@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `room_bookings`
--

CREATE TABLE `room_bookings` (
  `id` int(5) NOT NULL,
  `room_id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `token` varchar(100) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'booked',
  `date` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `room_bookings`
--

INSERT INTO `room_bookings` (`id`, `room_id`, `user_id`, `token`, `status`, `date`) VALUES
(17, 7, 7, 'wksTRCAeLUNKadxGbjN72h', 'booked', '2022-05-27');

-- --------------------------------------------------------

--
-- Table structure for table `room_images`
--

CREATE TABLE `room_images` (
  `id` int(5) NOT NULL,
  `room_id` int(5) NOT NULL,
  `path` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `room_images`
--

INSERT INTO `room_images` (`id`, `room_id`, `path`) VALUES
(16, 7, 'images/image_picker401899151353473518216487259847.jpg'),
(17, 7, 'images/image_picker321197119559231148616487259847.jpg'),
(18, 7, 'images/image_picker870376147110854288916487259847.jpg'),
(19, 7, 'images/image_picker282592073276079277316487259847.jpg'),
(28, 8, 'images/image_picker244995337608989449216492116338.jpg'),
(29, 8, 'images/image_picker323533758198303385016492116338.jpg'),
(30, 8, 'images/image_picker329328518135836982616492116338.jpg'),
(37, 9, 'images/image_picker440383860048264322216492126739.jpg'),
(38, 9, 'images/image_picker448741292318772899116492126739.jpg'),
(39, 9, 'images/image_picker789643936448665933616492126739.jpg'),
(40, 9, 'images/image_picker710588752306505581916492126739.jpg'),
(50, 10, 'images/image_picker5579667410632593238165098004610.jpg'),
(51, 10, 'images/image_picker5819588189182136436165098004710.jpg'),
(52, 10, 'images/image_picker5085734942640453379165098004710.jpg'),
(53, 11, 'images/image_picker5579667410632593238165098141111.jpg'),
(54, 11, 'images/image_picker5819588189182136436165098141111.jpg'),
(55, 11, 'images/image_picker5085734942640453379165098141111.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(5) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `username` varchar(30) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `address` varchar(20) NOT NULL,
  `dob` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(150) NOT NULL,
  `role` varchar(10) NOT NULL DEFAULT 'user',
  `image` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `username`, `gender`, `phone_number`, `address`, `dob`, `email`, `password`, `role`, `image`) VALUES
(4, 'Abina', 'Paudel', 'abina_paudel', 'male', '9874524152', 'Pokhara', '2002-03-06', 'abinapaudel@gmail.com', '$2y$10$7s/f87ZaMLbyTRIu8iEwY.FmBwr9pTw3A7hfbqmmOvaSod/AnvFIW', 'user', ''),
(6, 'Admin', 'Test', 'AdminUser', 'male', '9841525285', 'Pokhara', '2002-03-06', 'admin@gmail.com', '$2y$10$xl/HW3G37sQ6CaG5BL1fRe7mpmj9GyLsAoawsDJath4ELotkuVjVa', 'admin', 'images/image_picker15625350881648096260.jpg'),
(7, 'Abina', 'Paudel', 'abina_paudel', 'female', '9846078730', 'Simalchaur, Pokhara', '2002-04-02', 'abinapaudel20@gmail.com', '$2y$10$nLOd.KOala3aXWR.ZgLnrudwS7R8VCxwpsp21MNC7Y95V4wEiE/we', 'user', 'images/image_picker60522974225535736111651097478.jpg'),
(8, 'Sudip', 'Pokhrel', 'sudip_pokhrel', 'male', '9849677812', 'lamjung', '2002-04-08', 'sudip@gmail.com', '$2y$10$RTCiANf0AX8nqI30OzI.OesKBbNly6cO4S0egx8bRddzDPggfBfOG', 'user', ''),
(10, 'Binita', 'Sharma', 'binita_sharma', 'female', '9804245644', 'Chitwan', '2001-06-14', 'binitasharma10@gmail.com', '$2y$10$jX49sjbRWt8xWpncX9xKqeVJnJUBE5Q5Ek5QcAjZqeILc2bqvUho6', 'user', 'images/image_picker57378683842300923431652800748.jpg'),
(11, 'Sushma', 'Paudel', 'sushma_pokhrel', 'female', '9805897886', 'Simalchaur, Pokhara ', '2002-05-31', 'sushmapokhrel@gmail.com', '$2y$10$hvwU6y6T18v9cJqPkM1P7Ok3m2kMs28ipA8.OzdMvqq9syD.FTDMy', 'user', ''),
(12, 'Sushma', 'Paudel', 'sushma_pokhrel', 'female', '9805897886', 'Simalchaur, Pokhara ', '2002-05-31', 'sushmapokhrel10@gmail.com', '$2y$10$LGKOVV4ghyq4fqUMamhDiuyn8RasxBtdERovZJtjG179mZDdJ4E56', 'user', '');

-- --------------------------------------------------------

--
-- Table structure for table `visit_request`
--

CREATE TABLE `visit_request` (
  `id` int(5) NOT NULL,
  `type` varchar(20) NOT NULL,
  `user_id` int(5) NOT NULL,
  `title` varchar(100) NOT NULL,
  `date` varchar(40) NOT NULL,
  `message` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `visit_request`
--

INSERT INTO `visit_request` (`id`, `type`, `user_id`, `title`, `date`, `message`) VALUES
(14, 'room', 7, '2BHK(Furnished rooms)', '2022-04-01', 'I want to visit the room'),
(21, 'room', 10, '2BHK(Furnished room', '2022-05-17', 'I want to visit this room'),
(22, 'room', 7, '2BHK(Furnished room', '2022-05-28', 'I want to visit this room');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `lands`
--
ALTER TABLE `lands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `land_bookings`
--
ALTER TABLE `land_bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `land_id` (`land_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `land_images`
--
ALTER TABLE `land_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `land_id` (`land_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_bookings`
--
ALTER TABLE `room_bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `room_images`
--
ALTER TABLE `room_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `visit_request`
--
ALTER TABLE `visit_request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `feedbacks`
--
ALTER TABLE `feedbacks`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `lands`
--
ALTER TABLE `lands`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `land_bookings`
--
ALTER TABLE `land_bookings`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `land_images`
--
ALTER TABLE `land_images`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `room_bookings`
--
ALTER TABLE `room_bookings`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `room_images`
--
ALTER TABLE `room_images`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `visit_request`
--
ALTER TABLE `visit_request`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD CONSTRAINT `feedbacks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `land_bookings`
--
ALTER TABLE `land_bookings`
  ADD CONSTRAINT `land_bookings_ibfk_1` FOREIGN KEY (`land_id`) REFERENCES `lands` (`id`),
  ADD CONSTRAINT `land_bookings_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `land_images`
--
ALTER TABLE `land_images`
  ADD CONSTRAINT `land_images_ibfk_1` FOREIGN KEY (`land_id`) REFERENCES `lands` (`id`);

--
-- Constraints for table `room_bookings`
--
ALTER TABLE `room_bookings`
  ADD CONSTRAINT `room_bookings_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`),
  ADD CONSTRAINT `room_bookings_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `room_images`
--
ALTER TABLE `room_images`
  ADD CONSTRAINT `room_images_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`);

--
-- Constraints for table `visit_request`
--
ALTER TABLE `visit_request`
  ADD CONSTRAINT `visit_request_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
