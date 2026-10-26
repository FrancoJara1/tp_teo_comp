-- Limpiar tabla previa si es necesario
-- TRUNCATE TABLE glc_en_fnc;

-- 1. Estructura Principal y Símbolo Inicial (S)
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('S', 'SEL', 'X_FrWh');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('S', 'SEL', 'FR');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('X_FrWh', 'FR', 'WH');

-- 2. Cláusula SELECT
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('SEL', 'T_SELECT', 'COLLIST');

-- 3. Lista de Columnas y Columnas Individuales
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('COLLIST', 'COL', 'X_ComaCol');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('X_ComaCol', 'T_COMMA', 'COLLIST');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('COLLIST', 'T_ASTERISK', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('COLLIST', 'ABC', 'COL');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('COLLIST', 'ABC', NULL);

INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('COL', 'T_ASTERISK', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('COL', 'ABC', 'COL');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('COL', 'ABC', NULL);

-- 4. Cláusula FROM y Tablas
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('FR', 'T_FROM', 'TAB');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('TAB', 'ABC', 'TAB');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('TAB', 'ABC', NULL);

-- 5. Cláusula WHERE y Condiciones
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('WH', 'T_WHERE', 'Cond');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Cond', 'COLUM', 'X_OpVal');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('X_OpVal', 'Op', 'VAL');

-- 6. Operadores Relacionales
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Op', 'T_EQ', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Op', 'T_GT', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Op', 'T_LT', NULL);

-- 7. Valores, Números y Strings
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('VAL', 'Digito', 'NUM');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('VAL', 'D1_9', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('VAL', 'T_SQ', 'X_ValStr');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('X_ValStr', 'STRVAL', 'T_SQ');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('VAL', 'T_DQ', NULL);

INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('STR', 'T_SQ', 'X_StrVal2');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('X_StrVal2', 'STRVAL', 'T_SQ');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('STR', 'T_DQ', NULL);

INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('STRVAL', 'ABC', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('STRVAL', 'ABC', 'STRVAL');

INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('NUM', 'Digito', 'NUM');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('NUM', 'D1_9', NULL);

-- 8. Terminales y Tokens Base (Aislados en FNC)
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('T_SELECT', 'S', NULL); -- O mapeado al carácter/token literal
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('T_FROM', 'F', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('T_WHERE', 'W', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('T_ASTERISK', '*', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('T_COMMA', ',', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('T_EQ', '=', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('T_GT', '>', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('T_LT', '<', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('T_SQ', '''', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('T_DQ', '"', NULL);

-- 9. Dígitos y Letras (ABC)
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Digito', '0', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Digito', '1', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Digito', '2', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Digito', '3', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Digito', '4', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Digito', '5', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Digito', '6', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Digito', '7', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Digito', '8', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Digito', '9', NULL);

INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('D1_9', '1', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('D1_9', '2', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('D1_9', '3', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('D1_9', '4', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('D1_9', '5', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('D1_9', '6', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('D1_9', '7', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('D1_9', '8', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('D1_9', '9', NULL);

INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'A', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'B', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'C', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'D', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'E', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'F', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'G', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'H', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'I', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'J', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'K', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'L', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'M', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'N', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'O', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'P', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'Q', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'R', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'N', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'T', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'U', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'V', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'W', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'X', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'Y', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('ABC', 'Z', NULL);

INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('COLUM', 'ABC', 'COLUM');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('COLUM', 'ABC', NULL);