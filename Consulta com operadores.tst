PL/SQL Developer Test script 3.0
145
 declare

   vt_docfisefd_merc                                    pk_efd_docfisefd.t_tab_rec_docfisefd_merc;
   vt_tpsidoctsp                                        pk_efd_tpsidoctsp.t_tab_rec_tpsidoctsp;
   vt_itdocfiefd                                        pk_efd_itdocfiefd.t_tab_rec_itdocfiefd;
   vn_total                                             number(30,2) := 0;
   vn_percentual                                        docto_fiscal_efd.vlr_docto%type;
   vn_qtde                                              number(30,2) := 0;
   vn_percentual_item                                   docto_fiscal_efd.vlr_docto%type;
   vt_itdocfiefd_item                                   pk_efd_itdocfiefd.t_tab_rec_itdocfiefd;
   
   type t_rec_docto     is record ( docfisefd_id        docto_fiscal_efd.docfisefd_id%type
                                  , cd_particip         docto_fiscal_efd.cd_particip%type
                                  , modelo              docto_fiscal_efd.modelo%type 
                                  , serie               docto_fiscal_efd.serie%type
                                  , nro_docto           docto_fiscal_efd.nro_docto%type
                                  , cd                  tp_sit_docto_tecn_sped.cd%type
                                  , descr               tp_sit_docto_tecn_sped.descr%type
                                  , dt_emiss            docto_fiscal_efd.dt_emiss%type
                                  , dt_entr_saida       docto_fiscal_efd.dt_entr_saida%type
                                  , vlr_docto           docto_fiscal_efd.vlr_docto%type
                                  , qtde_items          number(16,2)
                                  );
                                  
   type t_tab_rec_docto is table of t_rec_docto index by binary_integer;
   vt_docto             t_tab_rec_docto;
   
