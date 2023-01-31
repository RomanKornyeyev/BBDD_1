/*para que salga el texto por consola (si no, no sale nada)*/
/*para que pregunte solo 1 vez para la var introducida x teclado*/
/*anchura de linea, en 200 suele estar bien*/
/*en caso de crear un bloque/procedimiento/función con errores de compilación */
SET SERVEROUTPUT ON;
SET VERIFY OFF;
SET LINESIZE 200;
SHOW ERRORS;




/*1-	Introducir un valor por teclado, crear una excepción si el valor es negativo.
Visualizar tanto si el valor es positivo como el de la excepción.*/
DECLARE
	VALOR_NEGATIVO EXCEPTION;
	NUM NUMBER := &INTRODUCIDO;
BEGIN
	IF NUM < 0 THEN
		RAISE VALOR_NEGATIVO;
	ELSE
		DBMS_OUTPUT.PUT_LINE('CORRECTO: EL VALOR ES POSITIVO');
	END IF;
	
	EXCEPTION
		WHEN VALOR_NEGATIVO THEN
			DBMS_OUTPUT.PUT_LINE('ERROR: EL VALOR NO PUEDE SER NEGATIVO');
END;
/




/*2-	Escribir un procedimiento que reciba un número de empleado y una cantidad que
incrementara el salario del empleado correspondiente. Utilizar dos excepciones, una definida
por el usuario salario_nulo y la otra predefinida NO_DATA_FOUND si no encuentra el nº de empleado. 
Mirar en las tablas si hay salarios nulos, si no hay insertar un nuevo empleado con salario nulo.*/
CREATE OR REPLACE PROCEDURE INCREMENTAR_SALARIO(NUM_EMPLE NUMBER, INCREMENTO NUMBER)
IS
	SALARIO_NULO EXCEPTION;
	V_SALARIO NUMBER;
BEGIN
	SELECT SALARIO INTO V_SALARIO FROM EMPLE WHERE EMP_NO=NUM_EMPLE;
	IF V_SALARIO IS NULL THEN
		RAISE SALARIO_NULO;
	ELSE
		UPDATE EMPLE SET SALARIO=V_SALARIO+INCREMENTO WHERE EMP_NO=NUM_EMPLE;
		DBMS_OUTPUT.PUT_LINE('NumEmple: '||NUM_EMPLE||' , salario antiguo: '||V_SALARIO||', salario nuevo: '||(V_SALARIO+INCREMENTO));
	END IF;
	
	EXCEPTION
		WHEN SALARIO_NULO THEN
			DBMS_OUTPUT.PUT_LINE('ERROR: SALARIO NULO');
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('ERROR: EMPLE NO ENCONTRADO');
END;
/
INSERT INTO EMPLE VALUES(9999, 'PRUEBA', 'EMPLEADO', NULL, '29/01/2023', NULL, NULL, 10);
EXECUTE INCREMENTAR_SALARIO(9999, 200);
EXECUTE INCREMENTAR_SALARIO(7900, 200);




/*3-	 Escribir un procedimiento que reciba los datos de un nuevo empleado. El procedimiento deberá controlar los siguientes errores:
- No existe departamento. 
- No existe director. Crear la excepción.
- Numero de empleado duplicado. Crear una clave primaria para EMP_NO ALTERANDO LA TABLA.
*/
ALTER TABLE EMPLE ADD CONSTRAINT PK_EMPLE PRIMARY KEY(EMP_NO);

CREATE OR REPLACE PROCEDURE INTRODUCIR_EMPLE(
	NUM_EMP EMPLE.EMP_NO%TYPE,
	APE 	EMPLE.APELLIDO%TYPE,
	OFI 	EMPLE.OFICIO%TYPE,
	DIREC   EMPLE.DIR%TYPE,
	FECHA 	EMPLE.FECHA_ALT%TYPE,
	SAL 	EMPLE.SALARIO%TYPE,
	COM 	EMPLE.COMISION%TYPE,
	NUM_DEP EMPLE.DEPT_NO%TYPE
)
IS
	DIR_EXC EXCEPTION;
	AUX_DEP NUMBER := 0;
	AUX_DIR NUMBER := 0;
	CURSOR C1 IS SELECT DIR, DEPT_NO FROM EMPLE;
