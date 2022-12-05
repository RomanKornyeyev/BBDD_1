/* === SELECT DE UNA SOLA TABLA === */
/* 1.	Seleccionar de la tabla EMPLE aquellas filas cuyo APELLIDO empiece por “A” y el OFICIO tenga una “E” en cualquier posición. */
SELECT * FROM EMPLE WHERE APELLIDO LIKE 'A%' AND OFICIO LIKE '%E%';

/* 2.	Visualizar el tema, estante y ejemplares de las filas de LIBRERÍA con ejemplares comprendidos entre 8 y 15.*/
SELECT TEMA, ESTANTE, EJEMPLARES FROM LIBRERIA WHERE EJEMPLARES BETWEEN 8 AND 15;

/* 3.	Visualizar las columnas TEMA, ESTANTE, EJEMPLARES de las filas cuyo ESTANTE no esté comprendido entre la ‘B’ y la ‘D’.*/
SELECT TEMA, ESTANTE, EJEMPLARES FROM LIBRERIA WHERE ESTANTE NOT BETWEEN 'B' AND 'D';

/* 4.	Visualizar los temas de LIBRERÍA cuyo número de ejemplares no esté entre 15 y 20, ambos incluidos.*/
SELECT TEMA FROM LIBRERIA WHERE EJEMPLARES NOT BETWEEN 15 AND 20;



/* === SUBCONSULTAS === */
/* 5.	Mostrar los empleados (nombre, oficio, salario y fecha de alta) que desempeñen el mismo oficio que “JIMENEZ” o que tengan un salario mayor o igual que “FERNANDEZ”.*/
SELECT APELLIDO, OFICIO, SALARIO, FECHA_ALT
FROM EMPLE WHERE 
	OFICIO LIKE(SELECT OFICIO FROM EMPLE WHERE APELLIDO LIKE 'JIMENEZ') 
	OR
	SALARIO >= (SELECT SALARIO FROM EMPLE WHERE APELLIDO LIKE 'FERNANDEZ');
	
/* 6.	Mostrar en pantalla el nombre, oficio y salario de los empleados del departamento de “FERNANDEZ” que tengan su mismo salario.*/
SELECT APELLIDO, OFICIO, SALARIO
FROM EMPLE 
WHERE (DEPT_NO, SALARIO) IN (SELECT DEPT_NO, SALARIO FROM EMPLE WHERE APELLIDO LIKE 'FERNANDEZ');

/* 7.	Presentar los nombres y oficios de los empleados que tienen el mismo trabajo que “JIMENEZ”.*/
SELECT APELLIDO, OFICIO FROM EMPLE WHERE OFICIO LIKE (SELECT OFICIO FROM EMPLE WHERE APELLIDO LIKE 'JIMENEZ');

/* 8.	Visualizar todos los temas de LIBRERÍA cuyo número de ejemplar sea inferior a los que hay en ‘Medicina’.*/
/**************** NO FUNCIONA ******************/
SELECT TEMA FROM LIBRERIA WHERE EJEMPLARES < (SELECT EJEMPLARES FROM LIBRERIA WHERE TEMA LIKE 'MEDICINA');



/* === COMBINACION DE TABLAS === */
/* 9.	Visualizar todas las asignaturas que contengan tres letras “o” en su interior y tengan alumnos matriculados de “Madrid”.*/
SELECT NOMBRE
FROM ASIGNATURAS, ALUMNOS, NOTAS
WHERE
	NOMBRE LIKE '%o%o%o%' AND POBLA LIKE 'Madrid'
	AND
	ASIGNATURAS.COD = NOTAS.COD AND NOTAS.DNI = ALUMNOS.DNI;

/* otra manera (renombrando tablas) */
SELECT NOMBRE
FROM ASIGNATURAS A, ALUMNOS AL, NOTAS N
WHERE
	NOMBRE LIKE '%o%o%o%' AND POBLA='Madrid'
	AND
	A.COD = N.COD AND N.DNI = AL.DNI;
	
