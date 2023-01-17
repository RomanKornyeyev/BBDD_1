/*6- Escribir un bloque PL/SQL que muestre la fecha actual y la hora con minutos y segundos.
LUNES     DIA 19 DE ABRIL    DE 2021  A LAS :12:06:55*/

DECLARE
	V_FECHA VARCHAR2(50); 
BEGIN
	SELECT TO_CHAR(SYSDATE, 'Day DD MONTH YYYY HH24:MI:SS') INTO V_FECHA FROM DUAL;
	DBMS_OUTPUT.PUT_LINE (V_FECHA);
END;
/

