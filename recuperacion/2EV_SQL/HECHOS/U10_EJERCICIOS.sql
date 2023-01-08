/* === GROUP BY Y HAVING (AGRUPACIÓN DE ELEMENTOS) === */
/* === EJEMPLOS === */

/*1) A partir de la tabla EMPLE visualizar el número de empleados que hay en cada departamento. (IMP) */
/*DEPT-NO         NUM_EMPLE
 10					3
 20					5
 30                 6*/
SELECT DEPT_NO, COUNT (EMP_NO) "Num_emple" FROM EMPLE GROUP BY DEPT_NO;

/*	En la anterior sólo visualizar los departamentos con más de 4 empleados (IMP) */
SELECT DEPT_NO, COUNT (EMP_NO) "Num_emple" FROM EMPLE GROUP BY DEPT_NO HAVING COUNT (EMP_NO) >4;

/*	En la anterior ordenar por nº de empleados descendentemente*/
SELECT DEPT_NO, COUNT (EMP_NO) "Num_emple" FROM EMPLE GROUP BY DEPT_NO HAVING COUNT (EMP_NO) >4 ORDER BY DEPT_NO DESC;

/*2) Obtener la suma de salarios, el salario máximo y mínimo de cada departamento y formatea la salida con puntos de miles y dos decimales. Visualizarlos ordenados por departamento.
DEPT-NO         SUMA                     MAXIMO                  MINIMO
    10                8.675,00                  4.100,00                 1.690,00
    20                11.370,00                 3.000,00                 1.040,00
    30                10.415,00                 3.005,00                 1.335,00*/
SELECT
	DEPT_NO,
	TO_CHAR(SUM(SALARIO), '99G999D99') "SUMA",
	TO_CHAR(MAX(SALARIO), '99G999D99') "MAX",
	TO_CHAR(MIN(SALARIO), '99G999D99') "MIN"
FROM
	EMPLE
GROUP BY
	DEPT_NO;

/*3) Obtener los nombres de los departamentos que tengan más de tres personas trabajando (IMP)
    DEPT-NO         NOM-DEPARTAMENTO
	20	            INVESTIGACION
	30              VENTAS*/
SELECT DEPT_NO, DNOMBRE "Nombre Departamento" FROM DEPART WHERE DEPT_NO IN (SELECT DEPT_NO FROM EMPLE GROUP BY DEPT_NO HAVING COUNT (EMP_NO)>3);
SELECT E.DEPT_NO, DNOMBRE "Nombre Departamento" FROM EMPLE E, DEPART D WHERE E.DEPT_NO=D.DEPT_NO GROUP BY E.DEPT_NO, DNOMBRE HAVING COUNT (EMP_NO) >3;
SELECT DEPT_NO, DNOMBRE "Nombre Departamento" FROM DEPART WHERE DEPT_NO IN (SELECT DEPT_NO FROM EMPLE GROUP BY DEPT_NO HAVING COUNT(EMP_NO)>3);
/* EN CL COUNT(EMP_NO) SE PODRÍA PONER UN ASTERISCO EN VEZ DE EMP_NO, ES DECIR, COUNT(*), VALE DE LAS 2 MANERAS */
/* === REPASAR === */

/*4) Calcular el número de empleados que realizan cada OFICIO en cada DEPARTAMENTO. Los datos que se visualizan son: nº de departamento, oficio y número de empleados.
( Necesitamos agrupar por departamento y dentro de cada departamento por oficio.)*/
SELECT DEPT_NO, OFICIO, COUNT(*) "NUM EMPLE" FROM EMPLE GROUP BY DEPT_NO, OFICIO;

/*5) Buscar el número de empleados máximo por departamento.*/
SELECT MAX(COUNT(*)) "Máximo" FROM EMPLE GROUP BY DEPT_NO;





/* === OUTER JOIN (+)(COMBINACIÓN EXTERNA)(POCO IMP) === */
/*Ejemplo:
Sean las tablas EMPLE y DEPART
1)	Ver su contenido.
	Queremos visualizar la información contenida en ambas tablas: el número de departamento, el nombre y el número de empleados que tiene y que aparezca un cero en los departamentos que no haya empleados.
	
       10 CONTABILIDAD                   3
       20 INVESTIGACION                  5
       30 VENTAS                         6
       40 PRODUCCION                     0*/

SELECT D.DEPT_NO, DNOMBRE, COUNT(APELLIDO) FROM EMPLE E, DEPART D WHERE E.DEPT_NO(+)=D.DEPT_NO GROUP BY D.DEPT_NO, DNOMBRE ORDER BY D.DEPT_NO;
/* *(+9 tabla hija que es donde se repiten las CP de la tabla padre.*/





