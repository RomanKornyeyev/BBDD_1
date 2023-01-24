/*1.	Obtener la longitud de la circunferencia introduciendo el radio por teclado cuyo valor es en cm
y el resultado lo queremos en metros.*/
/*BLOQUE*/
BEGIN
	DBMS_OUTPUT.PUT_LINE(&RADIO *2*3.14/1000);
END;
/

/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE LONGITUD_CIRCUNFERENCIA(RADIO NUMBER)
IS 
	LONGITUD NUMBER;
	PI NUMBER DEFAULT 3.14;
BEGIN 
	LONGITUD := 2*PI*RADIO/1000;
	DBMS_OUTPUT.PUT_LINE('Longitud= '||LONGITUD);
END;
/

EXECUTE LONGITUD_CIRCUNFERENCIA(20);


/*2.	Obtener el salario del empleado 7839 de la tabla EMPLE.*/
/*BLOQUE*/
DECLARE
	XEMPLE NUMBER(4):=&CODIGO_EMPLEADO;
	XSALARIO NUMBER(4);
BEGIN
	SELECT SALARIO INTO XSALARIO FROM EMPLE WHERE EMP_NO = XEMPLE;
	DBMS_OUTPUT.PUT_LINE('EL SALARIO DEL EMPLEADO Nº'||XEMPLE||' ES '||XSALARIO||'EUR.');
END;
/

/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE OBTENERSALARIO(IDEMPLEADO NUMBER)
IS
	XEMPLE NUMBER(4):=IDEMPLEADO;
	XSALARIO NUMBER(4);
BEGIN
	SELECT SALARIO INTO XSALARIO FROM EMPLE WHERE EMP_NO = XEMPLE;
	DBMS_OUTPUT.PUT_LINE('EL SALARIO DEL EMPLEADO Nº'||XEMPLE||' ES '||XSALARIO||'EUR.');
END;
/

EXECUTE OBTENERSALARIO(7839);


/*3.	Mostrar el nombre de la asignatura con código 7 de la tabla ASIGNATURAS.*/
/*BLOQUE*/
DECLARE
	XCOD_ASIG NUMBER(1):=7;
	XNOMBRE ASIGNATURAS.NOMBRE%TYPE;
BEGIN
	SELECT NOMBRE INTO XNOMBRE FROM ASIGNATURAS WHERE COD = XCOD_ASIG;
	DBMS_OUTPUT.PUT_LINE('EL NOMBRE DE LA ASIGNATURA CON CODIGO '||XCOD_ASIG||' ES '||XNOMBRE);
END;
/

/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE OBTENERASIGNATURA
IS
	XCOD_ASIG NUMBER(1):=7;
	XNOMBRE ASIGNATURAS.NOMBRE%TYPE;
BEGIN
	SELECT NOMBRE INTO XNOMBRE FROM ASIGNATURAS WHERE COD = XCOD_ASIG;
	DBMS_OUTPUT.PUT_LINE('EL NOMBRE DE LA ASIGNATURA CON CODIGO '||XCOD_ASIG||' ES '||XNOMBRE);
END;
/


/*4.	Visualizar el nombre de la tabla PROFESORES, introduciendo el DNI por teclado
a través de una variable de sustitución.*/
/*BLOQUE*/
DECLARE 
	XDNI PROFESORES.DNI%TYPE := &DNI_BUSQUEDA;
	XNOMBRE PROFESORES.APELLIDOS%TYPE;
BEGIN
	SELECT APELLIDOS INTO XNOMBRE FROM PROFESORES WHERE DNI = XDNI;
	DBMS_OUTPUT.PUT_LINE('EL DNI INTRODUCIDO CORRESPONDE A '||XNOMBRE);
END;

/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE BUSCARDNI(DNI NUMBER)
AS
	XDNI PROFESORES.DNI%TYPE := DNI;
	XNOMBRE PROFESORES.APELLIDOS%TYPE;
BEGIN
	SELECT APELLIDOS INTO XNOMBRE FROM PROFESORES WHERE DNI = XDNI;
	DBMS_OUTPUT.PUT_LINE('EL DNI INTRODUCIDO CORRESPONDE A '||XNOMBRE);
END;


/*5.	A través de variables visualice el departamento VENTAS de la tabla DEPART con
el siguiente mensaje ‘El departamento nº X esta en XXX’.*/
/*BLOQUE*/
DECLARE
	XDEPTNMB DEPART.DNOMBRE%TYPE:='VENTAS';
	XDEPTCOD DEPART.DEPT_NO%TYPE;
	XLOCALIDAD DEPART.LOC%TYPE;
