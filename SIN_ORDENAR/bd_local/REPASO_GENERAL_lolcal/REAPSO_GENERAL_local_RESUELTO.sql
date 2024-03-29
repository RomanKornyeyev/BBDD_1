/*para que salga el texto por consola (si no, no sale nada)*/
/*para que pregunte solo 1 vez para la var introducida x teclado*/
/*anchura de linea, en 200 suele estar bien*/
/*en caso de crear un bloque/procedimiento/funci?n con errores de compilaci?n */
SET SERVEROUTPUT ON;
SET VERIFY OFF;
SET LINESIZE 200;
SHOW ERRORS;




/* ----- UPDATES, INSERTS, ALTERS (PARA COMPROBACIONES Y DEMÁS) ------ */
/*3. Añadir la restricción de clave primaria a la columna COD_ASIG  de la tabla anterior.*/
ALTER TABLE TASIG ADD CONSTRAINT PK_COD_ASIG PRIMARY KEY (COD_ASIG);

/*4. Añadir la restricción clave ajena a la columna COD_ASIG de la tabla PROFESORES.*/
ALTER TABLE PROFESORES ADD CONSTRAINT FK_COD_ASIG REFERENCES (COD_ASIG) ON DELETE CASCADE;

/* Añadir el campo SALARIO a la tabla  EMPLEADO */
ALTER TABLE EMPLEADO ADD SALARIO NUMBER(10) NOT NULL;

/* Modificar las columnas de las tablas DEPARTAMENTO y EMPLEADO para que el nombre pueda almacenar más caracteres */
ALTER TABLE DEPARTAMENTO MODIFY NOMBRE VARCHAR(50);

INSERT INTO ALUMNOS (DNI, NOMBRE, DIR, ...) VALUES (VALOR1, VALOR2, VALOR3, ...); 

O

INSERT INTO ALUMNOS VALUES (VALOR1, VALOR2, VALOR3, ...); 

/* Updeit */
UPDATE LIBROS_EX SET COD=999 WHERE COD=100;






/* ----- PL (AHORA SÍ) ------ */
--EJERCICIO 6-- 
--TRIGGERS: CREAR UNA TABLA LIBROS Y OTRA TABLA CONTROL. INSERTAR, MODIFICAR O BORRAR EN LIBROS SE PLASMARA EN LA CONTROL CON LOS SIGUIENTES DATOS:--
--USER, FECHA Y 'STRING'. ESTE 'STRING' CORRESPONDERA AL TIPO DE ACCION QUE SE HAYA HECHO EN LA TABLA.--
DROP TABLE LIBROS_EX;
CREATE TABLE LIBROS_EX (
	COD NUMBER(4),
	TITULO VARCHAR(30),
	AUTOR VARCHAR(30)
);
DROP TABLE CONTROL;
CREATE TABLE CONTROL (
	USUARIO VARCHAR2(10),
	FECHA DATE,
	OPERACION VARCHAR2(20)
);

/*OJO, EN EL DECLARE EL TIPO DE STRING DE AUX TIENE QUE SER IGUAL AL DE LA TABLA CONTROL (VARCHAR2)*/
CREATE OR REPLACE TRIGGER EJER6_EX
	AFTER DELETE OR UPDATE OR INSERT ON LIBROS_EX FOR EACH ROW
DECLARE
	AUX VARCHAR2(20);
BEGIN
	IF INSERTING THEN
		AUX := 'INSERTADO';
	ELSIF UPDATING THEN
		AUX := 'ACTUALIZADO';
	ELSIF DELETING THEN
		AUX := 'BORRADO';
	END IF;
	
	INSERT INTO CONTROL VALUES(USER, SYSDATE, AUX);
END;
/

INSERT INTO LIBROS_EX VALUES(100, 'Me llamo Román', 'Román');
INSERT INTO LIBROS_EX VALUES(120, 'Me llamo Cosa', 'Cosa');
INSERT INTO LIBROS_EX VALUES(140, 'Me llamo Prueba', 'Jeje');
UPDATE LIBROS_EX SET COD=999 WHERE COD=100;
DELETE LIBROS_EX WHERE COD=140;
SELECT * FROM CONTROL;








/*2-	Crear un trigger que se disparará cada vez que se borre un empleado, guardando el literal “borrado empleado”,  su número de empleado,
apellido y el departamento en una fila de la tabla AUDITAR_EMPLE.*/
/*3-	Incluir una restricción en el ejercicio anterior para que se ejecute el disparador cuando el empleado borrado sea PRESIDENTE.*/
DROP TABLE AUDITAR_EMPLE;
CREATE TABLE AUDITAR_EMPLE(
	COL1 VARCHAR2(200)
);

