-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Examen2021Barcat
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Examen2021Barcat` ;

-- -----------------------------------------------------
-- Schema Examen2021Barcat
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Examen2021Barcat` DEFAULT CHARACTER SET utf8 ;
USE `Examen2021Barcat` ;

-- -----------------------------------------------------
-- Table `Examen2021Barcat`.`Actores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2021Barcat`.`Actores` ;

CREATE TABLE IF NOT EXISTS `Examen2021Barcat`.`Actores` (
  `idActor` CHAR(10) NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NULL,
  PRIMARY KEY (`idActor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Examen2021Barcat`.`Peliculas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2021Barcat`.`Peliculas` ;

CREATE TABLE IF NOT EXISTS `Examen2021Barcat`.`Peliculas` (
  `idPelicula` INT NOT NULL,
  `titulo` VARCHAR(128) NOT NULL,
  `estreno` INT NULL,
  `duracion` INT NULL,
  `clasificacion` ENUM('G', 'PG', 'PG-13', 'R', 'NC-17') NOT NULL DEFAULT 'G',
  PRIMARY KEY (`idPelicula`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `titulo_UNIQUE` ON `Examen2021Barcat`.`Peliculas` (`titulo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2021Barcat`.`Direcciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2021Barcat`.`Direcciones` ;

CREATE TABLE IF NOT EXISTS `Examen2021Barcat`.`Direcciones` (
  `idDireccion` INT NOT NULL,
  `calleYNumero` VARCHAR(50) NOT NULL,
  `municipio` VARCHAR(20) NULL,
  `codigoPostal` VARCHAR(10) NULL,
  `telefono` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idDireccion`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `calleYNumero_UNIQUE` ON `Examen2021Barcat`.`Direcciones` (`calleYNumero` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2021Barcat`.`Empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2021Barcat`.`Empleados` ;

CREATE TABLE IF NOT EXISTS `Examen2021Barcat`.`Empleados` (
  `idEmpleado` INT NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `idDireccion` INT NOT NULL,
  `correo` VARCHAR(50) NULL,
  `estado` ENUM('E', 'D') NOT NULL DEFAULT 'E',
  PRIMARY KEY (`idEmpleado`),
  CONSTRAINT `fk_Empleados_Direcciones1`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `Examen2021Barcat`.`Direcciones` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `correo_UNIQUE` ON `Examen2021Barcat`.`Empleados` (`correo` ASC) VISIBLE;

CREATE INDEX `fk_Empleados_Direcciones1_idx` ON `Examen2021Barcat`.`Empleados` (`idDireccion` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2021Barcat`.`Sucursales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2021Barcat`.`Sucursales` ;

CREATE TABLE IF NOT EXISTS `Examen2021Barcat`.`Sucursales` (
  `idSucursal` CHAR(10) NOT NULL,
  `idGerente` INT NOT NULL,
  `idDireccion` INT NOT NULL,
  PRIMARY KEY (`idSucursal`),
  CONSTRAINT `fk_Sucursales_Empleados1`
    FOREIGN KEY (`idGerente`)
    REFERENCES `Examen2021Barcat`.`Empleados` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sucursales_Direcciones1`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `Examen2021Barcat`.`Direcciones` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Sucursales_Empleados1_idx` ON `Examen2021Barcat`.`Sucursales` (`idGerente` ASC) VISIBLE;

CREATE INDEX `fk_Sucursales_Direcciones1_idx` ON `Examen2021Barcat`.`Sucursales` (`idDireccion` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2021Barcat`.`Inventario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2021Barcat`.`Inventario` ;

CREATE TABLE IF NOT EXISTS `Examen2021Barcat`.`Inventario` (
  `idInventario` INT NOT NULL,
  `idPelicula` INT NOT NULL,
  `idSucursal` CHAR(10) NOT NULL,
  PRIMARY KEY (`idInventario`),
  CONSTRAINT `fk_Inventario_Peliculas1`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `Examen2021Barcat`.`Peliculas` (`idPelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventario_Sucursales1`
    FOREIGN KEY (`idSucursal`)
    REFERENCES `Examen2021Barcat`.`Sucursales` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Inventario_Peliculas1_idx` ON `Examen2021Barcat`.`Inventario` (`idPelicula` ASC) VISIBLE;

CREATE INDEX `fk_Inventario_Sucursales1_idx` ON `Examen2021Barcat`.`Inventario` (`idSucursal` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Examen2021Barcat`.`ActoresDePeliculas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Examen2021Barcat`.`ActoresDePeliculas` ;

CREATE TABLE IF NOT EXISTS `Examen2021Barcat`.`ActoresDePeliculas` (
  `idPelicula` INT NOT NULL,
  `idActor` CHAR(10) NOT NULL,
  PRIMARY KEY (`idPelicula`, `idActor`),
  CONSTRAINT `fk_Actores_has_Peliculas_Actores`
    FOREIGN KEY (`idActor`)
    REFERENCES `Examen2021Barcat`.`Actores` (`idActor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actores_has_Peliculas_Peliculas1`
    FOREIGN KEY (`idPelicula`)
    REFERENCES `Examen2021Barcat`.`Peliculas` (`idPelicula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Actores_has_Peliculas_Peliculas1_idx` ON `Examen2021Barcat`.`ActoresDePeliculas` (`idPelicula` ASC) VISIBLE;

CREATE INDEX `fk_Actores_has_Peliculas_Actores_idx` ON `Examen2021Barcat`.`ActoresDePeliculas` (`idActor` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
/*2) Crear una vista llamada VPeliculasEnSucursales que muestre el título de las películas,
el código de la sucursal donde se encuentra, la calle y número de la sucursal y los datos del
gerente de la sucursal (formato: “apellido, nombre”). La salida deberá estar ordenada
alfabéticamente según el título de las películas. En caso que una misma película aparezca
varias veces en una misma sucursal, en la salida deberá aparecer una única vez. Incluir el
código con la llamada a la vista*/

DROP VIEW IF EXISTS VPeliculasEnSucursales;
CREATE VIEW VPeliculasEnSucursales
AS
	SELECT DISTINCT Peliculas.titulo AS 'Título', Sucursales.idSucursal, Direcciones.calleYNumero AS 'Calle y número', 
	CONCAT(Empleados.apellidos,', ',Empleados.nombres) AS 'Gerente'
    FROM
		Peliculas LEFT JOIN Inventario ON Peliculas.idPelicula = Inventario.idPelicula
		LEFT JOIN Sucursales ON Inventario.idSucursal = Sucursales.idSucursal
		LEFT JOIN Empleados ON Sucursales.idGerente = Empleados.idEmpleado
		LEFT JOIN Direcciones ON Sucursales.idDireccion = Direcciones.idDireccion
	ORDER BY Peliculas.titulo ASC;
    
SELECT * FROM VPeliculasEnSucursales;

/*3) Realizar un procedimiento almacenado llamado ModificarPelicula para modificar una
película, incluyendo el control de errores lógicos y mensajes de error necesarios
(implementar la lógica del manejo de errores empleando parámetros de salida). Incluir el
código con la llamada al procedimiento probando todos los casos con datos incorrectos y
uno con datos correctos.*/

DROP PROCEDURE IF EXISTS ModificarPelicula;
DELIMITER //
CREATE PROCEDURE ModificarPelicula (IN pIdPelicula INT, IN pTitulo VARCHAR(128), IN pEstreno INT, IN pDuracion INT, 
				IN pClasificacion ENUM('G', 'PG', 'PG-13', 'R', 'NC-17'), OUT mensaje VARCHAR(100))
BEGIN
	IF pIdPelicula IS NULL THEN
		SET mensaje = 'ERROR: Código de película vacío';
	ELSEIF NOT EXISTS (SELECT * FROM Peliculas WHERE Peliculas.idPelicula = pIdPelicula) THEN 
		SET mensaje = 'ERROR: La pelicula no existe';
	ELSEIF (pTitulo IS NULL OR pClasificacion IS NULL) THEN
		SET mensaje = 'ERROR: campos OBLIGATORIOS vacíos';
	ELSE
		
		START TRANSACTION;
			UPDATE Peliculas SET Peliculas.Titulo = pTitulo, Peliculas.estreno = pEstreno, Peliculas.duracion = pDuracion,
			Peliculas.clasificacion = pClasificacion WHERE Peliculas.idPelicula = pIdPelicula;
			SET mensaje = 'Pelicula modificada con éxito';
	END IF;
END //
DELIMITER ;

SET @mensaje=null;
CALL ModificarPelicula(1000,'ZORRO ARK 1',2006,50,'NC-17',@mensaje);
SELECT @mensaje;

CALL ModificarPelicula(null,'ZORRO ARK 1',2006,50,'NC-17',@mensaje);
SELECT @mensaje;

CALL ModificarPelicula(1000,'ZORRO ARK 2',null,null,'NC-17',@mensaje);
SELECT @mensaje;

CALL ModificarPelicula(1000,null,2006,50,'NC-17',@mensaje);
SELECT @mensaje;

/*4) Realizar un procedimiento almacenado llamado BuscarPeliculasPorAutor que reciba el
código de un actor y muestre sucursal por sucursal, película por película, la cantidad con el
mismo. Por cada película del autor especificado se deberá mostrar su código y título, el
código de la sucursal, la cantidad y la calle y número de la sucursal. La salida deberá estar
ordenada alfabéticamente según el título de las películas. Incluir en el código la llamada al
procedimiento.*/

DROP PROCEDURE IF EXISTS BuscarPeliculasPorActor;
DELIMITER //
CREATE PROCEDURE BuscarPeliculasPorActor(IN pIdActor CHAR(10))
BEGIN
	SELECT Peliculas.idPelicula, Peliculas.titulo AS 'Título', Sucursales.idSucursal, COUNT(Peliculas.idPelicula) AS 'Cantidad',
	Direcciones.calleYNumero AS 'Calle y número'
    FROM
		Actores LEFT JOIN ActoresDePeliculas ON Actores.idActor = ActoresDePeliculas.idActor
        LEFT JOIN Peliculas ON ActoresDePeliculas.idPelicula = Peliculas.idPelicula
		LEFT JOIN Inventario ON Peliculas.idPelicula = Inventario.idPelicula
		LEFT JOIN Sucursales ON Inventario.idSucursal = Sucursales.idSucursal
		LEFT JOIN Direcciones ON Sucursales.idDireccion = Direcciones.idDireccion
	WHERE Actores.idActor = pIdActor
	GROUP BY Peliculas.titulo, Sucursales.idSucursal, Direcciones.calleYNumero
    ORDER BY Peliculas.titulo ASC;
END //
DELIMITER ;

CALL BuscarPeliculasPorActor(100);
/*5) Utilizando triggers, implementar la lógica para que en caso que se quiera modificar una
dirección especificando la calle y número de otra dirección existente se informe mediante
un mensaje de error que no se puede. Incluir el código con la modificación de la calle y
número de una dirección con un valor distinto a cualquiera de las que ya hubiera definidas y
otro con un valor igual a otra que ya hubiera definida. */
DROP TRIGGER IF EXISTS `Trigger1_Modificacion_Direcciones`; 
DELIMITER //
CREATE TRIGGER `Trigger1_Modificacion_Direcciones` 
BEFORE UPDATE ON `Direcciones` FOR EACH ROW
BEGIN
	IF EXISTS (SELECT * FROM Direcciones WHERE Direcciones.calleYNumero = NEW.calleYNumero) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Direccion con calle y número existente', MYSQL_ERRNO = 45000;
	END IF;
END //
DELIMITER ;