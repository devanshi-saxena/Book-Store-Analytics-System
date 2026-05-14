DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS shipping CASCADE;
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS authors CASCADE;
DROP TABLE IF EXISTS publishers CASCADE;
DROP TABLE IF EXISTS genres CASCADE;

CREATE TABLE customers(
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50),
	email VARCHAR(50) NOT NULL UNIQUE,
	phone VARCHAR(15) UNIQUE,
	city VARCHAR(50) NOT NULL,
	country VARCHAR(50) NOT NULL,
	signup_date DATE DEFAULT CURRENT_DATE

);

CREATE TABLE authors(
	author_id INT PRIMARY KEY,
	author_name VARCHAR(50) NOT NULL,
	country VARCHAR(50) NOT NULL,
	birth_year INT CHECK(birth_year > 0)
	
);

CREATE TABLE publishers(
	publisher_id INT PRIMARY KEY,
	publisher_name VARCHAR(50) NOT NULL UNIQUE,
	country VARCHAR(50) NOT NULL
	
);

CREATE TABLE genres(
	genre_id INT PRIMARY KEY,
	genre_name VARCHAR(50) NOT NULL UNIQUE
	
);

CREATE TABLE payments(
	payment_id INT PRIMARY KEY,
	payment_method VARCHAR(30) NOT NULL CHECK( payment_method IN( 'upi','credit card','paypal','debit card')),
	payment_status VARCHAR(30) CHECK( payment_status IN ('success','failed','pending')),
	payment_date DATE DEFAULT CURRENT_DATE
	
);

CREATE TABLE shipping(
	shipping_id INT PRIMARY KEY,
	shipping_address VARCHAR(100) NOT NULL ,
	shipping_city VARCHAR(50) NOT NULL,
	shipping_country VARCHAR(50) NOT NULL,
	shipping_status VARCHAR(30) CHECK( shipping_status IN( 'packed','delivered','shipped')) ,
	delivery_date DATE
	
);

CREATE TABLE books(
	book_id INT PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	author_id INT REFERENCES authors(author_id),
	publisher_id INT REFERENCES publishers(publisher_id),
	genre_id INT REFERENCES genres(genre_id),
	isbn VARCHAR(13) UNIQUE,
	stock INT DEFAULT 0 CHECK(stock >=0),
	price NUMERIC(7,2) CHECK( price > 0),
	published_year INT CHECK(published_year > 0)
	
);

CREATE TABLE orders(
	order_id INT PRIMARY KEY,
	customer_id INT REFERENCES customers(customer_id),
	order_date DATE DEFAULT CURRENT_DATE,
	payment_id INT REFERENCES payments(payment_id),
	shipping_id INT REFERENCES shipping(shipping_id),
	order_status VARCHAR(30) CHECK(order_status IN ('pending','shipped','delivered','cancelled'))
);

CREATE TABLE order_items(
	order_item_id INT PRIMARY KEY,
	order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
	book_id INT REFERENCES books(book_id),
	quantity INT NOT NULL CHECK(quantity>0),
	price_each NUMERIC(7,2) CHECK(price_each > 0),
	subtotal NUMERIC(10,2) CHECK(subtotal >= 0)
	
);

INSERT INTO customers(customer_id, first_name, last_name, email, phone, city, country, signup_date) 
VALUES(
	1, 'John', 'Smith', 'john.smith@gmail.com', '9876501001', 'Toronto', 'Canada', '2023-01-15'),

	(2, 'Emma', 'Johnson', 'emma.johnson@gmail.com', '9876501002', 'Vancouver', 'Canada', '2023-02-10'),

	(3, 'Liam', 'Williams', 'liam.williams@gmail.com', '9876501003', 'New York', 'USA', '2023-03-05'),

	(4, 'Olivia', 'Brown', 'olivia.brown@gmail.com', '9876501004', 'Chicago', 'USA', '2023-03-18'),

	(5, 'Noah', 'Jones', 'noah.jones@gmail.com', '9876501005', 'London', 'UK', '2023-04-02'),

	(6, 'Sophia', 'Garcia', 'sophia.garcia@gmail.com', '9876501006', 'Manchester', 'UK', '2023-04-25'),
	
	(7, 'James', 'Miller', 'james.miller@gmail.com', '9876501007', 'Sydney', 'Australia', '2023-05-11'),
	
	(8, 'Isabella', 'Davis', 'isabella.davis@gmail.com', '9876501008', 'Melbourne', 'Australia', '2023-05-29'),
	
	(9, 'Benjamin', 'Rodriguez', 'benjamin.rodriguez@gmail.com', '9876501009', 'Berlin', 'Germany', '2023-06-14'),
	
	(10, 'Mia', 'Martinez', 'mia.martinez@gmail.com', '9876501010', 'Munich', 'Germany', '2023-06-28'),
	
	(11, 'Lucas', 'Hernandez', 'lucas.hernandez@gmail.com', '9876501011', 'Paris', 'France', '2023-07-03'),

	(12, 'Charlotte', 'Lopez', 'charlotte.lopez@gmail.com', '9876501012', 'Lyon', 'France', '2023-07-19'),
	
	(13, 'Henry', 'Gonzalez', 'henry.gonzalez@gmail.com', '9876501013', 'Tokyo', 'Japan', '2023-08-01'),
	
	(14, 'Amelia', 'Wilson', 'amelia.wilson@gmail.com', '9876501014', 'Osaka', 'Japan', '2023-08-16'),
	
	(15, 'Alexander', 'Anderson', 'alex.anderson@gmail.com', '9876501015', 'Delhi', 'India', '2023-09-07'),
	
	(16, 'Evelyn', 'Thomas', 'evelyn.thomas@gmail.com', '9876501016', 'Mumbai', 'India', '2023-09-21'),
	
	(17, 'Daniel', 'Taylor', 'daniel.taylor@gmail.com', '9876501017', 'Dubai', 'UAE', '2023-10-05'),
	
	(18, 'Harper', 'Moore', 'harper.moore@gmail.com', '9876501018', 'Abu Dhabi', 'UAE', '2023-10-18'),
	
	(19, 'Michael', 'Jackson', 'michael.jackson@gmail.com', '9876501019', 'Singapore', 'Singapore', '2023-11-02'),
	
	(20, 'Ella', 'Martin', 'ella.martin@gmail.com', '9876501020', 'Kuala Lumpur', 'Malaysia', '2023-11-20'

);

