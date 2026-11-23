create or replace function test_cyk()
returns void as $$
declare 
  resultado boolean;
Begin
  Raise notice 'Iniciando los tests de parsing del CYK...';
--Test 1: JSON vacio.
resultado := cyk('{}');
if not resultado then 
  raise notice 'Test 1 fallo: Se esperaba que si lo acepte';
else
  raise notice 'Test 1 correcto: JSON aceptado.';
end if;

--Test 2: JSON anidado
resultado:= cyk('{"a":1,"b":''h'',"c":{"d":''c'',"e":9}}');
if not resultado then
   raise notice 'Test 2 fallo: Se esperaba que si lo acepte.';
else
   raise notice 'Test 2 correcto: JSON aceptado.';
end if;


--Test 3: JSON con terminacion en ,(COMA).
resultado:= cyk('{"a":12,"f":''a'',}');
if not resultado then
   raise notice 'Test 3 correcto: no acepta terminacion con coma.';
else
   raise notice 'Test 3 fallo: Se esperaba que no lo acepte.';
end if;


--Test 4: JSON anidado vacio sin clave.
resultado:= cyk('{"a":12,"f":''a'',{}}');
if not resultado then
   raise notice 'Test 4 correcto: no acepta anidacion sin clave.'; 
else
   raise notice 'Test 4 fallo: Se esperaba que no lo acepte.';
end if;


raise notice 'Tests finalizados.';
end;
$$ language plpgsql
