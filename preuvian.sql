-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`business`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`business` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ruc` INT(11) NULL,
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
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
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
    REFERENCES `mydb`.`business` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
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
-- Table `mydb`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NULL,
  `status` TINYINT NULL DEFAULT 1,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product` (
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
    REFERENCES `mydb`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`recommendation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`recommendation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recommendation_product1_idx` (`product_id` ASC),
  CONSTRAINT `fk_recommendation_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product_recommendation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product_recommendation` (
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
    REFERENCES `mydb`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_recommendation_recommendation1`
    FOREIGN KEY (`recommendation_id`)
    REFERENCES `mydb`.`recommendation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sale` (
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
    REFERENCES `mydb`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sale_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sale_detail` (
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
    REFERENCES `mydb`.`sale` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_detail_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`color`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`color` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NULL,
  `status` TINYINT NULL DEFAULT 1,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product_color`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product_color` (
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
    REFERENCES `mydb`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_color_color1`
    FOREIGN KEY (`color_id`)
    REFERENCES `mydb`.`color` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`photos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`photos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image` VARCHAR(300) NULL,
  `product_color_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_photos_product_color1_idx` (`product_color_id` ASC),
  CONSTRAINT `fk_photos_product_color1`
    FOREIGN KEY (`product_color_id`)
    REFERENCES `mydb`.`product_color` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`history` (
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
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`banner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`banner` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(80) NULL,
  `slogan` VARCHAR(80) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `image` VARCHAR(300) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`payment` (
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
    REFERENCES `mydb`.`sale` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
