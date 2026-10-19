drop table if exists glc_en_fnc;
drop table if exists matriz_cyk;
drop table if exists expresion_json;


create table glc_en_fnc(
	start boolean,
	parte_izq text,
	parte_der1 text,
	parte_der2 text,
	tipo_produccion smallint  -- 1 indica Var→terminal, 2 indica Var→ Var1Var2
);
-- limpiar la tabla antes de cargar datos
truncate table glc_en_fnc;

-- 2. cargar producciones del tipo 2: var -> var1 var2 (tipo_produccion = 2)

-- producciones de s (simbolo inicial)
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values
(true, 'S', 'LLAVEI', 'X1', 2),
(true, 'S', 'LLAVEI', 'LLAVED', 2);

-- producciones auxiliares y de estructura principal
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values
(false, 'X1', 'B', 'LLAVED', 2),
(false, 'B', 'C', 'G', 2),
(false, 'X2', 'DOSP', 'E', 2),
(false, 'C', 'F', 'X2', 2),
(false, 'X3', 'STRS', 'COMILLAS', 2),
(false, 'X5', 'STRD', 'COMILLASD', 2),
(false, 'F', 'COMILLASD', 'X5', 2),
(false, 'X4', 'C', 'G', 2),
(false, 'G', 'COMA', 'X4', 2),
(false, 'G', 'COMA', 'C', 2);

-- producciones de e (valores)
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values
(false, 'E', 'COMILLAS', 'X3', 2),
(false, 'E', 'COMILLAS', 'COMILLAS', 2),
(false, 'E', 'LLAVEI', 'X1', 2),
(false, 'E', 'LLAVEI', 'LLAVED', 2);

-- producciones recursivas de numeros y cadenas
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values
(false, 'N', 'DIGITO', 'N', 2),
(false, 'STRS', 'ABC', 'STRS', 2),
(false, 'STRD', 'ABC', 'STRD', 2);


-- 3. cargar producciones del tipo 1: var -> terminal (tipo_produccion = 1)

-- terminales especiales (tokens sintacticos)
insert into glc_en_fnc (start, parte_izq, parte_der1, tipo_produccion) values
(false, 'LLAVEI', '{', 1),
(false, 'LLAVED', '}', 1),
(false, 'DOSP', ':', 1),
(false, 'COMILLAS', '''', 1),
(false, 'COMILLASD', '"', 1),
(false, 'COMA', ',', 1);

-- terminales de digitos (para digito y n)
insert into glc_en_fnc (start, parte_izq, parte_der1, tipo_produccion) values
(false, 'DIGITO', '0', 1), (false, 'DIGITO', '1', 1), (false, 'DIGITO', '2', 1), (false, 'DIGITO', '3', 1), (false, 'DIGITO', '4', 1),
(false, 'DIGITO', '5', 1), (false, 'DIGITO', '6', 1), (false, 'DIGITO', '7', 1), (false, 'DIGITO', '8', 1), (false, 'DIGITO', '9', 1),
(false, 'N', '0', 1), (false, 'N', '1', 1), (false, 'N', '2', 1), (false, 'N', '3', 1), (false, 'N', '4', 1),
(false, 'N', '5', 1), (false, 'N', '6', 1), (false, 'N', '7', 1), (false, 'N', '8', 1), (false, 'N', '9', 1);

-- terminales de alfabeto (minusculas 97-122 y mayusculas 65-90 para abc, strs y strd)
insert into glc_en_fnc (start, parte_izq, parte_der1, tipo_produccion)
select false, 'ABC', chr(i), 1 from generate_series(97, 122) i
union all
select false, 'ABC', chr(i), 1 from generate_series(65, 90) i;

insert into glc_en_fnc (start, parte_izq, parte_der1, tipo_produccion)
select false, 'STRS', chr(i), 1 from generate_series(97, 122) i
union all
select false, 'STRS', chr(i), 1 from generate_series(65, 90) i;

insert into glc_en_fnc (start, parte_izq, parte_der1, tipo_produccion)
select false, 'STRD', chr(i), 1 from generate_series(97, 122) i
union all
select false, 'STRD', chr(i), 1 from generate_series(65, 90) i;


create table matriz_cyk(
	i smallint,
	j smallint,
	x[] text
);

create table expression_json(
	id serial primary key,
	cadena text
);
