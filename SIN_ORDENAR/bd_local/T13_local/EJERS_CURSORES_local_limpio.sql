SET SERVEROUTPUT ON;
SET VERIFY OFF;
SHOW ERRORS;

/*1-	Escribir un bloque PL que utilice un cursor explicito para visualizar el nombre
y la localidad de todos los departamentos.*/
/*EL EXIT VA ANTES PARA NO DUPLICAR LA ÚLTIMA ROW DE SALIDA*/


/*2-	Visualizar los apellidos de los empleados pertenecientes al departamento 20 numerándolos secuencialmente.
Utilizar   %ROWCOUNT los números secuenciales.
1.SANCHEZ
2.JIMENEZ
3.GIL
4.ALONSO
5.FERNANDEZ
*/
/*CON WHILE*/

/*3-	Visualizar los empleados de un departamento mediante un procedimiento y utilizando variables de acoplamiento.*/


/*4-	Escribir un bloque PL que visualice el apellido, el oficio y la comisión de los empleados que supere los 500€. Utilizando CURSOR FOR........LOOP.*/


/*5-	 Escribir un bloque PL que visualice el apellido y la fecha de alta de todos los empleados ordenados por fecha de alta. Utilizando CURSOR FOR........LOOP.*/


/*6-	Desarrollar un procedimiento que visualice el apellido y la fecha de alta de todos los empleados ordenados por apellido.*/


/*7-	Codificar un procedimiento que muestre el nombre de cada departamento y el número de empleados que tiene.*/


/*8-	Escribir un procedimiento que visualice el apellido y el salario de los cinco empleados que tienen el salario más alto.
REY	4100
NEGRO	3005
FERNANDEZ3000
GIL	3000
JIMENEZ	2900
CEREZO	2885
MUÑOZ	1690
SALA	1625
MARTIN	1600
ARROYO	1500
ALONSO	1430
TOVAR	1350
JIMENO	1335
SANCHEZ 1040
La salida seria:
REY*4100
NEGRO*3005
FERNANDEZ*3000
GIL*3000
JIMENEZ*2900
*/


/*9-	Codificar un procedimiento que visualice los dos empleados que ganan menos de cada oficio.
FERNANDEZANALISTA	3000
GIL	ANALISTA	3000
CEREZO	DIRECTOR	2885
JIMENEZ	DIRECTOR	2900
NEGRO	DIRECTOR	3005
SANCHEZ EMPLEADO	1040
JIMENO	EMPLEADO	1335
ALONSO	EMPLEADO	1430
MUÑOZ	EMPLEADO	1690
REY	PRESIDENTE	4100
TOVAR	VENDEDOR	1350
ARROYO	VENDEDOR	1500
MARTIN	VENDEDOR	1600
SALA	VENDEDOR	1625

La salida seria:
ANALISTA*FERNANDEZ*3000
ANALISTA*GIL*3000
DIRECTOR*CEREZO*2885
DIRECTOR*JIMENEZ*2900
EMPLEADO*SANCHEZ*1040
EMPLEADO*JIMENO*1335
PRESIDENTE*REY*4100
VENDEDOR*TOVAR*1350
VENDEDOR*ARROYO*1500
*/
