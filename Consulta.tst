PL/SQL Developer Test script 3.0
79
   declare 
      vt_pesfelipe                         pk_efd_pesfelipe.t_tab_rec_pesfelipe;
      vt_cidade                            pk_cor_cidade.t_tab_rec_cidade;
      vt_paises                            pk_cor_paises.t_tab_rec_paises;
      vt_estado                            pk_cor_estado.t_tab_rec_estado;
      
      vv_cpf                               varchar2(20);
      vv_celular                           varchar2(20);
      vv_estado                            varchar2(20);
      vn_estado                              number(10); 
     
      
   begin
      pk_efd_pesfelipe.pkb_con ( en_pesfelipe_id => :en_pesfelipe_id
                               , en_cpf          => :en_cpf
                               , ev_nome         => :ev_nome
                               , en_celular      => :en_celular
                               , en_estado_civil => :en_estado_civil
                               , ev_endereco     => :ev_endereco
                               , en_nro          => :en_nro
                               , en_cidade_id    => :en_cidade_id
                               , ev_ordem        => 'nome'
                               , st_pesfelipe    =>  vt_pesfelipe
                               , sv_sistema      => :sv_sistema 
                               , sv_processo     => :sv_processo
                               , sv_msg_erro     => :sv_msg_erro
                               , sn_cd_erro      => :sn_cd_erro 
                               );
     
      if vt_pesfelipe.count > 0 then 
                           
         for i in vt_pesfelipe.first..vt_pesfelipe.last
         loop 

            vv_cpf := pk_efd_pesfelipe.fkg_cpf(vt_pesfelipe(i).cpf);  

            vv_celular := pk_efd_pesfelipe.fkg_cell(vt_pesfelipe(i).celular);
                              
            pk_cor_cidade.pkb_post_query2 ( en_cidade_id =>  vt_pesfelipe(i).cidade_id
                                          , st_cidade    =>  vt_cidade
                                          , SV_SISTEMA   => :sv_sistema 
                                          , sv_processo  => :sv_processo
                                          , sv_msg_erro  => :sv_msg_erro
                                          , sn_cd_erro   => :sn_cd_erro 
                                          );
                                        
            pk_cor_paises.pkb_post_query  ( en_paises_id =>  vt_cidade(1).pais_id
                                          , st_paises    =>  vt_paises
                                          , sv_sistema   => :sv_sistema 
                                          , sv_processo  => :sv_processo
                                          , sv_msg_erro  => :sv_msg_erro
                                          , sn_cd_erro   => :sn_cd_erro 
                                          );
                               
            pk_cor_estado.pkb_post_query ( en_estado_id =>  vt_cidade(1).estado_id
                                         , st_estado    =>  vt_estado 
                                         , sv_sistema   => :sv_sistema 
                                         , sv_processo  => :sv_processo
                                         , sv_msg_erro  => :sv_msg_erro
                                         , sn_cd_erro   => :sn_cd_erro 
                                         );
                           
            if vt_estado(1).descr = 'SANTA CATARINA' then
               dbms_output.put_line     ( 'Nome: '    || vt_pesfelipe(i).nome ||
                                        ', CPF: '     || vv_cpf || 
                                        ', Celular: ' || vv_celular ||
                                        ', Cidade: '  || vt_cidade(1).ci_descr ||
                                        ', Paises: '  || vt_paises(1).descr ||
                                        ', Estado: '  || vt_estado(1).descr
                                        );
                                     
            end if;            
         end loop; 
      else 
         Dbms_Output.Put_Line('Não Foram Encontrados Registros');
      end if;
   END;


13
en_pesfelipe_id
0
4
en_cpf
0
4
ev_nome
0
5
en_celular
0
4
en_estado_civil
0
3
ev_endereco
0
5
en_nro
0
3
en_cidade_id
0
4
ev_ordem
0
-5
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