BEGIN
	SELECT DEPT_NO,LOC INTO XDEPTCOD,XLOCALIDAD FROM DEPART WHERE DNOMBRE = XDEPTNMB;
	DBMS_OUTPUT.PUT_LINE('El departamento nº'||XDEPTCOD||' esta en '||XLOCALIDAD);
END;
/

/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE VENTAS
IS
	XDEPTNMB DEPART.DNOMBRE%TYPE:='VENTAS';
	XDEPTCOD DEPART.DEPT_NO%TYPE;
	XLOCALIDAD DEPART.LOC%TYPE;
BEGIN
	SELECT DEPT_NO,LOC INTO XDEPTCOD,XLOCALIDAD FROM DEPART WHERE DNOMBRE = XDEPTNMB;
	DBMS_OUTPUT.PUT_LINE('El departamento nº'||XDEPTCOD||' esta en '||XLOCALIDAD);
END;
/

EXECUTE VISUALIZAR_VENTAS('VENTAS');


/*6.	Insertar en la tabla EMPLE un empleado con código 9999 asignado directamente
en la variable, apellido ‘PEREZ’, oficio ‘ANALISTA’ y código del departamento al que pertenece 10.*/
/*BLOQUE*/
DECLARE
	XCOD NUMBER(4):=9999;
	XAPELL EMPLE.APELLIDO%TYPE:='PEREZ';
	XOFICIO EMPLE.OFICIO%TYPE:='ANALISTA';
	XCODEPT EMPLE.DEPT_NO%TYPE:=10;
BEGIN
	INSERT INTO EMPLE VALUES(XCOD,XAPELL,XOFICIO,NULL,NULL,NULL,NULL,XCODEPT);
END;
/

/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE INSERCION
IS
	XCOD NUMBER(4):=9999;
	XAPELL EMPLE.APELLIDO%TYPE:='PEREZ';
	XOFICIO EMPLE.OFICIO%TYPE:='ANALISTA';
	XCODEPT EMPLE.DEPT_NO%TYPE:=10;
BEGIN
	INSERT INTO EMPLE VALUES(XCOD,XAPELL,XOFICIO,NULL,NULL,NULL,NULL,XCODEPT);
END;
/


/*7.	Incrementar el salario en la tabla EMPLE en 200€ a todos los trabajadores que sean ‘ANALISTAS’, mediante un bloque anónimo PL,
asignando dicho valor a una variable declarada%TYPE.*/
/* BLOQUE */
DECLARE
    V_SALARIO EMPLE.SALARIO%TYPE;
BEGIN
    FOR C IN (SELECT SALARIO INTO V_SALARIO FROM EMPLE WHERE OFICIO IN 'ANALISTA') LOOP
    V_SALARIO := (C.SALARIO+200);
    UPDATE EMPLE SET SALARIO=V_SALARIO WHERE OFICIO='ANALISTA';
    END LOOP;
END;
/

/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE SUBIR_200 (V_OFICIO VARCHAR2)
AS
    V_SALARIO EMPLE.SALARIO%TYPE;
BEGIN
FOR C IN (SELECT SALARIO INTO V_SALARIO FROM EMPLE WHERE OFICIO=V_OFICIO) LOOP
    V_SALARIO := (C.SALARIO+200);
    UPDATE EMPLE SET SALARIO=V_SALARIO WHERE OFICIO=V_OFICIO;
    END LOOP;
END;
/


/*8.	Borrar un registro de la tabla EMPLE, existiendo en el bloque una variable PL y otra de sustitución.*/
/*BLOQUE*/
DECLARE
    V_EMPNO NUMBER;
    V_APELLIDO VARCHAR2(10) :='PEREZ';
BEGIN
    DELETE FROM EMPLE WHERE EMP_NO=&V_EMPNO AND APELLIDO=V_APELLIDO;
END;
/

/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE ELIMINAR_EMPLE (V_EMPNO NUMBER, V_APELLIDO VARCHAR2) IS
BEGIN
    	DELETE FROM EMPLE WHERE EMP_NO=V_EMPNO AND APELLIDO=V_APELLIDO;
	DBMS_OUTPUT.PUT_LINE('INFORMACION DE ' || V_EMPNO || ' ELIMINADA CON EXITO');
END;
/


/*9.	Suprimir de la tabla ASIGNATURAS aquellos que tengan un código mayor a cinco utilizando los atributos del
cursor SQL%ROWCOUNT. Que muestre cuantas filas ha borrado. */
/*BLOQUE*/
DECLARE
    V_CODIGO NUMBER :=5;
