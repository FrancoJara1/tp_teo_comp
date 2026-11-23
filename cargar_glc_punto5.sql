-- Limpiar tabla previa si es necesario
truncate table glc_en_fnc;

-- 1. Símbolo Inicial y Expresiones Aritméticas (S) -> start = true
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', 'S', 'Suma', 2);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', 'S', 'Resta', 2);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', 'S', 'Mul', 2);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', 'S', 'Div', 2);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', 'Simbolo_Pari', 'anid', 2);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', 'Digito', 'N', 2);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', '0', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', '1', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', '2', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', '3', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', '4', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', '5', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', '6', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', '7', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', '8', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (true, 'S', '9', null, 1);

-- 2. Variables Auxiliares Binarias (Operadores y Paréntesis)
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Suma', 'simbolo_mas', 'S', 2);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Resta', 'simbolo_menos', 'S', 2);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Mul', 'simbolo_mul', 'S', 2);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Div', 'simbolo_div', 'S', 2);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'anid', 'S', 'Simbolo_Pard', 2);

-- 3. Números de Múltiples Cifras (N)
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'N', 'Digito', 'N', 2);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'N', '0', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'N', '1', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'N', '2', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'N', '3', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'N', '4', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'N', '5', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'N', '6', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'N', '7', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'N', '8', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'N', '9', null, 1);

-- 4. Terminales de Operadores y Paréntesis
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'simbolo_mas', '+', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'simbolo_menos', '-', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'simbolo_mul', '*', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'simbolo_div', '/', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Simbolo_Pari', '(', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Simbolo_Pard', ')', null, 1);

-- 5. Dígitos (0 - 9)
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Digito', '0', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Digito', '1', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Digito', '2', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Digito', '3', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Digito', '4', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Digito', '5', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Digito', '6', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Digito', '7', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Digito', '8', null, 1);
insert into glc_en_fnc (start, parte_izq, parte_der1, parte_der2, tipo_produccion) values (false, 'Digito', '9', null, 1);