BEGIN
	FOR I IN C1 LOOP
		IF I.DEPT_NO = NUM_DEP THEN
			AUX_DEP := AUX_DEP+1;
		END IF;
		IF I.DIR = DIREC THEN
			AUX_DIR := AUX_DIR+1;
		END IF;
	END LOOP;
	
	IF AUX_DEP>0 AND AUX_DIR>0 THEN
		INSERT INTO EMPLE VALUES(NUM_EMP, APE, OFI, DIREC, FECHA, SAL, COM, NUM_DEP);
		DBMS_OUTPUT.PUT_LINE('EMPLEADO INSERTADO:'||NUM_EMP||'*'||APE||'*'||OFI||'*'||DIREC||'*'||FECHA||'*'||SAL||'*'||COM||'*'||NUM_DEP);
	ELSIF AUX_DEP=0 THEN
		RAISE NO_DATA_FOUND;
	ELSIF AUX_DIR=0 THEN
		RAISE DIR_EXC;
	END IF;
	
	EXCEPTION
		WHEN DIR_EXC THEN
			DBMS_OUTPUT.PUT_LINE('ERROR: EL DIRECTOR NO EXISTE');
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('ERROR: EL DEPARTAMENTO NO EXISTE');
		WHEN DUP_VAL_ON_INDEX THEN
			DBMS_OUTPUT.PUT_LINE('ERROR: EL NUM DE EMPLEADO YA EXISTE');
END;
/

EXECUTE INTRODUCIR_EMPLE(9500, 'MANOLITO', 'OFICINISTA', 7902, SYSDATE, 1000, 0, 20);
SELECT * FROM EMPLE;




/*4-	 Desarrollar un procedimiento que permita insertar nuevos departamentos según las siguientes especificaciones:
Se pasará al procedimiento el nº del departamento, nombre del departamento y la localidad.
El procedimiento insertará la fila nueva. 
Se incluirá la gestión del error que no se duplique el nº del dep. y el nombre del departamento.
*/
CREATE OR REPLACE PROCEDURE INSERTAR_DEPART(NUM NUMBER, NOM VARCHAR, LC VARCHAR)
IS
	NUM_REPE EXCEPTION;
	NOM_REPE EXCEPTION;
	AUX NUMBER := 0;
	CURSOR C1 IS SELECT DEPT_NO, DNOMBRE FROM DEPART;
BEGIN
	FOR I IN C1 LOOP
		IF(I.DEPT_NO = NUM)THEN
			AUX := AUX+1;
			RAISE NUM_REPE;
		END IF;
		IF(I.DNOMBRE = NOM)THEN
			AUX := AUX+1;
			RAISE NOM_REPE;
		END IF;
	END LOOP;
	
	IF AUX = 0 THEN
		INSERT INTO DEPART VALUES(NUM, NOM, LC);
	END IF;
	
	EXCEPTION
		WHEN NUM_REPE THEN
			DBMS_OUTPUT.PUT_LINE('ERROR: EL NÚMERO DE DEPARTAMENTO YA EXISTE');
		WHEN NOM_REPE THEN
			DBMS_OUTPUT.PUT_LINE('ERROR: EL NOMBRE DE DEPARTAMENTO YA EXISTE');
END;
/

EXECUTE INSERTAR_DEPART(50, 'MARKETING', 'MADRID');
SELECT * FROM DEPART;






/*5-	Crear una excepción mediante RAISE_APPLICATION_ERROR que no se puede dividir por 0. */
/*no entra*/
CREATE OR REPLACE PROCEDURE DIVIDIR_EX(DIVIDENDO NUMBER, DIVISOR NUMBER)
IS
	RESULTADO NUMBER;
BEGIN
	RESULTADO := DIVIDENDO / DIVISOR;
	DBMS_OUTPUT.PUT_LINE(RESULTADO);
	
	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20001, 'NO SE PUEDE DIVIDIR ENTRE CERO');
END;
/

EXECUTE DIVIDIR_EX(5, 0);