-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE TABLE IF NOT EXISTS `peruvian`.`business` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ruc` VARCHAR (11) NULL,
  `name` VARCHAR(80) NULL,
  `telephone_one` VARCHAR(80) NULL,
  `telephone_two` VARCHAR(80) NULL,
  `terms` TEXT NULL,
  `address` VARCHAR(150) NULL,
  `bank_account` VARCHAR(50) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peruvian`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peruvian`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `business_id` INT NOT NULL,
  `email` VARCHAR(200) NULL,
  `password` VARCHAR(250) NULL,
  `remember_token` VARCHAR(100) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_business_idx` (`business_id` ASC),
  CONSTRAINT `fk_user_business`
    FOREIGN KEY (`business_id`)
    REFERENCES `peruvian`.`business` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peruvian`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peruvian`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fb_id` VARCHAR(80) NULL,
  `fullname` VARCHAR(200) NULL,
  `email` VARCHAR(45) NULL,
  `district_id` INT(11) NULL,
  `phone` VARCHAR(45) NULL,
  `address` VARCHAR(200) NULL,
  `password` VARCHAR(80) NULL,
  `remember_token` VARCHAR(100) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peruvian`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peruvian`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NULL,
  `status` TINYINT NULL DEFAULT 1,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peruvian`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peruvian`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `title` VARCHAR(80) NULL,
  `unit_price` DECIMAL(10,2) NULL,
  `size` VARCHAR(45) NULL,
  `stock` INT NULL,
  `description` VARCHAR(300) NULL,
  `status` TINYINT NULL DEFAULT 1,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_category1_idx` (`category_id` ASC),
  INDEX `fk_product_customer1_idx` (`customer_id` ASC),
  CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `peruvian`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `peruvian`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peruvian`.`recommendation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peruvian`.`recommendation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recommendation_product1_idx` (`product_id` ASC),
  CONSTRAINT `fk_recommendation_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `peruvian`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peruvian`.`product_recommendation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peruvian`.`product_recommendation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `recommendation_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_recommendation_product1_idx` (`product_id` ASC),
  INDEX `fk_product_recommendation_recommendation1_idx` (`recommendation_id` ASC),
  CONSTRAINT `fk_product_recommendation_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `peruvian`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_recommendation_recommendation1`
    FOREIGN KEY (`recommendation_id`)
    REFERENCES `peruvian`.`recommendation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peruvian`.`sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peruvian`.`sale` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `registration_date` DATE NULL,
  `delivery_date` DATE NULL,
  `district_id` INT(11) NULL,
  `status` TINYINT NULL DEFAULT 1,
  `description` VARCHAR(200) NULL,
  `address` VARCHAR(200) NULL,
  `phone` VARCHAR(12) NULL,
  `subtotal` DECIMAL(7,2) NULL,
  `total` FLOAT(10,2) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sale_customer1_idx` (`customer_id` ASC),
  CONSTRAINT `fk_sale_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `peruvian`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peruvian`.`sale_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peruvian`.`sale_detail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sale_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `subtotal` FLOAT(10,2) NULL,
  `quantity` INT(11) NULL DEFAULT 0,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sale_detail_sale1_idx` (`sale_id` ASC),
  INDEX `fk_sale_detail_product1_idx` (`product_id` ASC),
  CONSTRAINT `fk_sale_detail_sale1`
    FOREIGN KEY (`sale_id`)
    REFERENCES `peruvian`.`sale` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_detail_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `peruvian`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peruvian`.`color`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peruvian`.`color` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NULL,
  `status` TINYINT NULL DEFAULT 1,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peruvian`.`product_color`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peruvian`.`product_color` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `color_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_color_product1_idx` (`product_id` ASC),
  INDEX `fk_product_color_color1_idx` (`color_id` ASC),
  CONSTRAINT `fk_product_color_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `peruvian`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_color_color1`
    FOREIGN KEY (`color_id`)
    REFERENCES `peruvian`.`color` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peruvian`.`photos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peruvian`.`photos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image` VARCHAR(300) NULL,
  `product_color_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_photos_product_color1_idx` (`product_color_id` ASC),
  CONSTRAINT `fk_photos_product_color1`
    FOREIGN KEY (`product_color_id`)
    REFERENCES `peruvian`.`product_color` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peruvian`.`history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peruvian`.`history` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(80) NULL,
  `description` VARCHAR(500) NULL,
  `image` VARCHAR(100) NULL,
  `video` VARCHAR(200) NULL,
  `status` TINYINT NULL DEFAULT 1,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_history_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_history_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `peruvian`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peruvian`.`banner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peruvian`.`banner` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(80) NULL,
  `slogan` VARCHAR(80) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `image` VARCHAR(300) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `peruvian`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `peruvian`.`payment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sale_id` INT NOT NULL,
  `amount` DECIMAL(10,2) NULL,
  `status` TINYINT NULL DEFAULT 1,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_payment_sale1_idx` (`sale_id` ASC),
  CONSTRAINT `fk_payment_sale1`
    FOREIGN KEY (`sale_id`)
    REFERENCES `peruvian`.`sale` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
