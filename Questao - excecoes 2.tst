PL/SQL Developer Test script 3.0
25
DECLARE
   vn_soma number(10,2);
BEGIN
   
   for i in 0..10
   loop
      
      begin
         vn_soma := 10 / i;
         dbms_output.put_line( 10 || ' / ' || i || ' = ' || vn_soma || chr(10));
         
      exception
   
         when zero_divide then
            dbms_output.put_line('N�o � poss�vel dividir por zero'  );
    
         when others then
            dbms_output.put_line('Ocorreu um erro ao executar a opera��o.');
            dbms_output.put_line('C�digo de erro: ' || sqlcode || ', Mensagem: ' || sqlerrm);   
            
      end;
      
   end loop;
   
END;
0
0
