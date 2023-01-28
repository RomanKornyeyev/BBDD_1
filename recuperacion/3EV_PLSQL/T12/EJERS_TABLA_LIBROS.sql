/*primero eliminar la tabla*/
drop table libros12;

/*volver a crear la tabla*/
create table libros12(
    codigo number(3),
    titulo varchar2(50),
    autor varchar2(80),
    precio number(5,2)
);

/*inserts*/
insert into libros12 values(100,'Uno','Richard Bach',15);
insert into libros12 values(300,'Aprenda PHP','Mario Molina',55);
insert into libros12 values(102,'Matematica estas ahi','Paenza',18);
insert into libros12 values(105,'El aleph','Borges',25);
insert into libros12 values(109,'El experto en laberintos','Gaskin',20);
insert into libros12 values(204,'Alicia en el pais de las maravillas','Carroll',31);
commit;


/* Creamos una función que reciba 1 parámetro (un valor numérico a incrementar) y retorne el valor ingresado como argumento con el incremento del 10%. */
CREATE OR REPLACE FUNCTION INCREMENTAR10(NUM NUMBER) RETURN NUMBER
IS
BEGIN
	RETURN (NUM*1.10);
END;
/
SELECT INCREMENTAR10(100) FROM DUAL;


/* Realizamos un "select" sobre "libros" que muestre el título, precio y llamamos a la función creada anteriormente para que nos
devuelva el precio incrementado en un 10%.*/
SELECT TITULO, PRECIO, INCREMENTAR10(PRECIO) "PRECIO INCREMENTADO 10%" FROM LIBROS12;

/* Creamos otra función que reciba 2 parámetros, un valor a incrementar y el incremento, y que nos retorne el valor ingresado
como primer argumento con el incremento especificado por el segundo argumento.*/
CREATE OR REPLACE FUNCTION N_INCREMENTADOR(BASE NUMBER, INCREMENTADOR NUMBER) RETURN NUMBER
IS
BEGIN
	RETURN (BASE + BASE * (INCREMENTADOR/100));
END;
/
SELECT N_INCREMENTADOR(100,15) FROM DUAL;


/* Realizamos un "select" sobre "libros" que muestre el título, precio y el precio
incrementado en un 20% (llamando a la función creada anteriormente,
enviando como primer argumento el campo "precio" y como segundo argumento el valor "20"). */
SELECT TITULO, PRECIO, N_INCREMENTADOR(PRECIO, 20) "PRECIO INCREMENTADO 20%" FROM LIBROS12;

/* Realizamos otro "select" similar al anterior, pero en esta ocasión le enviamos a la función otro valor como segundo argumento. */
SELECT TITULO, PRECIO, N_INCREMENTADOR(PRECIO, 15) "PRECIO INCREMENTADO 15%" FROM LIBROS12;

/* Creamos o reemplazamos una función que recibe un parámetro de tipo numérico
y retorna una cadena de caracteres.
Se define una variable en la zona de definición de variables denominada "valorretornado" de tipo varchar.
En el cuerpo de la función empleamos una estructura condicional (if) para averiguar
si el valor enviado como argumento es menor o igual a 20,
si lo es, almacenamos en la variable "valorretornado" la cadena "economico",
en caso contrario guardamos en tal variable la cadena "costoso";
al finalizar la estructura condicional retornamos la variable "valorretornado":
 */
CREATE OR REPLACE FUNCTION CONVERTIDOR(NUM NUMBER) RETURN VARCHAR
IS
	VALORRETORNADO VARCHAR(10);
BEGIN
	IF NUM <= 20 THEN
		VALORRETORNADO := 'ECONÓMICO';
	ELSE
		VALORRETORNADO := 'COSTOSO';
	END IF;
	RETURN VALORRETORNADO;
END;
/
 

/* Realizamos un "select" para mostrar el título, precio y una cadena que indique si el libro es económico o costoso
(llamando a la función creada anteriormente). */
SELECT TITULO, PRECIO, CONVERTIDOR(PRECIO)"¿ES CARO?" FROM LIBROS12;