INSERT INTO authors(author_id, author_name, country, birth_year) 
VALUES(
	
	 1, 'James Peterson', 'USA', 1975),
	
	(2, 'Emma Roberts', 'Canada', 1982),
	
	(3, 'William Turner', 'UK', 1968),
	
	(4, 'Sophia Martinez', 'Spain', 1985),
	
	(5, 'Daniel Kim', 'South Korea', 1979),
	
	(6, 'Olivia Brown', 'Australia', 1990),
	
	(7, 'Liam Anderson', 'Ireland', 1972),
	
	(8, 'Isabella Thomas', 'France', 1988),
	
	(9, 'Noah Wilson', 'Germany', 1980),
	
	(10, 'Charlotte Davis', 'India', 1992

);

INSERT INTO books(book_id, author_id, title, publisher_id, genre_id, isbn, stock, price, published_year) 
VALUES(
	1, 1, 'The Silent Forest', 1, 1, '9780000000001', 45, 19.99, 2018),
	
	(2, 2, 'Dreams of Tomorrow', 2, 2, '9780000000002', 30, 24.50, 2020),
	
	(3, 3, 'Mystery at Midnight', 3, 3, '9780000000003', 20, 15.75, 2016),
	
	(4, 4, 'Winds of Winterfall', 4, 1, '9780000000004', 50, 29.99, 2021),
	
	(5, 5, 'The Data Mindset', 5, 4, '9780000000005', 35, 34.99, 2022),
	
	(6, 6, 'Journey Beyond Stars', 2, 2, '9780000000006', 40, 21.50, 2019),
	
	(7, 7, 'Hidden Truths', 1, 3, '9780000000007', 18, 17.99, 2017),
	
	(8, 8, 'Python for Analysts', 5, 4, '9780000000008', 60, 39.99, 2023),
	
	(9, 9, 'Legends of Avalon', 4, 1, '9780000000009', 27, 26.80, 2015),
	
	(10, 10, 'Machine Learning Basics', 5, 4, '9780000000010', 32, 42.00, 2021),
	
	(11, 1, 'Echoes of Eternity', 3, 2, '9780000000011', 22, 18.45, 2014),
	
	(12, 2, 'The Last Cipher', 2, 3, '9780000000012', 28, 20.99, 2018),
	
	(13, 3, 'Deep Ocean Secrets', 1, 5, '9780000000013', 16, 14.25, 2013),
	
	(14, 4, 'Artificial Intelligence 101', 5, 4, '9780000000014', 55, 44.90, 2024),
	
	(15, 5, 'Shadow Hunter', 4, 3, '9780000000015', 12, 16.75, 2012),
	
	(16, 6, 'Future Horizons', 2, 2, '9780000000016', 33, 23.40, 2020),
	
	(17, 7, 'The Forgotten Kingdom', 4, 1, '9780000000017', 41, 31.20, 2019),
	
	(18, 8, 'SQL for Beginners', 5, 4, '9780000000018', 70, 27.99, 2022),
	
	(19, 9, 'City of Mirrors', 3, 3, '9780000000019', 14, 19.50, 2011),
	
	(20, 10, 'Cloud Computing Essentials', 5, 4, '9780000000020', 48, 36.75, 2023),
	
	(21, 1, 'Moonlight Shadows', 1, 3, '9780000000021', 24, 15.99, 2010),
	
	(22, 2, 'Adventures in Space', 2, 2, '9780000000022', 38, 22.10, 2017),
	
	(23, 3, 'Fantasy Realms', 4, 1, '9780000000023', 44, 28.60, 2021),
	
	(24, 4, 'Business Analytics Guide', 5, 4, '9780000000024', 29, 41.25, 2022),
	
	(25, 5, 'Secrets of the Night', 3, 3, '9780000000025', 17, 18.80, 2016),
	
	(26, 6, 'The Quantum Era', 2, 5, '9780000000026', 26, 32.50, 2024),
	
	(27, 7, 'Digital Transformation', 5, 4, '9780000000027', 36, 37.90, 2021),
	
	(28, 8, 'Rise of the Phoenix', 4, 1, '9780000000028', 19, 25.60, 2015),
	
	(29, 9, 'Crime and Clues', 3, 3, '9780000000029', 21, 17.45, 2018),
	
	(30, 10, 'Big Data Revolution', 5, 4, '9780000000030', 52, 45.99, 2023

);

