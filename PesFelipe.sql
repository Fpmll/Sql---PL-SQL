insert into pessoa_felipe ( pesfelipe_id
                          , cpf 
                          , nome 
                          , celular 
                          , estado_civil 
                          , endereco 
                          , nro 
                          , cidade_id 
                          ) 
     select pk_efd_pesfelipe.fkg_seq() 
          , pf.cpf 
          , pe.nome 
          , to_number( substr(mc.descr,2,2) ||
                       substr(mc.descr,6,5) || 
                       substr(mc.descr,12,4) 
            ) celular 
          , case when cp.estado_civil = 0 then 1 
                 when cp.estado_civil = 1 then 2 
                 when cp.estado_civil = 3 then 3 
                 when cp.estado_civil = 2 then 4 
                 when cp.estado_civil = 4 then 5 
            end estado_civil 
          , en.descr||', '||en.bairro endereco 
          , en.nro 
          , en.cidade_id 
       from pessoa pe 
          , r_pessoa_pefi rpp 
          , pefi pf 
          , compl_pefi cp 
          , ender en 
          , tipo_ender_tv te 
          , lateral ( select mcp.pessoa_id 
                           , mcp.descr 
                        from meio_comunic_pessoa mcp 
                           , tipo_comunic_tv tct 
                       where mcp.pessoa_id = pe.pessoa_id 
                         and mcp.tpcomunitv_id = tct.tpcomunitv_id 
                         and tct.cd in (11) -- Celular
                       fetch first 1 rows only
          ) mc   
     where pe.pessoa_id    = rpp.pessoa_id 
       and rpp.pefi_id     = pf.pefi_id 
       and pf.pefi_id      = cp.pefi_id 
       and pe.pessoa_id    = en.pessoa_id 
       and en.tpendertv_id = te.tpendertv_id 
       and te.cd           = 1 -- SEDE / DOMICILIO 
       and pe.pessoa_id    = mc.pessoa_id 
       and en.nro          <> 'S/N' 
       and cp.estado_civil in (0,1,2,3,4) 
       and rownum          <= 1000
       
       
       SELECT * FROM PESSOA_FELIPE
       ORDER BY PESFELIPE_ID ASC