begin
 
   pk_efd_docfisefd.pkb_con_merc( en_efdescrit_id   =>  pk_efd_efdescrit.fkg_id('01-mar-23','31-mar-23')                  
                                , en_efdunid_id     =>  pk_efd_efdunid.fkg_id(null,45,sysdate)
                                , en_ind_oper       =>  1
                                , ev_ordem          =>  'dt_entr_saida'
                                , st_docfisefd_merc =>  vt_docfisefd_merc
                                , sv_sistema        => :sv_sistema
                                , sv_processo       => :sv_processo
                                , sv_msg_erro       => :sv_msg_erro
                                , sn_cd_erro        => :sn_cd_erro
                                );
   
   if  vt_docfisefd_merc.count > 0 then
      for i in  vt_docfisefd_merc.first..vt_docfisefd_merc.last
      loop                            
         vn_qtde := 0;                   
         pk_efd_tpsidoctsp.pkb_postquer ( en_tpsidoctsp_id =>  vt_docfisefd_merc(i).tpsidoctsp_id
                                        , st_tpsidoctsp    =>  vt_tpsidoctsp  
                                        , sv_sistema       => :sv_sistema   
                                        , sv_processo      => :sv_processo   
                                        , sv_msg_erro      => :sv_msg_erro   
                                        , sn_cd_erro       => :sn_cd_erro
                                        );
                                       
         /*Dbms_Output.Put_Line('Descrição_ID: '         || vt_docfisefd_merc(i).docfisefd_id  || chr(10)||
                              'Codigo do Participante: ' || vt_docfisefd_merc(i).cd_particip   || chr(10)||
                              'Modelo: '                 || vt_docfisefd_merc(i).modelo        || chr(10)||
                              'Serie: '                  || vt_docfisefd_merc(i).serie         || chr(10)||
                              'Nro Documento: '          || vt_docfisefd_merc(i).nro_docto     || chr(10)||
                              'Codigo: '                 || vt_tpsidoctsp(1).cd                || chr(10)||
                              'Descrição: '              || vt_tpsidoctsp(1).descr             || chr(10)||
                              'Emiss: '                  || vt_docfisefd_merc(i).dt_emiss      || chr(10)||
                              'Ent-Sai: '                || vt_docfisefd_merc(i).dt_entr_saida || chr(10)||
                              'Valor: '                  || vt_docfisefd_merc(i).vlr_docto     || chr(10)
                              );*/
       
         vt_docto(i).docfisefd_id  := vt_docfisefd_merc(i).docfisefd_id;
         vt_docto(i).cd_particip   := vt_docfisefd_merc(i).cd_particip;
         vt_docto(i).modelo        := vt_docfisefd_merc(i).modelo;
         vt_docto(i).serie         := vt_docfisefd_merc(i).serie;
         vt_docto(i).nro_docto     := vt_docfisefd_merc(i).nro_docto;
         vt_docto(i).cd            := vt_tpsidoctsp(1).cd;
         vt_docto(i).descr         := vt_tpsidoctsp(1).descr;
         vt_docto(i).dt_emiss      := vt_docfisefd_merc(i).dt_emiss;
         vt_docto(i).dt_entr_saida := vt_docfisefd_merc(i).dt_entr_saida;
         vt_docto(i).vlr_docto     := vt_docfisefd_merc(i).vlr_docto;
         
         
         pk_efd_itdocfiefd.pkb_con ( en_docfisefd_id =>  vt_docfisefd_merc(i).docfisefd_id
                                   , st_itdocfiefd   =>  vt_itdocfiefd  
                                   , sv_sistema      => :sv_sistema     
                                   , sv_processo     => :sv_processo    
                                   , sv_msg_erro     => :sv_msg_erro    
                                   , sn_cd_erro      => :sn_cd_erro     
                                   );
                                   
         if vt_itdocfiefd.count > 0 then
            for j in vt_itdocfiefd.first..vt_itdocfiefd.last
            loop
                vn_qtde := vn_qtde +  nvl(vt_itdocfiefd(j).qtde,0);
            end loop;
         end if;
         vt_docto(i).qtde_items := vn_qtde ;
      end loop;
   end if;
          
   
   if vt_docto.count > 0 then
      for j in vt_docto.first..vt_docto.last
      loop
          vn_total := vn_total + nvl(vt_docto(j).vlr_docto,0);
      end loop;  
   end if;
   
   dbms_output.put_line('Soma: ' || vn_total   || chr(10));
         
   if vt_docto.count > 0 then 
      for k in vt_docto.first..vt_docto.last
      loop
         
         pk_efd_itdocfiefd.pkb_con ( en_docfisefd_id =>  vt_docto(k).docfisefd_id
                                   , st_itdocfiefd   =>  vt_itdocfiefd  
                                   , sv_sistema      => :sv_sistema     
                                   , sv_processo     => :sv_processo    
                                   , sv_msg_erro     => :sv_msg_erro    
                                   , sn_cd_erro      => :sn_cd_erro     
                                   );
                                                           
        if vt_itdocfiefd.count > 0 then
           for l in vt_itdocfiefd.first..vt_itdocfiefd.last
           loop 
              
              dbms_output.put_line('Num Doc: '       || vt_docto(k).nro_docto           || chr(10) ||
                                   'Valor_doc: '     || vt_docto(k).vlr_docto           || chr(10) ||
                                 --'Id Item: '       || vt_itdocfiefd(l).itdocfiefd_id  || chr(10) ||
                                   'Seq: '           || vt_itdocfiefd(l).seq            || chr(10) ||
                                 --'Cd: '            || vt_itdocfiefd(l).cd             || chr(10) ||
                                 --'Descr: '         || vt_itdocfiefd(l).descr          || chr(10) ||
                                   'Qtde: '          || vt_itdocfiefd(l).qtde           || chr(10) ||
                                   'Valor Item: '    || vt_itdocfiefd(l).vlr_item      
                                 --'valor Desc: '    || vt_itdocfiefd(l).vlr_desc       || chr(10) ||
                                 --'Valor Icms: '    || vt_itdocfiefd(l).vlr_icms       || chr(10) ||
                                 --'Valor Icms St: ' || vt_itdocfiefd(l).vlr_icms_st    || chr(10) || 
                                 --'Valor Ipi: '     || vt_itdocfiefd(l).vlr_ipi        || chr(10)
                                   );
              
              vn_percentual := ( vt_itdocfiefd(l).vlr_item   * 100 ) / vt_docto(k).vlr_docto;
              dbms_output.put_line( 'Percentual: '        || vn_percentual || '%'   );
              
              vn_percentual_item := (vt_itdocfiefd(l).qtde * 100)/ vt_docto(k).qtde_items;
              dbms_output.put_line('Qtde Totoal: '      || vt_docto(k).qtde_items || chr(10) ||
                                   'Percentual Item: '  || vn_percentual_item     || '%'     || chr(10));
           end loop;   
        end if;
      end loop;
   end if;       
end;
26
en_docfisefd_id
0
-4
en_efdescrit_id
0
-4
en_efdunid_id
0
-4
en_modespedtv_id
0
-4
en_unid_id_princ
0
-4
en_unid_cd
0
-3
en_nfen_id
0
-4
en_nfsa_id
0
-4
en_ind_oper
0
-3
en_ind_emit
0
-3
ev_cd_particip
0
-5
ev_modelo
0
-5
en_tpsidoctsp_id
0
-4
ev_tpsidoctsp_cd
0
-5
ev_serie
0
-5
en_nro_docto
0
-4
ev_chave
0
-5
ed_dt_emiss
0
-12
ed_dt_entr_saida
0
-12
en_ind_pagto
0
-3
en_ind_frete
0
-3
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
