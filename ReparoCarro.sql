--============================== DDL =============================
-- Tables

create table PESSOA (
       codpessoa number(10) not null,
       nome varchar2(100) not null,
       endereco varchar2(300) not null,
       telefone varchar2(14)
);

create table COR (
       codcor number(10) not null,
       descricao varchar2(200) not null
);

create table MARCA (
       codmarca number(10) not null,
       descricao varchar2(200) not null
);

create table MODELO (
       codmodelo number(10) not null,
       descricao varchar2(200) not null
);

create table VEICULO (
       codveiculo number(10) not null,
       renavam varchar2(20) not null,
       placa varchar2(10) not null,
       descricao varchar2(200) not null,
       codcor number(10) not null,
       codmodelo number(10) not null,
       codmarca number(10) not null
);

create table FUNCIONARIO (
       codfuncionario number(10) not null,
       codcategoria number(10) not null
);

create table CATEGORIA (
       codcategoria number(10) not null,
       descricao varchar2(100) not null,
       customo number(14,2) not null
);

create table PESSOAVEIC (
       codpessoaveiculo number(10) not null,
       codpessoa number(10) not null,
       codveiculo number(10) not null
);

create table PECA (
       codpeca number(10) not null,
       descricao varchar2(200) not null,
       qtdEstoque number(10) default 0 not null,
       valor number(10,2) not null
);

create table REPARO (
       codreparo number(10) not null,
       dtreparo date not null,
       codfunc number(10) not null,
       codpessoa number(10) not null,
       codveiculo number(10) not null,
       tempomo number(10,2),
       custototal number(10,2)
);

create table REPAROITEM (
       codreparoitem number(10) not null,
       codreparo number(10) not null,
       codpeca number(10) not null,
       qtd number(10) not null
);

-- Constraints

   -- primary key
alter table PESSOA add constraint PK_PESSOA primary key (codpessoa) using index tablespace AULA_INIDCE;
alter table COR add constraint PK_COR primary key (codcor) using index tablespace AULA_INIDCE;
alter table MARCA add constraint PK_MARCA primary key (codmarca) using index tablespace AULA_INIDCE;
alter table MODELO add constraint PK_MODELO primary key (codmodelo) using index tablespace AULA_INIDCE;
alter table VEICULO add constraint PK_VEICULO primary key (codveiculo) using index tablespace AULA_INIDCE;
alter table FUNCIONARIO add constraint PK_FUNCIONARIO primary key (codfuncionario) using index tablespace AULA_INIDCE;
alter table CATEGORIA add constraint PK_CATEGORIA primary key (codcategoria) using index tablespace AULA_INIDCE;
alter table PESSOAVEIC add constraint PK_PESSOAVEIC primary key (codpessoaveiculo) using index tablespace AULA_INIDCE;
alter table PECA add constraint PK_PECA primary key (codpeca) using index tablespace AULA_INIDCE;
alter table REPARO add constraint PK_REPARO primary key (codreparo) using index tablespace AULA_INIDCE;
alter table REPAROITEM add constraint PK_REPAROITEM primary key (codreparoitem) using index tablespace AULA_INIDCE;

  -- foreign key
alter table VEICULO add 
      constraint FK_VEICULO_COR foreign key (codcor) references COR(Codcor);
      
alter table VEICULO add 
      constraint FK_VEICULO_MARCA foreign key (codmarca) references MARCA(codmarca);
      
alter table VEICULO add 
      constraint FK_VEICULO_MODELO foreign key (codmodelo) references MODELO(codmodelo);
      
alter table FUNCIONARIO add 
      constraint FK_FUNC_PESSOA foreign key (codfuncionario) references PESSOA(codpessoa);

alter table FUNCIONARIO add 
      constraint FK_FUNC_CATEG foreign key (codcategoria) references CATEGORIA(codcategoria);

alter table PESSOAVEIC add 
      constraint FK_PESVEI_PES foreign key (codpessoa) references PESSOA(codpessoa);

alter table PESSOAVEIC add 
      constraint FK_PESVEI_VEI foreign key (codveiculo) references VEICULO(codveiculo);
      
alter table REPARO add 
      constraint FK_REP_PES foreign key (codpessoa) references PESSOA(codpessoa);
      
alter table REPARO add 
      constraint FK_REP_FUN foreign key (codfunc) references FUNCIONARIO(codfuncionario);
      
alter table REPARO add 
      constraint FK_REP_VEI foreign key (codveiculo) references VEICULO(codveiculo);

alter table REPAROITEM add 
      constraint FK_REPITEM_REP foreign key (codreparo) references REPARO(codreparo);

