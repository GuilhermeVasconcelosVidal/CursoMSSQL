--CASE


--EXEMPLO SIMPLES
USE curso;

  DECLARE @data DATETIME
  SET @data=GETDATE()-1
  SELECT @data AS Data_declarada,
          CASE WHEN @data = GETDATE() THEN 'Hoje'
		       WHEN @data < GETDATE() THEN 'Ontem'
			   WHEN @data > GETDATE() THEN 'Amanhã'
			   END dia 

--EXEMPLO 1

	USE AdventureWorks2017;

	  SELECT productnumber,
			 productline,
	  Categoria = CASE productline
				   WHEN 'R' THEN 'Road'
				   WHEN 'M' THEN 'Mountain'
				   WHEN 'T' THEN 'Touring'
				   WHEN 'S' THEN 'Other sale items'
				   ELSE 'Not for sale' END ,
				   NAME
	  FROM production.product
	  ORDER BY productnumber;


--EXEMPLO 2

SELECT productnumber,
	   productline,
	  CASE 
		   WHEN productline= 'R' THEN 'Road'
		   WHEN productline= 'M' THEN 'Mountain'
		   WHEN productline= 'T' THEN 'Touring'
		   WHEN productline= 'S' THEN 'Other sale items'
		   ELSE 'Not for sale' END Categoria ,
		   NAME
	  FROM production.product
	  ORDER BY productnumber;


--EXEMPLO 3

  SELECT productnumber,
         NAME,
		 listprice,
		 CASE WHEN listprice = 0 THEN 'Não está a venda'
		      WHEN listprice <= 50 THEN 'Abaixo de $50'
			  WHEN listprice > 50 AND listprice <= 250 THEN 'Entre $51 e $250'
			  WHEN listprice > 250 AND listprice <= 1000 THEN 'Entre $251 e $1000'
			  ELSE 'Acima de $1000' END Price_Range,
			  'Produtos' AS Categoria
		 FROM production.product
		 ORDER BY  productnumber; 


--ORDENANDO COM CASE WHEN

  SELECT businessentityid,
         salariedflag
  FROM humanresources.employee
  ORDER BY CASE WHEN salariedflag = 1 THEN businessentityid END DESC,
           CASE WHEN salariedflag = 0 THEN businessentityid END ASC;


--UPDATE COM CASE WHEN 

  BEGIN TRANSACTION;


  UPDATE HumanResources.Employee
  SET VacationHours = (CASE WHEN ( ( VacationHours- 10.00 ) < 0 )
     THEN VacationHours + 40.00
	 ELSE (VacationHours + 20.00) END )
--REALIZANDO PRINT DOS CAMPOS ATUALIZADO
     OUTPUT deleted.BusinessEntityID,
	 deleted.VacationHours AS Antes,
	 inserted.VacationHours AS Depois
	 WHERE SalariedFlag = 0;

 ROLLBACK














