/* === CREATES === */
DROP TABLE FABRICANTES CASCADE CONSTRAINTS;
DROP TABLE ARTICULOS CASCADE CONSTRAINTS;

CREATE TABLE FABRICANTES(
	COD_FAB NUMBER(3) PRIMARY KEY,
	NOMBRE VARCHAR(50),
	CONSTRAINT UNICO UNIQUE(NOMBRE)
);

CREATE TABLE ARTICULOS(
	COD_ART NUMBER(3),
	NOMBRE VARCHAR(50),
	PRECIO NUMBER(10),
	COD_FAB NUMBER(3) NOT NULL,
	CONSTRAINT FK_FAB FOREIGN KEY (COD_FAB) REFERENCES FABRICANTES(COD_FAB),
	CONSTRAINT MAYOR_CERO CHECK(PRECIO>0),
	CONSTRAINT MAYUS_NB CHECK(NOMBRE=UPPER(NOMBRE)),
	CONSTRAINT PK_ART PRIMARY KEY(COD_ART,COD_FAB)
);

/* INSERT FABRICANTES */
INSERT INTO FABRICANTES VALUES(1, 'Acer');
INSERT INTO FABRICANTES VALUES(2, 'Asus');
INSERT INTO FABRICANTES VALUES(3, 'Corsair');
INSERT INTO FABRICANTES VALUES(4, 'Dell');
INSERT INTO FABRICANTES VALUES(5, 'HP');
INSERT INTO FABRICANTES VALUES(6, 'Lenovo');
INSERT INTO FABRICANTES VALUES(7, 'Toshiba');

/* INSERT ARTICULOS */
INSERT INTO ARTICULOS VALUES(1, 'RADIO', 40, 1);
INSERT INTO ARTICULOS VALUES(2, 'TELEVISION', 200, 2);
INSERT INTO ARTICULOS VALUES(3, 'PORTATIL', 600, 1);
INSERT INTO ARTICULOS VALUES(4, 'TECLADO', 30, 2);
INSERT INTO ARTICULOS VALUES(5, 'TELEVISION', 220, 1);
INSERT INTO ARTICULOS VALUES(6, 'MONITOR', 150, 2);
INSERT INTO ARTICULOS VALUES(7, 'RATON', 15, 3);
INSERT INTO ARTICULOS VALUES(8, 'PROCESADOR', 300, 3);
INSERT INTO ARTICULOS VALUES(9, 'RAM', 120, 3);
INSERT INTO ARTICULOS VALUES(10, 'PLACA', 135, 3);
INSERT INTO ARTICULOS VALUES(12, 'PSU', 80, 1);
INSERT INTO ARTICULOS VALUES(13, 'PENDRIVE', 10, 4);
INSERT INTO ARTICULOS VALUES(14, 'PENDRIVE', 15, 4);

COMMIT;
/* EL COMMIT SOLO ES PARA LOS INSERTS */






/* === ALTER === */
/* ANTES DE LOS ALTER, METER TODAS LAS TABLAS Y LUEGO METER ALTERS 1 A 1 */
/*2.1- Añadir los campos DIRECCION y LOCALIDAD a la tabla fabricantes.*/
ALTER TABLE FABRICANTES ADD (DIRECCION VARCHAR(50), LOCALIDAD VARCHAR(50));

/*2.2- Eliminar la restricción de nombre en mayúsculas.*/
ALTER TABLE ARTICULOS DROP CONSTRAINT MAYUS_NB;

/*2.3- Insertar la siguiente fila: altavoces de 70€ del fabricante 2.*/
INSERT INTO ARTICULOS VALUES(11, 'Altavoces', 70, 5);

/*2.4- Cambiar el nombre del artículo 8 a ‘ impresora láser’.*/
UPDATE ARTICULOS SET NOMBRE='impresora láser' WHERE COD_ART=8;

/*2.5- Aplicar un descuento de 10€ a todos los artículos cuyo precio sea mayor 
igual a 120€.*/
UPDATE ARTICULOS SET PRECIO=(PRECIO-10) WHERE PRECIO >= 120;






/* === CONSULTAS === */
/*3.1- Obtener los nombres de los productos.*/
SELECT * FROM ARTICULOS;

/*3.2- Obtener los nombres y los precios de los productos cuyo precio sea menor 
que 200 euros.*/
SELECT NOMBRE, PRECIO FROM ARTICULOS WHERE PRECIO < 200;

/*3.3- Obtener todos los datos de los artículos cuyo precio este entre 60 y 120€.*/
SELECT * FROM ARTICULOS WHERE PRECIO BETWEEN 60 AND 120;

/*3.4- Obtener el nombre y el precio en pesetas.*/
SELECT NOMBRE, PRECIO*166.386 FROM ARTICULOS;

/*3.5- Obtener el precio medio de todos los productos.*/
SELECT AVG(PRECIO) FROM ARTICULOS;

/*3.6- Obtener el precio medio de los artículos cuyo fabricante sea 2.*/
/* no haría falta subconsulta/combinación de tablas */
SELECT AVG(PRECIO) FROM ARTICULOS WHERE COD_FAB=2;

/*3.7- Obtener el número de artículos cuyo precio sea mayor igual a 180€.*/
SELECT COUNT(*) FROM ARTICULOS WHERE PRECIO >= 180;

/*3.8- Obtener el nombre y el precio de los artículos cuyo precio sea mayor igual a 
180€ y ordenarlos descendentemente por precio, y luego ascendentemente por nombre.*/
SELECT NOMBRE, PRECIO FROM ARTICULOS WHERE PRECIO >= 180 ORDER BY PRECIO DESC, NOMBRE ASC;

/*3.9- Obtener un listado de artículos, incluyendo el nombre del artículo, su precio
y el nombre de su fabricante.*/
SELECT A.NOMBRE, A.PRECIO, F.NOMBRE FROM ARTICULOS A, FABRICANTES F WHERE A.COD_FAB=F.COD_FAB;

/*3.10- Obtener el precio medio de los productos de cada fabricante.*/
SELECT COD_FAB, AVG(PRECIO) FROM ARTICULOS GROUP BY COD_FAB;

/*3.11- Obtener el precio medio de los productos de cada fabricante, mostrando el 
nombre del fabricante también.*/
SELECT F.NOMBRE, AVG(PRECIO) FROM ARTICULOS A, FABRICANTES F WHERE A.COD_FAB=F.COD_FAB GROUP BY F.NOMBRE;

/*3.12- Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio 
medio se mayor o igual a 150€.*/
SELECT F.NOMBRE, AVG(PRECIO) FROM ARTICULOS A, FABRICANTES F WHERE A.COD_FAB=F.COD_FAB GROUP BY F.NOMBRE HAVING (AVG(PRECIO)) >= 150;

/*3.13- Obtener el nombre y el precio del artículo más barato.*/
SELECT NOMBRE, PRECIO FROM ARTICULOS WHERE PRECIO IN (SELECT MIN(PRECIO) FROM ARTICULOS);

/*3.14- Obtener una lista con el nombre y el precio de los artículos más caros de 
cada proveedor incluyendo el nombre del proveedor.*/
SELECT A.NOMBRE "ARTICULO", A.PRECIO, F.NOMBRE "PROVEEDOR" FROM ARTICULOS A, FABRICANTES F
WHERE A.COD_FAB=F.COD_FAB AND A.PRECIO IN (SELECT MAX(A.PRECIO) FROM ARTICULOS WHERE A.COD_FAB=F.COD_FAB);