-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Funcion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Funcion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Funcion` (
  `Tipo` VARCHAR(20) NOT NULL,
  `Descripcion` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`Tipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`Proteina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Proteina` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Proteina` (
  `ID` INT NOT NULL,
  `Descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `Funcion_Tipo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Proteina_Funcion1_idx` (`Funcion_Tipo` ASC) VISIBLE,
  CONSTRAINT `fk_Proteina_Funcion1`
    FOREIGN KEY (`Funcion_Tipo`)
    REFERENCES `mydb`.`Funcion` (`Tipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`Efecto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Efecto` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Efecto` (
  `Fenotipo` VARCHAR(100) NOT NULL,
  `Descripcion` VARCHAR(200) NULL DEFAULT NULL,
  `Proteina_ID` INT NOT NULL,
  PRIMARY KEY (`Fenotipo`),
  INDEX `fk_Efectos_Proteina1_idx` (`Proteina_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Efectos_Proteina1`
    FOREIGN KEY (`Proteina_ID`)
    REFERENCES `mydb`.`Proteina` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`Gen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Gen` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Gen` (
  `ID` INT NOT NULL,
  `Longitud` INT NULL DEFAULT NULL,
  `Nombre` VARCHAR(50) NULL DEFAULT NULL,
  `Posicion` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Posición en el formato:\\nCROMOSOMA: POSICION ',
  `Funcion_Tipo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID`, `Funcion_Tipo`),
  INDEX `fk_Gen_Funcion1_idx` (`Funcion_Tipo` ASC) VISIBLE,
  CONSTRAINT `fk_Gen_Funcion1`
    FOREIGN KEY (`Funcion_Tipo`)
    REFERENCES `mydb`.`Funcion` (`Tipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`Mutacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Mutacion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Mutacion` (
  `ID` INT NOT NULL,
  `Codon_afectado` VARCHAR(45) NULL DEFAULT NULL,
  `Tipo` VARCHAR(45) NULL DEFAULT NULL,
  `Gen_ID` INT NOT NULL,
  `Efectos_Fenotipo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID`, `Gen_ID`, `Efectos_Fenotipo`),
  INDEX `fk_Mutacion_Gen_idx` (`Gen_ID` ASC) VISIBLE,
  INDEX `fk_Mutacion_Efectos1_idx` (`Efectos_Fenotipo` ASC) VISIBLE,
  CONSTRAINT `fk_Mutacion_Efectos1`
    FOREIGN KEY (`Efectos_Fenotipo`)
    REFERENCES `mydb`.`Efecto` (`Fenotipo`),
  CONSTRAINT `fk_Mutacion_Gen`
    FOREIGN KEY (`Gen_ID`)
    REFERENCES `mydb`.`Gen` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
