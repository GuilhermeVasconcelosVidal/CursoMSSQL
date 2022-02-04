--CHOOSE	
--RETORNA O ITEM AO ÍNDICE ESPECIFICADO DE UMA LISTA DE VALORES NO SQL SERVER.

--EXEMPLO 1

USE AdventureWorks2017; 

  SELECT CHOOSE (3, 'Gerente', 'Diretor', 'Desenvolvedor', 'Tester') AS escolhido


--EXEMPLO 2

USE AdventureWorks2017;
  SELECT productcategoryid,
 CHOOSE (productcategoryid,'A', 'B', 'C', 'D', 'E') AS expressao
  FROM   production.productcategory;

--SELECT distinct productcategoryid FROM   production.productcategory; 

--EXEMPLO 3

  SELECT jobtitle,
         hiredate,
		 MONTH(hiredate)mes,
		 CHOOSE(MONTH(hiredate), 'Winter', 'Winter', 'Spring', 'Spring',
		                         'Spring', 'Summer', 'Summer', 'Summer',
								 'Autumn', 'Autumn', 'Autumn', 'Winter') AS Quarter_Hired
         FROM   humanresources.employee
		 WHERE  YEAR(hiredate) > 2005
		 ORDER BY YEAR(hiredate);


--IIF
--Retorna um de dois valores, dependendo de a expressão booliana
--ser avaliada como true ou false no SQL Server
--EXEMPLO 1
  
  DECLARE @a INT = 45,
          @b INT = 40;
		  SELECT IIF (@a > @b, 'TRUE', 'FALSE') AS resultado

  DECLARE @a INT = 45,
          @b INT = 40;
		  SELECT IIF (@a > @b, 'MAIOR', 'MENOR') AS resultado

  DECLARE @a INT = 45,
          @b INT = 40;
		  SELECT IIF (@a < @b, 'MENOR', 'MAIOR') AS resultado

--EXEMPLO 2
--IIF COM CONSTANTES NULL
--O RESULTADO DESSA INSTRUÇÃO É UM ERRO

SELECT IIF (45 > 30, NULL, NULL) AS result;


--EXEMPLO 3 
/*IIF com parâmetros NULL
O retorno NULL.*/

  DECLARE @p INT = NULL,
          @s INT = NULL;
  SELECT IIF (45 > 30, @p, @s) AS result;








