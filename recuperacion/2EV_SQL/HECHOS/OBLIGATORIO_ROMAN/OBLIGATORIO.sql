/*1 Averigua el DNI de todos los clientes.*/
SELECT DNI FROM CLIENTE;

/*2 Consulta todos los datos de todos los programas.*/
SELECT * FROM PROGRAMA;

/*3 Obtén un listado con los nombres de todos los programas.*/
SELECT NOMBRE FROM PROGRAMA;

/*4 Genera una lista con todos los comercios.*/
SELECT * FROM COMERCIO;

/*5 Genera una lista de las ciudades con establecimientos donde se venden
programas, sin que aparezcan valores duplicados (utiliza DISTINCT).*/
SELECT DISTINCT CIUDAD FROM COMERCIO;

/*6 Obtén una lista con los nombres de programas, sin que aparezcan valores
duplicados (utiliza DISTINCT).*/
SELECT DISTINCT NOMBRE FROM PROGRAMA;

/*7 Obtén el DNI más 4 (mayor de 4) de todos los clientes.*/
SELECT DNI FROM CLIENTE WHERE DNI > 4;

/*8 Haz un listado con los códigos de los programas multiplicados por 7.*/
SELECT CODIGO*7 FROM PROGRAMA;

/*9 ¿Cuáles son los programas cuyo código es inferior o igual a 10?*/
SELECT * FROM PROGRAMA WHERE CODIGO <= 10;

/*10 ¿Cuál es el programa cuyo código es 11?*/
SELECT * FROM PROGRAMA WHERE CODIGO > 11;

/*11 ¿Qué fabricantes son de Estados Unidos?*/
SELECT * FROM FABRICANTE WHERE PAIS = 'Estados Unidos';

/*12 ¿Cuáles son los fabricantes no españoles? Utilizar el operador IN.*/
SELECT * FROM FABRICANTE WHERE PAIS NOT IN 'España';

/*13 Obtén un listado con los códigos de las distintas versiones de Windows.*/
SELECT * FROM PROGRAMA WHERE NOMBRE = 'Windows';

/*14 ¿En qué ciudades comercializa programas El Corte Inglés?*/
SELECT * FROM COMERCIO WHERE NOMBRE = 'El Corte Inglés';

/*15 ¿Qué otros comercios hay, además de El Corte Inglés? Utilizar el operador IN.*/
SELECT * FROM COMERCIO WHERE NOMBRE NOT IN 'El Corte Inglés';

/*16 Genera una lista con los códigos de las distintas versiones de Windows y
Access. Utilizar el operador IN.*/
SELECT * FROM PROGRAMA WHERE NOMBRE IN 'Windows' OR NOMBRE IN 'Access';

/*17 Obtén un listado que incluya los nombres de los clientes de edades
comprendidas entre 10 y 25 y de los mayores de 50 años. Da una solución con
BETWEEN y otra sin BETWEEN.*/
SELECT NOMBRE "Nombres cli 10-25 o >50" FROM CLIENTE WHERE EDAD BETWEEN 10 AND 25 OR EDAD > 50;
SELECT NOMBRE "Nombres cli 10-25 o >50" FROM CLIENTE WHERE (EDAD >=10 AND EDAD <=25) OR EDAD >50;

/*18 Saca un listado con los comercios de Sevilla y Madrid. No se admiten
valores duplicados.*/
SELECT DISTINCT NOMBRE FROM COMERCIO WHERE CIUDAD = 'Sevilla' OR CIUDAD = 'Madrid';
/*valdría también con IN*/

/*19 ¿Qué clientes terminan su nombre en la letra “o”?*/
SELECT NOMBRE FROM CLIENTE WHERE NOMBRE LIKE '%o';

/*20 ¿Qué clientes terminan su nombre en la letra “o” y, además, son mayores
de 30 años?*/
SELECT NOMBRE FROM CLIENTE WHERE NOMBRE LIKE '%o' AND EDAD > 30;

/*21 Obtén un listado en el que aparezcan los programas cuya versión finalice
por una letra i, o cuyo nombre comience por una A o por una W.*/
SELECT * FROM PROGRAMA WHERE VERSION LIKE '%i' OR NOMBRE LIKE 'A%' OR NOMBRE LIKE 'W%';

/*22 Obtén un listado en el que aparezcan los programas cuya versión finalice
por una letra i, o cuyo nombre comience por una A y termine por una S.*/
SELECT * FROM PROGRAMA WHERE VERSION LIKE '%i' OR (NOMBRE LIKE 'A%' AND NOMBRE LIKE '%s');
SELECT * FROM PROGRAMA WHERE VERSION LIKE '%i' OR NOMBRE LIKE 'A%s';

/*23 Obtén un listado en el que aparezcan los programas cuya versión finalice
por una letra i, y cuyo nombre no comience por una A.*/
SELECT * FROM PROGRAMA WHERE VERSION LIKE '%i' AND NOMBRE NOT LIKE 'A%';