INSERT INTO genres(genre_id, genre_name) 
VALUES(
	1, 'Fantasy'),
	
	(2, 'Science Fiction'),
	
	(3, 'Mystery'),
	
	(4, 'Technology'),
	
	(5, 'Adventure'),
	
	(6, 'Business'

);

INSERT INTO order_items(order_item_id, order_id, book_id, quantity, price_each, subtotal) 
VALUES(
	1, 1, 1, 2, 19.99, 39.98),
	(2, 1, 5, 1, 34.99, 34.99),
	
	(3, 2, 2, 1, 24.50, 24.50),
	(4, 2, 8, 2, 39.99, 79.98),
	
	(5, 3, 3, 1, 15.75, 15.75),
	(6, 3, 10, 1, 42.00, 42.00),
	
	(7, 4, 4, 2, 29.99, 59.98),
	(8, 4, 6, 1, 21.50, 21.50),
	
	(9, 5, 7, 3, 17.99, 53.97),
	(10, 5, 9, 1, 26.80, 26.80),
	
	(11, 6, 11, 2, 18.45, 36.90),
	(12, 6, 14, 1, 44.90, 44.90),
	
	(13, 7, 12, 1, 20.99, 20.99),
	(14, 7, 15, 2, 16.75, 33.50),
	
	(15, 8, 13, 1, 14.25, 14.25),
	(16, 8, 18, 2, 27.99, 55.98),
	
	(17, 9, 16, 1, 23.40, 23.40),
	(18, 9, 17, 2, 31.20, 62.40),
	
	(19, 10, 19, 1, 19.50, 19.50),
	(20, 10, 20, 1, 36.75, 36.75),
	
	(21, 11, 21, 2, 15.99, 31.98),
	(22, 11, 24, 1, 41.25, 41.25),
	
	(23, 12, 22, 1, 22.10, 22.10),
	(24, 12, 25, 2, 18.80, 37.60),
	
	(25, 13, 23, 1, 28.60, 28.60),
	(26, 13, 26, 1, 32.50, 32.50),
	
	(27, 14, 27, 2, 37.90, 75.80),
	(28, 14, 28, 1, 25.60, 25.60),
	
	(29, 15, 29, 3, 17.45, 52.35),
	(30, 15, 30, 1, 45.99, 45.99),
	
	(31, 16, 1, 1, 19.99, 19.99),
	(32, 16, 2, 2, 24.50, 49.00),
	
	(33, 17, 3, 2, 15.75, 31.50),
	(34, 17, 4, 1, 29.99, 29.99),
	
	(35, 18, 5, 1, 34.99, 34.99),
	(36, 18, 6, 2, 21.50, 43.00),
	
	(37, 19, 7, 1, 17.99, 17.99),
	(38, 19, 8, 1, 39.99, 39.99),
	
	(39, 20, 9, 2, 26.80, 53.60),
	(40, 20, 10, 1, 42.00, 42.00),
	
	(41, 21, 11, 1, 18.45, 18.45),
	(42, 21, 12, 2, 20.99, 41.98),
	
	(43, 22, 13, 3, 14.25, 42.75),
	(44, 22, 14, 1, 44.90, 44.90),
	
	(45, 23, 15, 2, 16.75, 33.50),
	(46, 23, 16, 1, 23.40, 23.40),
	
	(47, 24, 17, 1, 31.20, 31.20),
	(48, 24, 18, 2, 27.99, 55.98),
	
	(49, 25, 19, 1, 19.50, 19.50),
	(50, 25, 20, 2, 36.75, 73.50),
	
	(51, 26, 21, 1, 15.99, 15.99),
	(52, 26, 22, 2, 22.10, 44.20),
	
	(53, 27, 23, 1, 28.60, 28.60),
	(54, 27, 24, 1, 41.25, 41.25),
	
	(55, 28, 25, 2, 18.80, 37.60),
	(56, 28, 26, 1, 32.50, 32.50),
	
	(57, 29, 27, 1, 37.90, 37.90),
	(58, 29, 28, 2, 25.60, 51.20),
	
	(59, 30, 29, 1, 17.45, 17.45),
	(60, 30, 30, 1, 45.99, 45.99),
	
	(61, 31, 1, 2, 19.99, 39.98),
	(62, 31, 3, 1, 15.75, 15.75),
	
	(63, 32, 5, 1, 34.99, 34.99),
	(64, 32, 7, 2, 17.99, 35.98),
	
	(65, 33, 9, 1, 26.80, 26.80),
	(66, 33, 11, 2, 18.45, 36.90),
	
	(67, 34, 13, 1, 14.25, 14.25),
	(68, 34, 15, 1, 16.75, 16.75),
	
	(69, 35, 17, 2, 31.20, 62.40),
	(70, 35, 19, 1, 19.50, 19.50),
	
	(71, 36, 21, 1, 15.99, 15.99),
	(72, 36, 23, 2, 28.60, 57.20),
	
	(73, 37, 25, 1, 18.80, 18.80),
	(74, 37, 27, 1, 37.90, 37.90),
	
	(75, 38, 29, 2, 17.45, 34.90),
	(76, 38, 30, 1, 45.99, 45.99),
	
	(77, 39, 2, 1, 24.50, 24.50),
	(78, 39, 4, 2, 29.99, 59.98),
	
	(79, 40, 6, 1, 21.50, 21.50),
	(80, 40, 8, 1, 39.99, 39.99),
	
	(81, 41, 10, 2, 42.00, 84.00),
	(82, 41, 12, 1, 20.99, 20.99),
	
	(83, 42, 14, 1, 44.90, 44.90),
	(84, 42, 16, 2, 23.40, 46.80),
	
	(85, 43, 18, 1, 27.99, 27.99),
	(86, 43, 20, 1, 36.75, 36.75),
	
	(87, 44, 22, 2, 22.10, 44.20),
	(88, 44, 24, 1, 41.25, 41.25),
	
	(89, 45, 26, 1, 32.50, 32.50),
	(90, 45, 28, 2, 25.60, 51.20),
	
	(91, 46, 30, 1, 45.99, 45.99),
	(92, 46, 1, 2, 19.99, 39.98),
	
	(93, 47, 3, 1, 15.75, 15.75),
	(94, 47, 5, 2, 34.99, 69.98),
	
	(95, 48, 7, 1, 17.99, 17.99),
	(96, 48, 9, 1, 26.80, 26.80),
	
	(97, 49, 11, 2, 18.45, 36.90),
	(98, 49, 13, 1, 14.25, 14.25),
	
	(99, 50, 15, 1, 16.75, 16.75),
	(100, 50, 17, 2, 31.20, 62.40

);

