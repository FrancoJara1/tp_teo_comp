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
