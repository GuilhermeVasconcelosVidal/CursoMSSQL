USE AdventureWorks2017;
--EXEMPLO 1
  DECLARE @meuvalor DECIMAL (5,2);
  SET @meuvalor = 193.57;

--OR, USING CAST
  SELECT CAST(@meuvalor AS VARBINARY(20));
  SELECT CAST(CAST(@meuvalor AS VARBINARY(20)) AS DECIMAL(5,2));
 
  --OR USING CONVERT
  SELECT CONVERT(VARBINARY(20), @meuvalor);
  SELECT CONVERT (DECIMAL(5,2), CONVERT(VARBINARY(20), @meuvalor));

--USE CAST 

USE AdventureWorks2017;
  SELECT SUBSTRING(NAME, 1, 30) AS ProducName,
  listprice
  FROM production.product
  WHERE CAST(listprice AS INT) LIKE '3%';

--USER CONVERT


  SELECT SUBSTRING(NAME, 1, 30) AS ProducName,
  listprice
  FROM production.product
  WHERE CONVERT(INT, listprice) LIKE '3%';


--FORMATANDO CAST E ARREDONDANDO
--USANDO CAST COM OPERADORES MATEMATICOS

  SELECT CAST(ROUND(salesytd / commissionpct, 0) AS INT) AS formatado,
                   (salesytd / commissionpct ) nao_format
  FROM sales.SalesPerson
  WHERE CommissionPct <> 0;

--USANDO CAST PARA CONCATENAR
  
  SELECT 'A lista de preco é' + listprice AS Lista_preco
  FROM production.product
  WHERE listprice BETWEEN 350.00 AND 400.00
 
--USANDO CAST PARA CONCATENAR DISTINCT
  SELECT DISTINCT 'A lista de preco é ' + cast(listprice AS VARCHAR(12)) AS Lista_preco
  FROM production.product
  WHERE listprice BETWEEN 350.00 AND 400.00;


--USANDO CAST PARA PRODUZIR TEXTO MAIS LEGIVEL
  
  SELECT DISTINCT 
  p.NAME,
  CAST(p.NAME AS CHAR (10)) AS Nome_tratado,
      s.unitprice 
  FROM   sales.salesorderdetail AS s
      JOIN production.product AS p
	  ON s.productid = p.productid
  WHERE	 p.NAME LIKE 'Long-Sleeve Logo Jersey, M';

--USANDO CAST COM CLAUSULA LIKE 

  SELECT p.firstname,
         p.lastname,
		 s.salesytd,
		 s.businessentityid,
		 CAST(CAST(s.salesytd AS INT ) AS CHAR(30) ) cast_1,
		 CAST(s.salesytd AS CHAR (30) )	AS cast_2
  FROM   person.person AS p
      JOIN sales.salesperson AS s
	  ON p.businessentityid = s.businessentityid
  WHERE CAST(CAST(s.salesytd AS INT) AS CHAR (20) ) LIKE '2%';

--TRY CAST
  
  SELECT 
      CASE WHEN TRY_CAST('TESTE' AS float) IS NULL
	  THEN 'Cast Falhou!'
	  ELSE 'Cast OK!'
END AS Resultado;

--TRY CAST 

  SELECT
      CASE WHEN TRY_CAST(52 AS float) IS NULL
	  THEN 'Cast Falhou!'
	  ELSE 'Cast OK!'
END AS Resultado;


--TRY CAST (SIMULANDO ERRO)

SET DATEFORMAT dmy;
SELECT TRY_CAST ('12/31/2021' AS DATETIME) AS Resultado;
GO

--TRY CAST 

SET DATEFORMAT dmy;
SELECT TRY_CAST ('27/12/2021' AS DATETIME) AS Resultado;
GO

--EXEMPLO PARSE
--Retorna o resultado de uma epressão, convertida no tipo de dados solicitado no SQL SERVER
/*
sting_value deve ser uma representação válida do tipo de dados solicitado, ou PARSE gera um erro.

data_type 
Valor literal que representa o tipo de dados solicitado para o resultado.

culture 
Cadeia de caracteres opcional que identifica a cultura na qual string_value é formatado.
*/

--CONFIGUÇÃO EXPLICITA DE IDIOMA

SELECT PARSE('Monday, 13 December 2010' AS DATETIME USING 'en-US') AS Resultado;

SELECT PARSE('Segunda-feira, 13 Dezembro 2010' AS DATETIME USING 'pt-BR') AS Result;

--CONFIGURAÇÃO IMPLICITA DE IDIOMA

SELECT PARSE('R$345,98' AS money USING 'pt-BR') AS result;
SELECT PARSE('$345.98' AS money USING 'en-US') AS Result;


SET LANGUAGE 'English';
SELECT PARSE('12/20/2010' AS DATETIME ) AS Resultado;

SET LANGUAGE 'Português';
SELECT PARSE('20/12/2010' AS DATETIME) AS Resultado;

--TRY CONVERT

  SELECT 
      CASE WHEN TRY_CONVERT(float,'TESTE') IS NULL
	  THEN 'Convert Falhou!'
	  ELSE 'Convert ok!'
END AS Resultado;

SELECT 
      CASE WHEN TRY_CONVERT(float,65) IS NULL
	  THEN 'Convet Falhou!'
	  ELSE 'Convert ok!'
END AS Resultado;


--TRY CONVERT

SET DATEFORMAT dmy;
SELECT TRY_CONVERT (DATETIME, '12/31/2010') AS Resultado;
GO

SET DATEFORMAT dmy;
SELECT TRY_CONVERT (DATETIME, '05/12/2010') AS Resultado;
GO


--TRY PARSE 

SELECT TRY_PARSE('HELLO WORLD!!!' AS DATETIME2 USING 'en-US') AS Result;

SELECT TRY_PARSE('10/05/2010' AS DATETIME USING 'en-US') AS Result;
 







