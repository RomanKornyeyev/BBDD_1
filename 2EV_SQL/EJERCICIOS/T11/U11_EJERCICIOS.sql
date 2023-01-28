/* === MANIPULACIÓN === */
/* === INSERCIÓN CON SELECT === */
/*EJEMPLO1: Dada la tabla EMPLE30 cuya descripción es la misma que EMPLE.  Insertar los datos de los empleados (de EMPLE a EMPLE30) del departamento 30 en EMPLE30.*/
INSERT INTO EMPLE30 SELECT * FROM EMPLE WHERE DEPT_NO=30;
SELECT * FROM EMPLE30;

/*EJEMPLO2: Insertar el empleado de apellido QUIROGA, con nº de empleado 1112 en la tabla EMPLE,
los restantes datos de QUIROGA serán los mismos que los de GIL y la fecha de alta será la fecha actual.*/
DESC EMPLE;
SELECT * FROM EMPLE;
INSERT INTO EMPLE SELECT 1112, 'QUIROGA', OFICIO, DIR, SYSDATE, SALARIO, COMISION, DEPT_NO FROM EMPLE WHERE APELLIDO = 'GIL';




/* === MODIFICACIÓN CON SELECT === */
/*EJEMPLO: Sea la tabla CENTROS, cuyo  COD_CENTRO es 22 cambiar la direccion a ‘C/PILON 13’ y el numero de plazas a 295.*/
DESC CENTROS;
SELECT * FROM CENTROS;
UPDATE CENTROS SET DIRECCION='C/PILON 13', NUM_PLAZAS=295 WHERE COD_CENTRO=22;

/*Otros formatos*/
/*EJEMPLO: Para todos los empleados de la tabla EMPLE que sean del departamento de CONTABILIDAD, cambiamos su salario al doble del salario de SANCHEZ y el apellido a minúscula.*/
DESC EMPLE;
SELECT * FROM EMPLE;
UPDATE 
	EMPLE
SET
	SALARIO=(SELECT SALARIO*2 FROM EMPLE WHERE APELLIDO='SANCHEZ'), APELLIDO=LOWER(APELLIDO)
WHERE 
	DEPT_NO=(SELECT DEPT_NO FROM DEPART WHERE DNOMBRE='CONTABILIDAD');





/* === CREACIÓN CON SELECT === */
/*EJEMPLO1: Crear una tabla llamada EMPLE1 con los empleados del departamento 30.*/
CREATE TABLE EMPLE1 AS SELECT * FROM EMPLE WHERE DEPT_NO=30;

/*EJEMPLO2: Crear una tabla EMPLE_DEPART a partir de las tablas EMPLE y DEPART. Esta tabla contendrá el apellido y el nombre del departamento de cada empleado.*/
CREATE TABLE EMPLE_DEPART AS SELECT E.APELLIDO, D.DNOMBRE FROM EMPLE E, DEPART D WHERE E.DEPT_NO=D.DEPT_NO;





/* === BORRADO DE FILAS === */
/*EJEMPLO: Borrar el COD_CENTRO 50 de la tabla CENTROS.*/
SELECT * FROM CENTROS;
DELETE FROM CENTROS WHERE COD_CENTRO=50;
/* Si no lleva *, es como si lo llevase, es decir, es como si fuese DELETE * FROM..., pero si pones *, no funciona */





/* === VISTAS (CREACIÓN Y USO) === */
/*Ejercicio: Crear una vista DEP30 que contiene el Apellido, Oficio  y Salario de los empleados de la tabla EMPLE del departamento 30. */
CREATE OR REPLACE VIEW DEP30 AS SELECT APELLIDO, OFICIO, SALARIO FROM EMPLE WHERE DEPT_NO=30;

/*	Comprobar la descripción de DEP30*/
DESC DEP30;

/*	Consultar el contenido de DEP30*/
SELECT * FROM DEP30;

/*	Para consultar las vistas creadas está USER_VIEWS (view_name, text)*/
SELECT VIEW_NAME, TEXT FROM USER_VIEWS;

/*	¿Qué ocurriría si borrásemos la tabla EMPLE? */
DROP TABLE EMPLE;
DESC DEP30;
/* si la tabla original se borra, la vista se va a la mierda */








