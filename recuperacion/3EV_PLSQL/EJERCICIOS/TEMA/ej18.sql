REM ****EJER 18****Escribir una función que devuelva el valor con IVA de una cantidad que se pasara como primer parámetro. La función podrá recoger un segundo parámetro, que será el tipo de IVA siendo el valor por defecto 16
CREATE OR REPLACE FUNCTION SUMAR_IVA(CANTIDAD NUMBER, IVA NUMBER DEFAULT 16)
RETURN NUMBER
IS VALOR_SUMADO NUMBER;
BEGIN 
	VALOR_SUMADO := CANTIDAD+CANTIDAD*(IVA/100);
	RETURN(VALOR_SUMADO);
END;
/

REM **EJECUCIÓN
SELECT SUMAR_IVA(500, 20) FROM DUAL;