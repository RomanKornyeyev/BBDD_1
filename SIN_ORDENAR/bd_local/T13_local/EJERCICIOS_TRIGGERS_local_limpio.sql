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
CREATE TABLE AUDITAR_EMPLE(
	COL1 VARCHAR2(200)
);






/*2-	Crear un trigger que se disparará cada vez que se borre un empleado, guardando el literal “borrado empleado”,  su número de empleado,
apellido y el departamento en una fila de la tabla AUDITAR_EMPLE.*/






/*3-	Incluir una restricción en el ejercicio anterior para que se ejecute el disparador cuando el empleado borrado sea PRESIDENTE.*/







/*4-	Escribe un disparador que permite auditar las operaciones de inserción o borrado de datos que se realicen en la tabla EMPLE según las siguientes especificaciones:
-	Se creará la tabla auditar_emple con col1 varchar2(200).
-	Cuando se produzca cualquier manipulación, se insertara un fila en la tabla creada que contendrá: fecha y hora, nºempleado, apellido y la palabra INSERCIÓN O BORRADO según la actualización.
Utilizar el formato múltiples eventos.
*/






/*5-	Escribir un disparador que controle las conexiones de los usuarios en la base de datos. Para ello crearemos la siguiente tabla:*/
CREATE TABLE CONTROL_CONEXIONES(
	USUARIO VARCHAR2(20),
	MOMENTO TIMESTAMP,
	EVENTO VARCHAR2(20)
);