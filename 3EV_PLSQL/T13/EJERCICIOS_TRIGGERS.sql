/*para que salga el texto por consola (si no, no sale nada)*/
/*para que pregunte solo 1 vez para la var introducida x teclado*/
/*anchura de linea, en 200 suele estar bien*/
/*en caso de crear un bloque/procedimiento/función con errores de compilación */
SET SERVEROUTPUT ON;
SET VERIFY OFF;
SET LINESIZE 200;
SHOW ERRORS;




/*1-	Crear el trigger auditar_subida_salario, que se disparará después de cada modificación de la columna salario de la tabla EMPLE.
Se creará primero la tabla auditar_emple con col1 varchar2(200). Donde se insertará el literal “subida salario empleado” y el número del empleado.
*/
DROP TABLE AUDITAR_EMPLE;
CREATE TABLE AUDITAR_EMPLE(
	COL1 VARCHAR2(200)
);

CREATE OR REPLACE TRIGGER AUDITAR_SUBIDA_SALARIO
	AFTER UPDATE OF SALARIO ON EMPLE FOR EACH ROW
BEGIN
	INSERT INTO AUDITAR_EMPLE VALUES('SUBIDA SALARIO EMPLEADO '||:OLD.EMP_NO);
END;
/

UPDATE EMPLE SET SALARIO=SALARIO+200;
UPDATE EMPLE SET SALARIO=SALARIO-200;
SELECT * FROM AUDITAR_EMPLE;




/*2-	Crear un trigger que se disparará cada vez que se borre un empleado, guardando el literal “borrado empleado”,  su número de empleado,
apellido y el departamento en una fila de la tabla AUDITAR_EMPLE.*/
CREATE OR REPLACE TRIGGER AUDITAR_BORRADO_EMPLE
	AFTER DELETE ON EMPLE FOR EACH ROW
BEGIN
	INSERT INTO AUDITAR_EMPLE VALUES('BORRADO EMPLEADO '||:OLD.EMP_NO||'*'||:OLD.APELLIDO||'*'||:OLD.DEPT_NO);
END;
/

DELETE FROM EMPLE WHERE APELLIDO='SANCHEZ';
SELECT * FROM AUDITAR_EMPLE;





/*3-	Incluir una restricción en el ejercicio anterior para que se ejecute el disparador cuando el empleado borrado sea PRESIDENTE.*/
CREATE OR REPLACE TRIGGER AUDITAR_BORRADO_EMPLE
	AFTER DELETE ON EMPLE FOR EACH ROW WHEN(OLD.OFICIO='PRESIDENTE')
BEGIN
	INSERT INTO AUDITAR_EMPLE VALUES('BORRADO EMPLEADO '||:OLD.EMP_NO||'*'||:OLD.APELLIDO||'*'||:OLD.DEPT_NO);
END;
/

DELETE FROM EMPLE WHERE OFICIO='PRESIDENTE';
SELECT * FROM AUDITAR_EMPLE;







/*4-	Escribe un disparador que permite auditar las operaciones de inserción o borrado de datos que se realicen en la tabla EMPLE según las siguientes especificaciones:
-	Se creará la tabla auditar_emple con col1 varchar2(200).
-	Cuando se produzca cualquier manipulación, se insertara un fila en la tabla creada que contendrá: fecha y hora, nºempleado, apellido y la palabra INSERCIÓN O BORRADO según la actualización.
Utilizar el formato múltiples eventos.
*/
CREATE OR REPLACE TRIGGER AUDITAR_MODIFICACION_EMPLE
	AFTER DELETE OR INSERT ON EMPLE FOR EACH ROW
BEGIN
	IF INSERTING THEN
		INSERT INTO AUDITAR_EMPLE VALUES(SYSDATE ||:NEW.EMP_NO||'*'||:NEW.APELLIDO||'*'||:NEW.DEPT_NO||' - INSERTADO');
	ELSIF DELETING THEN
		INSERT INTO AUDITAR_EMPLE VALUES(SYSDATE ||:OLD.EMP_NO||'*'||:OLD.APELLIDO||'*'||:OLD.DEPT_NO||' - BORRADO');
	END IF;
END;
/

DELETE FROM EMPLE WHERE EMP_NO=7521;
INSERT INTO EMPLE VALUES(2, 'DIAZ','ANALISTA',7698,SYSDATE,1800,0,10);
SELECT * FROM AUDITAR_EMPLE;






/*5-	Escribir un disparador que controle las conexiones de los usuarios en la base de datos. Para ello crearemos la siguiente tabla:*/
DROP TABLE CONTROL_CONEXIONES;
CREATE TABLE CONTROL_CONEXIONES(
	USUARIO VARCHAR2(20),
	MOMENTO TIMESTAMP,
	EVENTO VARCHAR2(20)
);

CREATE OR REPLACE TRIGGER CTL_CONX
	AFTER LOGON ON DATABASE
BEGIN
	INSERT INTO CONTROL_CONEXIONES(USUARIO, MOMENTO, EVENTO) VALUES(ORA_LOGIN_USER,SYSTIMESTAMP, ORA_SYSEVENT);
END;
/
/* SYSTIMESTAMP PARA FECHA, HORA Y + COSAS */

SELECT * FROM CONTROL_CONEXIONES;