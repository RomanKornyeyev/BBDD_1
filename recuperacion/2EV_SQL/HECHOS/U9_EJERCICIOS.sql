/* === FUNCIONES ARITMÉTICAS === */
/*15)	Calculo del SALARIO medio de los empleados del departamento 10 en la tabla EMPLE.*/
SELECT AVG(SALARIO) FROM EMPLE WHERE DEPT_NO=10;

/*16)	Calcula el número de filas de la tabla EMPLE*/
SELECT COUNT(EMP_NO) "NUM FILAS" FROM EMPLE;

/*17)	Cuenta las tuplas de la tabla EMPLE en los que COMISION no es nula.*/
SELECT COUNT(EMP_NO) "NUM FILAS" FROM EMPLE WHERE COMISION IS NOT NULL;

/*18)	Obtén el máximo salario de la tabla EMPLE*/
SELECT MAX(SALARIO) FROM EMPLE;

/*19)	Obtener el apellido máximo alfabéticamente de la tabla EMPLE
Sale Tovar porque la T está más lejos (es la más grande).*/
SELECT MAX(APELLIDO) FROM EMPLE;

/*20)	Obtener el salario y el apellido del empleado con apellido máximo de la tabla EMPLE; (===IMP===)
Hay que hacer subconsulta, porque select apellido, max(salario) from emple, DEVOLVERÍA SOLO UNA CONSULTA.
=== Cuando me piden una función y otro campo, OBLIGATORIAMENTE TENGO QUE HACER UNA SUBCONSULTA ===
=== es decir, cuando me piden salario, max(apellido) ESTO ESTARÍA MAL Y HAY QUE HACER SUBCONSULTA === */
SELECT SALARIO, APELLIDO FROM EMPLE WHERE APELLIDO IN (SELECT MAX(APELLIDO) FROM EMPLE);

/*21)	Obtener el salario y el apellido del empleado con el mayor salario de la tabla EMPLE; (===IMP===)*/
SELECT SALARIO, APELLIDO FROM EMPLE WHERE SALARIO IN (SELECT MAX(SALARIO) FROM EMPLE);
/* valdría con el igual en vez del IN */

/*22)	Obtener el apellido y salario del empleado con el menor salario. (===IMP===)*/
SELECT SALARIO, APELLIDO FROM EMPLE WHERE SALARIO IN (SELECT MIN(SALARIO) FROM EMPLE);

/*23)	Obtener la suma de todos los salarios de la tabla EMPLE*/
SELECT SUM(SALARIO) "SUMA SALARIOS" FROM EMPLE;

/*24)	Calcular la varianza de SALARIO de la tabla EMPLE.*/
SELECT VARIANCE(SALARIO) "VARIANZA" FROM EMPLE;

/*25)	Cuenta los oficios distintos que tienen los empleados de los departamentos 10 y 20. Utiliza la cláusula IN.*/
SELECT COUNT(DISTINCT OFICIO) FROM EMPLE WHERE DEPT_NO IN (10,20);

/*26)	Obtener la mayor y la menor nota de los alumnos de la tabla NOTAS_ALUMNOS para cada alumnos. (POCO IMP)*/
SELECT NOMBRE_ALUMNO 'Alumno', GREATEST(NOTA1, NOTA2, NOTA3) 'Mayor', LEAST(NOTA1, NOTA2, NOTA3) 'Menor' FROM NOTAS_ALUMNOS;





/* === FUNCIONES DE CARACTERES Y FUNCIONES QUE DEVUELVEN VALORES NUMÉRICOS (POCO IMP) === */
/*1)	Devolver la letra cuyo valor ASCII es 65*/
SELECT CHR(65) "ASCII" FROM DUAL;

/*2)	 Obtener en una columna el apellido y el oficio de cada uno de los empleados de la tabla EMPLE como en este ejemplo SANCHEZ es EMPLEADO.*/
SELECT CONCAT(CONCAT(APELLIDO,' ES '), OFICIO)FROM EMPLE;
SELECT APELLIDO||' ES '|| OFICIO FROM EMPLE; /*ASÍ ES MÁS FÁCIL*/

