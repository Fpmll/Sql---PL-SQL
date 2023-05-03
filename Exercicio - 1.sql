Tabelas envolvidas:
DOCUMENTO FISCAL DA EFD                => DOCTO_FISCAL_EFD
ITEM DO DOCUMENTO FISCAL DA EFD        => ITEM_DOCTO_FISCAL_EFD
INFORMAÇÃO COMPLEMENTAR DA NOTA FISCAL => INF_COMPL_NF_EFD
UNIDADE DA EFD                         => EFD_UNID
UNIDADE MEDADIA                        => UNID_MEDIDA

1) Faça uma seleção de dados mostrando os seguintes campos:

- Código da unidade           (unid.cd)
- Indicador da operação       (docto_fiscal_efd.ind_oper)
- Numero do documento         (docto_fiscal_efd.nro_docto)
- Valor do documento          (docto_fiscal_efd.vlr_docto)
- Código do item              (item_docto_fiscal_efd.cd)
- Descrição do item           (item_docto_fiscal_efd.descr)
- Código da unidade de medida (unid_medida.cd)
- Valor do item               (item_docto_fiscal_efd.vlr_item)

Critérios:
- Data de emissão do documento fiscal deve compreender o mês de janeiro/2023;
- Tipo do documento deve ser 1 (docto_fiscal_efd.tp_docto);
- Ordenar pelo Código da unidade, Numero do documento e Código do item.

----------------------------------------------------------------------------------------

1) Faça uma seleção de dados mostrando os seguintes campos:

- Código da unidade                    (unid.cd)
- Indicador da operação                (docto_fiscal_efd.ind_oper)
- Numero do documento                  (docto_fiscal_efd.nro_docto)
- Valor do documento                   (docto_fiscal_efd.vlr_docto)
- Código da informação complementar    (inf_compl_nf_efd.cd)
- Descrição da informação complementar (inf_compl_nf_efd.descr)


O relacionamento entre docto_fiscal_efd e inf_compl_nf_efd é opcional. No momento da junção
devemos utilizar o outer join. Pesquisar o uso do outer join no Oracle.

Critérios:
- Data de emissão do documento fiscal deve compreender o mês de janeiro/2023;
- Tipo do documento deve ser 1 (docto_fiscal_efd.tp_docto);
- Ordenar pelo Código da unidade e Numero do documento.

-------------------------------------------------------------------------------------------

3) Faça uma seleção de dados mostrando os seguintes campos:

- Código da unidade          (unid.cd)
- Tipo documento             (docto_fiscal_efd.tp_docto)
- Indicador operação         (docto_fiscal_efd.ind_oper)
- Soma do Valor do documento (docto_fiscal_efd.vlr_docto)

Critérios:
- Data de emissão do documento fiscal deve compreender o mês de janeiro/2023;
- Soma do Valor do documento deve ser maior ou igual a 100000 (pesquisar comando "having");
- Ordenar o resultado pelo Código da unidade (unid.cd).
              
----------------------------------------------------------------------------------------

4) Trazer a mesma seleção conforme o exercício 1, alterando somente a amostragem 
   das colunas DOCTO_FISCAL_EFD.TP_DOCTO e DOCTO_FISCAL_EFD.IND_OPER. Ao invés de
   mostrar o valor numérico destes campos, vamos buscar a descrição contida em seus
   respectivos domínios através do comando abaixo:
   
   select crc.rv_meaning
     from cg_ref_codes crc
    where crc.rv_domain    = 'DOCTO_FISCAL_EFD.TP_DOCTO'
      and crc.rv_low_value = x;
      
   select crc.rv_meaning
     from cg_ref_codes crc
    where crc.rv_domain    = 'DOCTO_FISCAL_EFD.IND_OPER'
      and crc.rv_low_value = x;
      
Consulta destes domínios dever ser através de "sub selects" no select principal.

------------------------------------------------------------------------------------------------




            
              
