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
	v_num NUMBER;
BEGIN
	SELECT COUNT(*) INTO V_NUM FROM EMPLE;
	DBMS_OUTPUT.PUT_LINE('NUM_FILAS= '||V_NUM);
END;
/

/*3- Construye un bloque PL/SQL para visualizar el apellido y el oficio del empleado 7900.*/
DECLARE
	V_APELLIDO VARCHAR2(10);
	V_OFICIO VARCHAR2(10);
BEGIN
	SELECT APELLIDO, OFICIO INTO V_APELLIDO, V_OFICIO FROM EMPLE
	WHERE EMP_NO=7900;
	DBMS_OUTPUT.PUT_LINE(V_APELLIDO || ' ES: ' || V_OFICIO);
END;
/

/*4- Construye un bloque PL/SQL que muestre el precio de costo del articulo Canutillos
de categoría Primera.*/
DECLARE
	V_COSTO NUMBER;
BEGIN
	SELECT PRECIO_COSTO INTO V_COSTO FROM ARTICULOS
	WHERE ARTICULO='Canutillos' AND CATEGORIA='Primera';
	DBMS_OUTPUT.PUT_LINE('PRECIO = '||V_COSTO);
END;
/

/*5- Realizar un programa que solicite la introducción de un número de empleado(variables de acoplamiento
&var que no se declara) y visualizara el nombre correspondiente al número introducido. Para declarar el nombre
del empleado utilizaremos la variable %TYPE.*/
DECLARE
	V_APELLIDO EMPLE.APELLIDO%TYPE;
BEGIN
	SELECT APELLIDO INTO V_APELLIDO FROM EMPLE
	WHERE EMP_NO=&VN_CLI;
	DBMS_OUTPUT.PUT_LINE('NOMBRE = '|| V_APELLIDO);
END;
/
/*ejemplo: 7369 = SANCHEZ; 7900 = JIMENO*/

/*6- Escribir un bloque PL/SQL que muestre la fecha actual y la hora con minutos y segundos.*/
DECLARE
	V_FECHA VARCHAR(50);
BEGIN
	SELECT TO_CHAR(SYSDATE, 'day dd month yyyy hh24:mi:ss') INTO V_FECHA
	FROM DUAL;
	DBMS_OUTPUT.PUT_LINE(V_FECHA);
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
DECLARE
	V_EMP_NO NUMBER;
	NUM_EMPLES NUMBER;
	V_OFICIO EMPLE.OFICIO%TYPE;
	V_AUMENTO NUMBER(5) DEFAULT 0;
BEGIN
	V_EMP_NO:=&VT_EMPNO;
	SELECT OFICIO INTO V_OFICIO FROM EMPLE WHERE EMP_NO=V_EMP_NO;
	IF V_OFICIO='PRESIDENTE' THEN
		V_AUMENTO:=30;
	END IF;
	SELECT COUNT(*) INTO NUM_EMPLES FROM EMPLE WHERE DIR=V_EMP_NO;
	CASE NUM_EMPLES
		WHEN 0 THEN V_AUMENTO:=V_AUMENTO+50;
		WHEN 1 THEN V_AUMENTO:=V_AUMENTO+80;
		WHEN 2 THEN V_AUMENTO:=V_AUMENTO+100;
	ELSE
		V_AUMENTO:=V_AUMENTO+110;
	END CASE;
	UPDATE EMPLE SET SALARIO = SALARIO + V_AUMENTO WHERE EMP_NO =V_EMP_NO;
	DBMS_OUTPUT.PUT_LINE('El aumento es de: '||V_AUMENTO);
END;
/

/*8- Construir un bloque PL/SQL para que escriba la cadena HOLA al revés.
Utilizando FOR, WHILE y LOOP.*/
/*FOR*/
DECLARE
	R_CADENA VARCHAR2(10);
BEGIN
	FOR I IN REVERSE 1..LENGTH('HOLA') LOOP
		R_CADENA:=R_CADENA||SUBSTR('HOLA', I, 1);
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(R_CADENA);
END;
/