INSERT INTO orders(order_id, customer_id, order_date, payment_id, shipping_id, order_status) 
VALUES(
	1, 1, '2024-01-02', 1, 1, 'delivered'),
	(2, 2, '2024-01-03', 2, 2, 'shipped'),
	(3, 3, '2024-01-04', 3, 3, 'pending'),
	(4, 4, '2024-01-05', 4, 4, 'delivered'),
	(5, 5, '2024-01-06', 5, 5, 'cancelled'),
	
	(6, 6, '2024-01-07', 6, 6, 'delivered'),
	(7, 7, '2024-01-08', 7, 7, 'shipped'),
	(8, 8, '2024-01-09', 8, 8, 'pending'),
	(9, 9, '2024-01-10', 9, 9, 'delivered'),
	(10, 10, '2024-01-11', 10, 10, 'cancelled'),
	
	(11, 11, '2024-01-12', 11, 11, 'delivered'),
	(12, 12, '2024-01-13', 12, 12, 'shipped'),
	(13, 13, '2024-01-14', 13, 13, 'pending'),
	(14, 14, '2024-01-15', 14, 14, 'delivered'),
	(15, 15, '2024-01-16', 15, 15, 'cancelled'),
	
	(16, 16, '2024-01-17', 16, 16, 'delivered'),
	(17, 17, '2024-01-18', 17, 17, 'shipped'),
	(18, 18, '2024-01-19', 18, 18, 'pending'),
	(19, 19, '2024-01-20', 19, 19, 'delivered'),
	(20, 20, '2024-01-21', 20, 20, 'cancelled'),
	
	(21, 1, '2024-01-22', 21, 21, 'delivered'),
	(22, 2, '2024-01-23', 22, 22, 'shipped'),
	(23, 3, '2024-01-24', 23, 23, 'pending'),
	(24, 4, '2024-01-25', 24, 24, 'delivered'),
	(25, 5, '2024-01-26', 25, 25, 'cancelled'),
	
	(26, 6, '2024-01-27', 26, 26, 'delivered'),
	(27, 7, '2024-01-28', 27, 27, 'shipped'),
	(28, 8, '2024-01-29', 28, 28, 'pending'),
	(29, 9, '2024-01-30', 29, 29, 'delivered'),
	(30, 10, '2024-01-31', 30, 30, 'cancelled'),
	
	(31, 11, '2024-02-01', 31, 31, 'delivered'),
	(32, 12, '2024-02-02', 32, 32, 'shipped'),
	(33, 13, '2024-02-03', 33, 33, 'pending'),
	(34, 14, '2024-02-04', 34, 34, 'delivered'),
	(35, 15, '2024-02-05', 35, 35, 'cancelled'),
	
	(36, 16, '2024-02-06', 36, 36, 'delivered'),
	(37, 17, '2024-02-07', 37, 37, 'shipped'),
	(38, 18, '2024-02-08', 38, 38, 'pending'),
	(39, 19, '2024-02-09', 39, 39, 'delivered'),
	(40, 20, '2024-02-10', 40, 40, 'cancelled'),
	
	(41, 1, '2024-02-11', 41, 41, 'delivered'),
	(42, 2, '2024-02-12', 42, 42, 'shipped'),
	(43, 3, '2024-02-13', 43, 43, 'pending'),
	(44, 4, '2024-02-14', 44, 44, 'delivered'),
	(45, 5, '2024-02-15', 45, 45, 'cancelled'),
	
	(46, 6, '2024-02-16', 46, 46, 'delivered'),
	(47, 7, '2024-02-17', 47, 47, 'shipped'),
	(48, 8, '2024-02-18', 48, 48, 'pending'),
	(49, 9, '2024-02-19', 49, 49, 'delivered'),
	(50, 10, '2024-02-20', 50, 50, 'cancelled'

);

