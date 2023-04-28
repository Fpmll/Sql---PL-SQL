CREATE OR REPLACE PACKAGE BODY PK_EFD_PESFELIPE IS

   ve_erro_interno      exception;
   ve_erro_externo      exception;
   
   pk_efdf0011.pkb_con_escritsped
   

   /*
   _____________________________________________________________________________________________________________________
   Desenvolvido por: Felipe Marinello
   Data:             18/04/2023
   _____________________________________________________________________________________________________________________
   Definição:        Localiza o próximo número disponível na sequência.
   _____________________________________________________________________________________________________________________
   Retorno:          Próximo ID disponível.
   _____________________________________________________________________________________________________________________
   */
   
   FUNCTION FKG_SEQ return pessoa_felipe.pesfelipe_id%type is
     
   BEGIN
     
     return pesfelipe_seq.nextval;
   
   EXCEPTION
     when others then
        raise_application_error(-20000, 'Erro na PK_EFD_PESFELIPE.FKG_SEQ:' || sqlerrm);
   END FKG_SEQ;
   
   /*
   _____________________________________________________________________________________________________________________
   Desenvolvido por: Felipe Marinello
   Data:             18/04/2023
   _____________________________________________________________________________________________________________________
   Definição:        Formatar o CPF.
   _____________________________________________________________________________________________________________________
   Retorno:          Retorna o CPF com a máscara 999.999.999-99.
   _____________________________________________________________________________________________________________________
   */
   
   
   

   
   FUNCTION FKG_CPF        ( en_cpf in pessoa_felipe.cpf%type
                           ) return varchar2 IS
     
      vv_cpf               varchar2(20);

   BEGIN 
     
      vv_cpf := substr(lpad(en_cpf,11,0),1,3) || '.' || substr(lpad(en_cpf,11,0),4,3) || '.'  || substr(lpad(en_cpf,11,0),7,3) || '-' || substr(lpad(en_cpf,11,0),10,2);
      return vv_cpf;
   
   EXCEPTION
      when others then
         raise_application_error(-20000, 'Erro na PK_EFD_PESFELIPE.FKG_SEQ:' || sqlerrm);
   END FKG_CPF;
     
    
    /*
   _____________________________________________________________________________________________________________________
   Desenvolvido por: Felipe Marinello
   Data:             18/04/2023
   _____________________________________________________________________________________________________________________
   Definição:        Formatar o Celular.
   _____________________________________________________________________________________________________________________
   Retorno:          Retorna o CELULAR com a máscara (99)99999-9999.
   _____________________________________________________________________________________________________________________
   */
   
   
   FUNCTION FKG_CELL      (en_cell in pessoa_felipe.celular%type
                          ) return varchar2 IS
                          
      vv_cell varchar2(20);
      
   BEGIN
      vv_cell := to_char(en_cell);
      vv_cell := '('||substr(vv_cell,1,2)||')' || substr(vv_cell,3,5) || '-' ||  substr(vv_cell,8,4);
  
      return vv_cell;
       
   EXCEPTION
     when others then
        raise_application_error(-20000, 'Erro na PK_EFD_PESFELIPE.FKG_SEQ:' || sqlerrm);
   END FKG_CELL;
   
   
   
   
   /*
   _____________________________________________________________________________________________________________________
   Desenvolvido por: Felipe Marinello
   Data:             18/04/2023
   _____________________________________________________________________________________________________________________
   Definição:        Valida informações da pessoa_felipe para inserção/alteração/exclusão.
   _____________________________________________________________________________________________________________________
   Retorno:          ev_acao             Representa da operação DML (INC|ALT|EXC).
                     et_pesfelipe        Registro a ser validado.
   _____________________________________________________________________________________________________________________
   */
   
   PROCEDURE PKB_VAL          ( ev_acao      in            varchar2
                              , et_pesfelipe in            t_tab_rec_pesfelipe 
                              , sv_sistema      out nocopy varchar2
                              , sv_processo     out nocopy varchar2
                              , sv_msg_erro     out nocopy varchar2
                              , sn_cd_erro      out nocopy number
                              ) is
                              
   BEGIN
     
       if ev_acao in ('INC','ALT') then
         
           if  et_pesfelipe(1).cpf is null then
              -- Obrigatório informar o Id do usuario.
              sn_cd_erro := 2;
              raise ve_erro_interno;
           end if;
           
            if  et_pesfelipe(1).nome is null then
              -- Obrigatório informar o Nome do usuario.
              sn_cd_erro := 3;
              raise ve_erro_interno;
           end if;
           
           if  et_pesfelipe(1).celular is null then
              -- Obrigatório informar o Celular do usuario.
              sn_cd_erro := 4;
              raise ve_erro_interno;
           end if;
           
           if  et_pesfelipe(1).estado_civil is null then
              -- Obrigatório informar o Estado Civil do usuario.
              sn_cd_erro := 5;
              raise ve_erro_interno;
           end if;
           
           if  et_pesfelipe(1).endereco is null then
              -- Obrigatório informar o Endereco do usuario.
              sn_cd_erro := 6;
              raise ve_erro_interno;
           end if;
           
           if et_pesfelipe(1).cidade_id is null then
             -- Obrigatorio informar A Cidade
             sn_cd_erro := 7;
             raise ve_erro_interno;
           end if;
               
           
           
         end if;
         
   EXCEPTION
     
      when ve_erro_externo then
         null;
      when ve_erro_interno then
         sv_sistema  := 'EFD';
         sv_processo := 'PK_EFD_AQUPRODRUR.PKB_VAL';
         pk_soft.pkb_busca_msg_erro ( en_cd       => sn_cd_erro
                                    , ev_sg_sist  => sv_sistema
                                    , ev_objeto   => sv_processo
                                    , sv_msg_erro => sv_msg_erro
                                    );
      when others then
         sn_cd_erro  := nvl(sn_cd_erro, 90000);
         sv_sistema  := 'EFD';
         sv_processo := 'PK_EFD_AQUPRODRUR.PKB_VAL';
         pk_soft.pkb_busca_msg_erro ( en_cd       => sqlcode
                                    , ev_sg_sist  => sv_sistema
                                    , ev_objeto   => sv_processo
                                    , sv_msg_erro => sv_msg_erro
                                    );
     
   END PKB_VAL;
   
    /*
   _____________________________________________________________________________________________________________________
   Desenvolvido por: Felipe Marinello
   Data:             19/04/2023
   _____________________________________________________________________________________________________________________
   Definição:        Consulta genérica da tabela pessoa_felipe.
   _____________________________________________________________________________________________________________________
   Retorno:          en_pesfelipe_id               ID do registro
                     en_cidade_id                  ID da Cidade do Usuario
                     en_cpf                        CPF do usuario
                     en_nome                       Nome do Usuario
                     en_celular                    Celualr do Usuario
                     en_estado_civil               Estadfo Civil do Usuario
                     en_endereco                   Endereco do Usuario
                     en_nro                        Nro do Usuario
   _____________________________________________________________________________________________________________________
   */
   
   PROCEDURE PKB_CON      ( en_pesfelipe_id   in           pessoa_felipe.pesfelipe_id%type default null
                          , en_cpf            in           pessoa_felipe.cpf%type          default null
                          , ev_nome           in           pessoa_felipe.nome%type         default null
                          , en_celular        in           pessoa_felipe.celular%type      default null
                          , en_estado_civil   in           pessoa_felipe.estado_civil%type default null
                          , ev_endereco       in           pessoa_felipe.endereco%type     default null
                          , en_nro            in           pessoa_felipe.nro%type          default null
                          , en_cidade_id      in           pessoa_felipe.cidade_id%type    default null 
                          , ev_ordem          in           varchar2                        default null 
                          , st_pesfelipe        out nocopy t_tab_rec_pesfelipe      
                          , sv_sistema          out nocopy varchar2
                          , sv_processo         out nocopy varchar2
                          , sv_msg_erro         out nocopy varchar2
                          , sn_cd_erro          out nocopy number
                          ) IS
                                  
            cur_1           sys_refcursor;
            vn_indice       pls_integer := 0;
            vv_string       varchar2(32767);
       
   BEGIN
          
      vv_string := 'select apr.*           
                      from pessoa_felipe apr';
                       
      if en_pesfelipe_id is not null then
         vv_string := vv_string || ' where apr.pesfelipe_id = :en_pesfelipe_id ';
      else
         vv_string := vv_string || ' where :en_pesfelipe_id is null ';
      end if;
          
      if en_cpf is not null then
         vv_string := vv_string || 'and apr.cpf = :en_cpf ';
      else
         vv_string := vv_string || 'and :en_cpf is null ';
      end if;
          
      if ev_nome is not null then
        vv_string := vv_string || 'and apr.nome = :ev_nome ';
      else 
        vv_string := vv_string || 'and :ev_nome is null ';
      end if;  
          
       if en_celular  is not null then
        vv_string := vv_string || 'and apr.celular = :en_celular ';
      else 
        vv_string := vv_string || 'and :en_celular  is null ';
      end if; 
          
       if en_estado_civil  is not null then
        vv_string := vv_string || 'and apr.estado_civil = :en_estado_civil ';
      else 
        vv_string := vv_string || 'and :en_estado_civil  is null ';
      end if; 
          
       if ev_endereco is not null then
        vv_string := vv_string || 'and apr.endereco = :ev_endereco ';
      else 
        vv_string := vv_string || 'and :ev_endereco is null ';
      end if; 
      
      if en_nro is not null then
        vv_string := vv_string || 'and apr.nro = :en_nro';
      else 
        vv_string := vv_string || 'and :en_nro is null ';
      end if;
          
      if en_cidade_id is not null then
        vv_string := vv_string || 'and apr.cidade_id = :en_cidade_id ';
      else 
        vv_string := vv_string || 'and :en_cidade_id is null ';
      end if;
            
      if ev_ordem is not null then
         vv_string := vv_string || ' order by ' || ev_ordem;
      end if;
          
      st_pesfelipe.delete;
      begin
         open cur_1 for vv_string
                  using en_pesfelipe_id                            
                      , en_cpf                       
                      , ev_nome                      
                      , en_celular                   
                      , en_estado_civil               
                      , ev_endereco                
                      , en_nro
                      , en_cidade_id;                                                                           
                      
      exception
         when others then
            sn_cd_erro := 90001;
            raise;
      end;
          
      loop
         vn_indice := vn_indice + 1;
         fetch cur_1 into st_pesfelipe(vn_indice);
         exit when cur_1%notfound;
      end loop;
          
      close cur_1;

   EXCEPTION
      when ve_erro_externo then
         null;
      when ve_erro_interno then
         sv_sistema  := 'EFD';
         sv_processo := 'PK_EFD_AQUPRODRUR.PKB_CON';
         pk_soft.pkb_busca_msg_erro ( en_cd       => sn_cd_erro
                                    , ev_sg_sist  => sv_sistema
                                    , ev_objeto   => sv_processo
                                    , sv_msg_erro => sv_msg_erro
                                    );
      when others then
         sn_cd_erro  := nvl(sn_cd_erro, 90000);
         sv_sistema  := 'EFD';
         sv_processo := 'PK_EFD_AQUPRODRUR.PKB_CON';
         pk_soft.pkb_busca_msg_erro ( en_cd       => sqlcode
                                    , ev_sg_sist  => sv_sistema
                                    , ev_objeto   => sv_processo
                                    , sv_msg_erro => sv_msg_erro
                                    );
   END PKB_CON;
   
       /*
   _____________________________________________________________________________________________________________________
   Desenvolvido por: Felipe Marinello
   Data:             19/04/2023
   _____________________________________________________________________________________________________________________
   Definição:        Inclusão de registros na tabela epssoa_felipe.
   _____________________________________________________________________________________________________________________
   Retorno:          et_pesfelipe        Tabela de Registros a Serem Incluidos.                   
   _____________________________________________________________________________________________________________________
   */
   
   PROCEDURE PKB_INC          ( et_pesfelipe          in            t_tab_rec_pesfelipe
                              , sv_sistema                out nocopy varchar2
                              , sv_processo               out nocopy varchar2
                              , sv_msg_erro               out nocopy varchar2
                              , sn_cd_erro                out nocopy number
                              ) IS
                              
      vt_pesfelipe            t_tab_rec_pesfelipe;
     
    BEGIN
      
      if  et_pesfelipe.count > 0 then
         for i in  et_pesfelipe.first.. et_pesfelipe.last
         loop
         
            vt_pesfelipe.delete;            
            vt_pesfelipe(1) := et_pesfelipe(i); 
            
            
           pkb_val  ( ev_acao      => 'INC'
                    , et_pesfelipe => et_pesfelipe 
                    , sv_sistema   => sv_sistema  
                    , sv_processo  => sv_processo    
                    , sv_msg_erro  => sv_msg_erro    
                    , sn_cd_erro   => sn_cd_erro   
                    );                      
           if sn_cd_erro is not null then
               raise ve_erro_externo;
            end if;    
            
            if  vt_pesfelipe(1).pesfelipe_id is null then
                vt_pesfelipe(1).pesfelipe_id := fkg_seq();
            end if;                 
             
            begin
               insert into pessoa_felipe ( pesfelipe_id
                                                    , cpf
                                                    , nome
                                                    , celular
                                                    , estado_civil
                                                    , endereco
                                                    , nro
                                                    , cidade_id
                                                    )
                                             values ( vt_pesfelipe(1).pesfelipe_id
                                                    , vt_pesfelipe(1).cpf
                                                    , vt_pesfelipe(1).nome
                                                    , vt_pesfelipe(1).celular
                                                    , vt_pesfelipe(1).estado_civil
                                                    , vt_pesfelipe(1).endereco
                                                    , vt_pesfelipe(1).nro
                                                    , vt_pesfelipe(1).cidade_id 
                                                    );
            exception
               when dup_val_on_index then
                  -- Usuario ja cadastrado.
                  sn_cd_erro := 1;
                  raise ve_erro_interno;
               when others then
                  sn_cd_erro := 90001;
                  raise;
            end;
             
         end loop;
      end if;
      
   EXCEPTION
      when ve_erro_externo then
         null;
      when ve_erro_interno then
         sv_sistema  := 'EFD';
         sv_processo := 'PK_EFD_AQUPRODRUR.PKB_INC';
         pk_soft.pkb_busca_msg_erro ( en_cd       => sn_cd_erro
                                    , ev_sg_sist  => sv_sistema
                                    , ev_objeto   => sv_processo
                                    , sv_msg_erro => sv_msg_erro
                                    );
      when others then
         sn_cd_erro  := nvl(sn_cd_erro, 90000);
         sv_sistema  := 'EFD';
         sv_processo := 'PK_EFD_AQUPRODRUR.PKB_INC';
         pk_soft.pkb_busca_msg_erro ( en_cd       => sqlcode
                                    , ev_sg_sist  => sv_sistema
                                    , ev_objeto   => sv_processo
                                    , sv_msg_erro => sv_msg_erro
                                    );
   END PKB_INC; 
   
   /*
   _____________________________________________________________________________________________________________________
   Desenvolvido por: Felipe Marinello
   Data:             19/04/2023
   _____________________________________________________________________________________________________________________
   Definição:        Alteração de registros na tabela epssoa_felipe.
   _____________________________________________________________________________________________________________________
   Retorno:          et_pesfelipe        Tabela de Registros a Serem Alterados.                   
   _____________________________________________________________________________________________________________________
   */
   
   PROCEDURE PKB_ALT        ( et_pesfelipe          in             t_tab_rec_pesfelipe
                            , sv_sistema                out nocopy varchar2
                            , sv_processo               out nocopy varchar2
                            , sv_msg_erro               out nocopy varchar2
                            , sn_cd_erro                out nocopy number
                            )IS
                              
      vt_pesfelipe          t_tab_rec_pesfelipe;
                
   BEGIN 
     
        if  et_pesfelipe.count > 0 then
         for i in  et_pesfelipe.first.. et_pesfelipe.last
         loop
         
            vt_pesfelipe.delete;            
            vt_pesfelipe(1) := et_pesfelipe(i); 
            
            
           pkb_val  ( ev_acao      => 'ALT'
                    , et_pesfelipe => et_pesfelipe 
                    , sv_sistema   => sv_sistema  
                    , sv_processo  => sv_processo    
                    , sv_msg_erro  => sv_msg_erro    
                    , sn_cd_erro   => sn_cd_erro   
                    );                      
            
        
            if sn_cd_erro is not null then
               raise ve_erro_externo;
            end if;
            
            begin
               
               update pessoa_felipe apr
                  set apr.cpf                 = vt_pesfelipe(1).cpf 
                    , apr.nome                = vt_pesfelipe(1).nome
                    , apr.celular             = vt_pesfelipe(1).celular 
                    , apr.estado_civil        = vt_pesfelipe(1).estado_civil 
                    , apr.endereco            = vt_pesfelipe(1).endereco 
                    , apr.nro                 = vt_pesfelipe(1).nro 
                    , apr.cidade_id           = vt_pesfelipe(1).cidade_id 
                where apr.pesfelipe_id        = vt_pesfelipe(1).pesfelipe_id;
                
            exception
               when dup_val_on_index then
                  -- Usuario ja Cadastrado.
                  sn_cd_erro := 1;
                  raise ve_erro_interno;
               when others then
                  sn_cd_erro := 90001;
                  raise;
            end;
            
            if sql%rowcount = 0 then
               -- Nenhum Usuario foi Alterado.
               sn_cd_erro := 2;
               raise ve_erro_interno;
            end if;
            
         end loop;
      end if;
      
   EXCEPTION
      when ve_erro_externo then
         null;
      when ve_erro_interno then
         sv_sistema  := 'EFD';
         sv_processo := 'PK_EFD_AQUPRODRUR.PKB_ALT';
         pk_soft.pkb_busca_msg_erro ( en_cd       => sn_cd_erro
                                    , ev_sg_sist  => sv_sistema
                                    , ev_objeto   => sv_processo
                                    , sv_msg_erro => sv_msg_erro
                                    );
      when others then
         sn_cd_erro  := nvl(sn_cd_erro, 90000);
         sv_sistema  := 'EFD';
         sv_processo := 'PK_EFD_AQUPRODRUR.PKB_ALT';
         pk_soft.pkb_busca_msg_erro ( en_cd       => sqlcode
                                    , ev_sg_sist  => sv_sistema
                                    , ev_objeto   => sv_processo
                                    , sv_msg_erro => sv_msg_erro
                                    );
   END PKB_ALT;
   
    /*
   _____________________________________________________________________________________________________________________
   Desenvolvido por: Felipe Marinello
   Data:             19/04/2023
   _____________________________________________________________________________________________________________________
   Definição:        Exlusão de registros na tabela epssoa_felipe.
   _____________________________________________________________________________________________________________________
   Retorno:          et_pesfelipe        Tabela de Registros a Serem Excluidos.                   
   _____________________________________________________________________________________________________________________
   */
   
   PROCEDURE PKB_EXC          ( et_pesfelipe          in            t_tab_rec_pesfelipe
                              , sv_sistema                out nocopy varchar2
                              , sv_processo               out nocopy varchar2
                              , sv_msg_erro               out nocopy varchar2
                              , sn_cd_erro                out nocopy number
                              )IS
                              
      vt_pesfelipe            t_tab_rec_pesfelipe;
                
   BEGIN 
     
        if  et_pesfelipe.count > 0 then
         for i in  et_pesfelipe.first..et_pesfelipe.last
         loop
         
            vt_pesfelipe.delete;            
            vt_pesfelipe(1) := et_pesfelipe(i); 
            
            
           pkb_val  ( ev_acao      => 'EXC'
                    , et_pesfelipe => et_pesfelipe 
                    , sv_sistema   => sv_sistema  
                    , sv_processo  => sv_processo    
                    , sv_msg_erro  => sv_msg_erro    
                    , sn_cd_erro   => sn_cd_erro   
                    );                      
            if sn_cd_erro is not null then
               raise ve_erro_externo;
            end if;
            
            begin
               
               delete pessoa_felipe apr
                where apr.pesfelipe_id = vt_pesfelipe(1).pesfelipe_id;
                
            exception
               when others then
                  if sqlcode = -02292 then
                     -- Não é possível excluir a Aquição de produção r ural pois está sendo utilizada por outros cadastros
                     sn_cd_erro := 1;
                     raise ve_erro_interno;
                  else
                     sn_cd_erro := 90001;
                     raise;
                  end if;
            end;
            
            if sql%rowcount = 0 then
               -- Nenhum Usuario Foi Excluido.
               sn_cd_erro := 2;
               raise ve_erro_interno;
            end if;
         end loop;
      end if;
      
   EXCEPTION
      when ve_erro_externo then
         null;
      when ve_erro_interno then
         sv_sistema  := 'EFD';
         sv_processo := 'PK_EFD_AQUPRODRUR.PKB_EXC';
         pk_soft.pkb_busca_msg_erro ( en_cd       => sn_cd_erro
                                    , ev_sg_sist  => sv_sistema
                                    , ev_objeto   => sv_processo
                                    , sv_msg_erro => sv_msg_erro
                                    );
      when others then
         sn_cd_erro  := nvl(sn_cd_erro, 90000);
         sv_sistema  := 'EFD';
         sv_processo := 'PK_EFD_AQUPRODRUR.PKB_EXC';
         pk_soft.pkb_busca_msg_erro ( en_cd       => sqlcode
                                    , ev_sg_sist  => sv_sistema
                                    , ev_objeto   => sv_processo
                                    , sv_msg_erro => sv_msg_erro
                                    );
   END PKB_EXC;
   
    /*
   _____________________________________________________________________________________________________________________
   Desenvolvido por: Felipe Marinello
   Data:             19/04/2023
   _____________________________________________________________________________________________________________________
   Definição:        Post Query da tabela pessoa_felipe.
   _____________________________________________________________________________________________________________________
   Parâmetros:       pesfelipe_id     ID do registro
                     st_pesfelipe     Tabela de registros encontardos.
   _____________________________________________________________________________________________________________________
   */ 
   
   PROCEDURE PKB_POSTQUER     ( en_pesfelipe_id       in             pessoa_felipe.pesfelipe_id%type
                              , st_pesfelipe              out nocopy t_tab_rec_pesfelipe
                              , sv_sistema                out nocopy varchar2
                              , sv_processo               out nocopy varchar2
                              , sv_msg_erro               out nocopy varchar2
                              , sn_cd_erro                out nocopy number
                              )IS
   BEGIN
      
      if en_pesfelipe_id is not null then
         pkb_con ( en_pesfelipe_id  => en_pesfelipe_id  
                 , st_pesfelipe     => st_pesfelipe
                 , sv_sistema       => sv_sistema
                 , sv_processo      => sv_processo
                 , sv_msg_erro      => sv_msg_erro
                 , sn_cd_erro       => sn_cd_erro
                 );
         if sn_cd_erro is not null then
            raise ve_erro_externo;
         end if;
      end if;
         
      if st_pesfelipe.count <> 1 then
         -- Id do Usuario nao encontardo.
         sn_cd_erro := 1;
         raise ve_erro_interno;
      end if;
      
   EXCEPTION
      when ve_erro_externo then
         null;
      when ve_erro_interno then
         sv_sistema  := 'EFD';
         sv_processo := 'PK_EFD_AQUPRODRUR.PKB_POSTQUER';
         pk_soft.pkb_busca_msg_erro ( en_cd       => sn_cd_erro
                                    , ev_sg_sist  => sv_sistema
                                    , ev_objeto   => sv_processo
                                    , sv_msg_erro => sv_msg_erro
                                    );
      when others then
         sn_cd_erro  := nvl(sn_cd_erro, 90000);
         sv_sistema  := 'EFD';
         sv_processo := 'PK_EFD_AQUPRODRUR.PKB_POSTQUER';
         pk_soft.pkb_busca_msg_erro ( en_cd       => sqlcode
                                    , ev_sg_sist  => sv_sistema
                                    , ev_objeto   => sv_processo
                                    , sv_msg_erro => sv_msg_erro
                                    );
   END PKB_POSTQUER;
   
    /*
   _____________________________________________________________________________________________________________________
   Desenvolvido por: Felipe Marinello
   Data:             19/04/2023
   _____________________________________________________________________________________________________________________
   Definição:        Consulta registro pela Unique Key.
   _____________________________________________________________________________________________________________________
   Parâmetros:       en_cpf           CPF do registro.
                     st_pesfelipe     Tabela de registros encontardos.
   _____________________________________________________________________________________________________________________
   */ 
   
   PROCEDURE PKB_VALIDA       ( en_cpf                in             pessoa_felipe.cpf%type
                              , st_pesfelipe              out nocopy t_tab_rec_pesfelipe
                              , sv_sistema                out nocopy varchar2
                              , sv_processo               out nocopy varchar2
                              , sv_msg_erro               out nocopy varchar2
                              , sn_cd_erro                out nocopy number
                              )IS
                             
   BEGIN
                              
      if en_cpf is not null then
         pkb_con ( en_cpf       => en_cpf
                 , st_pesfelipe => st_pesfelipe
                 , sv_sistema   => sv_sistema
                 , sv_processo  => sv_processo
                 , sv_msg_erro  => sv_msg_erro
                 , sn_cd_erro   => sn_cd_erro
                 );
         if sn_cd_erro is not null then
            raise ve_erro_externo;
         end if;
      end if;
         
      if st_pesfelipe.count <> 1 then
         -- CPF do Usuario nao encontardo.
         sn_cd_erro := 1;
         raise ve_erro_interno;
      end if;
      
   EXCEPTION
      when ve_erro_externo then
         null;
      when ve_erro_interno then
         sv_sistema  := 'EFD';
         sv_processo := 'PK_EFD_AQUPRODRUR.PKB_POSTQUER';
         pk_soft.pkb_busca_msg_erro ( en_cd       => sn_cd_erro
                                    , ev_sg_sist  => sv_sistema
                                    , ev_objeto   => sv_processo
                                    , sv_msg_erro => sv_msg_erro
                                    );
      when others then
         sn_cd_erro  := nvl(sn_cd_erro, 90000);
         sv_sistema  := 'EFD';
         sv_processo := 'PK_EFD_AQUPRODRUR.PKB_POSTQUER';
         pk_soft.pkb_busca_msg_erro ( en_cd       => sqlcode
                                    , ev_sg_sist  => sv_sistema
                                    , ev_objeto   => sv_processo
                                    , sv_msg_erro => sv_msg_erro
                                    );
   END PKB_VALIDA;

END PK_EFD_PESFELIPE;
   
   
     
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
/
