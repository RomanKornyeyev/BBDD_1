/* === CONSULTAS === */
/* === UNA SOLA TABLA === */
/*•	A partir de la tabla EMPLE. Obtener aquellos apellidos que empiecen por una ‘J’*/
SELECT APELLIDO FROM EMPLE WHERE APELLIDO LIKE 'J%';

/*•	Obtener aquellos apellidos que tengan una R en la segunda posición*/
SELECT APELLIDO FROM EMPLE WHERE APELLIDO LIKE '_R%';

/*•	Obtener aquellos apellidos que empiecen por A y tengan una O en su interior*/
SELECT APELLIDO FROM EMPLE WHERE APELLIDO LIKE 'A%O%';

/*•	Consultar en la tabla EMPLE los apellidos de los empleados cuya comisión es NULL*/
SELECT APELLIDO FROM EMPLE WHERE COMISION IS NULL;

/*•	Consultar los apellidos de la tabla EMPLE cuyo número de departamento sea 10 ó 30:*/
SELECT APELLIDO FROM EMPLE WHERE DEPT_NO IN (10,30);

/*•	Consultar los apellidos de la tabla EMPLE cuyo número de departamento no sea ni 10 ni 30:*/
SELECT APELLIDO FROM EMPLE WHERE DEPT_NO NOT IN (10,30);

/*•	Consultar los apellidos de la tabla EMPLE cuyo oficio sea ‘VENDEDOR’, ‘ANALISTA’ O ‘EMPLEADO’:*/
SELECT APELLIDO FROM EMPLE WHERE OFICIO IN('VENDEDOR', 'ANALISTA', 'EMPLEADO');





/* === SUBCONSULTAS === */
/* Presentar los nombres y oficios de los empleados que tienen el mismo oficio que “JIMENEZ” */
SELECT APELLIDO, OFICIO FROM EMPLE WHERE OFICIO IN (SELECT OFICIO FROM EMPLE WHERE APELLIDO='JIMENEZ');





/* === COMBINACIÓN DE TABLAS === */
/*•	Con las tablas ALUMNOS, ASIGNATURAS,NOTAS realizar una consulta para obtener el nombre de alumno, su asignatura y su nota.*/
SELECT APENOM "ALUMNO", NOMBRE "ASIGNATURA", NOTA FROM ALUMNOS AL, ASIGNATURAS A, NOTAS N WHERE AL.DNI=N.DNI AND A.COD=N.COD;

/*•	Seleccionar el apellido, el oficio y la localidad de los departamentos donde trabajan los ANALISTAS.*/ 
SELECT E.APELLIDO, E.OFICIO, D.LOC FROM EMPLE E, DEPART D WHERE E.DEPT_NO=D.DEPT_NO AND E.OFICIO='ANALISTA';





/* === FUNCIONES === */
/*1.	Calculo del SALARIO medio de los empleados del departamento 10 en la tabla EMPLE.*/
SELECT AVG(SALARIO) FROM EMPLE WHERE DEPT_NO=10;

/*2.	Calcula el número de filas de la tabla EMPLE*/
SELECT COUNT(*) FROM EMPLE;

/*3.	Cuenta las tuplas de la tabla EMPLE en los que COMISIÓN no es nula.*/
SELECT COUNT(COMISION) FROM EMPLE;

/*4.	Obtén el máximo salario de la tabla EMPLE*/
SELECT MAX(SALARIO) FROM EMPLE;

/*5.	Obtener la suma de todos los salarios de la tabla EMPLE*/
SELECT SUM(SALARIO) FROM EMPLE;

/*6.	Obtener el salario y el apellido del empleado con el mayor salario de la tabla EMPLE;*/
SELECT APELLIDO, SALARIO FROM EMPLE WHERE SALARIO = (SELECT MAX(SALARIO) FROM EMPLE);

/*7.	Mostrar la fecha de hoy con el siguiente formato: hoy es miércoles, 10 de febrero de 2021. */
SELECT TO_CHAR(SYSDATE, '"Hoy es" day "," dd "de" month "de" yyyy') FROM DUAL;

/*8.	Dada la tabla NACIMIENTOS, realizar  una sentencia SELECT que obtenga la siguiente salida:*/
/*NOMBRE		FECHANAC        Formateado*/
/*Pedro			12/05/1982         Nació el    12   de mayo  de 1982*/
SELECT NOMBRE, FECHANAC, TO_CHAR(FECHANAC, '"Nació el" dd "de" month "de" yyyy') "Formateado" FROM NACIMIENTOS; 

/*9	Visualizar la suma de salarios de la tabla EMPLE de manera formateada, tal que aparezca el símbolo de la moneda local, el punto para los miles y la coma para los decimales.*/
ALTER SESSION SET NLS_CURRENCY='euros';
SELECT TO_CHAR(SUM(SALARIO), '99G999D99L') "SUMA SALARIOS" FROM EMPLE;