INSERT INTO payments(payment_id, payment_method, payment_status, payment_date) 
VALUES(
	
	1, 'upi', 'success', '2024-01-02'),
	(2, 'credit card', 'success', '2024-01-03'),
	(3, 'paypal', 'pending', '2024-01-04'),
	(4, 'debit card', 'success', '2024-01-05'),
	(5, 'upi', 'failed', '2024-01-06'),
	(6, 'credit card', 'success', '2024-01-07'),
	(7, 'paypal', 'success', '2024-01-08'),
	(8, 'debit card', 'pending', '2024-01-09'),
	(9, 'upi', 'success', '2024-01-10'),
	(10, 'credit card', 'failed', '2024-01-11'),
	
	(11, 'paypal', 'success', '2024-01-12'),
	(12, 'debit card', 'success', '2024-01-13'),
	(13, 'upi', 'pending', '2024-01-14'),
	(14, 'credit card', 'success', '2024-01-15'),
	(15, 'paypal', 'failed', '2024-01-16'),
	(16, 'debit card', 'success', '2024-01-17'),
	(17, 'upi', 'success', '2024-01-18'),
	(18, 'credit card', 'pending', '2024-01-19'),
	(19, 'paypal', 'success', '2024-01-20'),
	(20, 'debit card', 'failed', '2024-01-21'),
	
	(21, 'upi', 'success', '2024-01-22'),
	(22, 'credit card', 'success', '2024-01-23'),
	(23, 'paypal', 'pending', '2024-01-24'),
	(24, 'debit card', 'success', '2024-01-25'),
	(25, 'upi', 'failed', '2024-01-26'),
	(26, 'credit card', 'success', '2024-01-27'),
	(27, 'paypal', 'success', '2024-01-28'),
	(28, 'debit card', 'pending', '2024-01-29'),
	(29, 'upi', 'success', '2024-01-30'),
	(30, 'credit card', 'failed', '2024-01-31'),
	
	(31, 'paypal', 'success', '2024-02-01'),
	(32, 'debit card', 'success', '2024-02-02'),
	(33, 'upi', 'pending', '2024-02-03'),
	(34, 'credit card', 'success', '2024-02-04'),
	(35, 'paypal', 'failed', '2024-02-05'),
	(36, 'debit card', 'success', '2024-02-06'),
	(37, 'upi', 'success', '2024-02-07'),
	(38, 'credit card', 'pending', '2024-02-08'),
	(39, 'paypal', 'success', '2024-02-09'),
	(40, 'debit card', 'failed', '2024-02-10'),
	
	(41, 'upi', 'success', '2024-02-11'),
	(42, 'credit card', 'success', '2024-02-12'),
	(43, 'paypal', 'pending', '2024-02-13'),
	(44, 'debit card', 'success', '2024-02-14'),
	(45, 'upi', 'failed', '2024-02-15'),
	(46, 'credit card', 'success', '2024-02-16'),
	(47, 'paypal', 'success', '2024-02-17'),
	(48, 'debit card', 'pending', '2024-02-18'),
	(49, 'upi', 'success', '2024-02-19'),
	(50, 'credit card', 'failed', '2024-02-20'

);

INSERT INTO publishers(publisher_id, publisher_name, country) 
VALUES(
	1, 'Maple Leaf Publishing', 'Canada'),

	(2, 'FutureVision Books', 'USA'),
	
	(3, 'SilverLine Publications', 'UK'),
	
	(4, 'Emerald House Publishers', 'Australia'),
	
	(5, 'TechSphere Publishing', 'India'),
	
	(6, 'BlueOcean Press', 'Germany'),
	
	(7, 'Sunrise Media Group', 'Japan'),
	
	(8, 'GlobalReads Publishing', 'France'

);

