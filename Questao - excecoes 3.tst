PL/SQL Developer Test script 3.0
43
declare
  
   vt_cor_unid     pk_cor_unid.t_tab_rec_unid_con;
   vv_nome         varchar2(15);
   
begin
    
   PK_COR_UNID.PKB_CONSULTA( en_unid_id   => :en_unid_id
                           , en_empr_id   => :en_empr_id
                           , en_cd_unid   => :en_cd_unid
                           , en_sit       => :en_sit
                           , est_unid_con =>  vt_cor_unid
                           , sv_sistema   => :sv_sistema
                           , sv_processo  => :sv_processo
                           , sv_msg_erro  => :sv_msg_erro
                           , sn_cd_erro   => :sn_cd_erro
                            );
                            
   if vt_cor_unid.count > 0 then
      
      for i in vt_cor_unid.first..vt_cor_unid.last
      loop
         
         begin
            
            vv_nome := vt_cor_unid(i).nome;
            dbms_output.put_line('Nome da Unidade: ' || vv_nome || chr(10));
        
         exception
            when value_error then
               dbms_output.put_line('Ocorreu um erro aritmético, de conversão, de truncamento ou de restrição de tamanho.'); 
   
            when others then
               dbms_output.put_line('Ocorreu um erro ao executar a operação.');
               dbms_output.put_line('Código de erro: ' || sqlcode || ', Mensagem: ' || sqlerrm);
               
         end;
        
      end loop;
   
   end if;                       
  
end;
8
en_unid_id
0
4
en_empr_id
0
4
en_cd_unid
0
3
en_sit
0
3
sv_sistema
0
5
sv_processo
0
5
sv_msg_erro
0
5
sn_cd_erro
0
4
0