/* === EJERCICIOS PROPUESTOS === */
/*TABLAS EMPLE Y DEPART*/
/*1.	Insertar a un empleado de apellido ‘SAAVEDRA’ con número 2000. La fecha de alta será la actual, el SALARIO será el mismo salario de
‘SALA’ más el 20 % y el resto de datos serán los mismos que los datos de ‘SALA’.*/
/* SALA es un apellido */
INSERT INTO EMPLE SELECT 2000, 'SAAVEDRA', OFICIO, DIR, SYSDATE, SALARIO*1.20, COMISION, DEPT_NO FROM EMPLE WHERE APELLIDO='SALA';

/*2.	Modificar el número de departamento de ‘SAAVEDRA’. El nuevo departamento será el departamento donde hay más empleados (group by + having count)
cuyo oficio sea ‘EMPLEADO’.*/
UPDATE
	EMPLE
SET 
	DEPT_NO = (SELECT DEPT_NO FROM EMPLE WHERE OFICIO LIKE 'EMPLEADO' GROUP BY DEPT_NO HAVING COUNT (*) = (SELECT MAX(COUNT(*)) FROM EMPLE WHERE OFICIO LIKE 'EMPLEADO' GROUP BY DEPT_NO))
WHERE
	APELLIDO LIKE 'SAAVEDRA';
/*como ponga este en el examen, estoy F*/

/*3.	Borrar todos los departamentos de la tabla DEPART para los cuales no existan empleados en EMPLE.*/
DELETE FROM DEPART WHERE DEPT_NO NOT IN (SELECT DEPT_NO FROM EMPLE);
/* Si no lleva *, es como si lo llevase, es decir, es como si fuese DELETE * FROM..., pero si pones *, no funciona */



/*TABLAS PERSONAL, PROFESORES Y CENTROS*/
/*4.	Modificar el número de plazas con un valor igual a la mitad en aquellos centros con menos de dos profesores. (group by + having count). */
UPDATE CENTROS SET NUM_PLAZAS = NUM_PLAZAS/2 WHERE COD_CENTRO IN (SELECT COD_CENTRO FROM PROFESORES GROUP BY COD_CENTRO HAVING COUNT(DNI)<2);
/*comprobación*/
SELECT COD_CENTRO, COUNT(*) "NUM PROFES" FROM PROFESORES GROUP BY COD_CENTRO HAVING COUNT(*)<2;

/*5.	Eliminar los centros que no tengan personal.*/
DELETE FROM CENTROS WHERE COD_CENTRO NOT IN (SELECT COD_CENTRO FROM PERSONAL);

/*6.	Añadir un nuevo profesor en el centro o en los centros cuyo número de administrativos sea 1, en la especialidad de ‘IDIOMA’, con DNI 8790005
y de nombre ‘Clara Salas’. DISTINCT.*/
/* (WTF, REPASAR) */
INSERT INTO
	PROFESORES
SELECT DISTINCT
	COD_CENTRO, 8790055,'SALAS,CLARA','IDIOMA'
FROM
	PROFESORES
WHERE
	COD_CENTRO IN (SELECT COD_CENTRO FROM PERSONAL WHERE FUNCION = 'ADMINISTRATIVO' GROUP BY COD_CENTRO HAVING COUNT(*) = 1);

/*7.	Borrar al personal que esté en centros de menos de 300 plazas (WHERE) y con menos de dos profesores (group by + having). (IMP)*/
DELETE FROM PERSONAL WHERE COD_CENTRO IN
(SELECT COD_CENTRO FROM CENTROS WHERE NUM_PLAZAS<300) AND COD_CENTRO IN (SELECT COD_CENTRO FROM PROFESORES GROUP BY COD_CENTRO HAVING COUNT(*)<2);

/*8.	Borrar a los profesores que estén en la tabla PROFESORES y que no estén en la tabla PERSONAL.*/
DELETE FROM PROFESORES WHERE DNI NOT IN (SELECT DNI FROM PERSONAL);
DELETE FROM PROFESORES WHERE DNI IN (SELECT DNI FROM PROFESORES MINUS SELECT DNI FROM PERSONAL);

/*11. Crear una vista que se llame CONSERJES que contenga el nombre del centro y el nombre de sus conserjes.*/
CREATE OR REPLACE VIEW CONSERJES AS SELECT NOMBRE,APELLIDOS FROM CENTROS, PERSONAL WHERE FUNCION='CONSERJE' AND CENTROS.COD_CENTRO=PERSONAL.COD_CENTRO;

/*12. Crear un sinónimo llamado CONSER asociado a la vista creada antes.*/
CREATE SYNONYM CONSER FOR CONSERJES;

/*13.	Cambiar el nombre de la tabla PROFESORES y llamarla PROFES.*/
RENAME PROFESORES TO PROFES;