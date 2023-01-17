/* 11- Escribir un procedimiento para consultar los datos de los departamentos mediante el número del departamento (dept_no).
Usar el bloque de EXCEPTION para que el programa funcione si no encuentra el departamento. */

CREATE OR REPLACE PROCEDURE VER_DEPART(NUMDEPART NUMBER)
IS
	V_DNOMBRE VARCHAR(14);
	V_LOCALIDAD VARCHAR(14);
BEGIN
	SELECT DNOMBRE, LOC INTO V_DNOMBRE, V_LOCALIDAD
	FROM DEPART WHERE DEPT_NO=NUMDEPART;
	DBMS_OUTPUT.PUT_LINE ('NUMDEPART:'||NUMDEPART||'*NB DEP:'||V_DNOMBRE||'*LOCALIDAD'||V_LOCALIDAD);
EXCEPTION
	WHEN NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE ('NUMDEPART:'||NUMDEPART||'*NB DEP:'||V_DNOMBRE||'*LOCALIDAD'||V_LOCALIDAD);
END;
/

EXECUTE VER_DEPART(10);
NUMDEPART:10*NB DEP:INVESTIGACION*LOCALIDADMADRID;

EXECUTE VER_DEPART(20);
NUMDEPART:20*NB DEP:INVESTIGACION*LOCALIDADMADRID;