INSERT INTO shipping(shipping_id, shipping_country, shipping_address, shipping_city, shipping_status, delivery_date) 
VALUES(
	
	1, 'Canada', '12 Maple Street', 'Toronto', 'delivered', '2024-01-05'),
	(2, 'USA', '45 Oak Avenue', 'New York', 'shipped', '2024-01-06'),
	(3, 'UK', '78 King Road', 'London', 'packed', '2024-01-07'),
	(4, 'India', '22 MG Road', 'Mumbai', 'delivered', '2024-01-08'),
	(5, 'Australia', '10 River Lane', 'Sydney', 'shipped', '2024-01-09'),
	
	(6, 'Germany', '88 Berlin Street', 'Berlin', 'packed', '2024-01-10'),
	(7, 'France', '15 Paris Avenue', 'Paris', 'delivered', '2024-01-11'),
	(8, 'Japan', '99 Sakura Road', 'Tokyo', 'shipped', '2024-01-12'),
	(9, 'UAE', '44 Palm Street', 'Dubai', 'packed', '2024-01-13'),
	(10, 'Singapore', '67 Marina Bay', 'Singapore', 'delivered', '2024-01-14'),
	
	(11, 'Canada', '21 Pine Road', 'Vancouver', 'shipped', '2024-01-15'),
	(12, 'USA', '300 Sunset Blvd', 'Chicago', 'packed', '2024-01-16'),
	(13, 'UK', '5 Queen Street', 'Manchester', 'delivered', '2024-01-17'),
	(14, 'India', '89 Park Lane', 'Delhi', 'shipped', '2024-01-18'),
	(15, 'Australia', '14 Harbour Street', 'Melbourne', 'packed', '2024-01-19'),
	
	(16, 'Germany', '9 Central Road', 'Munich', 'delivered', '2024-01-20'),
	(17, 'France', '72 Champs Street', 'Lyon', 'shipped', '2024-01-21'),
	(18, 'Japan', '55 Fuji Avenue', 'Osaka', 'packed', '2024-01-22'),
	(19, 'UAE', '101 Desert Road', 'Abu Dhabi', 'delivered', '2024-01-23'),
	(20, 'Malaysia', '11 Palm Avenue', 'Kuala Lumpur', 'shipped', '2024-01-24'),
	
	(21, 'Canada', '8 Lake View', 'Toronto', 'packed', '2024-01-25'),
	(22, 'USA', '65 Liberty Road', 'Boston', 'delivered', '2024-01-26'),
	(23, 'UK', '31 Oxford Street', 'Liverpool', 'shipped', '2024-01-27'),
	(24, 'India', '77 Nehru Road', 'Bangalore', 'packed', '2024-01-28'),
	(25, 'Australia', '42 Ocean Drive', 'Perth', 'delivered', '2024-01-29'),
	
	(26, 'Germany', '19 Green Lane', 'Hamburg', 'shipped', '2024-01-30'),
	(27, 'France', '61 Royal Street', 'Nice', 'packed', '2024-01-31'),
	(28, 'Japan', '90 Cherry Blossom Rd', 'Kyoto', 'delivered', '2024-02-01'),
	(29, 'UAE', '13 Falcon Avenue', 'Dubai', 'shipped', '2024-02-02'),
	(30, 'Singapore', '2 Orchard Road', 'Singapore', 'packed', '2024-02-03'),
	
	(31, 'Canada', '54 North Street', 'Ottawa', 'delivered', '2024-02-04'),
	(32, 'USA', '88 Broadway', 'Seattle', 'shipped', '2024-02-05'),
	(33, 'UK', '6 Baker Street', 'London', 'packed', '2024-02-06'),
	(34, 'India', '49 Ring Road', 'Hyderabad', 'delivered', '2024-02-07'),
	(35, 'Australia', '73 Hill Street', 'Brisbane', 'shipped', '2024-02-08'),
	
	(36, 'Germany', '27 River Road', 'Frankfurt', 'packed', '2024-02-09'),
	(37, 'France', '33 Eiffel Avenue', 'Paris', 'delivered', '2024-02-10'),
	(38, 'Japan', '41 Bamboo Lane', 'Nagoya', 'shipped', '2024-02-11'),
	(39, 'UAE', '19 Oasis Street', 'Sharjah', 'packed', '2024-02-12'),
	(40, 'Malaysia', '90 City Center', 'Penang', 'delivered', '2024-02-13'),
	
	(41, 'Canada', '120 Cedar Road', 'Montreal', 'shipped', '2024-02-14'),
	(42, 'USA', '16 Washington Ave', 'Houston', 'packed', '2024-02-15'),
	(43, 'UK', '88 Castle Road', 'Birmingham', 'delivered', '2024-02-16'),
	(44, 'India', '11 Lotus Street', 'Chennai', 'shipped', '2024-02-17'),
	(45, 'Australia', '7 Sunset Avenue', 'Canberra', 'packed', '2024-02-18'),
	
	(46, 'Germany', '45 King Plaza', 'Cologne', 'delivered', '2024-02-19'),
	(47, 'France', '18 Riviera Road', 'Marseille', 'shipped', '2024-02-20'),
	(48, 'Japan', '63 Temple Street', 'Sapporo', 'packed', '2024-02-21'),
	(49, 'UAE', '25 Pearl Road', 'Ajman', 'delivered', '2024-02-22'),
	(50, 'Singapore', '77 Garden Lane', 'Singapore', 'shipped', '2024-02-23'

);

SELECT * FROM authors;
SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM genres;
SELECT * FROM order_items;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM publishers;
SELECT * FROM shipping;

--1) Total revenue generated
SELECT SUM(subtotal) FROM order_items;
-- Insight: Helps measure the business's financial health and total earnings generated from all purchases