BEGIN
    DELETE FROM ASIGNATURAS WHERE COD>=V_CODIGO;
    DBMS_OUTPUT.PUT_LINE('NUMERO DE ASIGNATURAS BORRADAS: ' || TO_CHAR(SQL%ROWCOUNT));
END;
/

/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE ELIMINAR_ASIGNATURAS (V_CODIGO NUMBER)
AS
    V_NOMBRE ASIGNATURAS.NOMBRE%TYPE;
BEGIN
    FOR C IN (SELECT NOMBRE INTO V_NOMBRE FROM ASIGNATURAS WHERE COD>=V_CODIGO) LOOP
    	V_NOMBRE:=C.NOMBRE;
	DBMS_OUTPUT.PUT_LINE('LA ASIGNATURA ' || V_NOMBRE || ' HA SIDO BORRADA');
    END LOOP;
    
    DELETE FROM ASIGNATURAS WHERE COD>=V_CODIGO;
    DBMS_OUTPUT.PUT_LINE('NUMERO DE ASIGNATURAS BORRADAS: ' || TO_CHAR(SQL%ROWCOUNT));
END;
/


/*10.	Obtener un bloque PL que introduciendo el código de un trabajador de la tabla EMPLE,
visualizar el código y su salario para posteriormente actualizarlo en función de su sueldo.
Si su sueldo es mayor de 1200 € su incremento será del 20% y su es menor del 25%. Visualizar
su sueldo actualizado.*/
/*BLOQUE*/
DECLARE
    V_SALARIO NUMBER;
    V_CODIGO NUMBER;
BEGIN
    SELECT SALARIO INTO V_SALARIO FROM EMPLE WHERE EMP_NO=&V_CODIGO;
    DBMS_OUTPUT.PUT_LINE('EMPLEADO: ' || V_CODIGO || ' SALARIO: ' || V_SALARIO);
    
    IF (V_SALARIO>=1200)
    THEN 
        UPDATE EMPLE SET SALARIO=(V_SALARIO*1.20) WHERE EMP_NO=V_CODIGO;
        
    ELSE
        UPDATE EMPLE SET SALARIO=(V_SALARIO*1.25) WHERE EMP_NO=V_CODIGO;
        
    END IF;
    DBMS_OUTPUT.PUT_LINE('EMPLEADO: ' || V_CODIGO || ' SALARIO ACTUALIZADO: ' || V_SALARIO);
END;
/

/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE SUBIR_SUELDO_EMPLE (V_CODIGO NUMBER)
AS
    V_SALARIO NUMBER;
BEGIN
    SELECT SALARIO INTO V_SALARIO FROM EMPLE WHERE EMP_NO=V_CODIGO;
    DBMS_OUTPUT.PUT_LINE('EMPLEADO: ' || V_CODIGO || ' SALARIO: ' || V_SALARIO);
    
    IF (V_SALARIO>=1200)
    THEN 
        V_SALARIO := (V_SALARIO * 1.20);
        UPDATE EMPLE SET SALARIO=V_SALARIO WHERE EMP_NO=V_CODIGO;
        
    ELSE
	V_SALARIO := (V_SALARIO * 1.25);
        UPDATE EMPLE SET SALARIO=V_SALARIO WHERE EMP_NO=V_CODIGO;
        
    END IF;
    DBMS_OUTPUT.PUT_LINE('EMPLEADO: ' || V_CODIGO || ' SALARIO ACTUALIZADO: ' || V_SALARIO);
END;
/


/*11.	Introduciendo un número por teclado, correspondiente al dorsal de un futbolista, dar como
salida el puesto en el que juega dicho jugador. Utilizar la estructura de control más adecuada.*/
/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE PUESTO_JUGADOR (DORSAL NUMBER)
AS
	V_PUESTO VARCHAR2(20);
BEGIN
	IF (DORSAL=1) THEN V_PUESTO:='PORTERO';
		ELSIF (DORSAL=2) THEN V_PUESTO:='LATERAL DERECHO';
		ELSIF (DORSAL=3) THEN V_PUESTO:='LATERAL IZQUIERDO';
		ELSIF (DORSAL=4 OR DORSAL=5) THEN V_PUESTO:='CENTRAL';
		ELSIF (DORSAL=6 OR DORSAL=8) THEN V_PUESTO:='MEDIOCENTRO';
		ELSIF (DORSAL=7) THEN V_PUESTO:='EXTREMO DERECHO';
		ELSIF (DORSAL=9) THEN V_PUESTO:='DELANTERO CENTRO';
		ELSIF (DORSAL=10) THEN V_PUESTO:='MEDIA PUNTA';
		ELSEIF (DORSAL=11) THEN V_PUESTO:='EXTREMO IZQUIERDO';
	ELSE V_PUESTO:='NO EXISTE';
	END IF;
	DBMS_OUTPUT.PUT_LINE(V_PUESTO);
