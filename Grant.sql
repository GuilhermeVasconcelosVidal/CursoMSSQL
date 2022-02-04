--Parte 1 CONCEDE-GRANT
-- Cria um login e dá permissões no banco

exec master.dbo.sp_addlogin 'UsrTeste','SenhaTeste';

use curso;
go
--Adiocnar
EXEC sp_grantdbaccess 'UsrTeste';

--EXEC sp_revokedbaccess 'UsrTeste';


--Concedendo Acesso DE ATUALIZACAO PARA UsrTeste.
GRANT UPDATE ON FUNCIONARIOS TO UsrTeste; 

--Concedendo Acesso DE INSERT PARA UsrTeste.
GRANT INSERT ON FUNCIONARIOS TO UsrTeste; 

--Concedendo Acesso DE Leitura PARA UsrTeste.
GRANT SELECT ON FUNCIONARIOS TO UsrTeste;

--Concedendo Acesso DE DELETE PARA UsrTeste.
GRANT DELETE ON FUNCIONARIOS TO UsrTeste;


--criando procedure

CREATE PROCEDURE testproc2 
as
select * from SENSO

--executando procedure
EXEC testproc2

--Concedendo Acesso PARA EXCUTAR PROC TESTE_PROC PARA UsrTeste.
GRANT EXECUTE ON testproc TO UsrTeste  

--VERIFICANDO USUARIO LOGADO
select CURRENT_USER

--ALTERANDO USUARIO LOGADO

SETUSER 'UsrTeste'
--VERIFICANDO USUARIO LOGADO
select CURRENT_USER

--EXECUTANDO PROCEDURE COM USUARIO UsrTeste
EXEC testproc2

--TESTANDO SELECT
SELECT  * from FUNCIONARIOS;

--TESTANDO INSERT
INSERT into FUNCIONARIOS values ('Mariana','2000','TI')

--TESTANDO UPDATE
UPDATE FUNCIONARIOS set nome='Maisa'
where id='9';

--TESTANDO DELETE
DELETE FROM FUNCIONARIOS
WHERE ID='5';


SETUSER 

select CURRENT_USER;