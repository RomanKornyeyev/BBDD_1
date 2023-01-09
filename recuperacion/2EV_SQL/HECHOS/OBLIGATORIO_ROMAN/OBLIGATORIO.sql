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
/*29 Genera un listado de los programas y cantidades que se han distribuido a El*/
/*Corte Inglés de Madrid.*/
/*30 ¿Qué fabricante ha desarrollado Freddy Hardest?*/
/*31 Selecciona el nombre de los programas que se registran por Internet.*/
/*32 Selecciona el nombre de las personas que se registran por Internet.*/
/*33 ¿Qué medios ha utilizado para registrarse Pepe Pérez?*/
/*34 ¿Qué usuarios han optado por Internet como medio de registro?*/
/*35 ¿Qué programas han recibido registros por tarjeta postal?*/
/*36 ¿En qué localidades se han vendido productos que se han registrado por*/
/*Internet?*/
/*37 Obtén un listado de los nombres de las personas que se han registrado por*/
/*Internet, junto al nombre de los programas para los que ha efectuado el*/
/*registro.*/
/*38 Genera un listado en el que aparezca cada cliente junto al programa que ha*/
/*registrado, el medio con el que lo ha hecho y el comercio en el que lo ha*/
/*adquirido.*/
/*39 Genera un listado con las ciudades en las que se pueden obtener los*/
/*productos de Oracle.*/
/*40 Obtén el nombre de los usuarios que han registrado Access XP.*/
/*41 Nombre de aquellos fabricantes cuyo país es el mismo que ʻOracleʼ.*/
/*(Subconsulta).*/
/*42 Nombre de aquellos clientes que tienen la misma edad que Pepe Pérez.*/
/*(Subconsulta).*/
/*43 Genera un listado con los comercios que tienen su sede en la misma ciudad    */
/*que tiene el comercio ʻFNACʼ. (Subconsulta).*/
/*44 Nombre de aquellos clientes que han registrado un producto de la misma*/
/*forma que el cliente ʻPepe Pérezʼ. (Subconsulta).*/
/*45 Obtener el número de programas que hay en la tabla programas.*/
/*46 Calcula el número de clientes cuya edad es mayor de 40 años.*/
/*47 Calcula el número de productos que ha vendido el establecimiento cuyo CIF*/
/*es 1.*/