CREATE OR REPLACE TRIGGER AUDITAR_BORRADO_EMPLE
	AFTER DELETE ON EMPLE FOR EACH ROW WHEN(OLD.OFICIO='PRESIDENTE')
BEGIN
	INSERT INTO AUDITAR_EMPLE VALUES('BORRADO EMPLEADO '||:OLD.EMP_NO||'*'||:OLD.APELLIDO||'*'||:OLD.DEPT_NO);
END;
/

DELETE FROM EMPLE WHERE OFICIO='PRESIDENTE';
SELECT * FROM AUDITAR_EMPLE;








--EJERCICIO 3--
--CREAR UN PROCEDIMIENTO QUE RECIBA UN EMP_ NO. CONTROLAR EXCEPCION SI EL OFICIO ES PRESIDENTE O SI EL APELLIDO ES GIL.-- 
-- MOSTRAR EL APELLIDO, OFICIO, EMP_NO Y SALARIO DEL EMPLEADO QUE SE HA PASADO POR TECLADO--
CREATE OR REPLACE PROCEDURE EJ3(COD NUMBER)
IS
	EX_PRESI EXCEPTION;
	EX_GIL EXCEPTION;
	OFI VARCHAR(50);
	APE VARCHAR(50);
	SAL NUMBER;
BEGIN
	SELECT APELLIDO, OFICIO, SALARIO INTO APE, OFI, SAL FROM EMPLE WHERE EMP_NO=COD;
	IF OFI='PRESIDENTE' THEN
		RAISE EX_PRESI;
	ELSIF APE='GIL' THEN
		RAISE EX_GIL;
	END IF;
	DBMS_OUTPUT.PUT_LINE('NOMBRE: '||APE||' CODIGO: '||COD||' SALARIO: '||SAL||' OFICIO: '||OFI);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('ERROR: EMPLE NO ENCONTRADO');
		WHEN EX_PRESI THEN
			DBMS_OUTPUT.PUT_LINE('SOY EL PRESI');
		WHEN EX_GIL THEN
			DBMS_OUTPUT.PUT_LINE('SOY TREMENDO GIL');
END;
/

EXECUTE EJ3(7900);
EXECUTE EJ3(7788);
EXECUTE EJ3(7839);





--EJERCICIO 2--
--PROCEDIMIENTO QUE RECIBA UN EMP_NO. SI SU FECHA DE ALTA ES INFERIOR AL 1992, INCREMENTAR UN 10% SU SALARIO, DE LO CONTRARIO DISMINUIRLO UN 5%.--
--CONTROLAR EXCEPTION NO_DATA_FOUND. MOSTRAR EL ANTIGUO Y NUEVO SALARIO--
CREATE OR REPLACE PROCEDURE EJ2(COD NUMBER)
IS
	FECHA_REFERENCIA DATE := '01/01/1992';
	FECHA DATE;
	SAL_VIEJO NUMBER;
	SAL_NUEVO NUMBER;
BEGIN
	SELECT SALARIO, FECHA_ALT INTO SAL_VIEJO, FECHA FROM EMPLE WHERE EMP_NO=COD;
	IF FECHA < FECHA_REFERENCIA THEN
		UPDATE EMPLE SET SALARIO=SALARIO+(SALARIO*0.1) WHERE EMP_NO=COD;
	ELSE
		UPDATE EMPLE SET SALARIO=SALARIO-(SALARIO*0.05) WHERE EMP_NO=COD;
	END IF;
	SELECT SALARIO INTO SAL_NUEVO FROM EMPLE WHERE EMP_NO=COD;
	DBMS_OUTPUT.PUT_LINE('EMP_NO:'||COD||', SAL_VIEJO:'||SAL_VIEJO||', SAL_NUEVO:'||SAL_NUEVO);
	
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('EMPLE NO ENCONTRADO');
END;
/

EXECUTE EJ2(7900);
EXECUTE EJ2(10101010);







--EJERCICIO 4-- 
--FUNCION QUE RECIBA COMO PARAMETRO UN NUMERO Y DEVUELVA SU CORRESPONDIENTE DIA DE LA SEMANA, DANDO POR HECHO QUE DOMINGO=1, LUNES=2 ETC ETC--
CREATE OR REPLACE FUNCTION EJER4 (NUM NUMBER) RETURN VARCHAR
IS
	DIA VARCHAR(50);
