PL/SQL Developer Test script 3.0
35
declare

  vn_cd   unid.cd%type;
  vv_name unid.nome%type;
  
begin
   
  for i in 1..10 
  loop
     
     begin
      
        select cd
             , nome 
          into vn_cd
             , vv_name 
          from unid 
         where unid.cd = i;
        
         dbms_output.put_line('CD: ' || vn_cd || ', Nome: ' || vv_name);
      
     exception
       
        when no_data_found then
           dbms_output.put_line('Nenhum registro encontrado para o código ' || i);
        
        when others then
           dbms_output.put_line('Ocorreu um erro ao executar a operação.');
           dbms_output.put_line('Código de erro: ' || sqlcode || ', Mensagem: ' || sqlerrm);
           
    end;
    
  end loop;
  
end;
0
0
