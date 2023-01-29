/*para que salga el texto por consola (si no, no sale nada)*/
/*para que pregunte solo 1 vez para la var introducida x teclado*/
/*en caso de crear un bloque/procedimiento/función con errores de compilación */
SET SERVEROUTPUT ON;
SET VERIFY OFF;
SHOW ERRORS;

/*1-	Escribir un bloque PL que utilice un cursor explicito para visualizar el nombre
y la localidad de todos los departamentos.*/
/* CON LOOP */
DECLARE
	VNOM VARCHAR(50);
	VLOC VARCHAR(50);
	CURSOR C1 IS SELECT DNOMBRE, LOC FROM DEPART;
BEGIN
	OPEN C1;
	LOOP
		FETCH C1 INTO VNOM, VLOC;
		EXIT WHEN C1%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(VNOM||'*'||VLOC);
	END LOOP;
	CLOSE C1;
END;
/

REM ***AL DECLARAR EL CURSOR, SELECCIONAS LAS FILAS DE UNA TABLA QUE QUIERES SELECCIONAR (Y LUEGO LAS RECORRES CON UN BUCLE)
REM ***FETCH: CARGA LAS TABLAS EN LAS VARIABLES (EN ORDEN)
REM ***EXIT WHEN C1%NOTFOUND, CUANDO ENCUENTRA "UN NULL" EN EL "ARRAY", TERMINA EL BUCLE
REM ***EL EXIT VA ANTES PARA NO DUPLICAR LA ÚLTIMA ROW DE SALIDA
REM ***AS/IS ES IGUAL AL DECLARE
REM ***&VAR ES UNA VARIABLE DE ACOPLAMIENTO (METER DATOS POR TECLADO)(MAYORMENTE SE HACE CON BLOQUES ANÓNIMOS)

/*CON WHILE*/
DECLARE
	VNOM VARCHAR(50);
	VLOC VARCHAR(50);
	CURSOR C1 IS SELECT DNOMBRE, LOC FROM DEPART;
BEGIN
	OPEN C1;
	FETCH C1 INTO VNOM, VLOC;
	WHILE C1%FOUND LOOP
		DBMS_OUTPUT.PUT_LINE(VNOM||'*'||VLOC);
		FETCH C1 INTO VNOM, VLOC;
	END LOOP;
	CLOSE C1;
END;
/





/*2-	Visualizar los apellidos de los empleados pertenecientes al departamento 20 numerándolos secuencialmente.
Utilizar   %ROWCOUNT los números secuenciales.
1.SANCHEZ
2.JIMENEZ
3.GIL
4.ALONSO
5.FERNANDEZ
*/
DECLARE
	VAPE EMPLE.APELLIDO%TYPE;
	CURSOR C1 IS SELECT APELLIDO FROM EMPLE WHERE DEPT_NO=20;
BEGIN
	OPEN C1;
	LOOP
		FETCH C1 INTO VAPE;
		EXIT WHEN C1%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(C1%ROWCOUNT||'.'||VAPE);
	END LOOP;
	CLOSE C1;
END;
/





/*3-	Visualizar los empleados de un departamento mediante un procedimiento y utilizando variables de acoplamiento.*/
/*BLOQUE*/
DECLARE
	VAPE EMPLE.APELLIDO%TYPE;
	CURSOR C1 IS SELECT APELLIDO FROM EMPLE WHERE DEPT_NO=&DEP;
BEGIN
	OPEN C1;
	LOOP
		FETCH C1 INTO VAPE;
		EXIT WHEN C1%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(VAPE);
	END LOOP;
	CLOSE C1;
END;
/

/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE VER_EMPLES(DEPNUM NUMBER)
IS
	VAPE EMPLE.APELLIDO%TYPE;
	CURSOR C1 IS SELECT APELLIDO FROM EMPLE WHERE DEPT_NO=DEPNUM;
BEGIN
	OPEN C1;
	LOOP
		FETCH C1 INTO VAPE;
		EXIT WHEN C1%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(VAPE);
	END LOOP;
	CLOSE C1;
