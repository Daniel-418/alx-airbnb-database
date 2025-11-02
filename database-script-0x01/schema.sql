CREATE TABLE `User` (
	`user_id` CHAR(36) PRIMARY KEY,
	`first_name` VARCHAR(250) NOT NULL,
	`last_name` VARCHAR(250) NOT NULL,
	`email` VARCHAR(250) NOT NULL,
	`password_hash` VARCHAR(250) NOT NULL,
	`phone_number` VARCHAR(250),
	`role` ENUM ('guest', 'host', 'admin') NOT NULL,
	`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT `UQ_User_Email` UNIQUE (`email`)
);

CREATE TABLE `Property`(
	`property_id` CHAR(36) PRIMARY KEY,
	`host_id` CHAR(36) NOT NULL,
	`name` VARCHAR(50) NOT NULL,
	`description` TEXT NOT NULL,
	`location` VARCHAR(250) NOT NULL,
	`pricepernight` DECIMAL NOT NULL,
	`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT `FK_Property_Host` FOREIGN KEY (`host_id`) REFERENCES `User`(`user_id`)
);

CREATE TABLE `Booking` (	
	`booking_id` CHAR(36) PRIMARY KEY,
	`property_id` CHAR(36) NOT NULL,
	`user_id` CHAR(36) NOT NULL,
	`start_date` DATE NOT NULL,
	`end_date` DATE NOT NULL,
	`total_price` DECIMAL NOT NULL,
	`status` ENUM ('pending', 'confirmed', 'canceled') NOT NULL,
	`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT `FK_Booking_property` FOREIGN KEY (`property_id`) REFERENCES `Property`(`property_id`),
	CONSTRAINT `FK_Booking_user` FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`)
);

CREATE TABLE `Payment` (
	`payment_id` CHAR(36) PRIMARY KEY,
	`booking_id` CHAR(36) NOT NULL,
	`amount` DECIMAL NOT NULL,
	`payment_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`payment_method` ENUM ('credit_card', 'paypal', 'stripe') NOT NULL,
	CONSTRAINT `FK_payment_booking` FOREIGN KEY (`booking_id`) REFERENCES `Booking`(`booking_id`)
);

CREATE TABLE `Review` (
	`review_id` CHAR(36) PRIMARY KEY,
	`property_id` CHAR(36) NOT NULL,
	`user_id` CHAR(36) NOT NULL,
	`rating` INTEGER CHECK (rating >= 1 AND rating <= 5),
	`comment` TEXT NOT NULL,
	`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT `FK_Review_property` FOREIGN KEY (`property_id`) REFERENCES `Property`(`property_id`),
	CONSTRAINT `FK_Review_user` FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`)
);

CREATE TABLE `Message` (
	`message_id` CHAR(36) PRIMARY KEY,
	`sender_id` CHAR(36) NOT NULL,
	`recipient_id` CHAR(36) NOT NULL,
	`message_body` TEXT NOT NULL,
	`sent_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT `FK_message_sender` FOREIGN KEY (`sender_id`) REFERENCES `User`(`user_id`),
	CONSTRAINT `FK_message_recipient` FOREIGN KEY (`recipient_id`) REFERENCES `User`(`user_id`)
);
