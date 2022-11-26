/* === EJER 3 === */
DROP TABLE DEPARTAMENTO CASCADE CONSTRAINTS;
CREATE TABLE DEPARTAMENTO(
	COD_DEP VARCHAR(10) CONSTRAINT PK_DEPART PRIMARY KEY,
	NOMBRE VARCHAR(25) NOT NULL UNIQUE,
	LOCALIDAD VARCHAR(25) NOT NULL
);

DROP TABLE EMPLEADO CASCADE CONSTRAINTS;
CREATE TABLE EMPLEADO (
	COD_EMP VARCHAR(10) CONSTRAINT PK_EMP PRIMARY KEY,
	DNI VARCHAR(15) NOT NULL,
	NOMBRE VARCHAR(25) NOT NULL,
	DIR VARCHAR(50) NOT NULL,
	CP NUMBER(5) NOT NULL,
	POBLACION VARCHAR(25) NOT NULL,
	COD_DEP VARCHAR(10) NOT NULL CONSTRAINT FK_EMP REFERENCES DEPARTAMENTO(COD_DEP) ON DELETE CASCADE
);

DROP TABLE PROYECTO CASCADE CONSTRAINTS;
CREATE TABLE PROYECTO (
	COD_PROY VARCHAR(10) CONSTRAINT PK_PROY PRIMARY KEY,
	NOMBRE VARCHAR(10) NOT NULL UNIQUE
);

DROP TABLE HACER_PROYECTO CASCADE CONSTRAINTS;
CREATE TABLE HACER_PROYECTO (
	COD_EMP VARCHAR(10),
	COD_PROY VARCHAR(10),
	FECHA_I DATE NOT NULL,
	FECHA_F DATE,
	CONSTRAINT PK_HP PRIMARY KEY (COD_EMP,COD_PROY),
	CONSTRAINT FK_HP_EMP FOREIGN KEY (COD_EMP) REFERENCES EMPLEADO(COD_EMP) ON DELETE CASCADE,
	CONSTRAINT FK_HP_PROY FOREIGN KEY (COD_PROY) REFERENCES PROYECTO(COD_PROY) ON DELETE CASCADE	
);


/* === ALTER TABLES === */
/* Añadir el campo SALARIO a la tabla  EMPLEADO */
ALTER TABLE EMPLEADO ADD SUELDO NUMBER(10) NOT NULL;

/* Modificar las columnas de las tablas DEPARTAMENTO y EMPLEADO para que el nombre pueda almacenar más caracteres */
ALTER TABLE DEPARTAMENTO MODIFY NOMBRE VARCHAR(50);
ALTER TABLE EMPLEADO MODIFY NOMBRE VARCHAR(50);

/* A partir de la tabla DEPARTAMENTO impide que se puedan dar de alta más departamentos en la localidad de GETAFE */


/* Eliminar la restricción de UNIQUE de la columna NOMBRE de la tabla PROYECTO */
ALTER TABLE PROYECTO DROP UNIQUE (NOMBRE);

/* Insertar la siguiente tupla en HACER_PROYECTO (0001-E, 0001-P, 20 DE FEBRERO DE 2009, NULOS) */
INSERT INTO DEPARTAMENTO VALUES('0001-D', 'DEPART-1', 'MAD');
INSERT INTO EMPLEADO VALUES('0001-E', '12312Z', 'ROMAN', 'CALLE SOL', '28038', 'MADRID', '0001-D');
INSERT INTO PROYECTO VALUES('0001-P', 'PROY-1');
INSERT INTO HACER_PROYECTO VALUES('0001-E','0001-P','20/02/2009', NULL);
COMMIT;

/* Crear una vista llamada EMPLE_PROYECTO que contenga el NB_EMPLE, NB_PROY de aquellos proyectos realizados entre el 18/01/2009 y 18/02/2009 */
CREATE OR REPLACE VIEW EMPLE_PROYECTO AS 
(SELECT E.NOMBRE "NOMBRE", P.NOMBRE "PROYECTO"
FROM EMPLEADO E, PROYECTO P, HACER_PROYECTO H 
WHERE E.COD_EMP=H.COD_EMP AND P.COD_PROY=H.COD_PROY AND FECHA_I>'18/01/2009' AND FECHA_F<'18/02/2009');