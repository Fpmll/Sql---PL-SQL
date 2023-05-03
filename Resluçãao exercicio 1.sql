--1)
SELECT NRO
     , DT_INCL
     , USU_ID
     , TARA
     , PAYLOAD
  FROM RECIP_CARGA_EXP
  order by dt_incl asc;

--2)-----------------------------

SELECT nro
     , dt_incl
     , usu_id
     , tara
     , payload
  FROM recip_carga_exp rce
 where dt_incl >= '01-jan-2021' 
   and dt_incl <= '15-jan-2021'
 order by dt_incl asc;

--3)------------------------------------

SELECT rce.nro
     , rce.dt_incl
     , rce.usu_id
     , u.nome
     , rce.tara
     , rce.payload
  from Recip_Carga_Exp rce
     , usu             u
 where u.usu_id = rce.usu_id
   and rce.dt_incl >= '1-jan-2021' 
   and rce.dt_incl <= '15-jan-2021';

--4)-------------------------------------------

       
select u.usu_id
     , u.nome
     , sum(rce.tara) as tara
     , sum( rce.payload) as payload
     , count(rce.recpcarexp_id) recipientes
  from recip_carga_exp rce
     , usu             u
 where rce.usu_id = u.usu_id
 and rce.dt_incl >= '01-jan-21'
 and rce.dt_incl < '16-jan-21'
 group by u.usu_id
        , u.nome;


--5)-----------------------------------

select max(recpcarexp_id)
  from recip_carga_exp;

--6)-----------------------------------


SELECT  rce.recpcarexp_id
      , rce.nro
      , rce.dt_incl
      , rce.unidcarga_id
      , rce.usu_id
      , rce.carrocveic_id
      , rce.tara
      , rce.payload
   FROM recip_carga_exp       rce
      , vigen_recip_carga_exp vrce
  where vrce.recpcarexp_id = rce.recpcarexp_id;

--7)-------------------------------------------------

SELECT  rce.recpcarexp_id
      , rce.nro
      , rce.dt_incl
      , rce.unidcarga_id
      , rce.usu_id
      , rce.carrocveic_id
      , rce.tara
      , rce.payload
   FROM recip_carga_exp       rce
      , vigen_recip_carga_exp vrce
  where vrce.recpcarexp_id = rce.recpcarexp_id
    and vrce.dt_emb is null;

--8)---------------------------------------------------

SELECT rce.nro
     , drce.dt
  FROM recip_carga_exp       rce
     , vigen_recip_carga_exp vrce
     , devol_recip_carga_exp drce 
 where vrce.recpcarexp_id = rce.recpcarexp_id
   and drce.vigrecpcex_id = vrce.vigrecpcex_id ; 


--9)------------------------------------------------

SELECT rce.nro
     , drce.dt
  FROM recip_carga_exp       rce
     , vigen_recip_carga_exp vrce
     , devol_recip_carga_exp drce 
 where vrce.recpcarexp_id = rce.recpcarexp_id
   and drce.vigrecpcex_id = vrce.vigrecpcex_id  
   and drce.dt >= '01-jan-21'
   and drce.dt  < '31-jan-21';


--10)-------------------------------------------------


select distinct u.nome
  from usu              u
     , contrata_transp  ct
 where u.usu_id = ct.usu_id;

--11)-----------------------------------



select distinct u.nome
     , rce.nro
  from usu u
     , contrata_transp ct
     , recip_carga_exp rce
 where u.usu_id = ct.usu_id
   and u.usu_id = rce.usu_id;

--12)------------------------------------
 
 select u.cd_usu_bd usu
      , rce.nro
      , ect.seq
   from contrata_transp        ct
      , usu                    u
      , vigen_recip_carga_exp  vrc
      , recip_carga_exp        rce
      , evento_contrato_transp ect
  where ct.usu_id         = u.usu_id
    and ct.vigrecpcex_id  = vrc.vigrecpcex_id
    and vrc.recpcarexp_id = rce.recpcarexp_id
    and ct.contrtrans_id  = ect.contrtrans_id;
 
--13)--------------------------------------------------

select rce.nro
     , n.nro
  from vigen_recip_carga_exp  vrc
     , recip_carga_exp        rce
     , nota_vigen_recip_carga nvr
     , nfsa                   n
 where vrc.recpcarexp_id = rce.recpcarexp_id
   and vrc.vigrecpcex_id = nvr.vigrecpcex_id
   and nvr.nfsa_id = n.nfsa_id;

--14)----------------------------------------------

SELECT t.*
  FROM tipo_lacre_tv t;

--15)------------------------------------------------

SELECT rce.nro
     , lpe.lacre
     , tlt.descr
FROM tipo_lacre_tv tlt
     , lacre_plano_embarq_exp lpe
     , vigen_recip_carga_exp  vrce
     , recip_carga_exp        rce
 where lpe.tplacretv_id = tlt.tplacretv_id
   and lpe.vigrecpcex_id = vrce.vigrecpcex_id
   and vrce.recpcarexp_id = rce.recpcarexp_id;

--16)----------------------------------------------

 

select rc.nro
     , cve.placa
  from carroc_veiculo  cve
     , recip_carga_exp rc
 where cve.carrocveic_id = rc.carrocveic_id;

--17)---------------------------------------------

select hivrc.descr  logs
     , rce.nro       nro
  from hist_inf_vigen_recip_carga hivrc
     , vigen_recip_carga_exp         vi
     , recip_carga_exp              rce
 where hivrc.vigrecpcex_id = vi.vigrecpcex_id
   and vi.recpcarexp_id = rce.recpcarexp_id;

--18)--------------------------------------------

select hai.descr as logs
     , re.nro    as nro
     , hai.tipo  as tipo
     , ( SELECT rv_meaning
           FROM cg_ref_codes
          where rv_domain = 'HIST_INF_VIGEN_RECIP_CARGA.TIPO'
            and rv_low_value = hai.tipo
       ) tipo_descr
  from hist_inf_vigen_recip_carga hai
     , vigen_recip_carga_exp      vi
     , recip_carga_exp            re
 where hai.vigrecpcex_id = vi.vigrecpcex_id
   and vi.recpcarexp_id = re.recpcarexp_id
   and hai.tipo in (2);