BEGIN
	CASE
		WHEN NUM=1 THEN DIA:='LUNES';
		WHEN NUM=2 THEN DIA:='MARTES';
		WHEN NUM=3 THEN DIA:='MIERCOLES';
		WHEN NUM=4 THEN DIA:='JUEVES';
		WHEN NUM=5 THEN DIA:='VIERNES';
		WHEN NUM=6 THEN DIA:='SÁBADO';
		WHEN NUM=7 THEN DIA:='DOMINGO';
		ELSE DIA:='ERROR: ITNRODUCE UN DÍA DEL 1 AL 7';
	END CASE;
	
	RETURN DIA;
END;
/

SELECT EJER4(5) FROM DUAL;
SELECT EJER4(8) FROM DUAL;








--EJERCICIO 5-- 
--MOSTRAR TODOS LOS NOMBRES DE LOS EMPLEADOS, SU EMP_NO Y EL NOMBRE DEL DEPARTAMENTO AL QUE PERTENECEN Y EL NUMERO TOTAL DE EMPLEADOS--
DECLARE
	CURSOR C1 IS SELECT EMP_NO, APELLIDO, DNOMBRE FROM EMPLE E, DEPART D WHERE D.DEPT_NO=E.DEPT_NO;
	CONT NUMBER := 0;
BEGIN
	FOR I IN C1 LOOP
		DBMS_OUTPUT.PUT_LINE(I.EMP_NO||'*'||I.APELLIDO||'*'||I.DNOMBRE);
		CONT := CONT+1;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('TOTAL:'||CONT);
END;
/





--EJERCICIO 1--
--BLOQUE ANONIMO QUE MUESTRE EL NUMERO TOTAL DE EMPLEADOS Y LA MEDIA DEL SALARIO CON UN DECIMAL--
DECLARE
	NUM NUMBER;
	MEDIA NUMBER(10,1);
BEGIN
	SELECT COUNT(*), AVG(SALARIO) INTO NUM, MEDIA FROM EMPLE;
	DBMS_OUTPUT.PUT_LINE(NUM||'*'||MEDIA);
END;
/







--EJERCICIO 7--
--CREAR UNA TABLE NUMEROS CON UNA COLUMNA COLUM1 DE TIPO NUMERO.--
--LLENAR LA TABLA DE NUMEROS DEL 1 AL 10 SIN EL 3 NI EL 8--
DROP TABLE NUMEROS;
CREATE TABLE NUMEROS (
	COLUM1 NUMBER
);

DECLARE
BEGIN
	FOR I IN 1..10 LOOP
		IF I != 3 AND I != 8 THEN
			INSERT INTO NUMEROS VALUES(I);
		END IF;
	END LOOP;
END;
/

SELECT * FROM NUMEROS;



/*AÑADIR, Y REPITO: AÑADIR, NO CREAR DE NUEVO, UNA COLUMNA COLUMN2 DE TIPO NUMERO Y CREAR UN PROCEDIMIENTO QUE LLENE LA COLUM2 CON UN NUMERO
QUE ES LA POTENCIA CUADARADA DE SU CORRESPONDIENTE FILA*/
--DE 1 SERA 1--
--DE 2 SERA 4--
--DE 4 SERA 16--
--ETC--
ALTER TABLE NUMEROS ADD COLUM2 NUMBER;

CREATE OR REPLACE PROCEDURE LLENAR_COL2
IS
	CURSOR C1 IS SELECT COLUM1 FROM NUMEROS;
	COL1 NUMBER;
BEGIN
	OPEN C1;
	LOOP
		FETCH C1 INTO COL1;
		EXIT WHEN C1%NOTFOUND;
		UPDATE NUMEROS SET COLUM2=(COL1*COL1) WHERE COLUM1=COL1;
	END LOOP;
	CLOSE C1;
END;
/

EXECUTE LLENAR_COL2;
SELECT * FROM NUMEROS;
/*ERROR CON FOR LOOP*/
--ME DA ERROR DE QUE NO COINCIDE EL TIPO DE VARIABLE E INTUYO QUE SE DEBE AL TIPO DE VARIABLE QUE PUDIERA SER I; PERO NO TENGO IDEA SINCERAMENTE.--


--AHORA SOBRE ESTA TABLA NUEVAMENTE AÑADIR UNA NUEVA COLUMNA COLUM3 DE TIPO VARCHAR(10)--
--CREAR UN PROCEDIMIENTO QUE LLENE ESTA COLUMNA CON STRINGS DEPENDIENDO SI LA COLUM2 ES PAR O IMPAR--
--CON LOOP--
ALTER TABLE NUMEROS ADD COLUM3 VARCHAR(20);

CREATE OR REPLACE PROCEDURE LLENAR_COL3
IS
	CURSOR C1 IS SELECT COLUM2 FROM NUMEROS;
	COL2 VARCHAR(20);
