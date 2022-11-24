REM ===== EJER 1 =====
SET SERVEROUTPUT ON;
SET VERIFY OFF;
DECLARE
	VALOR_NEGATIVO EXCEPTION;
	valor NUMBER;
BEGIN
	valor := &valor2;
	IF valor < 0 THEN
		RAISE VALOR_NEGATIVO;
	ELSE
		DBMS_OUTPUT.PUT_LINE('El valor es positivo');
	END IF;
	EXCEPTION
		WHEN VALOR_NEGATIVO THEN
		DBMS_OUTPUT.PUT_LINE('El valor no puede ser negativo');
END;
/




REM ===== EJER 2 =====
SET SERVEROUTPUT ON;
SET VERIFY OFF;
CREATE OR REPLACE PROCEDURE SALARIO_CAMBIO(V_EMP_NO NUMBER, V_AUMENTO NUMBER)
IS
	V_SAL EMPLE.SALARIO%TYPE;
	SALARIO_NULO EXCEPTION;
BEGIN
	SELECT SALARIO INTO V_SAL FROM EMPLE WHERE EMP_NO=V_EMP_NO;
	IF
		V_SAL IS NULL THEN
		RAISE SALARIO_NULO;
	ELSE
		UPDATE EMPLE SET SALARIO=(V_SAL+V_AUMENTO) WHERE EMP_NO=V_EMP_NO;
		DBMS_OUTPUT.PUT_LINE('NumEmple: '||V_EMP_NO||' , salario: '||V_SAL);
	END IF;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE(E_EMP_NO||' ERROR. EMPLEADO NO ENCONTRADO.');
		WHEN SALARIO_NULO THEN
			DBMS_OUTPUT.PUT_LINE(E_EMP_NO||' Salario nulo.');
		
END;
/

REM ***HAY QUE HACER ESTE INSERT: INSERT INTO EMPLE VALUES(001,'SANCHEZ','ANALISTA',7698,SYSDATE,NULL,NULL,10);



REM ===== EJER 3 =====
ALTER TABLE EMPLE ADD CONSTRAINT PK_EMPLE PRIMARY KEY(EMP_NO);

SET SERVEROUTPUT ON;
SET VERIFY OFF;
CREATE OR REPLACE PROCEDURE NUEVO_EMP(NUM NUMBER, APE EMPLE.APELLIDO%TYPE, OFI EMPLE.APELLIDO%TYPE,
JEF NUMBER, FEC DATE, SAL NUMBER, COM NUMBER, DEP NUMBER)
IS
	V_JEF EMPLE.DIR%TYPE;
	V_DEP DEPART.DEPT_NO%TYPE;
	EX EXCEPTION;
	CURSOR C2 IS SELECT * FROM EMPLE;
BEGIN
	SELECT DEPT_NO INTO V_DEP FROM DEPART WHERE DEPT_NO=DEP;
	IF V_DEPT_NO%NOTFOUND THEN
		RAISE EX;
	ELSE
		
	END IF;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE(E_EMP_NO||' ERROR. EMPLEADO NO ENCONTRADO.');
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE(E_EMP_NO||' ERROR. EMPLEADO NO ENCONTRADO.');
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE(E_EMP_NO||' ERROR. EMPLEADO NO ENCONTRADO.');
END;
/





REM ========== SOLUCIÓN PROFE
REM ===== EJER 4 ===== IMP <<<<<<<<<<<<<<
SET SERVEROUTPUT ON;
SET VERIFY OFF;
CREATE OR REPLACE PROCEDURE NUEVO_DEPT(N_DEPT NUMBER, NOMBRE DEPART.DNOMBRE%TYPE, LOC VARCHAR2)
IS
	CURSOR C3 IS SELECT DNOMBRE FROM DEPART WHERE DNOMBRE=NOM_DEP;
	CURSOR C4 IS SELECT DEPT_NO FROM DEPART WHERE DEPT_NO=N_DEP;
	V_CDNOMBRE DEPART.DNOMBRE%TYPE DEFAULT NULL;
	V_CDEPART DEPART.DEPT_NO%TYPE DEFAULT NULL;
	V_DEPART DEPART.DEPT_NO%TYPE;
	NOMBRE_DUPLICADO EXCEPTION;
	DEPART_DUPLICADO EXCEPTION;
BEGIN
	OPEN C3;
	FETCH C3 INTO V_CDNOMBRE;
	CLOSE C3;
	
	OPEN C4;
	FETCH C4 INTO V_CDEPART;
	CLOSE C4;
	
	IF V_CDNOMBRE IS NOT NULL THEN
		RAISE NOMBRE_DUPLICADO;
	END IF;
	
	IF V_CDEPART IS NOT NULL THEN
		RAISE DEPART_DUPLICADO;
	END IF;
	
	SELECT MAX(DEPT_NO) INTO V_DEPART FROM DEPART;
	INSERT INTO DEPART VALUES (V_DEPART,NOM_DEP,LOC);
	
	EXCEPTION
	WHEN NOMBRE_DUPLICADO THEN
		DBMS_OUTPUT.PUT_LINE('ERROR DEPART DUPLICADO');
	WHEN DEPART_DUPLICADO THEN
		DBMS_OUTPUT.PUT_LINE('ERROR DEPT_NO DUPLICADO');
END;
/

EXECUTE NUEVO_DEPART(20,'GGG','MADRID');


REM === SOLUCIÓN FRANCO ===
SET SERVEROUTPUT ON;
SET VERIFY OFF;
CREATE OR REPLACE PROCEDURE NUEVO_DEPT(N_DEPT NUMBER, NOMBRE DEPART.DNOMBRE%TYPE, LOC VARCHAR2)




REM ===== EJER 5 =====
SET SERVEROUTPUT ON;
SET VERIFY OFF;
DECLARE
	V_COSA NUMBER;
	V_DIV NUMBER;
BEGIN
	V_COSA:=&TEMP;
	SELECT 10/V_COSA INTO V_DIV FROM DUAL;
EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20001, 'No se puede dividir por cero');
END;
/