alter table REPAROITEM add 
      constraint FK_REPITEM_PEC foreign key (codpeca) references PECA(codpeca);

-- Index
create index IDX_VEIC_COR on VEICULO(codcor) tablespace AULA_INIDCE;
create index IDX_VEIC_MARCA on VEICULO(codmarca) tablespace AULA_INIDCE;
create index IDX_VEIC_MODELO on VEICULO(codmodelo) tablespace AULA_INIDCE;
create index IDX_FUNC_CATEGORIA on FUNCIONARIO(codcategoria) tablespace AULA_INIDCE;
create index IDX_PESVEI_PES on PESSOAVEIC(codpessoa) tablespace AULA_INIDCE;
create index IDX_PESVEI_VEI on PESSOAVEIC(codveiculo) tablespace AULA_INIDCE;
create index IDX_REP_PES on REPARO(codpessoa) tablespace AULA_INIDCE;
create index IDX_REP_FUNC on REPARO(codfunc) tablespace AULA_INIDCE;
create index IDX_REP_VEI on REPARO(codveiculo) tablespace AULA_INIDCE;
create index IDX_REPI_REP on REPAROITEM(codreparo) tablespace AULA_INIDCE;
create index IDX_REPI_VEI on REPAROITEM(codpeca) tablespace AULA_INIDCE;


-- Comments

comment on table PESSOA is 'Pessoas';
comment on table COR is 'Cor de veículos';
comment on table MARCA is 'Marca de veículos';
comment on table MODELO is 'Modelo de veículos';
comment on table VEICULO is 'Veículos';
comment on table FUNCIONARIO is 'Funcionário';
comment on table CATEGORIA is 'Categoria de Funcionários';
comment on table PESSOAVEIC is 'Pessoa / Veículos';
comment on table PECA is 'Peças';
comment on table REPARO is 'Reparos';
comment on table REPAROITEM is 'Itens de Reparos';


comment on column CATEGORIA.CODCATEGORIA is 'Identificador de Categoria';
comment on column CATEGORIA.DESCRICAO is 'Descrição';
comment on column CATEGORIA.CUSTOMO is 'Custo de mão de obra';
comment on column COR.CODCOR is 'Identificador de Cor';
comment on column COR.DESCRICAO is 'Descrição';
comment on column FUNCIONARIO.CODFUNCIONARIO is 'Identificador de Funcionário';
comment on column FUNCIONARIO.CODCATEGORIA is 'Identificador de Categoria';
comment on column MARCA.CODMARCA is 'Identificador de Marca';
comment on column MARCA.DESCRICAO is 'Descrição';
comment on column MODELO.CODMODELO is 'Identificador de Modelo';
comment on column MODELO.DESCRICAO is 'Descrição';
comment on column PECA.CODPECA is 'Identificador de Peça';
comment on column PECA.DESCRICAO is 'Descrição';
comment on column PECA.QTDESTOQUE is 'Quantidade em Estoque';
comment on column PECA.VALOR is 'Valor unitário';
comment on column PESSOA.CODPESSOA is 'Identificador de Pessoa';
comment on column PESSOA.NOME is 'Nome';
comment on column PESSOA.ENDERECO is 'Endereço';
comment on column PESSOA.TELEFONE is 'Telefone';
comment on column PESSOAVEIC.CODPESSOA is 'Identificador de Pessoa';
comment on column PESSOAVEIC.CODVEICULO is 'Identificador de Veículo';
comment on column PESSOAVEIC.CODPESSOAVEICULO is 'Identicador Pessoa/Veículo';
comment on column REPARO.CODREPARO is 'Identificador de Reparo';
comment on column REPARO.DTREPARO is 'Data do Reparo';
comment on column REPARO.CODFUNC is 'Identificador de Funcionário';
comment on column REPARO.CODPESSOA is 'Identificador de Pessoa';
comment on column REPARO.CODVEICULO is 'Identificador de Veículo';
comment on column REPARO.TEMPOMO is 'Tempo de M.O.';
comment on column REPARO.CUSTOTOTAL is 'Valor Total';
comment on column REPAROITEM.CODREPAROITEM is 'Identificador Reparo Item';
comment on column REPAROITEM.CODREPARO is 'Identificador de Reparo';
comment on column REPAROITEM.CODPECA is 'Identificador de Peça';
comment on column REPAROITEM.QTD is 'Quantidade';
comment on column VEICULO.CODVEICULO is 'Identificador do Veículo';
comment on column VEICULO.RENAVAM is 'Código RENAVAM';
comment on column VEICULO.PLACA is 'Placa';
comment on column VEICULO.DESCRICAO is 'Descrição';
comment on column VEICULO.CODCOR is 'Identificador de Cor';
comment on column VEICULO.CODMODELO is 'Identificador de Modelo';
comment on column VEICULO.CODMARCA is 'Identificador de Marca';