/*24 Obtén una lista de empresas por orden alfabético ascendente.*/
SELECT NOMBRE FROM COMERCIO ORDER BY NOMBRE ASC;

/*25 Genera un listado de empresas por orden alfabético descendente.*/
SELECT NOMBRE FROM COMERCIO ORDER BY NOMBRE DESC;

/*26 Obtén un listado de programas por orden de versión*/
SELECT * FROM PROGRAMA ORDER BY VERSION;

/*27 Genera un listado de los programas que desarrolla Oracle.*/
SELECT F.NOMBRE "Fabricante", P.NOMBRE "Programa" FROM PROGRAMA P, DESARROLLA D, FABRICANTE F
WHERE (P.CODIGO=D.CODIGO) AND (D.ID_FAB=F.ID_FAB) AND F.NOMBRE = 'Oracle';

/*28 ¿Qué comercios distribuyen Windows?*/
SELECT C.NOMBRE FROM PROGRAMA P, COMERCIO C, DISTRIBUYE D WHERE (P.CODIGO=D.CODIGO AND C.CIF=D.CIF) AND P.NOMBRE='Windows';

/*29 Genera un listado de los programas y cantidades que se han distribuido a El
Corte Inglés de Madrid.*/
SELECT
	P.NOMBRE, D.CANTIDAD
FROM
	PROGRAMA P, COMERCIO C, DISTRIBUYE D 
WHERE 
	(P.CODIGO=D.CODIGO AND C.CIF=D.CIF) 
AND 
	(C.NOMBRE='El Corte Inglés' AND C.CIUDAD='Madrid');

/*30 ¿Qué fabricante ha desarrollado Freddy Hardest?*/
SELECT F.NOMBRE FROM FABRICANTE F, PROGRAMA P, DESARROLLA D WHERE F.ID_FAB=D.ID_FAB AND P.CODIGO=D.CODIGO AND P.NOMBRE='Freddy Hardest';

/*31 Selecciona el nombre de los programas que se registran por Internet.*/
SELECT P.NOMBRE "PROGRAMAS REG. INTERNET" FROM PROGRAMA P, REGISTRA R WHERE P.CODIGO=R.CODIGO AND R.MEDIO='Internet';
SELECT NOMBRE "PROGRAMAS REG. INTERNET" FROM PROGRAMA WHERE CODIGO IN (SELECT CODIGO FROM REGISTRA WHERE MEDIO='Internet');

/*32 Selecciona el nombre de las personas que se registran por Internet.*/
SELECT C.NOMBRE "NOMBRE CLI. REG. INTERNET" FROM CLIENTE C, REGISTRA R WHERE C.DNI=R.DNI AND R.MEDIO='Internet';

/*33 ¿Qué medios ha utilizado para registrarse Pepe Pérez?*/
SELECT C.NOMBRE "NOMBRE", R.MEDIO "MEDIO DE REGISTRO" FROM CLIENTE C, REGISTRA R WHERE C.DNI=R.DNI AND C.NOMBRE='Pepe Pérez';

/*34 ¿Qué usuarios han optado por Internet como medio de registro? (repetido) */
SELECT C.NOMBRE "NOMBRE", R.MEDIO "MEDIO DE REGISTRO" FROM CLIENTE C, REGISTRA R WHERE C.DNI=R.DNI AND R.MEDIO='Internet';

/*35 ¿Qué programas han recibido registros por tarjeta postal? (no estoy seguro de si hacen falta las 3 tablas)*/
SELECT P.NOMBRE FROM PROGRAMA P, REGISTRA R WHERE P.CODIGO=R.CODIGO AND R.MEDIO='Tarjeta postal';

/*36 ¿En qué localidades se han vendido productos que se han registrado por
Internet? (no estoy seguro de si hacen falta las 3 tablas)*/
SELECT C.CIUDAD FROM COMERCIO C, REGISTRA R WHERE C.CIF=R.CIF AND R.MEDIO='Internet';

/*37 Obtén un listado de los nombres de las personas que se han registrado por
Internet, junto al nombre de los programas para los que ha efectuado el
registro.*/
SELECT C.NOMBRE, P.NOMBRE "PROGRAMA" FROM PROGRAMA P, CLIENTE C, REGISTRA R WHERE P.CODIGO=R.CODIGO AND C.DNI=R.DNI AND R.MEDIO='Internet';

/*38 Genera un listado en el que aparezca cada cliente junto al programa que ha
registrado, el medio con el que lo ha hecho y el comercio en el que lo ha
adquirido.*/
SELECT
	CL.NOMBRE "CLIENTE", P.NOMBRE "PROGRAMA", R.MEDIO, CM.NOMBRE "COMERCIO"
FROM 
	PROGRAMA P, COMERCIO CM, CLIENTE CL, REGISTRA R
WHERE
	P.CODIGO=R.CODIGO AND CM.CIF=R.CIF AND CL.DNI=R.DNI;

