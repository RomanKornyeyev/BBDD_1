/* === EJERCICIOS PROPUESTOS === */
SET SERVEROUTPUT ON; /*para que salga el texto por consola (si no, no sale nada)*/
SET VERIFY OFF; /*para que pregunte solo 1 vez para la var introducida x teclado*/


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
/*no va, arreglar*/
DECLARE
	V_EMP_NO NUMBER;
	V_EMP_COM NUMBER;
	V_EMP_OFIC VARCHAR2(10);
	V_AUMENTO NUMBER(5) DEFAULT 0;
BEGIN
	V_EMP_NO:=&VT_EMPNO;
	SELECT OFICIO INTO V_OFICIO FROM EMPLE WHERE EMP_NO=V_EMP_NO;
	IF V_OFICIO='PRESIDENTE' THEN
		V_AUMENTO:=30;
	END IF;
	SELECT COUNT(*) INTO V_EMP_COM FROM EMPLE WHERE DIR=V_EMPLE_NO;
	CASE V_EMPLE_NO
		WHEN 0 THEN V_AUMENTO:=V_AUMENTO+50;
		WHEN 1 THEN V_AUMENTO:=V_AUMENTO+80;
		WHEN 2 THEN V_AUMENTO:=V_AUMENTO+100;
	ELSE
		V_AUMENTO:=V_AUMENTO+110;
	UPDATE EMPLE SET SALARIO = SALARIO + V_AUMENTO WHERE EMP_NO =V_EMPLE_NO;
	DBMS_OUTPUT.PUT_LINE(V_AUMENTO);
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