-- sequences

create sequence SEQ_PESSOA start with 1 nocycle nocache;
create sequence SEQ_COR start with 1 nocycle nocache;
create sequence SEQ_MARCA start with 1 nocycle nocache;
create sequence SEQ_MODELO start with 1 nocycle nocache;
create sequence SEQ_VEICULO start with 1 nocycle nocache;
create sequence SEQ_FUNCIONARIO start with 1 nocycle nocache;
create sequence SEQ_CATEGORIA start with 1 nocycle nocache;
create sequence SEQ_PESSOAVEIC start with 1 nocycle nocache;
create sequence SEQ_PECA start with 1 nocycle nocache;
create sequence SEQ_REPARO start with 1 nocycle nocache;
create sequence SEQ_REPAROITEM start with 1 nocycle nocache;


--============================== DML =============================

--- Insert 


insert into pessoa(codpessoa,
                   nome,
                   endereco,
                   telefone) values (seq_pessoa.nextval, 'Pedro', 'End 1', '1111-1111');
                   

insert into pessoa(codpessoa,
                   nome,
                   endereco,
                   telefone) values (seq_pessoa.nextval, 'Maria', 'End 2', '2222-1111');
insert into pessoa(codpessoa,
                   nome,
                   endereco,
                   telefone) values (seq_pessoa.nextval, 'Ana', 'End 3', '3333-1111');
insert into pessoa(codpessoa,
                   nome,
                   endereco,
                   telefone) values (seq_pessoa.nextval, 'Marcos', 'End 4', '4444-1111');
insert into pessoa(codpessoa,
                   nome,
                   endereco,
                   telefone) values (seq_pessoa.nextval, 'Ronaldo', 'End 5', '5555-1111');
                   
                   
                   
insert into cor (codcor, descricao) values (seq_cor.nextval, 'Azul');
insert into cor (codcor, descricao) values (seq_cor.nextval, 'Branco'); 
insert into cor (codcor, descricao) values (seq_cor.nextval, 'Preto'); 
insert into cor (codcor, descricao) values (seq_cor.nextval, 'Amarelo'); 
insert into cor (codcor, descricao) values (seq_cor.nextval, 'Cinza');  


insert into modelo (codmodelo, descricao) values (seq_modelo.nextval, 'Caminhonete');    
insert into modelo (codmodelo, descricao) values (seq_modelo.nextval, 'Carro Passeio');  
insert into modelo (codmodelo, descricao) values (seq_modelo.nextval, 'Carro Esportivo');  
insert into modelo (codmodelo, descricao) values (seq_modelo.nextval, 'Caminhao');  

insert into marca(codmarca, descricao) values (seq_marca.nextval, 'Ford');
insert into marca(codmarca, descricao) values (seq_marca.nextval, 'Fiat');
insert into marca(codmarca, descricao) values (seq_marca.nextval, 'Jeep');
insert into marca(codmarca, descricao) values (seq_marca.nextval, 'Chery');
insert into marca(codmarca, descricao) values (seq_marca.nextval, 'BMW');

insert into veiculo (codveiculo,
                     renavam,
                     placa,
                     descricao,
                     codcor,
                     codmodelo,
                     codmarca) values (seq_veiculo.nextval, 'RNV1', 'PLC01', 'Compass', 1, 1, 3);
insert into veiculo (codveiculo,
                     renavam,
                     placa,
                     descricao,
                     codcor,
                     codmodelo,
                     codmarca) values (seq_veiculo.nextval, 'RNV2', 'PLC02', 'Commander', 2, 1, 3);   
insert into veiculo (codveiculo,
                     renavam,
                     placa,
                     descricao,
                     codcor,
                     codmodelo,
                     codmarca) values (seq_veiculo.nextval, 'RNV3', 'PLC03', 'Ecosport', 3, 2, 1);
insert into veiculo (codveiculo,
                     renavam,
                     placa,
                     descricao,
                     codcor,
                     codmodelo,
                     codmarca) values (seq_veiculo.nextval, 'RNV4', 'PLC04', 'Z4', 2, 3, 5); 
insert into veiculo (codveiculo,
                     renavam,
                     placa,
                     descricao,
                     codcor,
                     codmodelo,
                     codmarca) values (seq_veiculo.nextval, 'RNV5', 'PLC05', 'X6', 4, 2, 5);                                                                           


insert into categoria(codcategoria,
                      descricao,
                      customo) values (seq_categoria.nextval, 'Mecânico', 100);
