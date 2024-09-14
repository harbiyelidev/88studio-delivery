CREATE TABLE IF NOT EXISTS `88studio_delivery` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`citizenid` VARCHAR(100) DEFAULT NULL,
	`current_xp` INT DEFAULT 0,
	`duty_time` INT DEFAULT 0,
	`total_package` INT DEFAULT 0,
	`total_cash` INT DEFAULT 0,
	`total_km` INT DEFAULT 0,
	`total_xp` INT DEFAULT 0,
	PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;