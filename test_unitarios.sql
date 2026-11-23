create or replace function test_cyk()
return void as $$
declare 
  result boolean;
Begin
  Raise notice 'Iniciando los tests de parsing del CYK...';

result := cyk('{}');
if not result then 
  raise notice 'Test 1 fallo: Se esperaba que si lo acepte';
else
  raise notice 'Test 1 correcta: JSON aceptado';
end if;
