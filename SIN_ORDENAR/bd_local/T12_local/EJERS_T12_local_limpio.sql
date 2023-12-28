/* === EJERCICIOS PROPUESTOS === */
/*para que salga el texto por consola (si no, no sale nada)*/
/*para que pregunte solo 1 vez para la var introducida x teclado*/
/* en caso de crear un bloque/procedimiento/función con errores de compilación */
SET SERVEROUTPUT ON; 
SET VERIFY OFF;
SHOW ERRORS; 


/*1-Construye un bloque PL/SQL que escriba el texto HOLA.*/
BEGIN
	DBMS_OUTPUT.PUT_LINE('HOLA');
END;
/

/*2- Construye un bloque PL/SQL para contar el numero de filas que hay en la tabla EMPLE depositar el resultado en la
variable v_num y visualizar el resultado.*/

/*3- Construye un bloque PL/SQL para visualizar el apellido y el oficio del empleado 7900.*/


/*4- Construye un bloque PL/SQL que muestre el precio de costo del articulo Canutillos
de categoría Primera.*/

/*5- Realizar un programa que solicite la introducción de un número de empleado(variables de acoplamiento
&var que no se declara) y visualizara el nombre correspondiente al número introducido. Para declarar el nombre
del empleado utilizaremos la variable %TYPE.*/

/*ejemplo: 7369 = SANCHEZ; 7900 = JIMENO*/

/*6- Escribir un bloque PL/SQL que muestre la fecha actual y la hora con minutos y segundos.*/

/*7- Modificar el salario de un empleado especificado en función del número de empleados que tiene a su cargo:
	- Si no tiene ningún empleado a su cargo la subida será de 50€.
	- Si tiene un empleado la subida será de 80€.
	- Si tiene dos la subida será de 100€.
	- Si tiene mas de tres la subida será de 110€.
Además si el empleado es PRESIDENTE se incrementara en 30€.
Resolverlo con IF….ELSE y con CASE.	
Introduzca un valor para vt_empno: 7839*/

/*8- Construir un bloque PL/SQL para que escriba la cadena HOLA al revés.
Utilizando FOR, WHILE y LOOP.*/
/*FOR*/

/*WHILE*/

/*LOOP (DO WHILE)*/


/*9- Escribir un bloque PL/SQL que introduzca dos números y los sume.
Introduzca un valor para v_num1: 20
Introduzca un valor para v_num2: 20
SUMA=40
*/


/* 10- Escribe un procedimiento que reciba dos números y visualice la suma. */
/*ARRIBA NUNCA PUEDEN IR VARIABLES CON LA LONGITUD*/

EXECUTE SUMAR_NUM(3,3);


/* 11- Escribir un procedimiento para consultar los datos de los departamentos mediante el número del departamento (dept_no).
Usar el bloque de EXCEPTION para que el programa funcione si no encuentra el departamento. */

EXECUTE VER_DEPART(10);
/*SALIDA:*/ NUMDEPART:10, NB DEP:INVESTIGACION, LOCALIDADMADRID;

EXECUTE VER_DEPART(20);
/*SALIDA:*/ NUMDEPART:20, NB DEP:INVESTIGACION, LOCALIDADMADRID;


/* 12- Crear un procedimiento que reciba un número de empleado y una cadena correspondiente a su nuevo oficio. 
El procedimiento deberá localizar el empleado, modificar el oficio y visualizar los cambios realizados. */

EXECUTE CAMBIAR_OFICIO(7934, 'NOSE');


/*13- Escribir un procedimiento que modifique el precio de costo de un artículo pasándole el nb del artículo, el nuevo precio y la categoría.
El procedimiento comprobará que la variación del precio no supere el 2%. Usar el bloque de EXCEPTION para que el programa funcione
si no encuentra el artículo.
NO PROBAR CON LOS MACARRONES. COGER LA MANTEQUILLA.
EJEMPLO: Mantequilla 2   Segunda
*/
EXECUTE MOD_PRECIO('Mantequilla', 2, 'Segunda');


/*14- Codifica un procedimiento que reciba una cadena y la visualice al revés.*/

EXECUTE PALABRA_AL_REVES('HOLA');


/*15- Crear una función que sume dos números.*/


/* 16-Crear una función que visualice una cadena al revés. */

/*COMO EJECUTAR*/
SELECT CADENAREVES('HOLA') FROM DUAL;


/*17- Escribe una función que reciba una fecha y devuelva el año,
en número, correspondiente a esa fecha.*/

/*COMO EJECUTAR*/
SELECT ANNIO_F('24-12-2015') FROM DUAL;


/*18-Escribir una función que devuelva el valor con IVA de una cantidad que se pasara como primer parámetro.
La función podrá recoger un segundo parámetro, que será el tipo de IVA siendo el valor por defecto */

/*EJECUCIÓN*/
SELECT SUMAR_IVA(500, 20) FROM DUAL;

/*19- Utilizar la función anterior para obtener el salario de los empleados con el iva de la función.*/
SELECT EMP_NO, SALARIO, SUMAR_IVA(SALARIO) FROM EMPLE;
