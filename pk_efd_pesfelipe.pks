CREATE OR REPLACE PACKAGE PK_EFD_PESFELIPE IS

   /*
   _____________________________________________________________________________________________________________________
   Desenvolvido por: Felipe Marinello
   Data: 17-04-2023              
   _____________________________________________________________________________________________________________________
   Definição: Procedimentos gerais da tabela aquisicao_producao_rural.    
   _____________________________________________________________________________________________________________________
   */   
   
   -- Constantes\
   
     
   ESTADO_CIVIL_SOLTEIRO          constant pessoa_felipe.estado_civil%type := 1;
   ESTADO_CIVIL_CASADO            constant pessoa_felipe.estado_civil%type := 2;
   ESTADO_CIVIL_SEPARADO          constant pessoa_felipe.estado_civil%type := 3;
   ESTADO_CIVIL_DIVORCIADO        constant pessoa_felipe.estado_civil%type := 4;
   ESTADO_CIVIL_VIUVO             constant pessoa_felipe.estado_civil%type := 5;
   
   -- Tipos de dados   
    
   type t_tab_rec_pesfelipe    is table of pessoa_felipe%rowtype index by binary_integer;
  
   -- Funções
   
   FUNCTION FKG_SEQ        return pessoa_felipe.pesfelipe_id%type;
      
   FUNCTION FKG_CPF        ( en_cpf in pessoa_felipe.cpf%type
                              ) return varchar2;
      
   FUNCTION FKG_CELL       ( en_cell in pessoa_felipe.celular%type
                              ) return varchar2;
                              
                        
      
   -- Procedimentos 
   
   PROCEDURE PKB_VAL       ( ev_acao          in            varchar2
                           , et_pesfelipe     in            t_tab_rec_pesfelipe 
                           , sv_sistema          out nocopy varchar2
                           , sv_processo         out nocopy varchar2
                           , sv_msg_erro         out nocopy varchar2
                           , sn_cd_erro          out nocopy number
                           );
        
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
                          );
        
   PROCEDURE PKB_INC      ( et_pesfelipe      in           t_tab_rec_pesfelipe
                          , sv_sistema          out nocopy varchar2
                          , sv_processo         out nocopy varchar2
                          , sv_msg_erro         out nocopy varchar2
                          , sn_cd_erro          out nocopy number
                          );
        
   PROCEDURE PKB_ALT      ( et_pesfelipe      in           t_tab_rec_pesfelipe
                          , sv_sistema          out nocopy varchar2
                          , sv_processo         out nocopy varchar2
                          , sv_msg_erro         out nocopy varchar2
                          , sn_cd_erro          out nocopy number
                          );
        
   PROCEDURE PKB_EXC      ( et_pesfelipe      in           t_tab_rec_pesfelipe
                          , sv_sistema          out nocopy varchar2
                          , sv_processo         out nocopy varchar2
                          , sv_msg_erro         out nocopy varchar2
                          , sn_cd_erro          out nocopy number
                          );
      
   PROCEDURE PKB_POSTQUER  ( en_pesfelipe_id  in           pessoa_felipe.pesfelipe_id%type
                           , st_pesfelipe       out nocopy t_tab_rec_pesfelipe
                           , sv_sistema         out nocopy varchar2
                           , sv_processo        out nocopy varchar2
                           , sv_msg_erro        out nocopy varchar2
                           , sn_cd_erro         out nocopy number
                            ); 
        
  PROCEDURE PKB_VALIDA    ( en_cpf            in           pessoa_felipe.cpf%type
                          , st_pesfelipe        out nocopy t_tab_rec_pesfelipe
                          , sv_sistema          out nocopy varchar2
                          , sv_processo         out nocopy varchar2
                          , sv_msg_erro         out nocopy varchar2
                          , sn_cd_erro          out nocopy number
                              );
                            
                                
END PK_EFD_PESFELIPE;
/
