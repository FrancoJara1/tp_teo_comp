-- ==========================================================
-- TRABAJO PRÁCTICO: ALGORITMO CYK EN POSTGRESQL (PL/pgSQL)
-- ==========================================================

-- 1. Limpiar tablas anteriores
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


-- ==========================================================
-- 4. FUNCIONES PL/pgSQL
-- ==========================================================

create or replace function setear_matriz(p_fila int)
returns void as $$
declare
    v_cadena text;
    v_n int;
    v_i int;
    v_j int;
    v_k int;
    v_caracter text;
    v_vars_k1 text[];
    v_vars_k2 text[];
    v_prod record;
    v_encontradas text[];
begin
    select cadena into v_cadena from expresion_json limit 1;
    v_n := length(v_cadena);

    if p_fila = 1 then
        for v_i in 1..v_n loop
            v_caracter := substring(v_cadena from v_i for 1);
            v_encontradas := array[]::text[];

            for v_prod in 
                select parte_izq from glc_en_fnc 
                where tipo_produccion = 1 and parte_der1 = v_caracter
            loop
                if not (v_prod.parte_izq = any(v_encontradas)) then
                    v_encontradas := array_append(v_encontradas, v_prod.parte_izq);
                end if;
            end loop;

            if array_length(v_encontradas, 1) > 0 then
                insert into matriz_cyk (i, j, x) values (v_i, v_i, v_encontradas);
            end if;
        end loop;
    else
        for v_i in 1..(v_n - p_fila + 1) loop
            v_j := v_i + p_fila - 1;
            v_encontradas := array[]::text[];

            for v_k in v_i..(v_j - 1) loop
                select x into v_vars_k1 from matriz_cyk where i = v_i and j = v_k;
                select x into v_vars_k2 from matriz_cyk where i = v_k + 1 and j = v_j;

                if v_vars_k1 is not null and v_vars_k2 is not null then
                    for v_prod in 
                        select parte_izq from glc_en_fnc 
                        where tipo_produccion = 2 
                          and parte_der1 = any(v_vars_k1) 
                          and parte_der2 = any(v_vars_k2)
                    loop
                        if not (v_prod.parte_izq = any(v_encontradas)) then
                            v_encontradas := array_append(v_encontradas, v_prod.parte_izq);
                        end if;
                    end loop;
                end if;
            end loop;

            if array_length(v_encontradas, 1) > 0 then
                insert into matriz_cyk (i, j, x) values (v_i, v_j, v_encontradas);
            end if;
        end loop;
    end if;
end;
$$ language plpgsql;

create or replace function cyk(p_string text)
returns boolean as $$
declare
    v_n int;
    v_simbolo_inicial text;
    v_celda_final text[];
    v_f int;
begin
    truncate table matriz_cyk;
    delete from expresion_json;
    insert into expresion_json (cadena) values (p_string);

    v_n := length(p_string);
    if v_n = 0 then
        return false;
    end if;

    for v_f in 1..v_n loop
        perform setear_matriz(v_f);
    end loop;

    select x into v_celda_final from matriz_cyk where i = 1 and j = v_n;

    -- Verificar si 'S' (símbolo inicial) está presente en la celda superior
    if v_celda_final is not null and 'S' = any(v_celda_final) then
        return true;
    else
        return false;
    end if;
end;
$$ language plpgsql;
-- ----------------------------------------------------------
-- función pl/pgsql para mostrar la matriz cyk en formato de pirámide
-- ----------------------------------------------------------
create or replace function ver_matriz_piramide()
returns text as $$
declare
    v_cadena text;
    v_n int;
    v_l int; -- longitud (nivel de la pirámide)
    v_i int;
    v_j int;
    v_x text[];
    v_celda text;
    v_resultado text := '';
    v_fila_text text;
    v_ancho_celda int := 14;
    v_esp_izq int;
