/*para que salga el texto por consola (si no, no sale nada)*/
/*para que pregunte solo 1 vez para la var introducida x teclado*/
/*anchura de linea, en 200 suele estar bien*/
/*en caso de crear un bloque/procedimiento/funci?n con errores de compilaci?n */
SET SERVEROUTPUT ON;
SET VERIFY OFF;
SET LINESIZE 200;
SHOW ERRORS;




/* ----- UPDATES, INSERTS, ALTERS (PARA COMPROBACIONES Y DEMÁS) ------ */
/*3. Añadir la restricción de clave primaria a la columna COD_ASIG  de la tabla anterior.*/
ALTER TABLE TASIG ADD CONSTRAINT PK_COD_ASIG PRIMARY KEY (COD_ASIG);

/*4. Añadir la restricción clave ajena a la columna COD_ASIG de la tabla PROFESORES.*/
ALTER TABLE PROFESORES ADD CONSTRAINT FK_COD_ASIG REFERENCES (COD_ASIG) ON DELETE CASCADE;

/* Añadir el campo SALARIO a la tabla  EMPLEADO */
ALTER TABLE EMPLEADO ADD SALARIO NUMBER(10) NOT NULL;

/* Modificar las columnas de las tablas DEPARTAMENTO y EMPLEADO para que el nombre pueda almacenar más caracteres */
ALTER TABLE DEPARTAMENTO MODIFY NOMBRE VARCHAR(50);

INSERT INTO ALUMNOS (DNI, NOMBRE, DIR, ...) VALUES (VALOR1, VALOR2, VALOR3, ...); 

O

INSERT INTO ALUMNOS VALUES (VALOR1, VALOR2, VALOR3, ...); 

/* Updeit */
UPDATE LIBROS_EX SET COD=999 WHERE COD=100;






/* ----- PL (AHORA SÍ) ------ */
--EJERCICIO 6-- 
--TRIGGERS: CREAR UNA TABLA LIBROS Y OTRA TABLA CONTROL. INSERTAR, MODIFICAR O BORRAR EN LIBROS SE PLASMARA EN LA CONTROL CON LOS SIGUIENTES DATOS:--
--USER, FECHA Y 'STRING'. ESTE 'STRING' CORRESPONDERA AL TIPO DE ACCION QUE SE HAYA HECHO EN LA TABLA.--
DROP TABLE LIBROS_EX;
CREATE TABLE LIBROS_EX (
	COD NUMBER(4),
	TITULO VARCHAR(30),
	AUTOR VARCHAR(30)
);
DROP TABLE CONTROL;
CREATE TABLE CONTROL (
	USUARIO VARCHAR2(10),
	FECHA DATE,
	OPERACION VARCHAR2(20)
);

/*OJO, EN EL DECLARE EL TIPO DE STRING DE AUX TIENE QUE SER IGUAL AL DE LA TABLA CONTROL (VARCHAR2)*/


INSERT INTO LIBROS_EX VALUES(100, 'Me llamo Román', 'Román');
INSERT INTO LIBROS_EX VALUES(120, 'Me llamo Cosa', 'Cosa');
INSERT INTO LIBROS_EX VALUES(140, 'Me llamo Prueba', 'Jeje');
UPDATE LIBROS_EX SET COD=999 WHERE COD=100;
DELETE LIBROS_EX WHERE COD=140;
SELECT * FROM CONTROL;








/*2-	Crear un trigger que se disparará cada vez que se borre un empleado, guardando el literal “borrado empleado”,  su número de empleado,
apellido y el departamento en una fila de la tabla AUDITAR_EMPLE.*/
/*3-	Incluir una restricción en el ejercicio anterior para que se ejecute el disparador cuando el empleado borrado sea PRESIDENTE.*/
DROP TABLE AUDITAR_EMPLE;
CREATE TABLE AUDITAR_EMPLE(
	COL1 VARCHAR2(200)
);



DELETE FROM EMPLE WHERE OFICIO='PRESIDENTE';
SELECT * FROM AUDITAR_EMPLE;








--EJERCICIO 3--
--CREAR UN PROCEDIMIENTO QUE RECIBA UN EMP_ NO. CONTROLAR EXCEPCION SI EL OFICIO ES PRESIDENTE O SI EL APELLIDO ES GIL.-- 
-- MOSTRAR EL APELLIDO, OFICIO, EMP_NO Y SALARIO DEL EMPLEADO QUE SE HA PASADO POR TECLADO--


EXECUTE EJ3(7900);
EXECUTE EJ3(7788);
EXECUTE EJ3(7839);





