-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Examen2021Kameyha
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Examen2021Kameyha` ;

-- -----------------------------------------------------
-- Schema Examen2021Kameyha
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Examen2021Kameyha` DEFAULT CHARACTER SET utf8 ;
USE `Examen2021Kameyha` ;

-- -----------------------------------------------------
-- Table `Examen2021Kameyha`.`Domicilios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2021Kameyha`.`Domicilios` ;

CREATE TABLE IF NOT EXISTS `Examen2021Kameyha`.`Domicilios` (
  `idDomicilio` INT NOT NULL,
  `calleYNumero` VARCHAR(50) NOT NULL,
  `codigoPostal` VARCHAR(10) NULL,
  `telefono` VARCHAR(25) NOT NULL,
  `municipio` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idDomicilio`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `calleYNumero_UNIQUE` ON `Examen2021Kameyha`.`Domicilios` (`calleYNumero` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2021Kameyha`.`Clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2021Kameyha`.`Clientes` ;

CREATE TABLE IF NOT EXISTS `Examen2021Kameyha`.`Clientes` (
  `idCliente` INT NOT NULL,
  `apellidos` VARCHAR(50) NOT NULL,
  `nombres` VARCHAR(50) NOT NULL,
  `correo` VARCHAR(50) NULL,
  `estado` ENUM('E', 'D') NOT NULL DEFAULT 'E',
  `idDomicilio` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  CONSTRAINT `fk_Clientes_Domicilios`
    FOREIGN KEY (`idDomicilio`)
    REFERENCES `Examen2021Kameyha`.`Domicilios` (`idDomicilio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Clientes_Domicilios_idx` ON `Examen2021Kameyha`.`Clientes` (`idDomicilio` ASC) VISIBLE;

CREATE UNIQUE INDEX `correo_UNIQUE` ON `Examen2021Kameyha`.`Clientes` (`correo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2021Kameyha`.`Tiendas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2021Kameyha`.`Tiendas` ;

CREATE TABLE IF NOT EXISTS `Examen2021Kameyha`.`Tiendas` (
  `idTienda` INT NOT NULL,
  `idDomicilio` INT NOT NULL,
  PRIMARY KEY (`idTienda`),
  CONSTRAINT `fk_Tiendas_Domicilios1`
    FOREIGN KEY (`idDomicilio`)
    REFERENCES `Examen2021Kameyha`.`Domicilios` (`idDomicilio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Tiendas_Domicilios1_idx` ON `Examen2021Kameyha`.`Tiendas` (`idDomicilio` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2021Kameyha`.`Peliculas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2021Kameyha`.`Peliculas` ;

CREATE TABLE IF NOT EXISTS `Examen2021Kameyha`.`Peliculas` (
  `idPelicula` INT NOT NULL,
  `titulo` VARCHAR(128) NOT NULL,
  `clasificacion` ENUM('G', 'PG', 'PG-13', 'R', 'NC-17') NOT NULL DEFAULT 'G',
  `estreno` INT NULL,
  `duracion` INT NULL,
  PRIMARY KEY (`idPelicula`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `titulo_UNIQUE` ON `Examen2021Kameyha`.`Peliculas` (`titulo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2021Kameyha`.`Registros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2021Kameyha`.`Registros` ;

CREATE TABLE IF NOT EXISTS `Examen2021Kameyha`.`Registros` (
  `idRegistro` INT NOT NULL,
  `idTienda` INT NOT NULL,
  `idPelicula` INT NOT NULL,
  PRIMARY KEY (`idRegistro`),
  CONSTRAINT `fk_Registros_Tiendas1`
    FOREIGN KEY (`idTienda`)
    REFERENCES `Examen2021Kameyha`.`Tiendas` (`idTienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registros_Peliculas1`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `Examen2021Kameyha`.`Peliculas` (`idPelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Registros_Tiendas1_idx` ON `Examen2021Kameyha`.`Registros` (`idTienda` ASC) VISIBLE;

CREATE INDEX `fk_Registros_Peliculas1_idx` ON `Examen2021Kameyha`.`Registros` (`idPelicula` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2021Kameyha`.`Alquileres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2021Kameyha`.`Alquileres` ;

CREATE TABLE IF NOT EXISTS `Examen2021Kameyha`.`Alquileres` (
  `idAlquiler` INT NOT NULL,
  `fechaAlquiler` DATETIME NOT NULL,
  `fechaDevolucion` DATETIME NULL,
  `idCliente` INT NOT NULL,
  `idRegistro` INT NOT NULL,
  PRIMARY KEY (`idAlquiler`),
  CONSTRAINT `fk_Alquileres_Clientes1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Examen2021Kameyha`.`Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alquileres_Registros1`
    FOREIGN KEY (`idRegistro`)
    REFERENCES `Examen2021Kameyha`.`Registros` (`idRegistro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Alquileres_Clientes1_idx` ON `Examen2021Kameyha`.`Alquileres` (`idCliente` ASC) VISIBLE;

CREATE INDEX `fk_Alquileres_Registros1_idx` ON `Examen2021Kameyha`.`Alquileres` (`idRegistro` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2021Kameyha`.`Pagos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2021Kameyha`.`Pagos` ;

CREATE TABLE IF NOT EXISTS `Examen2021Kameyha`.`Pagos` (
  `idPago` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `idAlquiler` INT NOT NULL,
  `importe` DECIMAL(5,2) NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`idPago`),
  CONSTRAINT `fk_Pagos_Clientes1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Examen2021Kameyha`.`Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pagos_Alquileres1`
    FOREIGN KEY (`idAlquiler`)
    REFERENCES `Examen2021Kameyha`.`Alquileres` (`idAlquiler`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Pagos_Clientes1_idx` ON `Examen2021Kameyha`.`Pagos` (`idCliente` ASC) VISIBLE;

CREATE INDEX `fk_Pagos_Alquileres1_idx` ON `Examen2021Kameyha`.`Pagos` (`idAlquiler` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- SELECT * FROM Peliculas;
/* 2) Crear una vista llamada VRankingAlquileres que muestre un ranking con los 10 clientes
que más cantidad de películas hayan alquilado. Por cada cliente se deberá mostrar su
código, apellido y nombre (formato: apellido, nombre) y la cantidad total de alquileres. La
salida deberá estar ordenada descendentemente según la cantidad de alquileres, y para el
caso de 2 clientes con la misma cantidad de alquileres, alfabéticamente según apellido y
nombre. Incluir el código con la consulta a la vista.*/

DROP VIEW IF EXISTS VRankingAlquileres;
CREATE VIEW VRankingAlquileres (Codigo,Nombre,Apellido)