/*3)	 Obtener el apellido de los empleados de EMPLE en minúsculas*/
SELECT LOWER(APELLIDO) "APELLIDO MINUS" FROM EMPLE;

/*3.1)  Visualizar en mayúscula, minúscula.*/
SELECT UPPER('oRaCle Y sql') "holaMayus" FROM DUAL; /*'hola' es como una constraint*/
SELECT LOWER('oRaCle Y sql') "holaMinus" FROM DUAL;





/* === FUNCIONES DE FECHAS (POCO IMP, MIRARLO Y QUE SUENE) === */
/*1)	Obtener la fecha del sistema*/
SELECT SYSDATE FROM DUAL;

/*2)	Dada la tabla EMPLE, sumar y restar dos meses a la fecha de alta. Mostrar las tres fecha cada una con una cabecera especificada por tí.*/
SELECT FECHA_ALT "alta original", ADD_MONTHS(FECHA_ALT,2) "suma2", ADD_MONTHS(FECHA_ALT,-2) "resta2" FROM EMPLE;

/*3)	Obtener en la tabla EMPLE el último día del mes para cada mes de las fechas de alta.*/
SELECT FECHA_ALT "fechaAlta", LAST_DAY(FECHA_ALT) "últimoDíaAlta" FROM EMPLE;

/*4)	Obtener nuestra edad utilizando las diferentes funciones de fecha.*/
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE,'26/09/1997')/12) "Edad de Román" FROM DUAL;

/*5)	Si hoy es jueves 22 de Enero de 2020(fecha del sistema) ¿qué fecha será el próximo jueves?*/
SELECT NEXT_DAY(SYSDATE,'lunes') '7 días más' FROM DUAL;
/*En miércoles hay que poner acento.*/





/* === FUNCIONES DE CONVERSIÓN (==MUY IMPORTANTE, EXAMEN==) === */
/* === TO_CHAR, TO_NUMBER, TO_DATE === */
/*TO_CHAR: To_char (fecha, 'formato').*/
/*1.	Mostrar a partir de la tabla emple la fecha de alta con el siguiente formato: Nombre del mes con todas sus letras,
el número del día del mes con dos caracteres y el año con cuatro dígitos.*/
SELECT FECHA_ALT, TO_CHAR(FECHA_ALT,'Month dd yyyy') "FORMATEADA" FROM EMPLE;

/*2.	Mostrar la fecha de alta con la abreviatura del mes, número del día del año, último dígito del año y los tres últimos dígitos del año.*/
SELECT FECHA_ALT, TO_CHAR(FECHA_ALT,'MON Ddd y yyy') FROM EMPLE;

/*3. Mostrar la fecha de hoy con el siguiente formato: hoy es , miércoles 10 de febrero de 2021. */
SELECT TO_CHAR(SYSDATE, '"Hoy es" day "," dd "de" month "de" yyyy') "FECHA ACTUAL" FROM DUAL;


/*TO_CHAR(NUMBER, 'FORMATO') */
/*1. Visualizar la suma de los salarios de la tabla emple de manera que aparezca el símbolo de la moneda el punto para los miles y la coma para los decimales.*/
ALTER SESSION SET NLS_CURRENCY='euros'; /*si funciona*/
ALTER SESSION SET NLS_CURRENCY='€'; /*no funciona*/
SELECT TO_CHAR(SUM(SALARIO),'99G999D99L') "TOTAL" FROM EMPLE;
SELECT TO_CHAR(SUM(SALARIO),'999G999G999D99L') "TOTAL" FROM EMPLE;


/*TO_DATE(CADENA, [‘FORMATO’]) */
/*1.	Convertir la cadena 04012007 a tipo fecha.*/
SELECT TO_DATE('04012007') "FECHA" FROM DUAL;


/*2.	Obtener el nombre del mes a partir de la cadena 09012008*/
SELECT TO_CHAR(TO_DATE('09012008'), 'Month') "MES" FROM DUAL;