/* === UNION, INTERSECT Y MINUS === */
/* UNION (COMBINA RESULTADOS DE LAS 2 CONSULTAS) */
/*Ejemplos:
Disponemos de tres tablas ALUM que contiene los alumnos que hay actualmente en un centro, 
NUEVOS contiene nombres de futuros alumnos y ANTIGUOS que contiene nombres de los antiguos alumnos
-	Ver sus estructuras y contenidos
-	Visualizar los nombres de los alumnos actuales y de los futuros alumnos*/
SELECT NOMBRE FROM ALUM UNION SELECT NOMBRE FROM NUEVOS;


/* INTERSECT (DEVUELVE LAS FILAS QUE SON COMUNES EN AMBAS CONSULTAS) */
/*-	Obtener los nombres de los alumnos que están actualmente en el centro y que ya estuvieron en el pasado.*/
SELECT NOMBRE FROM ALUM INTERSECT SELECT NOMBRE FROM ANTIGUOS;
SELECT NOMBRE FROM ALUM WHERE NOMBRE IN (SELECT NOMBRE FROM ANTIGUOS);


/* MINUS (DEVUELVE AQUELLAS FILAS QUE ESTÁN EN LA PRIMERA SELECT Y NO ESTÁN EN LA SEGUNDA) */
/*-	Obtener los nombres y la localidad de alumnos que están actualmente en el centro y que nunca estuvieron anteriormente en él.*/
SELECT NOMBRE, LOCALIDAD FROM ALUM MINUS SELECT NOMBRE, LOCALIDAD FROM ANTIGUOS;
SELECT NOMBRE, LOCALIDAD FROM ALUM WHERE NOMBRE NOT IN (SELECT NOMBRE FROM ANTIGUOS);

/*Los resultados se pueden ordenar
-	Ordenar la salida por LOCALIDAD descententemente*/
SELECT NOMBRE, LOCALIDAD FROM ALUM MINUS SELECT NOMBRE, LOCALIDAD FROM ANTIGUOS ORDER BY LOCALIDAD DESC;










/* === EJERCICIOS PROPUESTOS === */
/* === TABLA LIBRERÍA === */
/*1)	Visualizar los diferentes estantes de la tabla LIBRERÍA  ordenados descendentemente por estante.*/
SELECT DISTINCT ESTANTE FROM LIBRERIA GROUP BY ESTANTE ORDER BY ESTANTE DESC;

/*2)	Averiguar cuantos temas tiene cada estante.*/
SELECT ESTANTE, COUNT(TEMA) "Num temas" FROM LIBRERIA GROUP BY ESTANTE;

/*3)	Visualizar los estantes que tengan más de tres temas.*/
SELECT ESTANTE FROM LIBRERIA GROUP BY ESTANTE HAVING COUNT(TEMA) > 3;
/*no rows selected*/

/*4)	Visualizar por cada estante la suma de los ejemplares.*/
SELECT ESTANTE, SUM(EJEMPLARES) FROM LIBRERIA GROUP BY ESTANTE;



/* === TABLAS EMPLE Y DEPART (IMP) === */
/*5)	Visualizar los departamentos en los que el salario medio es mayor o igual que la media de todos los salarios (IMP)*/
SELECT DEPT_NO, AVG(SALARIO) "Medio" FROM EMPLE GROUP BY DEPT_NO HAVING AVG(SALARIO)>=(SELECT AVG(SALARIO) FROM EMPLE);

/*6)	A partir de la tabla EMPLE, visualizar el número de vendedores del departamento VENTAS.*/
SELECT COUNT(*) FROM EMPLE E, DEPART D WHERE (E.DEPT_NO=D.DEPT_NO) AND (OFICIO='VENDEDOR') AND (DNOMBRE='VENTAS') GROUP BY OFICIO;

/*7)	Partiendo de la tabla EMPLE, visualizar por cada oficio de los empleados del departamento VENTAS la suma de los salarios.*/
SELECT OFICIO, SUM(SALARIO) "SUMA" FROM EMPLE E, DEPART D WHERE (E.DEPT_NO=D.DEPT_NO) AND (DNOMBRE='VENTAS') GROUP BY OFICIO;

/*8)	A partir de la tabla EMPLE, visualizar el número de empleados de cada departamento cuyo oficio sea EMPLEADO.*/
SELECT DEPT_NO, COUNT(*) "NUM EMPLES" FROM EMPLE WHERE OFICIO='EMPLEADO' GROUP BY DEPT_NO;



