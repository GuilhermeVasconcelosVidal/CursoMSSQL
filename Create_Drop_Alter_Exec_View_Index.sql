USE curso;
GO

create table colaborador
(
  matricula int identity (1,1) not null primary key,
  nome      varchar (50) not null,
  sobrenome varchar (50) not null,
  endereco  varchar (50),
  cidade    varchar (50),
  pais      varchar (25),
  data_nasc date not null check(data_nasc<getdate()),
  data_cadastro datetime default getdate(),
  situacao char (1) default ('A')
);
-- CRIANDO TABELA COM CHAVE ESTRANGEIRA
create table salario
(
  matricula int primary key not null,
  salario   decimal(10,2) not null check (salario>0),
  foreign key(matricula) references colaborador(matricula)
);

  alter table colaborador add primary key (matricula); 

--CRIACAO DE TABELA COM CHAVE PRIMARIA
create table audit_salario
  (
       transacao int identity(1,1) not null	primary key,
	   matricula int not null,
	   data_trans datetime not null,
	   sal_antigo decimal(10,2),
	   sal_novo   decimal(10,2),
       usuario    varchar(20) not  null
   );

--ADD CHAVE ESTRANGEIRA
alter table audit_salario
add foreign key (matricula) references colaborador(matricula);

--CRIACAO DE INDEX

  create index ix_func1 on colaborador(data_nasc);
  create index ix_func2 on colaborador(cidade,pais);
  
-- ADD NOVO CAMPO NA TABELA 

  alter table colaborador add genero char(1);

--RENOMEANDO CAMPO DA TABELA

  exec Sp_rename 'colaborador.endereco', 'ender', 'column'

--ALTERANDO TIPO DA COLUNA

  alter table colaborador alter column ender varchar(30);

--EXCLUINDO CAMPO DA COLUNA 

  alter table colaborador drop column genero;

--EXCLUINDO CHAVE ESTRANGEIRA

alter table salario
drop constraint FK__salario__matricu__1CBC4616;

--RENOMEANDO TABELAS
exec Sp_rename   'colaborador','FUNC';

exec Sp_rename   'FUNC','colaborador';


--CRIANDO UMA BASE DE DADOS
create database teste;

--EXCLUINDO UMA BASE DE DADOS 

drop database teste;

--EXCLUINDO TABLE 

drop table salario;

-- CRIACAO DE VIEW

create view v_colaborador
    as
	select * from colaborador;

--ALTER VIEW 

alter view v_colaborador
   as
   select matricula,nome from colaborador;

--EXCLUINDO VIEW

drop view v_colaborador;

--EXCLUINDO INDEX

drop index ix_func1 on colaborador;

--CRIANDO INDEX
create index IX_FUNC1 on colaborador (nome);

--EXCLUINDO PROCEDURE

drop procedure proc_salario;

--EXCLUINDO FUNÇÃO

drop function func_salario;

--EXCLUINDO TRIGGER

drop trigger trig_func_salario;

--DDL TRUNCATE

select * into senso_bk from senso;

--VERIFICANDO DADOS 

select * from senso_bk;

--REALIAZANDO TRUNCATE

truncate table senso_bk;

--DDL TRUNCATE VRERIFICANDO

--FAZENDO BK EM TABELA TEMPORARIA 
select * into #bk_senso2 from senso;

--VERIFICANDO REGISTRO TABELA TEMPORARIA

select * from #bk_senso2;

--ANALISE DE REGISTROS ANTES DO TRUNCATE 
select count(*) as AntesTruncateCount
from   #bk_senso2;

--DDL TRUNCATE APAGAR DADOS DA TABELA 
truncate table senso;

--VERIFICANDO TABELAS APOS TRUNCATE
select count(*) as DepoisTruncateCount
from   senso;


--POPULANDO A TABELA COM DADOS DA TABELA TEMPORARIA
insert into senso
select * from #bk_senso2

--VERIFICANDO REGISTRO
select * from senso;















