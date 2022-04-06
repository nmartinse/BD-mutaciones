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
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema BD_MUTACIONES
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema new_schema3
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Funcion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Funcion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Funcion` (
  `Tipo` VARCHAR(20) NOT NULL,
  `Descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`Tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Gen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Gen` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Gen` (
  `ID_gen` INT NOT NULL,
  `Longitud` INT NULL,
  `Nombre` VARCHAR(50) NULL,
  `Posicion` VARCHAR(45) NULL COMMENT 'Posición en el formato:\nCROMOSOMA: POSICION ',
  `Funcion_Tipo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID_gen`, `Funcion_Tipo`),
  INDEX `fk_Gen_Funcion1_idx` (`Funcion_Tipo` ASC) VISIBLE,
  CONSTRAINT `fk_Gen_Funcion1`
    FOREIGN KEY (`Funcion_Tipo`)
    REFERENCES `mydb`.`Funcion` (`Tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Proteina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Proteina` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Proteina` (
  `ID_Proteina` INT NOT NULL,
  `Descripcion` VARCHAR(45) NULL,
  `Funcion_Tipo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID_Proteina`),
  INDEX `fk_Proteina_Funcion1_idx` (`Funcion_Tipo` ASC) VISIBLE,
  CONSTRAINT `fk_Proteina_Funcion1`
    FOREIGN KEY (`Funcion_Tipo`)
    REFERENCES `mydb`.`Funcion` (`Tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Efecto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Efecto` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Efecto` (
  `Fenotipo` INT NOT NULL,
  `Descripcion` VARCHAR(45) NULL,
  `Proteina_ID_Proteina` INT NOT NULL,
  PRIMARY KEY (`Fenotipo`),
  INDEX `fk_Efectos_Proteina1_idx` (`Proteina_ID_Proteina` ASC) VISIBLE,
  CONSTRAINT `fk_Efectos_Proteina1`
    FOREIGN KEY (`Proteina_ID_Proteina`)
    REFERENCES `mydb`.`Proteina` (`ID_Proteina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mutacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Mutacion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Mutacion` (
  `ID_OMIM` INT NOT NULL,
  `Codon_afectado` VARCHAR(45) NULL,
  `Tipo` VARCHAR(45) NULL,
  `Gen_ID_gen` INT NOT NULL,
  `Efectos_Fenotipo` INT NOT NULL,
  PRIMARY KEY (`ID_OMIM`, `Gen_ID_gen`, `Efectos_Fenotipo`),
  INDEX `fk_Mutacion_Gen_idx` (`Gen_ID_gen` ASC) VISIBLE,
  INDEX `fk_Mutacion_Efectos1_idx` (`Efectos_Fenotipo` ASC) VISIBLE,
  CONSTRAINT `fk_Mutacion_Gen`
    FOREIGN KEY (`Gen_ID_gen`)
    REFERENCES `mydb`.`Gen` (`ID_gen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mutacion_Efectos1`
    FOREIGN KEY (`Efectos_Fenotipo`)
    REFERENCES `mydb`.`Efecto` (`Fenotipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
