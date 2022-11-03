-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema konto
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `konto` ;

-- -----------------------------------------------------
-- Schema konto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `konto` DEFAULT CHARACTER SET utf8 ;
USE `konto` ;

-- -----------------------------------------------------
-- Table `konto`.`kontotyp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `konto`.`kontotyp` (
  `koty_id` INT NOT NULL AUTO_INCREMENT,
  `koty_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`koty_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `konto`.`kunde`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `konto`.`kunde` (
  `kun_id` INT NOT NULL AUTO_INCREMENT,
  `kun_vname` VARCHAR(45) NOT NULL,
  `kun_nname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`kun_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `konto`.`kunde_kontotyp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `konto`.`kunde_kontotyp` (
  `kuko_iban` VARCHAR(22) NOT NULL,
  `kun_id` INT NOT NULL,
  `koty_id` INT NOT NULL,
  `kuko_soll_haben` DOUBLE NOT NULL DEFAULT 0,
  `kuko_rahmen` DOUBLE NOT NULL DEFAULT 0,
  PRIMARY KEY (`kuko_iban`),
  INDEX `fk_kontotyp_has_kunde_kunde1_idx` (`kun_id` ASC) VISIBLE,
  INDEX `fk_kontotyp_has_kunde_kontotyp_idx` (`koty_id` ASC) VISIBLE,
  CONSTRAINT `fk_kontotyp_has_kunde_kontotyp`
    FOREIGN KEY (`koty_id`)
    REFERENCES `konto`.`kontotyp` (`koty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kontotyp_has_kunde_kunde1`
    FOREIGN KEY (`kun_id`)
    REFERENCES `konto`.`kunde` (`kun_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `konto`.`buchung`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `konto`.`buchung` (
  `buch_id` INT NOT NULL AUTO_INCREMENT,
  `kuko_iban` VARCHAR(45) NOT NULL,
  `buch_betrag` DOUBLE NOT NULL,
  `buch_datum` DATETIME NOT NULL DEFAULT now(),
  PRIMARY KEY (`buch_id`),
  INDEX `fk_buchung_kunde_kontotyp1_idx` (`kuko_iban` ASC) VISIBLE,
  CONSTRAINT `fk_buchung_kunde_kontotyp1`
    FOREIGN KEY (`kuko_iban`)
    REFERENCES `konto`.`kunde_kontotyp` (`kuko_iban`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `konto`.`kontotyp`
-- -----------------------------------------------------
START TRANSACTION;
USE `konto`;
INSERT INTO `konto`.`kontotyp` (`koty_id`, `koty_name`) VALUES (DEFAULT, 'Giro');
INSERT INTO `konto`.`kontotyp` (`koty_id`, `koty_name`) VALUES (DEFAULT, 'Spar');
INSERT INTO `konto`.`kontotyp` (`koty_id`, `koty_name`) VALUES (DEFAULT, 'Treuhand');
INSERT INTO `konto`.`kontotyp` (`koty_id`, `koty_name`) VALUES (DEFAULT, 'Wertpapierdepot');
INSERT INTO `konto`.`kontotyp` (`koty_id`, `koty_name`) VALUES (DEFAULT, 'Jugend');

COMMIT;


-- -----------------------------------------------------
-- Data for table `konto`.`kunde`
-- -----------------------------------------------------
START TRANSACTION;
USE `konto`;
INSERT INTO `konto`.`kunde` (`kun_id`, `kun_vname`, `kun_nname`) VALUES (DEFAULT, 'Bob', 'Maier');
INSERT INTO `konto`.`kunde` (`kun_id`, `kun_vname`, `kun_nname`) VALUES (DEFAULT, 'Isabelle', 'Klapper');
INSERT INTO `konto`.`kunde` (`kun_id`, `kun_vname`, `kun_nname`) VALUES (DEFAULT, 'Martin', 'Reich');
INSERT INTO `konto`.`kunde` (`kun_id`, `kun_vname`, `kun_nname`) VALUES (DEFAULT, 'Roswitha', 'Huber');

COMMIT;


-- -----------------------------------------------------
-- Data for table `konto`.`kunde_kontotyp`
-- -----------------------------------------------------
START TRANSACTION;
USE `konto`;
INSERT INTO `konto`.`kunde_kontotyp` (`kuko_iban`, `kun_id`, `koty_id`, `kuko_soll_haben`, `kuko_rahmen`) VALUES ('AT441904300234573201', 1, 1, -4940, -5000);
INSERT INTO `konto`.`kunde_kontotyp` (`kuko_iban`, `kun_id`, `koty_id`, `kuko_soll_haben`, `kuko_rahmen`) VALUES ('AT441664200456745280', 2, 5, 500, DEFAULT);
INSERT INTO `konto`.`kunde_kontotyp` (`kuko_iban`, `kun_id`, `koty_id`, `kuko_soll_haben`, `kuko_rahmen`) VALUES ('AT447845687897542447', 3, 1, 54000, -100000);
INSERT INTO `konto`.`kunde_kontotyp` (`kuko_iban`, `kun_id`, `koty_id`, `kuko_soll_haben`, `kuko_rahmen`) VALUES ('AT448732546587987156', 3, 4, 250000, DEFAULT);
INSERT INTO `konto`.`kunde_kontotyp` (`kuko_iban`, `kun_id`, `koty_id`, `kuko_soll_haben`, `kuko_rahmen`) VALUES ('AT441111222244442222', 3, 2, 1000, -2000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `konto`.`buchung`
-- -----------------------------------------------------
START TRANSACTION;
USE `konto`;
INSERT INTO `konto`.`buchung` (`buch_id`, `kuko_iban`, `buch_betrag`, `buch_datum`) VALUES (DEFAULT, 'AT441904300234573201', 10, '2022-01-01 00:00:00');
INSERT INTO `konto`.`buchung` (`buch_id`, `kuko_iban`, `buch_betrag`, `buch_datum`) VALUES (64213, 'AT441904300234573201', 7650.22, '2022-06-01 06:15:01');
INSERT INTO `konto`.`buchung` (`buch_id`, `kuko_iban`, `buch_betrag`, `buch_datum`) VALUES (DEFAULT, 'AT441904300234573201', -7690.22, '2022-06-13 06:17:09');
INSERT INTO `konto`.`buchung` (`buch_id`, `kuko_iban`, `buch_betrag`, `buch_datum`) VALUES (DEFAULT, 'AT441664200456745280', -200, '2022-04-10 12:45:13');
INSERT INTO `konto`.`buchung` (`buch_id`, `kuko_iban`, `buch_betrag`, `buch_datum`) VALUES (DEFAULT, 'AT447845687897542447', 123.59, '2022-09-20 23:05:22');
INSERT INTO `konto`.`buchung` (`buch_id`, `kuko_iban`, `buch_betrag`, `buch_datum`) VALUES (DEFAULT, 'AT448732546587987156', -22.99, '2022-09-20 23:59:01');
INSERT INTO `konto`.`buchung` (`buch_id`, `kuko_iban`, `buch_betrag`, `buch_datum`) VALUES (DEFAULT, 'AT441111222244442222', 2349, '2022-09-21 08:46:01');

COMMIT;