begin
    -- obtener la cadena actual evaluada
    select cadena into v_cadena from expresion_json limit 1;
    v_n := length(v_cadena);
    
    if v_n = 0 or v_cadena is null then
        return 'no hay ninguna cadena evaluada o la matriz está vacía.';
    end if;

    v_resultado := '=== pirámide de programación dinámica (cyk) ===' || e'\n\n';

    -- recorrer desde la longitud n (cima) hasta la longitud 1 (base)
    for v_l in reverse v_n..1 loop
        -- calcular el espacio izquierdo para dar forma de pirámide centrada
        v_esp_izq := (v_n - v_l) * (v_ancho_celda / 2);
        v_fila_text := repeat(' ', v_esp_izq) || 'l=' || rpad(v_l::text, 2) || '| ';

        for v_i in 1..(v_n - v_l + 1) loop
            v_j := v_i + v_l - 1;
            select x into v_x from matriz_cyk where i = v_i and j = v_j;
            
            if v_x is null then
                v_celda := '{ }';
            else
                v_celda := '{' || array_to_string(v_x, ',') || '}';
            end if;
            
            v_fila_text := v_fila_text || rpad(v_celda, v_ancho_celda) || ' ';
        end loop;

        v_resultado := v_resultado || v_fila_text || e'\n';
    end loop;

    -- agregar la leyenda de la cadena en la base
    v_resultado := v_resultado || e'\n' || '---------------------------------------------------' || e'\n';
    v_resultado := v_resultado || 'referencia de posiciones de la cadena:' || e'\n';
    for v_i in 1..v_n loop
        v_resultado := v_resultado || format('[%s: %s] ', v_i, substring(v_cadena from v_i for 1));
    end loop;
    v_resultado := v_resultado || e'\n';

    return v_resultado;
end;
$$ language plpgsql;

create or replace function ver_matriz_cyk2()
returns text as $$
declare
    v_cadena text;
    v_n int;
    v_i int;
    v_j int;
    v_x text[];
    v_celda text;
    v_resultado text := '';
    v_fila_text text;
    v_ancho_celda int := 12;
begin
    -- Obtener la cadena actual evaluada
    select cadena into v_cadena from expresion_json limit 1;
    v_n := length(v_cadena);
    
    if v_n = 0 or v_cadena is null then
        return 'No hay ninguna cadena evaluada o la matriz está vacía.';
    end if;

    v_resultado := '=== MATRIZ / TABLA DE PARSING CYK (Cuadrícula n x n) ===' || E'\n\n';

    -- Encabezado con las columnas (j) y sus caracteres correspondientes
    v_fila_text := rpad('i \\ j', 8) || ' | ';
    for v_j in 1..v_n loop
        v_fila_text := v_fila_text || rpad(format('%s (%s)', v_j, substring(v_cadena from v_j for 1)), v_ancho_celda) || ' ';
    end loop;
    v_resultado := v_resultado || v_fila_text || E'\n';
    v_resultado := v_resultado || repeat('-', length(v_fila_text)) || E'\n';

    -- Filas de la matriz (i desde 1 hasta n)
    for v_i in 1..v_n loop
        v_fila_text := rpad(format('i = %s', v_i), 8) || ' | ';
        for v_j in 1..v_n loop
            if v_j < v_i then
                -- Mitad inferior de la matriz (no utilizada en CYK)
                v_celda := '-';
            else
                -- Buscar el conjunto de variables en la matriz CYK
                select x into v_x from matriz_cyk where i = v_i and j = v_j;
                if v_x is null then
                    v_celda := '{ }';
                else
                    v_celda := '{' || array_to_string(v_x, ',') || '}';
                end if;
            end if;
            v_fila_text := v_fila_text || rpad(v_celda, v_ancho_celda) || ' ';
        end loop;
        v_resultado := v_resultado || v_fila_text || E'\n';
    end loop;

    v_resultado := v_resultado || E'\n' || 'Cadena evaluada: ' || v_cadena || E'\n';
    return v_resultado;
end;
$$ language plpgsql;


-- ==========================================================
-- instrucciones de uso
-- ==========================================================
-- 1. ejecuta tu algoritmo:
--    select cyk('{"a":'b'}');
--
-- 2. visualiza la pirámide ejecutando:
--    select ver_matriz_piramide();