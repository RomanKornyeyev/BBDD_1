/*para que salga el texto por consola (si no, no sale nada)*/
/*para que pregunte solo 1 vez para la var introducida x teclado*/
/*en caso de crear un bloque/procedimiento/función con errores de compilación */
SET SERVEROUTPUT ON;
SET VERIFY OFF;
SHOW ERRORS;




/*1-	Introducir un valor por teclado, crear una excepción si el valor es negativo.
Visualizar tanto si el valor es positivo como el de la excepción.*/





/*2-	Escribir un procedimiento que reciba un número de empleado y una cantidad que
incrementara el salario del empleado correspondiente. Utilizar dos excepciones, una definida
por el usuario salario_nulo y la otra predefinida NO_DATA_FOUND si no encuentra el nº de empleado. 
Mirar en las tablas si hay salarios nulos, si no hay insertar un nuevo empleado con salario nulo.*/





/*3-	 Escribir un procedimiento que reciba los datos de un nuevo empleado. El procedimiento deberá controlar los siguientes errores:
- No existe departamento. 
- No existe director. Crear la excepción.
- Numero de empleado duplicado. Crear una clave primaria para EMP_NO ALTERANDO LA TABLA.
*/





/*4-	 Desarrollar un procedimiento que permita insertar nuevos departamentos según las siguientes especificaciones:
Se pasará al procedimiento el nº del departamento, nombre del departamento y la localidad.
El procedimiento insertará la fila nueva. 
Se incluirá la gestión del error que no se duplique el nº del dep. y el nombre del departamento.
*/






/*5-	Crear una excepción mediante RAISE_APPLICATION_ERROR que no se puede dividir por 0. */