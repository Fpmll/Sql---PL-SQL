     
     Atrav�s de blocos an�nimos, utilizando o tratamento de erros do oracle, segue lista.
     
     Lembrando que a trativa 'when others then' deve ser utilizada sempre, por�m ela � gen�rica,
     quando poss�vel trate os erros com exce��es espec�ficas.

  1) Fa�a um loop de 10 posi��es e utilizando o �ndice (i)
     execute uma consulta (use SQL) na tabela UNID e mostre C�digo e nome. 
     A tabela deve ser consultada atrav�s do campo 'unid.cd'.
     
  2) Fa�a um loop de 0 a 10 e mostre o resultado da divis�o
     de 10/i. Caso ocorrer erro, mostre a divis�o que aconteceu o erro.
     
  3) Fa�a uma consulta na tabela unid, utilizando a PK_COR_UNID, sem passagem de par�metros de entrada.
     Fa�a um loop no resultado e atribua o nome da unidade para a variavel 'vv_nome   varchar2(15)' e mostre
     na tela o resultado.
     
  4) Declare uma vari�vel 'vn_vlr  number(4,2)' e consulte a tabela
     docto_fiscal_efd passando a unidade 44. Utilize a PK_EFD_DOCFISEFD.PKB_CON_MERC
     para consulta. Fa�a um loop no resultado, atribuindo o campo docto_fiscal_efd.vlr_docto 
     a vari�vel vn_vlr, mostrando na tela o resultado. Se acontecer algum erro, pare o processo.

