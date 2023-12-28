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
DECLARE
	V_NUM NUMBER;
BEGIN
	SELECT COUNT(*) INTO V_NUM FROM EMPLE;
	DBMS_OUTPUT.PUT_LINE('NUM LÍNEAS:'||V_NUM);
END;
/

/*3- Construye un bloque PL/SQL para visualizar el apellido y el oficio del empleado 7900.*/
DECLARE
	V_APE EMPLE.APELLIDO%TYPE;
	V_OFICIO EMPLE.OFICIO%TYPE;
BEGIN
	SELECT APELLIDO, OFICIO INTO V_APE, V_OFICIO FROM EMPLE WHERE EMP_NO=7900;
	DBMS_OUTPUT.PUT_LINE('APELLIDO Y OFICIO EMPLE 7900: '||V_APE||', '||V_OFICIO);
END;
/


/*4- Construye un bloque PL/SQL que muestre el precio de costo del articulo Canutillos
de categoría Primera.*/
DECLARE
	V_PRECIO ARTICULOS.PRECIO_COSTO%TYPE;
BEGIN
	SELECT PRECIO_COSTO INTO V_PRECIO FROM ARTICULOS WHERE ARTICULO='Canutillos' AND CATEGORIA='Primera';
	DBMS_OUTPUT.PUT_LINE('PRECIO CANUTILLOS PRIMERA:'||V_PRECIO);
END;
/


/*5- Realizar un programa que solicite la introducción de un número de empleado(variables de acoplamiento
&var que no se declara) y visualizara el nombre correspondiente al número introducido. Para declarar el nombre
del empleado utilizaremos la variable %TYPE.*/
DECLARE
	V_NOMBRE EMPLE.APELLIDO%TYPE;
BEGIN
	SELECT APELLIDO INTO V_NOMBRE FROM EMPLE WHERE EMP_NO=&INTRODUCIDO;
	DBMS_OUTPUT.PUT_LINE('NOMBRE:'||V_NOMBRE);
END;
/
/*ejemplo: 7369 = SANCHEZ; 7900 = JIMENO*/

/*6- Escribir un bloque PL/SQL que muestre la fecha actual y la hora con minutos y segundos.*/
DECLARE
	FECHA DATE;
BEGIN
	SELECT SYSDATE INTO FECHA FROM DUAL;
	DBMS_OUTPUT.PUT_LINE(TO_CHAR(FECHA, 'dd/mm/yyyy hh:mm:ss'));
END;
/


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
DECLARE
	R_CADENA VARCHAR(10);
BEGIN
	FOR I IN REVERSE 1..LENGTH('HOLA') LOOP
		R_CADENA:=R_CADENA||SUBSTR('HOLA', I, 1);
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(R_CADENA);
END;
/

/*WHILE*/
DECLARE
	R_CADENA VARCHAR(10);
	I NUMBER;
BEGIN
	I := LENGTH('HOLA');
	WHILE I > 0 LOOP
		R_CADENA:=R_CADENA||SUBSTR('HOLA', I, 1);
		I:=I-1;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(R_CADENA);
END;
/

/*LOOP (DO WHILE)*/
DECLARE
	R_CADENA VARCHAR(10);
	I NUMBER;
BEGIN
	I:=LENGTH('HOLA');
	LOOP
		R_CADENA:=R_CADENA||SUBSTR('HOLA', I, 1);
		EXIT WHEN I = 1;
		I:=I-1;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(R_CADENA);
END;
/

/*9- Escribir un bloque PL/SQL que introduzca dos números y los sume.
Introduzca un valor para v_num1: 20
Introduzca un valor para v_num2: 20
SUMA=40
*/
DECLARE
	SUMA NUMBER;
BEGIN
	SUMA := &NUM1 + &NUM2;
	DBMS_OUTPUT.PUT_LINE(SUMA);
END;
/


/* 10- Escribe un procedimiento que reciba dos números y visualice la suma. */
/*ARRIBA NUNCA PUEDEN IR VARIABLES CON LA LONGITUD*/
CREATE OR REPLACE PROCEDURE SUMAR_NUM(NUM1 NUMBER, NUM2 NUMBER)
IS
	SUMA NUMBER;
BEGIN
	SUMA := NUM1 + NUM2;
	DBMS_OUTPUT.PUT_LINE(SUMA);
END;
/

EXECUTE SUMAR_NUM(3,3);


/* 11- Escribir un procedimiento para consultar los datos de los departamentos mediante el número del departamento (dept_no).
Usar el bloque de EXCEPTION para que el programa funcione si no encuentra el departamento. */
CREATE OR REPLACE PROCEDURE VER_DEPART(NUM_DEP NUMBER)
IS
	V_NOM VARCHAR(20);
	V_LOC VARCHAR(20);
BEGIN
	SELECT DNOMBRE, LOC INTO V_NOM, V_LOC FROM DEPART WHERE DEPT_NO=NUM_DEP;
	DBMS_OUTPUT.PUT_LINE ('NUMDEPART:'||NUM_DEP||', NB DEP:'||V_NOM||', LOCALIDAD'||V_LOC);
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('ERROR');
END;
/

EXECUTE VER_DEPART(10);
/*SALIDA:*/ NUMDEPART:10, NB DEP:INVESTIGACION, LOCALIDADMADRID;

EXECUTE VER_DEPART(20);
/*SALIDA:*/ NUMDEPART:20, NB DEP:INVESTIGACION, LOCALIDADMADRID;


