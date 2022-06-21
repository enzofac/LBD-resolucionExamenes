-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

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


-- SET SQL_MODE=@OLD_SQL_MODE;
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
CREATE VIEW VRankingAlquileres (Codigo,ApellidosyNombres,CantidadAlquileres)
AS
	SELECT Clientes.idCliente, CONCAT(Clientes.apellidos,' ', Clientes.nombres), COUNT(Peliculas.idPelicula) AS CantidadAlquileres
    FROM
    Clientes LEFT JOIN Alquileres ON Clientes.idCliente = Alquileres.idCliente
			 LEFT JOIN Registros ON Alquileres.idRegistro = Registros.idRegistro
             LEFT JOIN Peliculas ON Registros.idPelicula = Peliculas.idPelicula
	GROUP BY Clientes.idCliente, Clientes.apellidos, Clientes.nombres
    ORDER BY CantidadAlquileres DESC, Clientes.apellidos ASC, Clientes.nombres ASC
    LIMIT 10;

SELECT * FROM VRankingAlquileres;    

/*3) Realizar un procedimiento almacenado llamado BorrarPelicula para borrar una película,
incluyendo el control de errores lógicos y mensajes de error necesarios (implementar la
lógica del manejo de errores empleando parámetros de salida). Incluir el código con la
llamada al procedimiento probando todos los casos con datos incorrectos y uno con datos
correctos.*/

DROP PROCEDURE IF EXISTS spBorrarPelicula;
DELIMITER //
CREATE PROCEDURE spBorrarPelicula(IN pIdPelicula INT, OUT mensaje VARCHAR(100))
BEGIN
	IF pIdPelicula IS NULL THEN
		SET mensaje = 'ERROR: Código de película vacío';
	ELSEIF EXISTS (SELECT * FROM Registros WHERE Registros.idPelicula = pIdPelicula) THEN
		SET mensaje = 'ERROR: La pelicula tiene asociado registro/s';
	ELSEIF NOT EXISTS (SELECT * FROM Peliculas WHERE Peliculas.idPelicula = pIdPelicula) THEN 
		SET mensaje = 'ERROR: La pelicula no existe';
	ELSE
		START TRANSACTION;
			DELETE FROM Peliculas WHERE Peliculas.idPelicula = pIdPelicula;
			SET mensaje = 'Pelicula borrada con éxito';
	END IF;
END //
DELIMITER ;
CALL spBorrarPelicula(null,@resultado); -- parámetro null
SELECT @resultado;
SELECT * FROM Registros;
CALL spBorrarPelicula(1,@resultado); -- película asociada a registro
SELECT @resultado;
SELECT * FROM Peliculas;
CALL spBorrarPelicula(2000,@resultado); -- película no existe
SELECT @resultado;
SELECT * FROM Peliculas LEFT JOIN Registros ON Peliculas.idPelicula = Registros.idPelicula;-- id 14 no tiene registros
CALL spBorrarPelicula(14,@resultado); -- correcto
SELECT @resultado;
SELECT * FROM Peliculas;

/*4) Realizar un procedimiento almacenado llamado TotalAlquileres que reciba el código de
un cliente y muestre por cada película la cantidad de veces que la alquiló. Se deberá
mostrar el código de la película, su título y la cantidad de veces que fue alquilada. Al final
del listado deberá mostrar también la cantidad total de alquileres efectuados. La salida
deberá estar ordenada alfabéticamente según el título de la película. Incluir en el código la
llamada al procedimiento.*/

DROP PROCEDURE IF EXISTS spTotalAlquileres;
DELIMITER //
CREATE PROCEDURE spTotalAlquileres (IN pIdCliente INT)
BEGIN
	SELECT Peliculas.idPelicula, Peliculas.titulo, COUNT(Alquileres.idAlquiler) AS 'Cantidad'
    FROM
    Clientes LEFT JOIN Alquileres ON Clientes.idCliente = Alquileres.idCliente
			 LEFT JOIN Registros ON Alquileres.idRegistro = Registros.idRegistro
             LEFT JOIN Peliculas ON Registros.idPelicula = Peliculas.idPelicula
	WHERE Clientes.idCliente = pIdCliente
	GROUP BY Peliculas.idPelicula, Peliculas.titulo  WITH ROLLUP
    ORDER BY Peliculas.titulo ASC;
END //
DELIMITER ;
-- se tuvo que modificar el SQL_MODE, sacando ONLY_FULL_GROUP_BY
CALL spTotalAlquileres(1);-- queda un nombre en la columna titulo

/*5) Utilizando triggers, implementar la lógica para que en caso que se quiera crear una
película ya existente según código y/o título se informe mediante un mensaje de error que
no se puede. Incluir el código con las creaciones de películas existentes según código y/o
título y otro inexistente.*/

DROP TRIGGER IF EXISTS `Trigger1_Creacion_Pelicula`; 
DELIMITER //
CREATE TRIGGER `Trigger1_Creacion_Pelicula` 
BEFORE INSERT ON `Peliculas` FOR EACH ROW
BEGIN
	IF EXISTS (SELECT * FROM Peliculas WHERE Peliculas.idPelicula = NEW.idPelicula OR Peliculas.titulo = NEW.titulo) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Pelicula existente', MYSQL_ERRNO = 45000;
	END IF;
END //
DELIMITER ;

INSERT INTO `Peliculas` VALUES (1,'XDDDDDDDDDDDDDDDDDDDDDDDDDDD','PG',2006,86);-- id repetido
SELECT * FROM Peliculas WHERE idPelicula=5000;-- no existe
INSERT INTO `Peliculas` VALUES (5000,'ACADEMY DINOSAUR','PG',2006,86);-- titulo repetido
INSERT INTO `Peliculas` VALUES (5000,'XDDDDDDDDDDDDDDDDDDDDDDDDDDD','PG',2006,86);-- correcto
SELECT * FROM Peliculas WHERE idPelicula=5000;-- ahora existe