/*WHILE*/
DECLARE
	R_CADENA VARCHAR2(10);
	I NUMBER;
BEGIN
	I := LENGTH('HOLA');
	WHILE I >= 1 LOOP
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
		I := I-1;
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
	V_NUM1 NUMBER;
	V_NUM2 NUMBER;
	SUMA NUMBER;
BEGIN
	V_NUM1:=&V_1;
	V_NUM2:=&V_2;
	SUMA := V_NUM1 + V_NUM2;
	DBMS_OUTPUT.PUT_LINE('SUMA='||SUMA);
END;
/


/* 10- Escribe un procedimiento que reciba dos números y visualice la suma. */
/*ARRIBA NUNCA PUEDEN IR VARIABLES CON LA LONGITUD*/
CREATE OR REPLACE PROCEDURE SUMAR_NUM(NUM1 NUMBER, NUM2 NUMBER)
IS
	SUMA NUMBER;
BEGIN
	SUMA := NUM1 + NUM2;
	DBMS_OUTPUT.PUT_LINE ('SUMA='||SUMA);
END;
/

EXECUTE SUMAR_NUM(3,3);


/* 11- Escribir un procedimiento para consultar los datos de los departamentos mediante el número del departamento (dept_no).
Usar el bloque de EXCEPTION para que el programa funcione si no encuentra el departamento. */
CREATE OR REPLACE PROCEDURE VER_DEPART(NUMDEPART NUMBER)
IS
	V_DNOMBRE VARCHAR(14);
	V_LOCALIDAD VARCHAR(14);
BEGIN
	SELECT DNOMBRE, LOC INTO V_DNOMBRE, V_LOCALIDAD
	FROM DEPART WHERE DEPT_NO=NUMDEPART;
	DBMS_OUTPUT.PUT_LINE ('NUMDEPART:'||NUMDEPART||', NB DEP:'||V_DNOMBRE||', LOCALIDAD'||V_LOCALIDAD);
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE ('EL DEPARTAMENTO NÚMERO '||NUMDEPART||' NO EXISTE');
END;
/

EXECUTE VER_DEPART(10);
/*SALIDA:*/ NUMDEPART:10, NB DEP:INVESTIGACION, LOCALIDADMADRID;

EXECUTE VER_DEPART(20);
/*SALIDA:*/ NUMDEPART:20, NB DEP:INVESTIGACION, LOCALIDADMADRID;


/* 12- Crear un procedimiento que reciba un número de empleado y una cadena correspondiente a su nuevo oficio. 
El procedimiento deberá localizar el empleado, modificar el oficio y visualizar los cambios realizados. */
CREATE OR REPLACE PROCEDURE CAMBIAR_OFICIO(N_EMP NUMBER, OFICIO_NUEVO VARCHAR2)
IS
	OFICIO_ANTERIOR EMPLE.OFICIO%TYPE;
BEGIN
	SELECT OFICIO INTO OFICIO_ANTERIOR FROM EMPLE WHERE EMP_NO=N_EMP;
	UPDATE EMPLE SET OFICIO=OFICIO_NUEVO WHERE EMP_NO=N_EMP;
	DBMS_OUTPUT.PUT_LINE('EMPLE_NUM:'||N_EMP||'. OFICIO ANTERIOR:'||OFICIO_ANTERIOR||', OFICIO NUEVO:'||OFICIO_NUEVO);
END;
/

EXECUTE CAMBIAR_OFICIO(7934, 'NOSE');


/*13- Escribir un procedimiento que modifique el precio de costo de un artículo pasándole el nb del artículo, el nuevo precio y la categoría.
El procedimiento comprobará que la variación del precio no supere el 2%. Usar el bloque de EXCEPTION para que el programa funcione
si no encuentra el artículo.
NO PROBAR CON LOS MACARRONES. COGER LA MANTEQUILLA.
EJEMPLO: Mantequilla 2   Segunda
*/
CREATE OR REPLACE PROCEDURE MOD_PRECIO(NOM VARCHAR2, PREC NUMBER, CAT VARCHAR2)
IS
	V_NOMBRE ARTICULOS.ARTICULO%TYPE;
	V_PRECIO ARTICULOS.PRECIO_COSTO%TYPE;
