/* 4- Construye un bloque PL/SQL que muestre el precio de costo del articulo Canutillos de categoría Primera. */

DECLARE
	V_COSTO NUMBER;
BEGIN
	SELECT PRECIO_COSTO INTO V_COSTO FROM ARTICULOS
	WHERE ARTICULO='Canutillos' AND CATEGORIA='Primera';
	DBMS_OUTPUT.PUT_LINE('PRECIO = ' || V_COSTO);
END;
/