/*•	Dada la tabla EMPLE, obtener el sueldo medio, el número de comisiones no nulas, el máximo sueldo y el mínimo sueldo de los empleados del departamento 30.*/
/*Emplear el formato adecuado para la salida para las cantidades numéricas.*/
SELECT 
	TO_CHAR(AVG(SALARIO), '99G999D99L') "SUELDO MEDIO",
	COUNT(COMISION) "COMISIONES NO NULAS",
	TO_CHAR(MAX(SALARIO), '99G999D99L') "MAX",
	TO_CHAR(MIN(SALARIO), '99G999D99L') "MIN"
FROM 
	EMPLE WHERE DEPT_NO=30;





/* === GROUP BY === */
/*•	A partir de la tabla EMPLE visualizar el número de empleados que hay en cada departamento.*/
SELECT DEPT_NO "DEPARTAMENTO", COUNT(EMP_NO) "NUM EMPLEADOS" FROM EMPLE GROUP BY DEPT_NO;

/*•	Visualizar los departamentos con más de 4 empleados*/
SELECT DEPT_NO "DEPARTAMENTO", COUNT(EMP_NO) "NUM EMPLEADOS" FROM EMPLE GROUP BY DEPT_NO HAVING COUNT(EMP_NO) > 4;

/*•	Obtener los nombres de los departamentos que tengan más de tres personas trabajando*/
/* repasar */
SELECT E.DEPT_NO, D.DNOMBRE, COUNT(EMP_NO) "NUM EMPLEADO" FROM DEPART D, EMPLE E WHERE D.DEPT_NO=E.DEPT_NO GROUP BY E.DEPT_NO, D.DNOMBRE HAVING COUNT (*) > 3;

/*•	Visualizar los departamentos en los que el salario medio es mayor o igual que la media de todos los salarios.*/
SELECT DEPT_NO, AVG(SALARIO) FROM EMPLE GROUP BY DEPT_NO HAVING AVG(SALARIO) >= (SELECT AVG(SALARIO) FROM EMPLE);





/* === MANIPULACIÓN === */
/*Insertar el empleado de apellido QUIROGA, con nº de empleado 1112 en la tabla EMPLE, los restantes datos de QUIROGA serán los mismos que los de GIL y
la fecha de alta será la fecha actual.*/
INSERT INTO EMPLE SELECT 1112, 'QUIROGA', OFICIO, DIR, SYSDATE, SALARIO, COMISION, DEPT_NO FROM EMPLE WHERE APELLIDO = 'GIL';

/*Para actualizar*/
/*EJEMPLO: Sea la tabla CENTROS, cuyo  COD_CENTRO es 22 cambiar la direccion a ‘C/PILON 13’ y el numero de plazas a 295.*/
UPDATE CENTROS SET DIRECCION='C/PILON 13', NUM_PLAZAS=295 WHERE COD_CENTRO=22;

/*EJEMPLO: Borrar el COD_CENTRO 50 de la tabla CENTROS.*/
DELETE FROM CENTROS WHERE COD_CENTRO=50;

/*Crear una vista DEP30 que contiene el Apellido, Oficio  y Salario de los empleados de la tabla EMPLE del departamento 30. */
CREATE OR REPLACE VIEW DEP30 AS SELECT APELLIDO, OFICIO, SALARIO FROM EMPLE WHERE DEPT_NO=30;

/*1.	Borrar al personal que esté en centros de menos de 300 plazas y con menos de dos profesores.*/
/*repasar*/
DELETE FROM PERSONAL WHERE COD_CENTRO IN (SELECT COD_CENTRO FROM CENTROS WHERE NUM_PLAZAS<300)
AND COD_CENTRO IN (SELECT COD_CENTRO FROM PROFESORES GROUP BY COD_CENTRO HAVING COUNT(*) <2);





/* === INTERSECT, MINUS === */
/*2.	Visualizar los nombres de los alumnos actuales y de los futuros alumnos*/
SELECT NOMBRE FROM ALUM UNION SELECT NOMBRE FROM NUEVOS;

/*3.	Obtener los nombres de los alumnos que están actualmente en el centro y que ya estuvieron en el pasado.*/
SELECT NOMBRE FROM ALUM INTERSECT SELECT NOMBRE FROM ANTIGUOS;
SELECT NOMBRE FROM ALUM WHERE NOMBRE IN (SELECT NOMBRE FROM ANTIGUOS);
/**** INTERSECT = IN ****/

/*4.	Obtener los nombres y la localidad de alumnos que están actualmente en el centro y que nunca estuvieron anteriormente en él.*/
SELECT NOMBRE, LOCALIDAD FROM ALUM MINUS SELECT NOMBRE FROM ANTIGUOS;
SELECT NOMBRE, LOCALIDAD FROM ALUM WHERE NOMBRE NOT IN (SELECT NOMBRE FROM ANTIGUOS);
/**** MINUS = NOT IN ****/