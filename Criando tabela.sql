create table client( -- = criando tabela 
 i_cliente_cliente integer primary key not null,
 s_nomecli_cliente varchar2(50) not null,
 c_cpf_cliente char(11) not null,
 d_datanasci_cliente date
);

create sequence client_seq nocache; -- = criar sequencia 

drop table client; -- = deletar tabela/BD/schema
