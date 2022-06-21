-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Examen2019
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Examen2019` ;

-- -----------------------------------------------------
-- Schema Examen2019
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Examen2019` DEFAULT CHARACTER SET utf8 ;
USE `Examen2019` ;

-- -----------------------------------------------------
-- Table `Examen2019`.`Puestos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2019`.`Puestos` ;

CREATE TABLE IF NOT EXISTS `Examen2019`.`Puestos` (
  `puesto` INT NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`puesto`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `Examen2019`.`Puestos` (`nombre` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2019`.`Personas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2019`.`Personas` ;

CREATE TABLE IF NOT EXISTS `Examen2019`.`Personas` (
  `persona` INT NOT NULL,
  `nombres` VARCHAR(25) NOT NULL,
  `apellidos` VARCHAR(25) NOT NULL,
  `puesto` INT NOT NULL,
  `fechaIngreso` DATE NOT NULL,
  `fechaBaja` DATE NULL,
  PRIMARY KEY (`persona`),
  CONSTRAINT `fk_Personas_Puestos`
    FOREIGN KEY (`puesto`)
    REFERENCES `Examen2019`.`Puestos` (`puesto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Personas_Puestos_idx` ON `Examen2019`.`Personas` (`puesto` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2019`.`Categorias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2019`.`Categorias` ;

CREATE TABLE IF NOT EXISTS `Examen2019`.`Categorias` (
  `categoria` INT NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`categoria`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `Examen2019`.`Categorias` (`nombre` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2019`.`Niveles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2019`.`Niveles` ;

CREATE TABLE IF NOT EXISTS `Examen2019`.`Niveles` (
  `nivel` INT NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`nivel`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `Examen2019`.`Niveles` (`nombre` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2019`.`Conocimientos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2019`.`Conocimientos` ;

CREATE TABLE IF NOT EXISTS `Examen2019`.`Conocimientos` (
  `conocimiento` INT NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  `categoria` INT NOT NULL,
  PRIMARY KEY (`conocimiento`),
  CONSTRAINT `fk_Conocimientos_Categorias1`
    FOREIGN KEY (`categoria`)
    REFERENCES `Examen2019`.`Categorias` (`categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Conocimientos_Categorias1_idx` ON `Examen2019`.`Conocimientos` (`categoria` ASC) VISIBLE;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `Examen2019`.`Conocimientos` (`nombre` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2019`.`Habilidades`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2019`.`Habilidades` ;

CREATE TABLE IF NOT EXISTS `Examen2019`.`Habilidades` (
  `habilidad` INT NOT NULL,
  `persona` INT NOT NULL,
  `conocimiento` INT NOT NULL,
  `nivel` INT NOT NULL,
  `fechaUltimaModificacion` DATE NOT NULL,
  `observaciones` VARCHAR(200) NULL,
  PRIMARY KEY (`habilidad`),
  CONSTRAINT `fk_Habilidades_Conocimientos1`
    FOREIGN KEY (`conocimiento`)
    REFERENCES `Examen2019`.`Conocimientos` (`conocimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Habilidades_Personas1`
    FOREIGN KEY (`persona`)
    REFERENCES `Examen2019`.`Personas` (`persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Habilidades_Niveles1`
    FOREIGN KEY (`nivel`)
    REFERENCES `Examen2019`.`Niveles` (`nivel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Habilidades_Conocimientos1_idx` ON `Examen2019`.`Habilidades` (`conocimiento` ASC) VISIBLE;

CREATE INDEX `fk_Habilidades_Personas1_idx` ON `Examen2019`.`Habilidades` (`persona` ASC) VISIBLE;

CREATE INDEX `fk_Habilidades_Niveles1_idx` ON `Examen2019`.`Habilidades` (`nivel` ASC) VISIBLE;

CREATE UNIQUE INDEX `ui_Habilidades_PersonayConocimiento` ON `Examen2019`.`Habilidades` (`persona` ASC, `conocimiento` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
