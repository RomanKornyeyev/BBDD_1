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