insert into categoria(codcategoria,
                      descricao,
                      customo) values (seq_categoria.nextval, 'Funileiro', 90);                     

insert into funcionario(codfuncionario, codcategoria) values (1,1);     
insert into funcionario(codfuncionario, codcategoria) values (3,2);       


insert into pessoaveic(codpessoa,
                       codveiculo,
                       codpessoaveiculo) values (2,1,seq_pessoaveic.nextval);  
insert into pessoaveic(codpessoa,
                       codveiculo,
                       codpessoaveiculo) values (4,3,seq_pessoaveic.nextval);         
insert into pessoaveic(codpessoa,
                       codveiculo,
                       codpessoaveiculo) values (5,2,seq_pessoaveic.nextval);  
                       
insert into peca(codpeca,
                 descricao,
                 qtdestoque,
                 valor) values (seq_peca.nextval, 'Parafuso', 10, 1.50);  
                 
insert into peca(codpeca,
                 descricao,
                 qtdestoque,
                 valor) values (seq_peca.nextval, 'Porca', 200, 0.50);  
insert into peca(codpeca,
                 descricao,
                 qtdestoque,
                 valor) values (seq_peca.nextval, 'Bateria', 3, 230.80);  
                 
insert into reparo(codreparo,
                   dtreparo,
                   codfunc,
                   codpessoa,
                   codveiculo,
                   tempomo,
                   custototal) values (seq_reparo.nextval, sysdate -2, 1,4,3,2,0);   
insert into reparo(codreparo,
                   dtreparo,
                   codfunc,
                   codpessoa,
                   codveiculo,
                   tempomo,
                   custototal) values (seq_reparo.nextval, sysdate -4, 3,5,2,5,0);   
                   
insert into reparoitem(codreparoitem,
                       codreparo,
                       codpeca,
                       qtd) values (seq_reparoitem.nextval,1,1,2);     
insert into reparoitem(codreparoitem,
                       codreparo,
                       codpeca,
                       qtd) values (seq_reparoitem.nextval,1,2,3);     
insert into reparoitem(codreparoitem,
                       codreparo,
                       codpeca,
                       qtd) values (seq_reparoitem.nextval,2,3,4);                                                                                                                                           
                       
                       
                       
--- Update

-- Colocar a descricao da cor em Maiusculo
update cor set descricao = upper(descricao);   

-- Altera cor  Azul para Azul Claro
update cor set descricao = 'Azul Claro'
where upper(descricao) = 'AZUL';  

-- Alterar para minusculo cores com codigo menor que 4 e que possuem a letra B na descricao // LIKE
update cor set descricao = lower(descricao)
where codcor < 4
and upper(descricao) like ('%B%');  


-- Delete 

-- apagar veiculo de codigo 3
delete veiculo where codveiculo = 3;

-- apagar veiculos que nao possui vinculo com pessoas  // EXISTS
delete veiculo v where not exists (select 1 from pessoaveic p where p.codveiculo = v.codveiculo);   

--============================== DQL (SELECT) =============================  


-- Recuperar a pessoa e seus veiculos

select p.codpessoa, p.nome, v.descricao
from pessoa p, pessoaveic pv, veiculo v
where p.codpessoa = pv.codpessoa
and pv.codveiculo = v.codveiculo;


select p.codpessoa, p.nome, v.descricao
from pessoa p
inner join pessoaveic pv on (p.codpessoa = pv.codpessoa)
inner join veiculo v on ( pv.codveiculo = v.codveiculo );


-- Peca ordenadas por estoque decrescente
select *
from peca p
order by p.qtdestoque desc


-- Quantidade de veiculos por marca

select m.descricao marca_veiculo, count(1) qtd
from veiculo v, marca m
where v.codmarca = m.codmarca
group by m.descricao
order by 2 asc, 1 asc;


--============================== View =============================

create or replace view FUNCCATEG as
select f.codfuncionario, p.nome, c.codcategoria, c.descricao, c.customo
from pessoa p, funcionario f, categoria c
where p.codpessoa = f.codfuncionario 
and f.codcategoria = c.codcategoria;
 


select * from funccateg fc, reparo r
where fc.codfuncionario = r.codfunc;


-- RECUPERAR FUNCIONARIO E REPARO DE VEICULOS CUJA COR SEJA AZUL OU AMARELO
select * from funccateg fc, reparo r, veiculo v
where fc.codfuncionario = r.codfunc
and r.codveiculo = v.codveiculo
and v.codcor in (select codcor from cor where upper(descricao) like ('%AMARELO%') OR upper(descricao) like ('%AZUL%'));
