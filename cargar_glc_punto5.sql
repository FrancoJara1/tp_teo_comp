-- Limpiar tabla previa si es necesario
TRUNCATE TABLE GLC_en_FNC;

-- 1. Símbolo Inicial y Expresiones Aritméticas (S) -> start = TRUE
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', 'S', 'Suma', 2);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', 'S', 'Resta', 2);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', 'S', 'Mul', 2);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', 'S', 'Div', 2);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', 'Simbolo_Pari', 'anid', 2);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', 'Digito', 'N', 2);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', '0', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', '1', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', '2', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', '3', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', '4', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', '5', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', '6', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', '7', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', '8', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (TRUE, 'S', '9', NULL, 1);

-- 2. Variables Auxiliares Binarias (Operadores y Paréntesis)
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Suma', 'simbolo_mas', 'S', 2);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Resta', 'simbolo_menos', 'S', 2);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Mul', 'simbolo_mul', 'S', 2);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Div', 'simbolo_div', 'S', 2);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'anid', 'S', 'Simbolo_Pard', 2);

-- 3. Números de Múltiples Cifras (N)
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'N', 'Digito', 'N', 2);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'N', '0', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'N', '1', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'N', '2', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'N', '3', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'N', '4', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'N', '5', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'N', '6', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'N', '7', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'N', '8', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'N', '9', NULL, 1);

-- 4. Terminales de Operadores y Paréntesis
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'simbolo_mas', '+', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'simbolo_menos', '-', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'simbolo_mul', '*', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'simbolo_div', '/', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Simbolo_Pari', '(', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Simbolo_Pard', ')', NULL, 1);

-- 5. Dígitos (0 - 9)
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Digito', '0', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Digito', '1', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Digito', '2', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Digito', '3', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Digito', '4', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Digito', '5', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Digito', '6', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Digito', '7', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Digito', '8', NULL, 1);
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion) VALUES (FALSE, 'Digito', '9', NULL, 1);