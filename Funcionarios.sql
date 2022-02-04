
use curso
go


create table FUNCIONARIOS
(
 ID int identity (1,1) not null primary key,
 NOME varchar (50) not null,
 SALARIO decimal (10,2),
 SETOR varchar (30)
);

--BUSCANDO DADOS:

select * from FUNCIONARIOS;

--CRIANDO COLUNAS:

 select nome,setor
 from   FUNCIONARIOS

 
--INSERT DE DADOS DOS FUNCIONARIOS:

insert into FUNCIONARIOS values ('João',1000,''), ('Jose',2000,''), ('Alexandre',3000,'');


--AUMENTO DE 50% NO SALARIO DO FUNCIONARIO "8":

 update FUNCIONARIOS set salario = salario*1.5
 where id = '1';

--DELETE DE FUNCIONARIOS   
--delete FUNCIONARIOS
 --where id='13';

 select * from FUNCIONARIOS;

--AUMENTANDO SALARIO E ADD SETOR EM ID'S DIFERENTES DE 8: 

update FUNCIONARIOS set salario = salario*1.5,setor= 'TI'
 where id <> '1';