/* 10.	Visualizar los nombres de alumnos que tengan una nota entre 7 y 8 en la asignatura de “FOL”.*/
SELECT APENOM,NOMBRE,NOTA
FROM NOTAS N, ALUMNOS AL, ASIGNATURAS A
WHERE 
	NOTA BETWEEN 7 AND 8 AND NOMBRE LIKE 'FOL'
	AND
	AL.DNI = N.DNI AND A.COD = N.COD;

/* 11.	Visualizar los nombres de asignaturas que no tengan suspensos.*/
SELECT DISTINCT NOMBRE FROM ASIGNATURAS A, NOTAS N WHERE NOTA >= 5 AND A.COD = N.COD;

/* 12.	Visualizar los nombres de alumnos de “Madrid” que tengan alguna asignatura suspensa.*/
SELECT APENOM
FROM NOTAS N, ALUMNOS AL, ASIGNATURAS A
WHERE
	POBLA LIKE 'Madrid' AND NOTA < 5
	AND
	AL.DNI = N.DNI AND A.COD = N.COD;

/* 13.	Mostrar los nombres de alumnos que tengan la misma nota que tiene “Díaz Fernández, María” en FOL en alguna asignatura.*/
/* ??? creo que funciona */
SELECT APENOM, NOMBRE, NOTA
FROM NOTAS N, ALUMNOS AL, ASIGNATURAS A
WHERE
	NOTA LIKE (
			SELECT NOTA
			FROM NOTAS N, ALUMNOS AL, ASIGNATURAS A
			WHERE
				(AL.DNI = N.DNI AND A.COD = N.COD)
				AND
				(APENOM LIKE 'Díaz Fernández, María' AND NOMBRE LIKE 'FOL')
			)
	AND
	AL.DNI = N.DNI AND A.COD = N.COD;

/* 14.	Seleccionar el apellido, el oficio y la localidad de los departamentos donde trabajan los ANALISTAS. */
SELECT APELLIDO, OFICIO, LOC
FROM EMPLE E, DEPART D
WHERE
	OFICIO LIKE 'ANALISTA'
	AND
	D.DEPT_NO = E.DEPT_NO;



/* === TABLAS EMPLE y DEPART === */
/* 1.	Obtener los datos de los empleados cuyo director (columna DIR de EMPLE) sea ‘CEREZO’.*/	
SELECT * FROM EMPLE WHERE DIR LIKE (SELECT EMP_NO FROM EMPLE WHERE APELLIDO='CEREZO');

/* 2.	Obtener los datos de los empleados del departamento de ‘VENTAS’.*/
SELECT * FROM EMPLE WHERE DEPT_NO LIKE (SELECT DEPT_NO FROM DEPART WHERE DNOMBRE LIKE 'VENTAS');

/* 3.	Obtener los datos de los departamentos que no tengan empleados.*/
SELECT * FROM DEPART WHERE DEPT_NO NOT IN (SELECT DISTINCT DEPT_NO FROM EMPLE);

/* 4.	Obtener los datos de los departamentos que tengan empleados.*/
SELECT * FROM DEPART WHERE DEPT_NO IN (SELECT DISTINCT DEPT_NO FROM EMPLE);

/* 5.	Obtener el apellido y el salario de los empleados que superen todos los salarios de los empleados del departamento 20.*/
SELECT APELLIDO, SALARIO FROM EMPLE WHERE SALARIO > ALL (SELECT SALARIO FROM EMPLE WHERE DEPT_NO = 20);



/* === TABLAS ALUMNOS, ASIGNATURAS y NOTAS === */
/* ??? no sé si estas están bien */
/* 1.	Obtener los datos de las asignaturas que no tengan alumnos.*/
SELECT * FROM ASIGNATURAS WHERE COD NOT IN (SELECT COD FROM NOTAS);

/* 2.	Obtener el nombre y apellido de los alumnos que tengan nota en la asignatura con código 1.*/
SELECT APENOM FROM ALUMNOS WHERE DNI IN (SELECT DNI FROM NOTAS WHERE COD = 1);

/* 3.	Obtener el nombre y apellido de los alumnos que no tengan nota en la asignatura con código 1.*/
SELECT APENOM FROM ALUMNOS WHERE DNI NOT IN (SELECT DNI FROM NOTAS WHERE COD = 1);