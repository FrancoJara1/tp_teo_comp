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

create table matriz_cyk(
	i smallint,
	j smallint,
	x[] text
);

create table expression_json(
	id serial primary key,
	cadena text
);
