/* === CONSULTAS === */
/* === UNA SOLA TABLA === */
/*•	A partir de la tabla EMPLE. Obtener aquellos apellidos que empiecen por una ‘J’*/

/*•	Obtener aquellos apellidos que tengan una R en la segunda posición*/

/*•	Obtener aquellos apellidos que empiecen por A y tengan una O en su interior*/

/*•	Consultar en la tabla EMPLE los apellidos de los empleados cuya comisión es NULL*/

/*•	Consultar los apellidos de la tabla EMPLE cuyo número de departamento sea 10 ó 30:*/

/*•	Consultar los apellidos de la tabla EMPLE cuyo número de departamento no sea ni 10 ni 30:*/

/*•	Consultar los apellidos de la tabla EMPLE cuyo oficio sea ‘VENDEDOR’, ‘ANALISTA’ O ‘EMPLEADO’:*/





/* === SUBCONSULTAS === */
/* Presentar los nombres y oficios de los empleados que tienen el mismo oficio que “JIMENEZ” */





/* === COMBINACIÓN DE TABLAS === */
/*•	Con las tablas ALUMNOS, ASIGNATURAS,NOTAS realizar una consulta para obtener el nombre de alumno, su asignatura y su nota.*/

/*•	Seleccionar el apellido, el oficio y la localidad de los departamentos donde trabajan los ANALISTAS.*/ 





/* === FUNCIONES === */
/*1.	Calculo del SALARIO medio de los empleados del departamento 10 en la tabla EMPLE.*/

/*2.	Calcula el número de filas de la tabla EMPLE*/

/*3.	Cuenta las tuplas de la tabla EMPLE en los que COMISIÓN no es nula.*/

/*4.	Obtén el máximo salario de la tabla EMPLE*/

/*5.	Obtener la suma de todos los salarios de la tabla EMPLE*/

/*6.	Obtener el salario y el apellido del empleado con el mayor salario de la tabla EMPLE;*/

/*7.	Mostrar la fecha de hoy con el siguiente formato: hoy es miércoles, 10 de febrero de 2021. */

/*8.	Dada la tabla NACIMIENTOS, realizar  una sentencia SELECT que obtenga la siguiente salida:*/
/*NOMBRE		FECHANAC        Formateado*/
/*Pedro			12/05/1982         Nació el    12   de mayo  de 1982*/

/*9	Visualizar la suma de salarios de la tabla EMPLE de manera formateada, tal que aparezca el símbolo de la moneda local, el punto para los miles y la coma para los decimales.*/
ALTER SESSION SET NLS_CURRENCY='euros';

/*•	Dada la tabla EMPLE, obtener el sueldo medio, el número de comisiones no nulas, el máximo sueldo y el mínimo sueldo de los empleados del departamento 30.*/
/*Emplear el formato adecuado para la salida para las cantidades numéricas.*/






/* === GROUP BY === */
/*•	A partir de la tabla EMPLE visualizar el número de empleados que hay en cada departamento.*/

/*•	Visualizar los departamentos con más de 4 empleados*/

/*•	Obtener los nombres de los departamentos que tengan más de tres personas trabajando*/
/* repasar */

/*•	Visualizar los departamentos en los que el salario medio es mayor o igual que la media de todos los salarios.*/





/* === MANIPULACIÓN === */
/*Insertar el empleado de apellido QUIROGA, con nº de empleado 1112 en la tabla EMPLE, los restantes datos de QUIROGA serán los mismos que los de GIL y
la fecha de alta será la fecha actual.*/

/*Para actualizar*/
/*EJEMPLO: Sea la tabla CENTROS, cuyo  COD_CENTRO es 22 cambiar la direccion a ‘C/PILON 13’ y el numero de plazas a 295.*/

/*EJEMPLO: Borrar el COD_CENTRO 50 de la tabla CENTROS.*/

/*Crear una vista DEP30 que contiene el Apellido, Oficio  y Salario de los empleados de la tabla EMPLE del departamento 30. */

/*1.	Borrar al personal que esté en centros de menos de 300 plazas y con menos de dos profesores.*/
/*repasar*/





/* === INTERSECT, MINUS === */
/*2.	Visualizar los nombres de los alumnos actuales y de los futuros alumnos*/

/*3.	Obtener los nombres de los alumnos que están actualmente en el centro y que ya estuvieron en el pasado.*/

/**** INTERSECT = IN ****/

/*4.	Obtener los nombres y la localidad de alumnos que están actualmente en el centro y que nunca estuvieron anteriormente en él.*/

/**** MINUS = NOT IN ****/