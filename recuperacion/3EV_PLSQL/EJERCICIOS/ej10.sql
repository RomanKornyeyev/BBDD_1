/* 10- Escribe un procedimiento que reciba dos números y visualice la suma. */

/*ARRIBA NUNCA PUEDEN IR VARIABLES CON LA LONGITUD*/
CREATE OR REPLACE PROCEDURE SUMAR_NUM(NUM1 NUMBER, NUM2 NUMBER)
IS
	SUMA NUMBER(5);
BEGIN
	SUMA := NUM1 + NUM2;
	DBMS_OUTPUT.PUT_LINE ('SUMA='||SUMA);
END;
/

EXECUTE SUMAR_NUM(3,3);