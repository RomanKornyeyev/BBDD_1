/*9- Escribir un bloque PL/SQL que introduzca dos números y los sume.
Introduzca un valor para v_num1: 20
Introduzca un valor para v_num2: 20
SUMA=40
*/


SET VERIFY OFF;
DECLARE
	NUM1 NUMBER; 
	NUM2 NUMBER;
	SUMA NUMBER(6);
BEGIN
	NUM1:=&V_NUM1;
	NUM2:=&V_NUM2;
	SUMA:=NUM1+NUM2;
	DBMS_OUTPUT.PUT_LINE ('SUMA='||SUMA);
END;
/