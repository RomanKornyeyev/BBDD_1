/*1.	Obtener la longitud de la circunferencia introduciendo el radio por teclado cuyo valor es en cm
y el resultado lo queremos en metros.*/
/*BLOQUE*/

/*PROCEDIMIENTO*/

EXECUTE LONGITUD_CIRCUNFERENCIA(20);


/*2.	Obtener el salario del empleado 7839 de la tabla EMPLE.*/
/*BLOQUE*/

/*PROCEDIMIENTO*/

EXECUTE OBTENERSALARIO(7839);


/*3.	Mostrar el nombre de la asignatura con código 7 de la tabla ASIGNATURAS.*/
/*BLOQUE*/

/*PROCEDIMIENTO*/


/*4.	Visualizar el nombre de la tabla PROFESORES, introduciendo el DNI por teclado
a través de una variable de sustitución.*/
/*BLOQUE*/

/*PROCEDIMIENTO*/


/*5.	A través de variables visualice el departamento VENTAS de la tabla DEPART con
el siguiente mensaje ‘El departamento nº X esta en XXX’.*/
/*BLOQUE*/

/*PROCEDIMIENTO*/

EXECUTE VISUALIZAR_VENTAS('VENTAS');


/*6.	Insertar en la tabla EMPLE un empleado con código 9999 asignado directamente
en la variable, apellido ‘PEREZ’, oficio ‘ANALISTA’ y código del departamento al que pertenece 10.*/
/*BLOQUE*/

/*PROCEDIMIENTO*/


/*7.	Incrementar el salario en la tabla EMPLE en 200€ a todos los trabajadores que sean ‘ANALISTAS’, mediante un bloque anónimo PL,
asignando dicho valor a una variable declarada%TYPE.*/
/* BLOQUE */

/*PROCEDIMIENTO*/


/*8.	Borrar un registro de la tabla EMPLE, existiendo en el bloque una variable PL y otra de sustitución.*/
/*BLOQUE*/

/*PROCEDIMIENTO*/


/*9.	Suprimir de la tabla ASIGNATURAS aquellos que tengan un código mayor a cinco utilizando los atributos del
cursor SQL%ROWCOUNT. Que muestre cuantas filas ha borrado. */
/*BLOQUE*/
/

/*PROCEDIMIENTO*/


/*10.	Obtener un bloque PL que introduciendo el código de un trabajador de la tabla EMPLE,
visualizar el código y su salario para posteriormente actualizarlo en función de su sueldo.
Si su sueldo es mayor de 1200 € su incremento será del 20% y su es menor del 25%. Visualizar
su sueldo actualizado.*/
/*BLOQUE*/

/*PROCEDIMIENTO*/


/*11.	Introduciendo un número por teclado, correspondiente al dorsal de un futbolista, dar como
salida el puesto en el que juega dicho jugador. Utilizar la estructura de control más adecuada.*/
/*PROCEDIMIENTO*/

EXECUTE PUESTO_JUGADOR(2);


/*12.	Dados dos números introducidos por teclado, obtener cuál de los dos es mayor.*/
/*BLOQUE*/

/*PROCEDIMIENTO*/


/*13.	Realizar un programa que devuelva el número de cifras de un número entero, introducido por teclado, mediante una variable de sustitución.*/
/*BLOQUE*/

/*PROCEDIMIENTO*/

EXECUTE NUM_CIFRAS (123);


/*14.	Dado un número introducido por teclado, visualizar por pantalla todos los números iguales o
inferiores a él. Este programa se efectuará por todos los tipos de estructuras repetitivas.*/
/*BLOQUE*/

/*PROCEDIMIENTO*/

EXECUTE NUM_RANGOS (13);


/*15.	Introduciendo un año por teclado, decir si este es bisiesto o no.*/
/*BLOQUE*/

/*PROCEDIMIENTO*/

EXECUTE BISIESTO_YEAR(2022);