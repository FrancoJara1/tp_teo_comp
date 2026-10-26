drop table if exists glc_en_fnc cascade;
drop table if exists matriz_cyk cascade;
drop table if exists expresion_json cascade;

-- 2. Crear tablas obligatorias
create table glc_en_fnc (
    start boolean default false,
    parte_izq text not null,
    parte_der1 text not null,
    parte_der2 text,
    tipo_produccion smallint not null -- 1: Var->terminal, 2: Var->Var1Var2
);

create table matriz_cyk (
    i smallint,
    j smallint,
    x text[]
);

create table expresion_json (
    cadena text
);

-- ==========================================================
-- 3. INSERTS DE PRODUCCIONES EN FNC
-- ==========================================================

-- Símbolo Inicial (S)
-- Maneja:
--   - Objeto vacío: {}  -> LLAVEI LLAVED
--   - Objeto con 1 sola propiedad: {"a":'b'} -> LLAVEI X7 (donde X7 -> C LLAVED)
--   - Objeto con múltiples propiedades: {"a":'b',"c":1} -> LLAVEI X1 (donde X1 -> B LLAVED)
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values
(true, 'S', 'LLAVEI', 'LLAVED', 2),
(true, 'S', 'LLAVEI', 'X7', 2),
(true, 'S', 'LLAVEI', 'X1', 2);

-- Producciones estructurales principales
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values
(false, 'X7', 'C', 'LLAVED', 2),        -- Para objetos de 1 sola propiedad
(false, 'X1', 'B', 'LLAVED', 2),        -- Para objetos de 2 o más propiedades
(false, 'B', 'C', 'G', 2),
(false, 'X2', 'DOSP', 'E', 2),
(false, 'C', 'F', 'X2', 2),
(false, 'X3', 'STRS', 'COMILLAS', 2),
(false, 'X5', 'STRD', 'COMILLASD', 2),
(false, 'F', 'COMILLASD', 'X5', 2),
(false, 'X4', 'C', 'G', 2),
(false, 'G', 'COMA', 'X4', 2),
(false, 'G', 'COMA', 'C', 2);

-- Producciones binarias de E (Strings, Números y Objetos anidados)
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values
(false, 'E', 'COMILLAS', 'X3', 2),
(false, 'E', 'COMILLAS', 'COMILLAS', 2),
(false, 'E', 'LLAVEI', 'LLAVED', 2),     -- Objeto anidado vacío
(false, 'E', 'LLAVEI', 'X7', 2),         -- Objeto anidado de 1 propiedad
(false, 'E', 'LLAVEI', 'X1', 2),         -- Objeto anidado de múltiples propiedades
(false, 'E', 'DIGITO', 'N', 2);          -- Número de varios dígitos

-- Producción recursiva de N (DIGITO N)
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values
(false, 'N', 'DIGITO', 'N', 2);

-- Producciones recursivas de Cadenas (ABC STRS / ABC STRD)
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values
(false, 'STRS', 'ABC', 'STRS', 2),
(false, 'STRD', 'ABC', 'STRD', 2);

-- Terminales Estructurales (Tipo 1)
insert into glc_en_fnc (start, parte_izq, parte_der1, tipo_produccion) values
(false, 'LLAVEI', '{', 1),
(false, 'LLAVED', '}', 1),
(false, 'DOSP', ':', 1),
(false, 'COMILLAS', '''', 1),  -- Comilla simple recta
(false, 'COMILLAS', '‘', 1),   -- Comilla simple curva izq
(false, 'COMILLAS', '’', 1),   -- Comilla simple curva der
(false, 'COMILLASD', '"', 1),
(false, 'COMA', ',', 1);

-- Dígitos directos para E (0 al 9)
insert into glc_en_fnc (start, parte_izq, parte_der1, tipo_produccion) values
(false, 'E', '0', 1), (false, 'E', '1', 1), (false, 'E', '2', 1), (false, 'E', '3', 1), (false, 'E', '4', 1),
(false, 'E', '5', 1), (false, 'E', '6', 1), (false, 'E', '7', 1), (false, 'E', '8', 1), (false, 'E', '9', 1);

-- Dígitos para DIGITO (0 al 9)
insert into glc_en_fnc (start, parte_izq, parte_der1, tipo_produccion) values
(false, 'DIGITO', '0', 1), (false, 'DIGITO', '1', 1), (false, 'DIGITO', '2', 1), (false, 'DIGITO', '3', 1), (false, 'DIGITO', '4', 1),
(false, 'DIGITO', '5', 1), (false, 'DIGITO', '6', 1), (false, 'DIGITO', '7', 1), (false, 'DIGITO', '8', 1), (false, 'DIGITO', '9', 1);

-- Dígitos terminales para N (0 al 9)
insert into glc_en_fnc (start, parte_izq, parte_der1, tipo_produccion) values
(false, 'N', '0', 1), (false, 'N', '1', 1), (false, 'N', '2', 1), (false, 'N', '3', 1), (false, 'N', '4', 1),
(false, 'N', '5', 1), (false, 'N', '6', 1), (false, 'N', '7', 1), (false, 'N', '8', 1), (false, 'N', '9', 1);

-- Alfabeto completo para minúsculas y mayúsculas
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