use  curso
go


--FORÇANDO O ERRO
SELECT 1,1
UNION 
SELECT 'A',2

--FORMA CORRETA 
SELECT '1',1
UNION
SELECT 'A',2


--USANDO O UNION

USE AdventureWorks2017

  SELECT CITY
  FROM PERSON.Address
  WHERE AddressID<15000

  UNION

  SELECT CITY
  FROM PERSON.Address
  WHERE AddressID>=15000
  ORDER BY CITY

--EXEMPLO USANDO O UNION ALL

  SELECT CITY
  FROM PERSON.Address
  WHERE AddressID<15000

  UNION ALL

  SELECT CITY 
  FROM PERSON.Address
  WHERE AddressID>=15000

  
--OUTRO EXEMPLO COM UNION

USE crm;

  SELECT cidade,
         codigo_pais 
  FROM   CLIENTE 
      WHERE  codigo_pais = 'US'


  UNION


  SELECT cidade,
         codigo_pais  
  FROM   CLIENTE 
      WHERE  codigo_pais = 'BR'
  ORDER BY cidade; 	  

  USE crm;
 
  SELECT cidade,
         codigo_pais
  FROM   CLIENTE
      WHERE  codigo_pais = 'US'

UNION ALL

  SELECT cidade,
         codigo_pais
  FROM	 CLIENTE
      WHERE  codigo_pais = 'BR'
  ORDER BY cidade;