BEGIN
	OPEN C1;
	LOOP
		FETCH C1 INTO COL2;
		EXIT WHEN C1%NOTFOUND;
		IF COL2 MOD 2 = 0 THEN
			UPDATE NUMEROS SET COLUM3='PAR' WHERE COL2=COLUM2;
		ELSE
			UPDATE NUMEROS SET COLUM3='IMPAR' WHERE COL2=COLUM2;
		END IF;
	END LOOP;
	CLOSE C1;
END;
/


EXECUTE LLENAR_COL3;
SELECT * FROM NUMEROS;


-- VARIANTE CON FOR LOOP-- 
CREATE OR REPLACE PROCEDURE LLENAR_COL3
IS
	CURSOR C1 IS SELECT COLUM2 FROM NUMEROS;
BEGIN
	FOR I IN C1 LOOP
		IF I.COLUM2 MOD 2 = 0 THEN
			UPDATE NUMEROS SET COLUM3='PAR' WHERE I.COLUM2=COLUM2;
		ELSE
			UPDATE NUMEROS SET COLUM3='IMPAR' WHERE I.COLUM2=COLUM2;
		END IF;
	END LOOP;
END;
/

EXECUTE LLENAR_COL3;
SELECT * FROM NUMEROS;









--EJERCICIO 8--
--CREAR UNA FUNCION QUE RECIBA UN NUMERO Y HAGA EL FACTORIAL DEL MISMO, ADEMAS QUE SE DEVUELVA EL PROCESO ARITMETICO QUE HACE. EJEMPLO:
--4!=4*3*2*1. RESULTADO: 24--
CREATE OR REPLACE FUNCTION EJER8(NUM NUMBER) RETURN VARCHAR
IS
	CADENA VARCHAR(200);
	ACUMULADOR NUMBER;
BEGIN
	CADENA := NUM||'! = ';
	ACUMULADOR := NUM;
	FOR I IN REVERSE 1..NUM LOOP
		IF I != NUM THEN
			CADENA := CADENA||'*'||I;
			ACUMULADOR := ACUMULADOR*I;
		ELSE
			CADENA := CADENA||I;
		END IF;
	END LOOP;
	CADENA := CADENA||'. RESULTADO:'||ACUMULADOR;
	
	RETURN CADENA;
END;
/

SELECT EJER8(5) FROM DUAL;







--EJERCICIO 8.1 (REVERTIR CADENA)--
--DADO UN STRING, REVIRTELO: "HOLA" -> "ALOH"--
CREATE OR REPLACE PROCEDURE EJER_CADENA(CADENA VARCHAR)
IS
	R_CADENA VARCHAR(50);
BEGIN
	FOR I IN REVERSE 1..LENGTH(CADENA) LOOP
		R_CADENA := R_CADENA||SUBSTR(CADENA, I, 1);
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(R_CADENA);
END;
/

EXECUTE EJER_CADENA('HOLA');









--EJERCICIO 9--
--MOSTRAR LO SIGUIENTE--
/*
DEPARTAMENTO: 10 CONTABILIDAD
---- 7782 CEREZO
---- 7934 MU?OZ
---- 7839 REY
DEPARTAMENTO: 20 INVESTIGACION
---- 7566 JIMENEZ
---- 7369 SANCHEZ
---- 7788 GIL
---- 7902 FERNANDEZ
---- 7876 ALONSO
DEPARTAMENTO: 30 VENTAS
---- 7521 SALA
---- 7844 TOVAR
---- 7499 ARROYO
---- 7900 JIMENO
---- 7654 MARTIN
---- 7698 NEGRO
DEPARTAMENTO: 40 PRODUCCION
----
*/
--UNION EN LA RELACION NATURAL, IMPORTATE--
/* CON UNION SACA LOS DEPARTS VACÍOS, SIN UNION NO*/
DECLARE
	CURSOR C1 IS SELECT EMP_NO, APELLIDO, D.DEPT_NO, DNOMBRE FROM EMPLE E, DEPART D WHERE D.DEPT_NO=E.DEPT_NO(+) ORDER BY DEPT_NO;
	DEP NUMBER := 0;
BEGIN
	FOR I IN C1 LOOP
		IF DEP != I.DEPT_NO THEN
			DEP := I.DEPT_NO;
			DBMS_OUTPUT.PUT_LINE('DEPARTAMENTO: '||I.DEPT_NO||' '||I.DNOMBRE);
		END IF;
		DBMS_OUTPUT.PUT_LINE('-----'||I.EMP_NO||' '||I.APELLIDO);
	END LOOP;
END;
/