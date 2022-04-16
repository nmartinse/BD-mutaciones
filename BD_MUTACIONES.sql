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
-- -----------------------------------------------------
-- Schema chebi
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema chebi
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `chebi` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Efecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Efecto` (
  `Fenotipo` VARCHAR(100) NOT NULL,
  `Descripcion` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`Fenotipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`Gen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Gen` (
  `ID` INT NOT NULL,
  `ID_ncbi` INT NULL DEFAULT NULL,
  `Longitud` DOUBLE NULL DEFAULT NULL,
  `Nombre` VARCHAR(50) NULL DEFAULT NULL,
  `Posicion` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Posición en el formato:\\\\\\\\nCROMOSOMA: POSICION ',
  `Funcion` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`Mutacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mutacion` (
  `ID` VARCHAR(45) NOT NULL,
  `Codon_afectado` VARCHAR(45) NULL DEFAULT NULL,
  `Tipo` VARCHAR(45) NULL DEFAULT NULL,
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
-- Table `mydb`.`Pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pacientes` (
  `DNI` VARCHAR(9) NOT NULL,
  `Clinica` VARCHAR(45) NULL DEFAULT NULL,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `Edad` INT NULL DEFAULT NULL,
  `Pais` VARCHAR(45) NULL DEFAULT NULL,
  `Ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `Mutacion_ID` VARCHAR(45) NOT NULL,
  `Mutacion_Gen_ID` INT NOT NULL,
  `Mutacion_Efecto_Fenotipo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`DNI`, `Mutacion_ID`, `Mutacion_Gen_ID`, `Mutacion_Efecto_Fenotipo`),
  INDEX `fk_Pacientes_Mutacion1_idx` (`Mutacion_ID` ASC, `Mutacion_Gen_ID` ASC, `Mutacion_Efecto_Fenotipo` ASC) VISIBLE,
  CONSTRAINT `fk_Pacientes_Mutacion1`
    FOREIGN KEY (`Mutacion_ID` , `Mutacion_Gen_ID` , `Mutacion_Efecto_Fenotipo`)
    REFERENCES `mydb`.`Mutacion` (`ID` , `Gen_ID` , `Efecto_Fenotipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`Transcriptoma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Transcriptoma` (
  `ID` VARCHAR(50) NOT NULL,
  `Longitud` INT NULL DEFAULT NULL,
  `num_exons` INT NULL DEFAULT NULL,
  `Gen_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Transcriptoma_Gen1_idx` (`Gen_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Transcriptoma_Gen1`
    FOREIGN KEY (`Gen_ID`)
    REFERENCES `mydb`.`Gen` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`Proteina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Proteina` (
  `ID` VARCHAR(45) NOT NULL,
  `Nombre` VARCHAR(50) NULL DEFAULT NULL,
  `Longitud` INT NULL DEFAULT NULL,
  `Descripcion` VARCHAR(500) NULL DEFAULT NULL,
  `Transcriptoma_ID` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Proteina_Transcriptoma1_idx` (`Transcriptoma_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Proteina_Transcriptoma1`
    FOREIGN KEY (`Transcriptoma_ID`)
    REFERENCES `mydb`.`Transcriptoma` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `chebi` ;

-- -----------------------------------------------------
-- Table `chebi`.`compounds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chebi`.`compounds` (
  `id` INT NOT NULL,
  `name` TEXT NULL DEFAULT NULL,
  `source` VARCHAR(32) NOT NULL,
  `parent_id` INT NULL DEFAULT NULL,
  `chebi_accession` VARCHAR(30) NOT NULL,
  `status` VARCHAR(1) NOT NULL,
  `definition` TEXT NULL DEFAULT NULL,
  `star` INT NOT NULL,
  `modified_on` TEXT NULL DEFAULT NULL,
  `created_by` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `chebi`.`structures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chebi`.`structures` (
  `id` INT NOT NULL,
  `compound_id` INT NOT NULL,
  `structure` TEXT NOT NULL,
  `type` TEXT NOT NULL,
  `dimension` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_STRUCTURES_TO_COMPOUND` (`compound_id` ASC) VISIBLE,
  CONSTRAINT `structures_ibfk_1`
    FOREIGN KEY (`compound_id`)
    REFERENCES `chebi`.`compounds` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `chebi`.`autogen_structures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chebi`.`autogen_structures` (
  `id` INT NOT NULL,
  `structure_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_STRUCTURES_TO_AUTOGEN_STRUC` (`structure_id` ASC) VISIBLE,
  CONSTRAINT `autogen_structures_ibfk_1`
    FOREIGN KEY (`structure_id`)
    REFERENCES `chebi`.`structures` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `chebi`.`chemical_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chebi`.`chemical_data` (
  `id` INT NOT NULL,
  `compound_id` INT NOT NULL,
  `chemical_data` TEXT NOT NULL,
  `source` TEXT NOT NULL,
  `type` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `compound_id` (`compound_id` ASC) VISIBLE,
  CONSTRAINT `chemical_data_ibfk_1`
    FOREIGN KEY (`compound_id`)
    REFERENCES `chebi`.`compounds` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `chebi`.`database_accession`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chebi`.`database_accession` (
  `id` INT NOT NULL,
  `compound_id` INT NOT NULL,
  `accession_number` VARCHAR(255) NOT NULL,
  `type` TEXT NOT NULL,
  `source` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `compound_id` (`compound_id` ASC) VISIBLE,
  CONSTRAINT `database_accession_ibfk_1`
    FOREIGN KEY (`compound_id`)
    REFERENCES `chebi`.`compounds` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `chebi`.`default_structures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chebi`.`default_structures` (
  `id` INT NOT NULL,
  `structure_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_STRUCTURES_TO_DEFAULT_STRUC` (`structure_id` ASC) VISIBLE,
  CONSTRAINT `default_structures_ibfk_1`
    FOREIGN KEY (`structure_id`)
    REFERENCES `chebi`.`structures` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `chebi`.`names`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chebi`.`names` (
  `id` INT NOT NULL,
  `compound_id` INT NOT NULL,
  `name` TEXT NOT NULL,
  `type` TEXT NOT NULL,
  `source` TEXT NOT NULL,
  `adapted` TEXT NOT NULL,
  `language` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `compound_id` (`compound_id` ASC) VISIBLE,
  CONSTRAINT `names_ibfk_1`
    FOREIGN KEY (`compound_id`)
    REFERENCES `chebi`.`compounds` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `chebi`.`ontology`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chebi`.`ontology` (
  `id` INT NOT NULL,
  `title` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `chebi`.`vertice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chebi`.`vertice` (
  `id` INT NOT NULL,
  `vertice_ref` VARCHAR(60) NOT NULL,
  `compound_id` INT NULL DEFAULT NULL,
  `ontology_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UNIQUE_ONTOLOGY_REF` (`vertice_ref` ASC, `ontology_id` ASC) VISIBLE,
  INDEX `ontology_id` (`ontology_id` ASC) VISIBLE,
  CONSTRAINT `vertice_ibfk_1`
    FOREIGN KEY (`ontology_id`)
    REFERENCES `chebi`.`ontology` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