/* 12- Crear un procedimiento que reciba un número de empleado y una cadena correspondiente a su nuevo oficio. 
El procedimiento deberá localizar el empleado, modificar el oficio y visualizar los cambios realizados. */
CREATE OR REPLACE PROCEDURE CAMBIAR_OFICIO(NUM_EMP NUMBER, OFICIO_NUEVO VARCHAR)
IS
	OFICIO_ANTERIOR EMPLE.OFICIO%TYPE;
BEGIN
	SELECT OFICIO INTO OFICIO_ANTERIOR FROM EMPLE WHERE NUM_EMP=EMP_NO;
	UPDATE EMPLE SET OFICIO=OFICIO_NUEVO WHERE NUM_EMP=EMP_NO;
	DBMS_OUTPUT.PUT_LINE('NUM: '||NUM_EMP||', OFICIO ANTERIOR: '||OFICIO_ANTERIOR||', OFICIO NUEVO: '||OFICIO_NUEVO);
END;
/
EXECUTE CAMBIAR_OFICIO(7934, 'NOSE');


/*13- Escribir un procedimiento que modifique el precio de costo de un artículo pasándole el nb del artículo, el nuevo precio y la categoría.
El procedimiento comprobará que la variación del precio no supere el 2%. Usar el bloque de EXCEPTION para que el programa funcione
si no encuentra el artículo.
NO PROBAR CON LOS MACARRONES. COGER LA MANTEQUILLA.
EJEMPLO: Mantequilla 2   Segunda
*/
CREATE OR REPLACE PROCEDURE MOD_PRECIO(NOM VARCHAR, NUEVO_PREC NUMBER, CATEGOR VARCHAR)
IS
	PRECIO_VIEJO ARTICULOS.PRECIO_COSTO%TYPE;
BEGIN
	SELECT PRECIO_COSTO INTO PRECIO_VIEJO FROM ARTICULOS WHERE ARTICULO=NOM AND CATEGORIA=CATEGOR;
	IF (NUEVO_PREC <= PRECIO_VIEJO*1.02) AND (NUEVO_PREC >= PRECIO_VIEJO*0.98) THEN
		UPDATE ARTICULOS SET PRECIO_COSTO=NUEVO_PREC WHERE ARTICULO=NOM AND CATEGORIA=CATEGOR;
		DBMS_OUTPUT.PUT_LINE('PRECIO ANTIGUO: '||PRECIO_VIEJO||', PRECIO NUEVO: '||NUEVO_PREC);
	ELSE
		DBMS_OUTPUT.PUT_LINE('EL PRECIO NO HA SIDO ACTUALIZADO, ES SUPERIOR AL 20%');
	END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('ERROR');
END;
/
EXECUTE MOD_PRECIO('Mantequilla', 2, 'Segunda');


/*14- Codifica un procedimiento que reciba una cadena y la visualice al revés.*/
CREATE OR REPLACE PROCEDURE PALABRA_AL_REVES(CADENA VARCHAR)
IS
	R_CADENA VARCHAR(20);
BEGIN
	FOR I IN REVERSE 1..LENGTH(CADENA) LOOP
		R_CADENA := R_CADENA||SUBSTR(CADENA, I, 1);
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(R_CADENA);
END;
/
EXECUTE PALABRA_AL_REVES('HOLA');


/*15- Crear una función que sume dos números.*/
CREATE OR REPLACE FUNCTION SUMA_NUMS(NUM1 NUMBER, NUM2 NUMBER) RETURN NUMBER
IS
	SUMA NUMBER;
BEGIN
	SUMA := NUM1+NUM2;
	RETURN SUMA;
END;
/
BEGIN
	DBMS_OUTPUT.PUT_LINE('SUMA: '||SUMA_NUMS(3, 4));
END;
/

/* 16-Crear una función que visualice una cadena al revés. */
CREATE OR REPLACE FUNCTION CADENAREVES(CADENA VARCHAR) RETURN VARCHAR
IS
	R_CADENA VARCHAR(20);
BEGIN
	FOR I IN REVERSE 1..LENGTH(CADENA) LOOP
		R_CADENA := R_CADENA||SUBSTR(CADENA, I, 1);
	END LOOP;
	RETURN R_CADENA;
END;
/
/*COMO EJECUTAR*/
SELECT CADENAREVES('HOLA') FROM DUAL;
BEGIN
	DBMS_OUTPUT.PUT_LINE('CADENA HOLA AL REVÉS: '||CADENAREVES('HOLA'));
END;
/


/*17- Escribe una función que reciba una fecha y devuelva el año,
en número, correspondiente a esa fecha.*/
CREATE OR REPLACE FUNCTION ANNIO_F(FECHA DATE) RETURN NUMBER
IS
	NUM NUMBER;
BEGIN
	NUM := TO_NUMBER(TO_CHAR(FECHA, 'yyyy'));
	RETURN NUM;
END;
/
/*COMO EJECUTAR*/
SELECT ANNIO_F('24-12-2015') FROM DUAL;


/*18-Escribir una función que devuelva el valor con IVA de una cantidad que se pasara como primer parámetro.
La función podrá recoger un segundo parámetro, que será el tipo de IVA siendo el valor por defecto */
CREATE OR REPLACE FUNCTION SUMAR_IVA(PRECIO NUMBER, IVA NUMBER DEFAULT 21) RETURN NUMBER
IS
	SUMA NUMBER;
BEGIN
	SUMA := PRECIO + PRECIO*(IVA/100);
	RETURN SUMA;
END;
/
/*EJECUCIÓN*/
SELECT SUMAR_IVA(500, 20) FROM DUAL;

/*19- Utilizar la función anterior para obtener el salario de los empleados con el iva de la función.*/
SELECT EMP_NO, SALARIO, SUMAR_IVA(SALARIO) FROM EMPLE;