END;
/
EXECUTE VER_EMPLES(20);





/*4-	Escribir un bloque PL que visualice el apellido, el oficio y la comisión de los empleados que supere los 500€.
Utilizando CURSOR FOR........LOOP.*/
DECLARE
	CURSOR C1 IS SELECT APELLIDO, OFICIO, COMISION FROM EMPLE WHERE COMISION>500;
BEGIN
	FOR I IN C1 LOOP
		DBMS_OUTPUT.PUT_LINE(I.APELLIDO||'*'||I.OFICIO||'*'||I.COMISION);
	END LOOP;
END;
/

REM *********EN LOS FOR LOOP LOS CURSORES SE ABREN Y CIERRAN AUTOMÁTICAMENTE
REM ***FOR LOOP ESTÁ ROTÍSIMO, PERO EN ALGUNOS MATCHUPS ES UNA MIERDA (NO VA)





/*5-	 Escribir un bloque PL que visualice el apellido y la fecha de alta de todos los empleados ordenados por fecha de alta.
Utilizando CURSOR FOR........LOOP.*/
DECLARE
	CURSOR C1 IS SELECT APELLIDO, FECHA_ALT FROM EMPLE ORDER BY FECHA_ALT DESC;
BEGIN
	FOR I IN C1 LOOP
		DBMS_OUTPUT.PUT_LINE(I.APELLIDO||'*'||I.FECHA_ALT);
	END LOOP;
END;
/





/*6-	Desarrollar un procedimiento que visualice el apellido y la fecha de alta de todos los empleados ordenados por apellido.*/
CREATE OR REPLACE PROCEDURE VER_EMPLES
IS
	CURSOR C1 IS SELECT APELLIDO, FECHA_ALT FROM EMPLE ORDER BY APELLIDO;
BEGIN
	FOR I IN C1 LOOP
		DBMS_OUTPUT.PUT_LINE(I.APELLIDO||'*'||I.FECHA_ALT);
	END LOOP;
END;
/
EXECUTE VER_EMPLES;





/*7-	Codificar un procedimiento que muestre el nombre de cada departamento y el número de empleados que tiene.*/
CREATE OR REPLACE PROCEDURE VER_DEP_EMPLES
IS
	CURSOR C1 IS SELECT DEPT_NO, COUNT(EMP_NO) AS NUM_EMPLES FROM EMPLE GROUP BY DEPT_NO;
BEGIN
	FOR I IN C1 LOOP
		DBMS_OUTPUT.PUT_LINE(I.DEPT_NO||'*'||I.NUM_EMPLES);
	END LOOP;
END;
/
EXECUTE VER_DEP_EMPLES;





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
CREATE OR REPLACE PROCEDURE VER_5SALARIO
IS
	VAPE VARCHAR(20);
	VSAL NUMBER;
	CURSOR C1 IS SELECT APELLIDO, SALARIO FROM EMPLE ORDER BY SALARIO DESC;
BEGIN
	OPEN C1;
	LOOP
		FETCH C1 INTO VAPE, VSAL;
		DBMS_OUTPUT.PUT_LINE(VAPE||'*'||VSAL);
		EXIT WHEN C1%ROWCOUNT=5;
	END LOOP;
	CLOSE C1;
END;
/
EXECUTE VER_5SALARIO;


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
CREATE OR REPLACE PROCEDURE VER_MENOROFICIO
IS
	AUX VARCHAR(20);
	CONT NUMBER := 0;
	CURSOR C1 IS SELECT OFICIO, APELLIDO, SALARIO FROM EMPLE ORDER BY OFICIO, SALARIO ASC;
BEGIN
	FOR I IN C1 LOOP
		IF CONT < 2 THEN
			AUX := I.OFICIO;
			CONT := CONT + 1;
			DBMS_OUTPUT.PUT_LINE(I.OFICIO||'*'||I.APELLIDO||'*'||I.SALARIO);
		ELSIF AUX != I.OFICIO OR CONT>=2 THEN
			CONT := 0;
		END IF;
	END LOOP;
END;
/
EXECUTE VER_MENOROFICIO;