END;
/

EXECUTE PUESTO_JUGADOR(2);


/*12.	Dados dos números introducidos por teclado, obtener cuál de los dos es mayor.*/
/*BLOQUE*/
DECLARE
    NUM1 NUMBER;
    NUM2 NUMBER;
    MAYOR NUMBER;
BEGIN
    IF (%NUM1>%NUM2)
    THEN MAYOR:=NUM1;
    ELSE
        MAYOR:=NUM2;
    END IF;
    DBMS_OUTPUT.PUT_LINE('ENTRE LOS NUMEROS ' || NUM1 || ' Y ' || NUM2 || ', EL MAYOR ES: ' || MAYOR);
END;
/

/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE NUM_MAYOR (NUM1 NUMBER, NUM2 NUMBER)
AS
    MAYOR NUMBER;
BEGIN
    IF (NUM1>NUM2)
    THEN MAYOR:=NUM1;
    ELSE
        MAYOR:=NUM2;
    END IF;
    DBMS_OUTPUT.PUT_LINE('ENTRE LOS NUMEROS ' || NUM1 || ' Y ' || NUM2 || ', EL MAYOR ES: ' || MAYOR);
END;
/


/*13.	Realizar un programa que devuelva el número de cifras de un número entero, introducido por teclado, mediante una variable de sustitución.*/
/*BLOQUE*/
DECLARE
    NUM1 NUMBER;
    CIFRAS NUMBER := 0;
BEGIN
    FOR CONTADOR IN 1 .. LENGTH(&NUM1) LOOP
        CIFRAS:=CIFRAS+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('CIFRAS QUE TIENE EL NUMERO ' || NUM1 ||' :' || CIFRAS);
END;
/

/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE NUM_CIFRAS (NUM1 NUMBER)
AS
    CIFRAS NUMBER := 0;
BEGIN
    FOR CONTADOR IN 1 .. LENGTH(NUM1) LOOP
        CIFRAS:=CIFRAS+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('CIFRAS QUE TIENE EL NUMERO INTRODUCIDO :' || CIFRAS);
END;
/

EXECUTE NUM_CIFRAS (123);


/*14.	Dado un número introducido por teclado, visualizar por pantalla todos los números iguales o
inferiores a él. Este programa se efectuará por todos los tipos de estructuras repetitivas.*/
/*BLOQUE*/
DECLARE
    NUM1 NUMBER;
    MENORES NUMBER;
BEGIN
    SELECT NUM1+1 INTO MENORES FROM DUAL;
    FOR I+1 IN REVERSE &NUM1 .. 0 LOOP
        MENORES := MENORES-1;
        DBMS_OUTPUT.PUT_LINE(MENORES);
    END LOOP;
END;
/

/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE NUM_RANGOS (NUM1 NUMBER)
AS
    MENORES NUMBER;
BEGIN
    SELECT NUM1+1 INTO MENORES FROM DUAL;
    FOR I IN 0 .. NUM1 LOOP
        MENORES:=MENORES-1;
        DBMS_OUTPUT.PUT_LINE(MENORES);
    END LOOP;
END;
/

EXECUTE NUM_RANGOS (13);


/*15.	Introduciendo un año por teclado, decir si este es bisiesto o no.*/
/*BLOQUE*/
DECLARE 
    NUM1 NUMBER;
    BISIESTO BOOLEAN := FALSE;
BEGIN
    
    IF (MOD(&NUM1,4)=0 AND MOD(NUM1, 100)!=0) 
        OR MOD(NUM1,400)=0
    THEN 
        BISIESTO := TRUE;
        DBMS_OUTPUT.PUT_LINE('EL AÑO ' || NUM1 || ' ES BISIESTO');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('EL AÑO ' || NUM1 || ' NO ES BISIESTO');
    END IF;
END;
/

/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE BISIESTO_YEAR (NUM1 NUMBER) IS
BEGIN
    IF (MOD(NUM1,4)=0 AND MOD(NUM1, 100)!=0) 
        OR MOD(NUM1,400)=0
    THEN 
        DBMS_OUTPUT.PUT_LINE('EL AÑO ' || NUM1 || ' ES BISIESTO');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('EL AÑO ' || NUM1 || ' NO ES BISIESTO');
    END IF;
END;
/

EXECUTE BISIESTO_YEAR(2022);