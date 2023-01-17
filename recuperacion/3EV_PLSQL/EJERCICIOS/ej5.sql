/*5- Realizar un programa que solicite la introducción de un número de empleado(variables de acoplamiento &var que no se declara) y visualizara el nombre correspondiente al número introducido. Para declarar el nombre del empleado utilizaremos la variable %TYPE.
Introduzca un valor para vn_emp: 7900
JIMENO */

SET VERIFY OFF;
DECLARE
	V_APELLIDO EMPLE.APELLIDO%TYPE; 
BEGIN
	SELECT APELLIDO INTO V_APELLIDO FROM EMPLE
	WHERE EMP_NO=&vn_cli;
	DBMS_OUTPUT.PUT_LINE ('NOMBRE = ' || V_APELLIDO);
END;
/