/* === EJERCICIOS PROPUESTOS (IMP) === */
/*1.	A partir de la tabla EMPLE, visualizar cuantos apellidos de los empleados empiezan por la letra A’.*/
SELECT COUNT(APELLIDO) FROM EMPLE WHERE APELLIDO LIKE 'A%';

/*2.	Dada la tabla EMPLE, obtener el sueldo medio, el número de comisiones no nulas, el máximo sueldo y el mínimo sueldo de los empleados del departamento 30.
Emplear el formato adecuado para la salida para las cantidades numéricas.
El '999G999D99' es el formato de monedas: 102.234,12;
La G es un punto (miles) y la D (centésimas) es una coma.*/
SELECT
	TO_CHAR(AVG(SALARIO), '99G999D99L') "MEDIO",
	COUNT(COMISION) "COM NO NULAS",
	TO_CHAR(MIN(SALARIO),'99G999D99L') "MÍNIMO",
	TO_CHAR(MAX(SALARIO), '99G999D99L') "MÁXIMO" 
FROM EMPLE WHERE DEPT_NO=30;

/*3.	Contar las filas de LIBRERIA cuyo tema tenga, por lo menos, una ‘A’.*/
SELECT COUNT(*) FROM LIBRERIA WHERE TEMA LIKE '%A%';

/*4.	Visualizar el tema con mayor número de ejemplares de la tabla LIBRERIA y que tengan, al menos, una ‘E’ (pueden ser un tema o varios).*/
SELECT TEMA FROM LIBRERIA WHERE EJEMPLARES = (SELECT MAX(EJEMPLARES) FROM LIBRERIA) AND (TEMA LIKE '%E%'); 

/*5.	Visualizar el número de estantes diferentes que hay en la tabla LIBRERIA.*/
SELECT COUNT(DISTINCT ESTANTE) "Estantes distintos" FROM LIBRERIA;

/*6.	Visualizar el número de estantes distintos que hay en la tabla LIBRERIA de aquellos temas que contienen, al menos, una ‘e’.*/
SELECT COUNT(DISTINCT ESTANTE) "Estantes distintos con E" FROM LIBRERIA WHERE TEMA LIKE '%E%';

/*7.	A partir de la tabla LIBROS, realizar una sentencia SELECT para que aparezcan los títulos ordenados por su número de caracteres.*/
SELECT TITULO FROM LIBROS ORDER BY LENGTH(TITULO);

/*8.	Dada la tabla NACIMIENTOS, realizar  una sentencia SELECT que obtenga la siguiente salida:
NOMBRE			FECHANAC
Pedro			12/05/82  Nació el    12   de mayo  de 1982*/
SELECT 
	NOMBRE "NOMBRE",
	TO_CHAR(FECHANAC, 'dd/mm/yy "Nació el" dd "de" month "de" yyyy') "FECHA NACIMIENTO"
FROM
	NACIMIENTOS;

/*9.	Convertir la cadena ‘01051998’ a fecha y visualizar su nombre de mes en mayúsculas*/
SELECT TO_CHAR(TO_DATE('01051998','DDMMYY'), 'dd/MONTH/yyyy') "Fecha" FROM DUAL;

/*10.	A partir de la tabla EMPLE, obtener el apellido de los empleados que lleven más de 24 años trabajando revisar fechas*/
SELECT APELLIDO FROM EMPLE WHERE MONTHS_BETWEEN(SYSDATE, FECHA_ALT)/12 > 24;

/*11.	Seleccionar el apellido de los empleados de la tabla EMPLE que lleven más de 24 años trabajando en el departamento ‘VENTAS’ revisar fechas*/
SELECT APELLIDO FROM EMPLE E, DEPART D WHERE
	(D.DEPT_NO=E.DEPT_NO)
	AND
	(MONTHS_BETWEEN(SYSDATE, FECHA_ALT)/12 > 24)
	AND
	(DNOMBRE = 'VENTAS');