--2) Total orders per customer
SELECT c.first_name, c.last_name, COUNT(o.order_id) AS total_orders FROM orders o JOIN customers c ON c.customer_id=o.customer_id GROUP BY c.first_name, c.last_name ORDER BY total_orders DESC;
-- Insight: Identifies active customers and helps analyze customer purchasing frequency and engagement.

--3) Top 5 best selling books
SELECT b.title, SUM(o.quantity) AS total_quantity FROM books b JOIN order_items o ON b.book_id=o.book_id GROUP BY b.title ORDER BY total_quantity DESC LIMIT 5;
-- Insight: 1. Highlights the books driving the highest sales volume, helping optimize inventory planning and promotional strategies.
--2. A product may sell more but generate lower revenue, while another sells less yet contributes higher profits. Analyzing both prevents shallow business decisions.


--4)Revenue generated by each genre
SELECT g.genre_name, SUM(oi.subtotal) AS revenue_generated FROM order_items oi JOIN books b ON oi.book_id=b.book_id JOIN genres g ON b.genre_id=g.genre_id GROUP BY g.genre_name ORDER BY revenue_generated DESC;
-- Insight: Shows which book genres contribute the most revenue, helping the business focus on profitable categories.

--5)Average order value(Total revenue/No. of orders)
SELECT AVG(order_total) AS order_total FROM (SELECT order_id, SUM(subtotal) AS order_total FROM order_items GROUP BY order_id);
--or
SELECT SUM(subtotal) / COUNT(DISTINCT order_id) AS aov FROM order_items;
-- Insight:1. Measures the average amount customers spend per order and helps evaluate purchasing behavior.
-- 2. Useful after promotions to show whether discounts increased basket size or only reduced revenue quality

--ADVANCE QUERY
--6) Customer lifetime value(CLV) = aov x purchase frequency x customer lifespan or customer total overall spends
SELECT c.first_name, c.last_name, SUM(oi.subtotal) AS lifetime_value FROM customers c JOIN orders o ON c.customer_id=o.customer_id JOIN order_items oi ON o.order_id=oi.order_id GROUP BY c.customer_id, c.first_name, c.last_name ORDER BY lifetime_value;
-- Insight: 1. Identifies high-value customers who generate the most long-term revenue for the business.
-- 2. Identify customers for retention and priotize them for personalized marketing and quality service

--7) Top-selling author
SELECT a.author_name, SUM(oi.quantity) AS total 
FROM authors a 
JOIN books b ON a.author_id=b.author_id 
JOIN order_items oi ON b.book_id=oi.book_id 
GROUP BY a.author_name 
ORDER BY total DESC LIMIT 1;
-- Insight: Determines which author’s books are most popular among customers and generate the highest sales.

--8) Monthly revenue trend
SELECT
    TO_CHAR(o.order_date, 'YYYY-MM') AS month,
    SUM(oi.subtotal) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;
-- Insight: Analyzes how revenue changes over time and helps identify sales growth patterns and seasonal trends. i.e. when sales peaked and when they dipped.

--9) Customers who spent above average
WITH customer_spending AS
(SELECT c.first_name, c.last_name,c.customer_id, SUM(oi.subtotal) AS total
FROM customers c 
JOIN orders o ON o.customer_id=c.customer_id
Join order_items oi ON oi.order_id=o.order_id
GROUP BY c.first_name, c.last_name, c.customer_id
)
SELECT * FROM customer_spending 
WHERE total > (SELECT AVG(total) FROM customer_spending);
-- Insight: Helps identify premium customers who spend more than the average customer and may be suitable for loyalty programs.

--10) Books never ordered
SELECT title FROM books WHERE book_id NOT IN(SELECT book_id FROM order_items);
-- Insight: Identifies underperforming books that may require promotions, discounts, or removal from inventory.

--Window functions
--11) Rank customers by spending
SELECT c.first_name, c.last_name, c.customer_id, SUM(oi.subtotal) AS spending, RANK() OVER( ORDER BY SUM(oi.subtotal) DESC) AS spending_rank
FROM customers c 
JOIN orders o ON o.customer_id=c.customer_id
JOIN order_items oi ON o.order_id=oi.order_id
GROUP BY c.first_name, c.last_name, c.customer_id;
-- Insight: Ranks customers based on their spending to identify top contributors to business revenue.


--12) top 3 books in each genre
WITH rank_books AS(
SELECT g.genre_name, b.title, SUM(oi.quantity),
DENSE_RANK() OVER( PARTITION BY g.genre_name ORDER BY SUM(oi.quantity) DESC) AS rank_in_genre
FROM genres g 
JOIN books b ON g.genre_id=b.genre_id
JOIN order_items oi ON oi.book_id=b.book_id
GROUP BY g.genre_name, b.title
)
SELECT * FROM rank_books WHERE rank_in_genre <= 3;
-- Insight: Highlights the best-performing books within every genre to understand category-level customer preferences.


--13) Running total revenue = revenue till date
SELECT o.order_date, SUM(oi.subtotal) AS daily_revenue, SUM(SUM(oi.subtotal)) OVER( ORDER BY o.order_date) AS running_revenue
FROM orders o
JOIN order_items oi ON o.order_id=oi.order_id
GROUP BY o.order_date
ORDER BY o.order_date;
-- Insight: Tracks cumulative revenue growth over time and helps monitor overall financial progress.


