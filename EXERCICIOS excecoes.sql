     
     Através de blocos anônimos, utilizando o tratamento de erros do oracle, segue lista.
     
     Lembrando que a trativa 'when others then' deve ser utilizada sempre, porém ela é genérica,
     quando possível trate os erros com exceções específicas.

  1) Faça um loop de 10 posições e utilizando o índice (i)
     execute uma consulta (use SQL) na tabela UNID e mostre Código e nome. 
     A tabela deve ser consultada através do campo 'unid.cd'.
     
  2) Faça um loop de 0 a 10 e mostre o resultado da divisão
     de 10/i. Caso ocorrer erro, mostre a divisão que aconteceu o erro.
     
  3) Faça uma consulta na tabela unid, utilizando a PK_COR_UNID, sem passagem de parâmetros de entrada.
     Faça um loop no resultado e atribua o nome da unidade para a variavel 'vv_nome   varchar2(15)' e mostre
     na tela o resultado.
     
  4) Declare uma variável 'vn_vlr  number(4,2)' e consulte a tabela
     docto_fiscal_efd passando a unidade 44. Utilize a PK_EFD_DOCFISEFD.PKB_CON_MERC
     para consulta. Faça um loop no resultado, atribuindo o campo docto_fiscal_efd.vlr_docto 
     a variável vn_vlr, mostrando na tela o resultado. Se acontecer algum erro, pare o processo.

