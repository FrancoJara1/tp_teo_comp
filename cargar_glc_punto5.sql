-- Limpiar tabla previa si es necesario
TRUNCATE TABLE glc_en_fnc;

-- 1. Símbolo Inicial y Expresiones Aritméticas (A)
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', 'A', 'Suma');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', 'A', 'Resta');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', 'A', 'Mul');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', 'A', 'Div');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', 'Simbolo_Pari', 'anid');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', 'Digito', 'N');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', '0', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', '1', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', '2', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', '3', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', '4', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', '5', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', '6', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', '7', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', '8', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('A', '9', NULL);

-- 2. Variables Auxiliares Binarias (Operadores y Paréntesis)
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Suma', 'simbolo_mas', 'A');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Resta', 'simbolo_menos', 'A');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Mul', 'simbolo_mul', 'A');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Div', 'simbolo_div', 'A');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('anid', 'A', 'Simbolo_Pard');

-- 3. Números de Múltiples Cifras (N)
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('N', 'Digito', 'N');
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('N', '0', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('N', '1', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('N', '2', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('N', '3', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('N', '4', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('N', '5', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('N', '6', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('N', '7', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('N', '8', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('N', '9', NULL);

-- 4. Terminales de Operadores y Paréntesis
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('simbolo_mas', '+', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('simbolo_menos', '-', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('simbolo_mul', '*', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('simbolo_div', '/', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Simbolo_Pari', '(', NULL);
INSERT INTO glc_en_fnc (no_terminal, prod1, prod2) VALUES ('Simbolo_Pard', ')', NULL);

-- 5. Dígitos (0 - 9)
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