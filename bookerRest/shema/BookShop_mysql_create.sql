CREATE TABLE `AUTHORS` (
	`id` INT(32) NOT NULL AUTO_INCREMENT,
	`name` varchar(64) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `BOOKS` (
	`id` INT(32) NOT NULL,
	`title` varchar(128) NOT NULL,
	`price` FLOAT(16) NOT NULL,
	`descript` TEXT(512) NOT NULL,
	`discount` INT(16) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `BOOK_TO_AUTHOR` (
	`id_author` INT(32) NOT NULL,
	`id_book` INT(32) NOT NULL
);

CREATE TABLE `GENRE` (
	`id` INT(32) NOT NULL,
	`name` varchar(64) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `BOOK_TO_GENRE` (
	`id_genre` INT(32) NOT NULL,
	`id_book` INT(32) NOT NULL
);

CREATE TABLE `CUSTOMERS` (
	`id` INT(32) NOT NULL,
	`name` varchar(64) NOT NULL,
	`login` varchar(32) NOT NULL,
	`pass` varchar(32) NOT NULL,
	`discount` INT(16) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `DISCOUNT` (
	`id` INT(32) NOT NULL AUTO_INCREMENT,
	`name` varchar(64) NOT NULL,
	`precents` INT(16) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `CART` (
	`id_customer` INT(32) NOT NULL,
	`id_book` INT(32) NOT NULL,
	`count` INT(32) NOT NULL
);

CREATE TABLE `ORDERS` (
	`id` INT(32) NOT NULL,
	`id_customer` INT(32) NOT NULL,
	`id_status` INT(32) NOT NULL,
	`id_payment` INT(32) NOT NULL,
	`discount_customer` INT(16) NOT NULL,
	-- `date_time` DATETIME(16) NOT NULL,
	`total` FLOAT(16) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `ORDER_STATUS` (
	`id` INT(32) NOT NULL,
	`ord_name` varchar(64) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `PAYMENT` (
	`id` INT(32) NOT NULL,
	`name` varchar(64) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `ORDER_FULL_INFO` (
	`id_book` INT(32) NOT NULL,
	`id_order` INT(32) NOT NULL,
	`title_book` varchar(128) NOT NULL,
	`quanttity` INT(16) NOT NULL,
	`discount_book` INT(16) NOT NULL
);

CREATE TABLE `HISTORY_BOOK` (
	`id_book` INT(32) NOT NULL,
	`title` varchar(128) NOT NULL,
	`author` varchar(128) NOT NULL,
	`genre` varchar(128) NOT NULL,
	`price` FLOAT(16) NOT NULL
);

ALTER TABLE `DISCOUNT` ADD CONSTRAINT `DISCOUNT_fk0` FOREIGN KEY (`precents`) REFERENCES `BOOKS`(`discount`);

ALTER TABLE `BOOK_TO_AUTHOR` ADD CONSTRAINT `BOOK_TO_AUTHOR_fk0` FOREIGN KEY (`id_author`) REFERENCES `AUTHORS`(`id`);

ALTER TABLE `BOOK_TO_AUTHOR` ADD CONSTRAINT `BOOK_TO_AUTHOR_fk1` FOREIGN KEY (`id_book`) REFERENCES `BOOKS`(`id`);

ALTER TABLE `BOOK_TO_GENRE` ADD CONSTRAINT `BOOK_TO_GENRE_fk0` FOREIGN KEY (`id_genre`) REFERENCES `GENRE`(`id`);

ALTER TABLE `BOOK_TO_GENRE` ADD CONSTRAINT `BOOK_TO_GENRE_fk1` FOREIGN KEY (`id_book`) REFERENCES `BOOKS`(`id`);

ALTER TABLE `CUSTOMERS` ADD CONSTRAINT `CUSTOMERS_fk0` FOREIGN KEY (`discount`) REFERENCES `DISCOUNT`(`id`);

ALTER TABLE `CART` ADD CONSTRAINT `CART_fk0` FOREIGN KEY (`id_customer`) REFERENCES `CUSTOMERS`(`id`);

ALTER TABLE `CART` ADD CONSTRAINT `CART_fk1` FOREIGN KEY (`id_book`) REFERENCES `BOOKS`(`id`);

ALTER TABLE `ORDERS` ADD CONSTRAINT `ORDERS_fk0` FOREIGN KEY (`id_customer`) REFERENCES `CUSTOMERS`(`id`);

ALTER TABLE `ORDERS` ADD CONSTRAINT `ORDERS_fk1` FOREIGN KEY (`id_status`) REFERENCES `ORDER_STATUS`(`id`);

ALTER TABLE `ORDERS` ADD CONSTRAINT `ORDERS_fk2` FOREIGN KEY (`id_payment`) REFERENCES `PAYMENT`(`id`);

ALTER TABLE `ORDERS` ADD CONSTRAINT `ORDERS_fk3` FOREIGN KEY (`discount_customer`) REFERENCES `CUSTOMERS`(`discount`);

ALTER TABLE `ORDER_FULL_INFO` ADD CONSTRAINT `ORDER_FULL_INFO_fk0` FOREIGN KEY (`id_book`) REFERENCES `BOOKS`(`id`);

ALTER TABLE `ORDER_FULL_INFO` ADD CONSTRAINT `ORDER_FULL_INFO_fk1` FOREIGN KEY (`id_order`) REFERENCES `ORDERS`(`id`);

ALTER TABLE `ORDER_FULL_INFO` ADD CONSTRAINT `ORDER_FULL_INFO_fk2` FOREIGN KEY (`title_book`) REFERENCES `BOOKS`(`title`);

ALTER TABLE `ORDER_FULL_INFO` ADD CONSTRAINT `ORDER_FULL_INFO_fk3` FOREIGN KEY (`discount_book`) REFERENCES `BOOKS`(`discount`);

ALTER TABLE `HISTORY_BOOK` ADD CONSTRAINT `HISTORY_BOOK_fk0` FOREIGN KEY (`id_book`) REFERENCES `BOOKS`(`id`);

ALTER TABLE `HISTORY_BOOK` ADD CONSTRAINT `HISTORY_BOOK_fk1` FOREIGN KEY (`title`) REFERENCES `BOOKS`(`title`);

ALTER TABLE `HISTORY_BOOK` ADD CONSTRAINT `HISTORY_BOOK_fk2` FOREIGN KEY (`author`) REFERENCES `AUTHORS`(`name`);

ALTER TABLE `HISTORY_BOOK` ADD CONSTRAINT `HISTORY_BOOK_fk3` FOREIGN KEY (`genre`) REFERENCES `GENRE`(`name`);

ALTER TABLE `HISTORY_BOOK` ADD CONSTRAINT `HISTORY_BOOK_fk4` FOREIGN KEY (`price`) REFERENCES `BOOKS`(`price`);
