
--CRIANDO TESTE 
create table cadastro
(
 nome varchar(50) not null,
 docto varchar(50) not null
);

-- INICIA TRANSA플O

begin transaction;

--INSERE REGISTROS
insert into cadastro values   ('Andre','12341244') 
insert into cadastro values   ('Joao','12341248')
insert into cadastro values   ('Pedro','12341246')

--SELECT DOS REGISTROS INSERIDOS
select * from cadastro


--RETOTRNA A TABELA NO ESTADO ANTERIOR DO BEGIN TRANSACTION
rollback;

--SALVAR TABELA 
commit transaction;

--LIMPANDO A TABELA 
delete from cadastro;

begin transaction;

--INSERE CADASTRO
insert into cadastro values ('Andre','12341244');

--CRIA PONTO DE RECUPERA플O
save transaction a1;

--INSERE CADASTRO
insert into cadastro values ('Joao','12341248');

--CRIA PONTO DE RECUPERA플O 
save transaction a2;

--INSERE CADASTRO
insert into cadastro values ('Pedro','12341246');

--CRIA PONTO DE RECUPERA플O
save  transaction a3;

--VERIFICA CADASTRO
select * from cadastro;

--RESTAURA TABELA ATE O PONTO A2
ROLLBACK TRANSACTION A2;

COMMIT TRANSACTION;



