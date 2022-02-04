--DATEDIFF

--DIFERENÇA DE DIAS 

  SELECT DATEDIFF(DAY,'2004-05-23', '2021-12-29');

--DIFERENÇA DE MESES

  SELECT DATEDIFF(MONTH,'2004-05-23','2021-12-29');

--DIFEENÇA DE ANOS 
 
  SELECT DATEDIFF(YEAR,'2004-05-23','2021-12-29');

--ATRAVES DESTE COMANDO PODEMOS DESCOBRIR HA QUANTOS DIAS/MESES OU ANOS TEMOS DE VIDA.

--DIFERENÇA EM DIA 

  SELECT DATEDIFF(DAY,'2004-05-23', GETDATE());

--DIFERENÇA DE MESES 

SELECT DATEDIFF(MONTH,'2004-05-23', GETDATE());


--DIFERENÇA DE ANOS 

  SELECT DATEDIFF(YEAR,'2004-05-23', GETDATE());


--EXEMPLO 

USE crm;


  SELECT a.id_cliente,
         a.nascimento,
		 GETDATE() hoje,
		 DATEDIFF(DAY,a.nascimento,GETDATE())  dif_dia,	
		 DATEDIFF(MONTH,a.nascimento,GETDATE())dif_mes,
		 DATEDIFF(YEAR,a.nascimento,GETDATE()) dif_ano
  FROM cliente a
  WHERE a.nascimento> '1980-01-01';


--DATEADD

--ADICIONANDO 90 DIAS

  SELECT GETDATE() agora,
         DATEADD (DAY, 90, GETDATE())

--ADD 2 MESES 

  SELECT GETDATE() agora,
         DATEADD (MONTH, 2, GETDATE())

--ADD 3 ANOS
 
  SELECT GETDATE() agora,
         DATEADD(YEAR, 3, GETDATE())

--EXEMPLO

USE curso;

--DROP TABLE CONTAS 

CREATE TABLE contas
( 
  id_cont INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  data_conta DATE NOT NULL,
  dias INT,
  data_vencimento date,
  valor decimal (10,2),
  situacao char(1) DEFAULT('A')
  ); 

--INSERINDO DADOS 

  INSERT INTO contas (data_conta, dias, valor) VALUES ('2021-12-29', 10, 25.75);

  INSERT INTO contas (data_conta, dias, valor) VALUES ('2021-12-29', 30, 40.75);

  INSERT INTO contas (data_conta, dias, valor) VALUES ('2021-12-29', 60, 30.75);


--EXEMPLO 

 SELECT id_cont, data_conta, dias, data_vencimento, valor FROM contas;


 --trazendo o valor na consulta 

   SELECT id_cont,
          data_conta,
		  dias,
		  DATEADD(DAY, dias, data_conta)vencto,
		  valor	FROM contas;
--REALIZANDO UPDATE
  UPDATE contas SET data_vencimento = DATEADD(DAY,dias, data_conta)
  WHERE data_vencimento IS NULL

--VERIFICANDO

  SELECT * FROM contas 







