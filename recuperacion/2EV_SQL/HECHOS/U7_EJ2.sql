/*1. Añadir a la tabla PROFESORES una columna llamada COD_ASIG con dos posiciones numéricas.*/
ALTER TABLE PROFESORES ADD COD_ASIG NUMBER(2);

/*2. Crear la tabla TASIG con las siguientes columnas:COD_ASIG numérico, 2 posiciones y NOM_ASIG cadena de 20 caracteres.*/
DROP TABLE TASIG CASCADE CONSTRAINTS;
CREATE TABLE TASIG (
    COD_ASIG NUMBER(2),
    NOM_ASIG VARCHAR(20)
);

/*3. Añadir la restricción de clave primaria a la columna COD_ASIG  de la tabla anterior.*/
ALTER TABLE TASIG ADD CONSTRAINT PK_COD_ASIG PRIMARY KEY (COD_ASIG);

/*4. Añadir la restricción clave ajena a la columna COD_ASIG de la tabla PROFESORES.*/
ALTER TABLE PROFESORES ADD CONSTRAINT FK_COD_ASIG REFERENCES (COD_ASIG) ON DELETE CASCADE; /* ===???=== */

/*5. Cambiar el nombre de la tabla PROFESORES y llamarla PROFES.*/
ALTER TABLE PROFESORES RENAME PROFES; /* ===???=== */

/*6. Borrar la tabla TASIG.*/
DROP TABLE TASIG;

/*7. Devolver la tabla PROFESORES a su situación inicial.*/
ROLLBACK PROFES; /* ===???=== */









