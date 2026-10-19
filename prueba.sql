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
(true, 's', 'llavei', 'x1', 2),
(true, 's', 'llavei', 'llaved', 2);

-- producciones auxiliares y de estructura principal
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values
(false, 'x1', 'b', 'llaved', 2),
(false, 'b', 'c', 'g', 2),
(false, 'x2', 'dosp', 'e', 2),
(false, 'c', 'f', 'x2', 2),
(false, 'x3', 'strs', 'comillas', 2),
(false, 'x5', 'strd', 'comillasd', 2),
(false, 'f', 'comillasd', 'x5', 2),
(false, 'x4', 'c', 'g', 2),
(false, 'g', 'coma', 'x4', 2),
(false, 'g', 'coma', 'c', 2);

-- producciones de e (valores)
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values
(false, 'e', 'comillas', 'x3', 2),
(false, 'e', 'comillas', 'comillas', 2),
(false, 'e', 'llavei', 'x1', 2),
(false, 'e', 'llavei', 'llaved', 2);

-- producciones recursivas de numeros y cadenas
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values
(false, 'n', 'digito', 'n', 2),
(false, 'strs', 'abc', 'strs', 2),
(false, 'strd', 'abc', 'strd', 2);


-- 3. cargar producciones del tipo 1: var -> terminal (tipo_produccion = 1)

-- terminales especiales (tokens sintacticos)
insert into glc_en_fnc (start, parte_izq, parte_der1, tipo_produccion) values
(false, 'llavei', '{', 1),
(false, 'llaved', '}', 1),
(false, 'dosp', ':', 1),
(false, 'comillas', '''', 1),
(false, 'comillasd', '"', 1),
(false, 'coma', ',', 1);

-- terminales de digitos (para digito y n)
insert into glc_en_fnc (start, parte_izq, parte_der1, tipo_produccion) values
(false, 'digito', '0', 1), (false, 'digito', '1', 1), (false, 'digito', '2', 1), (false, 'digito', '3', 1), (false, 'digito', '4', 1),
(false, 'digito', '5', 1), (false, 'digito', '6', 1), (false, 'digito', '7', 1), (false, 'digito', '8', 1), (false, 'digito', '9', 1),
(false, 'n', '0', 1), (false, 'n', '1', 1), (false, 'n', '2', 1), (false, 'n', '3', 1), (false, 'n', '4', 1),
(false, 'n', '5', 1), (false, 'n', '6', 1), (false, 'n', '7', 1), (false, 'n', '8', 1), (false, 'n', '9', 1);

-- terminales de alfabeto (minusculas 97-122 y mayusculas 65-90 para abc, strs y strd)
insert into glc_en_fnc (start, parte_izq, parte_der1, tipo_produccion)
select false, 'abc', chr(i), 1 from generate_series(97, 122) i
union all
select false, 'abc', chr(i), 1 from generate_series(65, 90) i;

insert into glc_en_fnc (start, parte_izq, parte_der1, tipo_produccion)
select false, 'strs', chr(i), 1 from generate_series(97, 122) i
union all
select false, 'strs', chr(i), 1 from generate_series(65, 90) i;

insert into glc_en_fnc (start, parte_izq, parte_der1, tipo_produccion)
select false, 'strd', chr(i), 1 from generate_series(97, 122) i
union all
select false, 'strd', chr(i), 1 from generate_series(65, 90) i;


create table matriz_cyk(
	i smallint,
	j smallint,
	x[] text
);

create table expression_json(
	id serial primary key,
	cadena text
);
