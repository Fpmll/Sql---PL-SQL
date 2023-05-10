PL/SQL Developer Test script 3.0
65
declare
 
  vt_docfisefd_merc    pk_efd_docfisefd.t_tab_rec_docfisefd_merc;
  vn_vlr               number(4,2);
  vv_nome              varchar2(100);
  
begin

   PK_EFD_DOCFISEFD.PKB_CON_MERC( en_docfisefd_id   => :en_docfisefd_id
                                , en_efdescrit_id   => :en_efdescrit_id
                                , en_efdunid_id     => :en_efdunid_id
                                , en_modespedtv_id  => :en_modespedtv_id
                                , en_unid_id_princ  => :en_unid_id_princ
                                , en_unid_cd        =>  44
                                , en_nfen_id        => :en_nfen_id
                                , en_nfsa_id        => :en_nfsa_id
                                , en_ind_oper       => :en_ind_oper
                                , en_ind_emit       => :en_ind_emit
                                , ev_cd_particip    => :ev_cd_particip
                                , ev_modelo         => :ev_modelo
                                , en_tpsidoctsp_id  => :en_tpsidoctsp_id
                                , ev_tpsidoctsp_cd  => :ev_tpsidoctsp_cd
                                , ev_serie          => :ev_serie
                                , en_nro_docto      => :en_nro_docto
                                , ev_chave          => :ev_chave
                                , ed_dt_emiss       => :ed_dt_emiss
                                , ed_dt_entr_saida  => :ed_dt_entr_saida
                                , en_ind_pagto      => :en_ind_pagto
                                , en_ind_frete      => :en_ind_frete
                                , ev_ordem          => :ev_ordem
                                , st_docfisefd_merc =>  vt_docfisefd_merc
                                , sv_sistema        => :sv_sistema
                                , sv_processo       => :sv_processo
                                , sv_msg_erro       => :sv_msg_erro
                                , sn_cd_erro        => :sn_cd_erro
                                 );
                                 
   if vt_docfisefd_merc.count > 0 then
      
      for i in vt_docfisefd_merc.first..vt_docfisefd_merc.last
      loop 
         
         begin   
            
            vn_vlr := vt_docfisefd_merc(i).vlr_docto;
            dbms_output.put_line('Valor Documento: ' || vn_vlr);
        
         exception
            
            when value_error then
               dbms_output.put_line('Ocorreu um erro aritmético, de conversão, de truncamento ou de restrição de tamanho na variável VN_VLR' ); 
               exit;
               
            when others then
               dbms_output.put_line('Ocorreu um erro ao executar a operação.');
               dbms_output.put_line('Código de erro: ' || sqlcode || ', Mensagem: ' || sqlerrm);  
               exit;
                
         end;
         
      end loop;
      
   end if; 
                
end;
26
en_docfisefd_id
0
4
en_efdescrit_id
0
4
en_efdunid_id
0
4
en_modespedtv_id
0
4
en_unid_id_princ
0
4
en_unid_cd
0
-3
en_nfen_id
0
4
en_nfsa_id
0
4
en_ind_oper
0
3
en_ind_emit
0
3
ev_cd_particip
0
5
ev_modelo
0
5
en_tpsidoctsp_id
0
4
ev_tpsidoctsp_cd
0
5
ev_serie
0
5
en_nro_docto
0
4
ev_chave
0
5
ed_dt_emiss
0
12
ed_dt_entr_saida
0
12
en_ind_pagto
0
3
en_ind_frete
0
3
ev_ordem
0
5
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
