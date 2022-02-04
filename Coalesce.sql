


--EXEMPLO

  SELECT COALESCE(NULL, NULL, 'Terceiro Valor', 'Quarto Valor');


  SELECT COALESCE(NULL, NULL, NULL, NULL);

USE curso;
  
--DROP TABLE tab_salario ;
  
  CREATE TABLE tab_salario
  (
     matricula     INT      IDENTITY,
	 salario_hora  DECIMAL  NULL,
	 salario       DECIMAL  NULL,
	 comissao      DECIMAL  NULL,
	 vendas        INT      NULL
  );

  INSERT tab_salario (salario_hora, salario, comissao, vendas)
  VALUES 
       (10.00, NULL, NULL, NULL),
	   (20.00, NULL, NULL, NULL),
	   (30.00, NULL, NULL, NULL),
	   (40.00, NULL, NULL, NULL),
	   
	   (NULL, 10000.00, NULL, NULL),
	   (NULL, 20000.00, NULL, NULL),
	   (NULL, 30000.00, NULL, NULL),
	   (NULL, 40000.00, NULL, NULL),
	   
	   (NULL, NULL, 15000, 3),
	   (NULL, NULL, 25000, 2),
	   (NULL, NULL, 20000, 6),
	   (NULL, NULL, 14000, 4);

  SELECT matricula,
         salario_hora,
		 salario,
		 comissao,
		 vendas,
		 CAST(COALESCE(salario_hora * 40 * 52, salario, comissao * vendas) AS MONEY) AS 'Total Salario'
  FROM tab_salario
  ORDER BY matricula;
  GO

  SELECT * FROM tab_salario;