BEGIN
	SELECT ARTICULO, PRECIO_COSTO INTO V_NOMBRE, V_PRECIO FROM ARTICULOS WHERE ARTICULO=NOM AND CATEGORIA=CAT;
	IF (PREC <= (V_PRECIO*1.02)) THEN
		UPDATE ARTICULOS SET PRECIO_COSTO=PREC WHERE ARTICULO=NOM AND CATEGORIA=CAT;
		DBMS_OUTPUT.PUT_LINE('Modificación exitosa');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Precio demasiado elevado, no se ha modificado');
	END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('ERROR: Producto no encontrado.');
END;
/
EXECUTE MOD_PRECIO('Mantequilla', 2, 'Segunda');


/*14- Codifica un procedimiento que reciba una cadena y la visualice al revés.*/
CREATE OR REPLACE PROCEDURE PALABRA_AL_REVES(CADENA VARCHAR)
IS
	R_CADENA VARCHAR2(50);
BEGIN
	FOR I IN REVERSE 1..LENGTH(CADENA) LOOP
		R_CADENA:=R_CADENA||SUBSTR(CADENA,I,1);
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('PALABRA AL REVÉS: '||R_CADENA);
END;
/

EXECUTE PALABRA_AL_REVES('HOLA');


/*15- Crear una función que sume dos números.*/
CREATE OR REPLACE FUNCTION SUMAR_FUN(NUM1 NUMBER, NUM2 NUMBER) RETURN NUMBER
AS
	SUMA NUMBER;
BEGIN
	SUMA:=NUM1+NUM2;
	RETURN(SUMA);
END;
/

BEGIN
	DBMS_OUTPUT.PUT_LINE('Suma: '||SUMAR_FUN(3,3));
END;
/


/* 16-Crear una función que visualice una cadena al revés. */
CREATE OR REPLACE FUNCTION CADENAREVES(CADENA VARCHAR2) RETURN VARCHAR2
IS 
	R_CADENA VARCHAR2(50);
BEGIN
	FOR I IN REVERSE 1..LENGTH(CADENA) LOOP
		R_CADENA:=R_CADENA || SUBSTR(CADENA,I,1);
	END LOOP;
	RETURN(R_CADENA);
END;
/

/*COMO EJECUTAR*/
SELECT CADENAREVES('HOLA') FROM DUAL;


/*17- Escribe una función que reciba una fecha y devuelva el año,
en número, correspondiente a esa fecha.*/
SET VERIFY OFF;
SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION ANNIO_F(FECHA DATE) RETURN NUMBER
IS 
	ANNIO NUMBER;
BEGIN
	ANNIO := TO_NUMBER(TO_CHAR(FECHA, 'YYYY'));
	RETURN(ANNIO);
END;
/

/*COMO EJECUTAR*/
SELECT ANNIO_F('24-12-2015') FROM DUAL;


/*18-Escribir una función que devuelva el valor con IVA de una cantidad que se pasara como primer parámetro.
La función podrá recoger un segundo parámetro, que será el tipo de IVA siendo el valor por defecto */
CREATE OR REPLACE FUNCTION SUMAR_IVA(CANTIDAD NUMBER, IVA NUMBER DEFAULT 16) RETURN NUMBER
IS
	VALOR_SUMADO NUMBER;
BEGIN 
	VALOR_SUMADO := CANTIDAD+CANTIDAD*(IVA/100);
	RETURN(VALOR_SUMADO);
END;
/

/*EJECUCIÓN*/
SELECT SUMAR_IVA(500, 20) FROM DUAL;

/*19- Utilizar la función anterior para obtener el salario de los empleados con el iva de la función.*/
SELECT EMP_NO, SALARIO, SUMAR_IVA(SALARIO) FROM EMPLE;
