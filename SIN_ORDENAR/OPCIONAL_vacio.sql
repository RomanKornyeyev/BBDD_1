/* === CREATES === */
DROP TABLE FABRICANTES CASCADE CONSTRAINTS;
DROP TABLE ARTICULOS CASCADE CONSTRAINTS;


































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

/*2.2- Eliminar la restricción de nombre en mayúsculas.*/

/*2.3- Insertar la siguiente fila: altavoces de 70€ del fabricante 2.*/

/*2.4- Cambiar el nombre del artículo 8 a ‘ impresora láser’.*/

/*2.5- Aplicar un descuento de 10€ a todos los artículos cuyo precio sea mayor 
igual a 120€.*/






/* === CONSULTAS === */
/*3.1- Obtener los nombres de los productos.*/

/*3.2- Obtener los nombres y los precios de los productos cuyo precio sea menor 
que 200 euros.*/

/*3.3- Obtener todos los datos de los artículos cuyo precio este entre 60 y 120€.*/

/*3.4- Obtener el nombre y el precio en pesetas.*/

/*3.5- Obtener el precio medio de todos los productos.*/

/*3.6- Obtener el precio medio de los artículos cuyo fabricante sea 2.*/
/* no haría falta subconsulta/combinación de tablas */

/*3.7- Obtener el número de artículos cuyo precio sea mayor igual a 180€.*/

/*3.8- Obtener el nombre y el precio de los artículos cuyo precio sea mayor igual a 
180€ y ordenarlos descendentemente por precio, y luego ascendentemente por nombre.*/

/*3.9- Obtener un listado de artículos, incluyendo el nombre del artículo, su precio
y el nombre de su fabricante.*/

/*3.10- Obtener el precio medio de los productos de cada fabricante.*/

/*3.11- Obtener el precio medio de los productos de cada fabricante, mostrando el 
nombre del fabricante también.*/

/*3.12- Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio 
medio se mayor o igual a 150€.*/

/*3.13- Obtener el nombre y el precio del artículo más barato.*/

/*3.14- Obtener una lista con el nombre y el precio de los artículos más caros de 
cada proveedor incluyendo el nombre del proveedor.*/