/*39 Genera un listado con las ciudades en las que se pueden obtener los
productos de Oracle.*/
SELECT DISTINCT C.CIUDAD FROM COMERCIO C, PROGRAMA P, DESARROLLA DE, FABRICANTE F, DISTRIBUYE DI
WHERE C.CIF=DI.CIF AND P.CODIGO=DI.CODIGO AND F.ID_FAB=DE.ID_FAB AND P.CODIGO=DE.CODIGO AND F.NOMBRE='Oracle';
/*Espero no ver este en el examen xD*/

/*40 Obtén el nombre de los usuarios que han registrado Access XP.*/
SELECT C.NOMBRE "USERS REG. ACC.XP" FROM PROGRAMA P, CLIENTE C, REGISTRA R WHERE (P.CODIGO=R.CODIGO AND C.DNI=R.DNI) AND (P.NOMBRE='Access' AND P.VERSION='XP');

/*41 Nombre de aquellos fabricantes cuyo país es el mismo que ʻOracleʼ.
(Subconsulta).*/
SELECT NOMBRE FROM FABRICANTE WHERE PAIS IN (SELECT PAIS FROM FABRICANTE WHERE NOMBRE='Oracle');

/*42 Nombre de aquellos clientes que tienen la misma edad que Pepe Pérez (Subconsulta).*/
SELECT NOMBRE FROM CLIENTE WHERE EDAD IN (SELECT EDAD FROM CLIENTE WHERE NOMBRE='Pepe Pérez');

/*43 Genera un listado con los comercios que tienen su sede en la misma ciudad
que tiene el comercio ʻFNACʼ. (Subconsulta).*/
SELECT NOMBRE FROM COMERCIO WHERE CIUDAD IN (SELECT CIUDAD FROM COMERCIO WHERE NOMBRE='FNAC');

/*44 Nombre de aquellos clientes que han registrado un producto de la misma
forma que el cliente ʻPepe Pérezʼ. (Subconsulta).*/
/* repasar este */
SELECT DISTINCT C.NOMBRE FROM CLIENTE C, REGISTRA R WHERE C.DNI=R.DNI AND R.MEDIO IN (SELECT R.MEDIO FROM CLIENTE C, REGISTRA R WHERE C.DNI=R.DNI AND C.NOMBRE='Pepe Pérez'); 

/*45 Obtener el número de programas que hay en la tabla programas.*/
SELECT COUNT(CODIGO) "NUM PROGRAMAS" FROM PROGRAMA;

/*46 Calcula el número de clientes cuya edad es mayor de 40 años.*/
SELECT COUNT(DNI) "NUM CLI EDAD>40" FROM CLIENTE WHERE EDAD > 40;

/*47 Calcula el número de productos que ha vendido el establecimiento cuyo CIF es 1.*/
SELECT SUM(CANTIDAD) FROM DISTRIBUYE WHERE CIF=1;

/*48 Calcula la media de programas que se venden cuyo código es 7.*/
SELECT AVG(CANTIDAD) FROM DISTRIBUYE WHERE CODIGO=7;

/*49 Calcula la mínima cantidad de programas de código 7 que se ha vendido*/
/*(no sé si está bien)*/
SELECT MIN(CANTIDAD) FROM DISTRIBUYE WHERE CODIGO=7;

/*50 Calcula la máxima cantidad de programas de código 7 que se ha vendido.*/
SELECT MAX(CANTIDAD) FROM DISTRIBUYE WHERE CODIGO=7;

/*51 ¿En cuántos establecimientos se vende el programa cuyo código es 7?*/
SELECT COUNT(CIF) FROM DISTRIBUYE WHERE CODIGO=7;

/*52 Calcular el número de registros que se han realizado por Internet.*/
SELECT COUNT(*) "NUM REGISTROS POR INTERNET" FROM REGISTRA WHERE MEDIO = 'Internet';

/*53 Obtener el número total de programas que se han vendido en ʻSevillaʼ.*/
SELECT SUM(CANTIDAD) "NUM PROGRAMAS VEND EN SEVILLA" FROM COMERCIO C, DISTRIBUYE D WHERE C.CIF=D.CIF AND C.CIUDAD='Sevilla';

/*54 Calcular el número total de programas que han desarrollado los fabricantes 
cuyo país es ʻEstados Unidosʼ.*/
SELECT COUNT(P.CODIGO) "PROGRAMAS DESARR. EN EEUU" FROM FABRICANTE F, PROGRAMA P, DESARROLLA D
WHERE F.ID_FAB=D.ID_FAB AND P.CODIGO=D.CODIGO AND F.PAIS='Estados Unidos';

/*55 Visualiza el nombre de todos los clientes en mayúscula. En el resultado de
la consulta debe aparecer también la longitud de la cadena nombre.*/
SELECT UPPER(NOMBRE) "NOMBRE", LENGTH(NOMBRE) "LONGITUD" FROM CLIENTE;

/*56 Con una consulta concatena los campos nombre y versión de la tabla PROGRAMA.*/
SELECT CONCAT(NOMBRE, VERSION) FROM PROGRAMA;