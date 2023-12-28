DROP TABLE EMPLEADO CASCADE CONSTRAINTS;
DROP TABLE HACER_PROYECTO CASCADE CONSTRAINTS;
DROP TABLE PROYECTO CASCADE CONSTRAINTS;
DROP TABLE DEPARTAMENTO CASCADE CONSTRAINTS;

CREATE TABLE DEPARTAMENTO(
	COD_DEP VARCHAR2(10) CONSTRAINT PK_DEPART PRIMARY KEY,
	NOMBRE VARCHAR2(25) NOT NULL,
	LOCALIDAD VARCHAR2(25) NOT NULL,
	CONSTRAINT UNICO UNIQUE (NOMBRE)
);

CREATE TABLE EMPLEADO(
	COD_EMP VARCHAR2(10) CONSTRAINT PK_EMP PRIMARY KEY,
	DNI VARCHAR2(9) NOT NULL,
	NOMBRE VARCHAR2(25) NOT NULL,
	DIR VARCHAR2(50) NOT NULL,
	CP NUMBER(5) NOT NULL,
	POBLACION VARCHAR2(25) NOT NULL,
	COD_DEP VARCHAR2(10) NOT NULL,
	CONSTRAINT FK_EMP FOREIGN KEY (COD_DEP) REFERENCES DEPARTAMENTO(COD_DEP) ON DELETE CASCADE
);

CREATE TABLE PROYECTO(
	COD_PROY VARCHAR2(10) CONSTRAINT PK_PROY PRIMARY KEY,
	NOMBRE VARCHAR2(25) NOT NULL,
	CONSTRAINT UNICOO UNIQUE (NOMBRE)
);

CREATE TABLE HACER_PROYECTO(
	COD_EMP VARCHAR2(10),
	COD_PROY VARCHAR2(10),
	FECHA_I DATE NOT NULL,
	FECHA_F DATE,
	CONSTRAINT FK_HP_EMP FOREIGN KEY (COD_EMP) REFERENCES EMPLEADO(COD_EMP) ON DELETE CASCADE,
	CONSTRAINT FK_HP_PROY FOREIGN KEY (COD_PROY) REFERENCES PROYECTO(COD_PROY) ON DELETE CASCADE,
	CONSTRAINT PK_HP PRIMARY KEY (COD_EMP, COD_PROY)
);


/*===ALTERS===*/
ALTER TABLE EMPLEADO ADD SALARIO NUMBER(10) NOT NULL;

ALTER TABLE DEPARTAMENTO MODIFY NOMBRE VARCHAR2(50);
ALTER TABLE EMPLEADO MODIFY NOMBRE VARCHAR2(50);

ALTER TABLE DEPARTAMENTO ADD CONSTRAINT DK CHECK (LOCALIDAD<>'GETAFE');

ALTER TABLE PROYECTO DROP CONSTRAINT UNICOO;


/*===INSERTS===*/
INSERT INTO DEPARTAMENTO VALUES('001', 'MATES', 'MADRID');
INSERT INTO EMPLEADO VALUES('001-A', '123456789', 'ROMAN', 'C/SOL',28038,'MADRID','001',2000);
INSERT INTO PROYECTO VALUES('01X', 'FIESTA');
INSERT INTO HACER_PROYECTO VALUES('001-A', '01X', '20/10/2020', NULL);
COMMIT;



/* ========== EJER 1 =========== */
SELECT COLUMN_NAME, CONSTRAINT_NAME, COLUMN_NAME
  FROM user_cons_columns
WHERE table_name = 'EMPLEADO';