--EJERCICIO 2--
--PROCEDIMIENTO QUE RECIBA UN EMP_NO. SI SU FECHA DE ALTA ES INFERIOR AL 1992, INCREMENTAR UN 10% SU SALARIO, DE LO CONTRARIO DISMINUIRLO UN 5%.--
--CONTROLAR EXCEPTION NO_DATA_FOUND. MOSTRAR EL ANTIGUO Y NUEVO SALARIO--


EXECUTE EJ2(7900);
EXECUTE EJ2(10101010);







--EJERCICIO 4-- 
--FUNCION QUE RECIBA COMO PARAMETRO UN NUMERO Y DEVUELVA SU CORRESPONDIENTE DIA DE LA SEMANA, DANDO POR HECHO QUE DOMINGO=1, LUNES=2 ETC ETC--


SELECT EJER4(5) FROM DUAL;
SELECT EJER4(8) FROM DUAL;








--EJERCICIO 5-- 
--MOSTRAR TODOS LOS NOMBRES DE LOS EMPLEADOS, SU EMP_NO Y EL NOMBRE DEL DEPARTAMENTO AL QUE PERTENECEN Y EL NUMERO TOTAL DE EMPLEADOS--








--EJERCICIO 7--
--CREAR UNA TABLE NUMEROS CON UNA COLUMNA COLUM1 DE TIPO NUMERO.--
--LLENAR LA TABLA DE NUMEROS DEL 1 AL 10 SIN EL 3 NI EL 8--
DROP TABLE NUMEROS;
CREATE TABLE NUMEROS (
	COLUM1 NUMBER
);



SELECT * FROM NUMEROS;



/*AÑADIR, Y REPITO: AÑADIR, NO CREAR DE NUEVO, UNA COLUMNA COLUMN2 DE TIPO NUMERO Y CREAR UN PROCEDIMIENTO QUE LLENE LA COLUM2 CON UN NUMERO
QUE ES LA POTENCIA CUADARADA DE SU CORRESPONDIENTE FILA*/
--DE 1 SERA 1--
--DE 2 SERA 4--
--DE 4 SERA 16--
--ETC--
ALTER TABLE NUMEROS ADD COLUM2 NUMBER;



EXECUTE LLENAR_COL2;
SELECT * FROM NUMEROS;
/*ERROR CON FOR LOOP*/
--ME DA ERROR DE QUE NO COINCIDE EL TIPO DE VARIABLE E INTUYO QUE SE DEBE AL TIPO DE VARIABLE QUE PUDIERA SER I; PERO NO TENGO IDEA SINCERAMENTE.--


--AHORA SOBRE ESTA TABLA NUEVAMENTE AÑADIR UNA NUEVA COLUMNA COLUM3 DE TIPO VARCHAR(10)--
--CREAR UN PROCEDIMIENTO QUE LLENE ESTA COLUMNA CON STRINGS DEPENDIENDO SI LA COLUM2 ES PAR O IMPAR--
--CON LOOP--
ALTER TABLE NUMEROS ADD COLUM3 VARCHAR(20);




EXECUTE LLENAR_COL3;
SELECT * FROM NUMEROS;


-- VARIANTE CON FOR LOOP-- 


EXECUTE LLENAR_COL3;
SELECT * FROM NUMEROS;









--EJERCICIO 8--
--CREAR UNA FUNCION QUE RECIBA UN NUMERO Y HAGA EL FACTORIAL DEL MISMO, ADEMAS QUE SE DEVUELVA EL PROCESO ARITMETICO QUE HACE. EJEMPLO:
--4!=4*3*2*1. RESULTADO: 24--


SELECT EJER8(5) FROM DUAL;







--EJERCICIO 8.1 (REVERTIR CADENA)--
--DADO UN STRING, REVIRTELO: "HOLA" -> "ALOH"--


EXECUTE EJER_CADENA('HOLA');









--EJERCICIO 9--
--MOSTRAR LO SIGUIENTE--
/*
DEPARTAMENTO: 10 CONTABILIDAD
---- 7782 CEREZO
---- 7934 MU?OZ
---- 7839 REY
DEPARTAMENTO: 20 INVESTIGACION
---- 7566 JIMENEZ
---- 7369 SANCHEZ
---- 7788 GIL
---- 7902 FERNANDEZ
---- 7876 ALONSO
DEPARTAMENTO: 30 VENTAS
---- 7521 SALA
---- 7844 TOVAR
---- 7499 ARROYO
---- 7900 JIMENO
---- 7654 MARTIN
---- 7698 NEGRO
DEPARTAMENTO: 40 PRODUCCION
----
*/
--UNION EN LA RELACION NATURAL, IMPORTATE--
/* CON UNION SACA LOS DEPARTS VACÍOS, SIN UNION NO*/