/* === TABLA ALUM, ANTIGUOS Y NUEVOS === */
/*9)	Visualizar los nombres de los alumnos de la tabla ALUM que aparezcan en alguna de estas tablas: NUEVOS o ANTIGUOS. Utilizando operadores de conjunto.*/
SELECT NOMBRE FROM ALUM INTERSECT(SELECT NOMBRE FROM NUEVOS UNION SELECT NOMBRE FROM ANTIGUOS);

/*10)	Escribir las distintas formas en que se puede poner la consulta anterior llegando al mismo resultado.*/
SELECT NOMBRE FROM ALUM WHERE NOMBRE IN(SELECT NOMBRE FROM NUEVOS UNION SELECT NOMBRE FROM ANTIGUOS);
SELECT NOMBRE FROM ALUM WHERE NOMBRE IN(SELECT NOMBRE FROM NUEVOS) OR NOMBRE IN (SELECT NOMBRE FROM ANTIGUOS);

/*11)	Visualizar los nombres de los alumnos de la tabla ALUM que aparezcan en estas dos tablas: ANTIGUOS y NUEVOS. Utilizando operadores de conjunto.*/
SELECT NOMBRE FROM ALUM INTERSECT(SELECT NOMBRE FROM NUEVOS INTERSECT SELECT NOMBRE FROM ANTIGUOS);

/*12)	Escribir las distintas formas en que se puede poner la consulta anterior llegando al mismo resultado.*/
SELECT NOMBRE FROM ALUM WHERE NOMBRE IN (SELECT NOMBRE FROM NUEVOS INTERSECT SELECT NOMBRE FROM ANTIGUOS);
SELECT NOMBRE FROM ALUM INTERSECT (SELECT NOMBRE FROM NUEVOS WHERE NOMBRE IN(SELECT NOMBRE FROM ANTIGUOS));

/*13)	Visualizar aquellos nombres de la tabla ALUM que no estén en la tabla ANTIGUOS ni en la tabla NUEVOS. Utilizando operadores de conjunto.*/
SELECT NOMBRE FROM ALUM MINUS (SELECT NOMBRE FROM NUEVOS UNION SELECT NOMBRE FROM ANTIGUOS);
SELECT NOMBRE FROM ALUM MINUS SELECT NOMBRE FROM NUEVOS MINUS SELECT NOMBRE FROM ANTIGUOS;



/* === TABLAS PERSONAL, PROFESORES Y CENTROS === */
/*14) Realizar una consulta en la que aparezca por cada centro y en cada especialidad el número de profesores.
Si el centro no tiene profesores, debe aparecer un 0 en la columna de número de profesores. 
*son outer join 
NOMBRE                         ESPECIALIDAD     Núm.Profes
------------------------------ ---------------- ----------
CP Los Danzantes               DIBUJO                    1
CP Los Danzantes               LENGUA                    2
CP Manuel Hidalgo              INFORMÁTICA               1
IES Antoñete                                             0
IES El Quijote                 INFORMÁTICA               1
IES El Quijote                 MATEMÁTICAS               2
IES Planeta Tierra             MATEMÁTICAS               1*/
SELECT NOMBRE, ESPECIALIDAD, COUNT(DNI) "NUM PROFES"
FROM CENTROS C, PROFESORES P 
WHERE C.COD_CENTRO=P.COD_CENTRO(+) GROUP BY NOMBRE, ESPECIALIDAD;

/*15)Obtener por cada centro el número de empleados. Si el centro carece de empleados, ha de aparecer un 0 como número de empleados. 
COD_CENTRO NOMBRE                         Empleados
---------- ------------------------------ ---------
10 			IES El Quijote                 4
15 			CP Los Danzantes               5
22 			IES Planeta Tierra             3
45 			CP Manuel Hidalgo              2
50			ES Antoñete                    0*/
SELECT C.COD_CENTRO, NOMBRE, COUNT(DNI) "EMPLES"
FROM CENTROS C, PERSONAL P
WHERE C.COD_CENTRO=P.COD_CENTRO(+) GROUP BY C.COD_CENTRO, NOMBRE ORDER BY C.COD_CENTRO;

/*16)Obtener la especialidad con menos profesores.*/
SELECT ESPECIALIDAD FROM PROFESORES GROUP BY ESPECIALIDAD HAVING COUNT(ESPECIALIDAD) = (SELECT MIN(COUNT(*)) FROM PROFESORES GROUP BY ESPECIALIDAD);
	
/*17)Obtener por cada función el número de trabajadores.*/
SELECT FUNCION, COUNT(*) "NUM TRABAJADORES" FROM PERSONAL GROUP BY FUNCION;