--Higher level
--14) Low stock alert = stock of books less than 30
SELECT stock FROM books WHERE stock < 30;
-- Insight: Identifies books with critically low inventory levels to support timely restocking decisions.


--15) Most popular genre
SELECT g.genre_name, SUM(oi.quantity) AS sold
FROM books b 
JOIN genres g ON g.genre_id=b.genre_id
JOIN order_items oi ON oi.book_id=b.book_id
GROUP BY g.genre_name
ORDER BY sold DESC LIMIT 1;
-- Insight: 1. Determines which genre has the highest customer demand based on total books sold.
--2. Focus on high-performing categories to maximizr ROI

--16) Repeat customer = customers who placed more than 1 order
SELECT c.first_name, c.last_name, COUNT(o.order_id) AS no_of_orders
FROM customers c
JOIN orders o ON o.customer_id=c.customer_id
GROUP BY c.first_name, c.last_name
HAVING COUNT(o.order_id) > 1;
-- Insight: 1. Helps measure customer retention by identifying customers who place multiple orders.
--2. Find loyal customers contributing to recurring revenue
--3. Reflects satisfaction, trust and continued relevance towards the business

--17) Cancelled order percentage
WITH cancel_order AS(
SELECT COUNT(*) AS cancelled_order 
FROM orders
WHERE order_status = 'cancelled' 
)
SELECT 100*cancelled_order/(SELECT COUNT(*) FROM orders) AS cancelled_percentage 
FROM cancel_order;
-- Insight: Measures the proportion of cancelled orders to evaluate operational efficiency and customer satisfaction.

--18) Revenue by country
SELECT s.shipping_country, SUM(oi.subtotal) AS country_revenue
FROM shipping s
JOIN orders o ON s.shipping_id=o.shipping_id
JOIN order_items oi ON o.order_id=oi.order_id
GROUP BY s.shipping_country
ORDER BY country_revenue DESC; 
-- Insight: 1. Analyzes geographic revenue distribution to identify high-performing markets and regions.
-- 2. Helps allocate resources effectively

--19)Customer segmentation
WITH total_spend AS(
SELECT c.first_name, c.last_name, SUM(oi.subtotal) AS spend
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY c.first_name, c.last_name
)
SELECT first_name, last_name, CASE
	WHEN spend >= 200 THEN 'High Value'
	WHEN spend >= 100 THEN 'Average value'
	ELSE 'low value'
END AS customer_segmentation
FROM total_spend;
-- Insight:1. Groups customers into spending categories such as High, Medium, and Low Value for targeted marketing strategies.
--2. Business can strategise their ad spends

--20) Best month for sales
SELECT TO_CHAR( o.order_date, 'month') AS month, SUM(subtotal) AS sales
FROM orders o
JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY month
ORDER BY sales DESC LIMIT 1;
-- Insight: Identifies the highest revenue-generating month to support seasonal planning and promotional campaigns.


--21) Top publisher by revenue
SELECT p.publisher_name, SUM(oi.subtotal) AS sales
FROM publishers p
JOIN books b ON p.publisher_id=b.publisher_id
JOIN order_items oi ON b.book_id=oi.book_id
GROUP BY p.publisher_name
ORDER BY sales DESC LIMIT 1;
-- Insight: Helps in evaluating profitable publishing partnerships.

--22) Average books per order
SELECT AVG(total_books) AS avg_books_per_order
FROM(
    SELECT
        order_id,
        SUM(quantity) AS total_books
    FROM order_items
    GROUP BY order_id
) AS order_summary;
-- Insight: Analyze cart size

--23) Highest revenue generating books
SELECT b.title, SUM(oi.subtotal) AS revenue
FROM books b
JOIN order_items oi ON b.book_id = oi.book_id
GROUP BY b.title
ORDER BY revenue DESC LIMIT 1;
-- Insight:1. Helps in prioritizing profitable products.
--2. Indicates that business should increase stock of these products, promote them and negotiate better supplier rates
--3. Prevents warehouses from overstocking slow movers

--24) Daily sales performance ranking = ranks days based on revenue
SELECT order_date, SUM(oi.subtotal) AS revenue,
	DENSE_RANK() OVER(
        ORDER BY SUM(oi.subtotal) DESC
    ) AS sales_rank
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY order_date;
-- Insight: 1. Identifies peak revenue days and customer purchasing patterns.
--2. Helps in identifying anomaly detection as sudden drops can signal system issues, tracking issues or fulfillment problems before customers formally report them

--25) Churned customers = Customers who haven't placed an order in last 6 months
SELECT c.first_name, c.last_name, MAX(o.order_date) AS latest_order_date
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.first_name, c.last_name
HAVING MAX(o.order_date) < CURRENT_DATE - INTERVAL '6 months';
-- Insight:1. Identifies inactive users who may need re-engagement campaigns
--2. Can indicate dissatisfaction or changing needs
--3. Reactivation is cheaper than new acquisition

--To see tables that exist
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';