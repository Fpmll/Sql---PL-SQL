Tabelas envolvidas:
DOCUMENTO FISCAL DA EFD                => DOCTO_FISCAL_EFD
ITEM DO DOCUMENTO FISCAL DA EFD        => ITEM_DOCTO_FISCAL_EFD
INFORMA��O COMPLEMENTAR DA NOTA FISCAL => INF_COMPL_NF_EFD
UNIDADE DA EFD                         => EFD_UNID
UNIDADE MEDADIA                        => UNID_MEDIDA

1) Fa�a uma sele��o de dados mostrando os seguintes campos:

- C�digo da unidade           (unid.cd)
- Indicador da opera��o       (docto_fiscal_efd.ind_oper)
- Numero do documento         (docto_fiscal_efd.nro_docto)
- Valor do documento          (docto_fiscal_efd.vlr_docto)
- C�digo do item              (item_docto_fiscal_efd.cd)
- Descri��o do item           (item_docto_fiscal_efd.descr)
- C�digo da unidade de medida (unid_medida.cd)
- Valor do item               (item_docto_fiscal_efd.vlr_item)

Crit�rios:
- Data de emiss�o do documento fiscal deve compreender o m�s de janeiro/2023;
- Tipo do documento deve ser 1 (docto_fiscal_efd.tp_docto);
- Ordenar pelo C�digo da unidade, Numero do documento e C�digo do item.

----------------------------------------------------------------------------------------

1) Fa�a uma sele��o de dados mostrando os seguintes campos:

- C�digo da unidade                    (unid.cd)
- Indicador da opera��o                (docto_fiscal_efd.ind_oper)
- Numero do documento                  (docto_fiscal_efd.nro_docto)
- Valor do documento                   (docto_fiscal_efd.vlr_docto)
- C�digo da informa��o complementar    (inf_compl_nf_efd.cd)
- Descri��o da informa��o complementar (inf_compl_nf_efd.descr)


O relacionamento entre docto_fiscal_efd e inf_compl_nf_efd � opcional. No momento da jun��o
devemos utilizar o outer join. Pesquisar o uso do outer join no Oracle.

Crit�rios:
- Data de emiss�o do documento fiscal deve compreender o m�s de janeiro/2023;
- Tipo do documento deve ser 1 (docto_fiscal_efd.tp_docto);
- Ordenar pelo C�digo da unidade e Numero do documento.

-------------------------------------------------------------------------------------------

3) Fa�a uma sele��o de dados mostrando os seguintes campos:

- C�digo da unidade          (unid.cd)
- Tipo documento             (docto_fiscal_efd.tp_docto)
- Indicador opera��o         (docto_fiscal_efd.ind_oper)
- Soma do Valor do documento (docto_fiscal_efd.vlr_docto)

Crit�rios:
- Data de emiss�o do documento fiscal deve compreender o m�s de janeiro/2023;
- Soma do Valor do documento deve ser maior ou igual a 100000 (pesquisar comando "having");
- Ordenar o resultado pelo C�digo da unidade (unid.cd).
              
----------------------------------------------------------------------------------------

4) Trazer a mesma sele��o conforme o exerc�cio 1, alterando somente a amostragem 
   das colunas DOCTO_FISCAL_EFD.TP_DOCTO e DOCTO_FISCAL_EFD.IND_OPER. Ao inv�s de
   mostrar o valor num�rico destes campos, vamos buscar a descri��o contida em seus
   respectivos dom�nios atrav�s do comando abaixo:
   
   select crc.rv_meaning
     from cg_ref_codes crc
    where crc.rv_domain    = 'DOCTO_FISCAL_EFD.TP_DOCTO'
      and crc.rv_low_value = x;
      
   select crc.rv_meaning
     from cg_ref_codes crc
    where crc.rv_domain    = 'DOCTO_FISCAL_EFD.IND_OPER'
      and crc.rv_low_value = x;
      
Consulta destes dom�nios dever ser atrav�s de "sub selects" no select principal.

------------------------------------------------------------------------------------------------




            
              
