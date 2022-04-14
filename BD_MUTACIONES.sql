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
-- Table `mydb`.`Efecto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Efecto` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Efecto` (
  `Fenotipo` VARCHAR(100) NOT NULL,
  `Descripcion` VARCHAR(500) NULL,
  PRIMARY KEY (`Fenotipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`Gen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Gen` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Gen` (
  `ID` INT NOT NULL,
  `ID_ncbi` INT NULL,
  `Longitud` INT NULL,
  `Nombre` VARCHAR(50) NULL,
  `Posicion` VARCHAR(45) NULL COMMENT 'Posición en el formato:\\\\nCROMOSOMA: POSICION ',
  `Funcion` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`Mutacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Mutacion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Mutacion` (
  `ID` VARCHAR(45) NOT NULL,
  `Codon_afectado` VARCHAR(45) NULL,
  `Tipo` VARCHAR(45) NULL,
  `Gen_ID` INT NOT NULL,
  `Efecto_Fenotipo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID`, `Gen_ID`, `Efecto_Fenotipo`),
  INDEX `fk_Mutacion_Gen_idx` (`Gen_ID` ASC) VISIBLE,
  INDEX `fk_Mutacion_Efecto1_idx` (`Efecto_Fenotipo` ASC) VISIBLE,
  CONSTRAINT `fk_Mutacion_Efecto1`
    FOREIGN KEY (`Efecto_Fenotipo`)
    REFERENCES `mydb`.`Efecto` (`Fenotipo`),
  CONSTRAINT `fk_Mutacion_Gen`
    FOREIGN KEY (`Gen_ID`)
    REFERENCES `mydb`.`Gen` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`Transcriptoma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Transcriptoma` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Transcriptoma` (
  `ID` VARCHAR(50) NOT NULL,
  `Longitud` INT NULL,
  `pos_init` INT NULL,
  `pos_stop` INT NULL,
  `Gen_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Transcriptoma_Gen1_idx` (`Gen_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Transcriptoma_Gen1`
    FOREIGN KEY (`Gen_ID`)
    REFERENCES `mydb`.`Gen` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Proteina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Proteina` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Proteina` (
  `ID` VARCHAR(45) NOT NULL,
  `Nombre` VARCHAR(50) NULL,
  `Longitud` INT NULL,
  `Descripcion` VARCHAR(500) NULL,
  `Transcriptoma_ID` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Proteina_Transcriptoma1_idx` (`Transcriptoma_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Proteina_Transcriptoma1`
    FOREIGN KEY (`Transcriptoma_ID`)
    REFERENCES `mydb`.`Transcriptoma` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`Pacientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pacientes` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pacientes` (
  `DNI` INT NOT NULL,
  `Clinica` VARCHAR(45) NULL,
  `Nombre` VARCHAR(45) NULL,
  `Apellidos` VARCHAR(45) NULL,
  `Edad` INT NULL,
  `Pais` VARCHAR(45) NULL,
  `Ciudad` VARCHAR(45) NULL,
  `Mutacion_ID` VARCHAR(45) NOT NULL,
  `Mutacion_Gen_ID` INT NOT NULL,
  `Mutacion_Efecto_Fenotipo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`DNI`, `Mutacion_ID`, `Mutacion_Gen_ID`, `Mutacion_Efecto_Fenotipo`),
  INDEX `fk_Pacientes_Mutacion1_idx` (`Mutacion_ID` ASC, `Mutacion_Gen_ID` ASC, `Mutacion_Efecto_Fenotipo` ASC) VISIBLE,
  CONSTRAINT `fk_Pacientes_Mutacion1`
    FOREIGN KEY (`Mutacion_ID` , `Mutacion_Gen_ID` , `Mutacion_Efecto_Fenotipo`)
    REFERENCES `mydb`.`Mutacion` (`ID` , `Gen_ID` , `Efecto_Fenotipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
