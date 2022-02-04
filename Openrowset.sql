--CONFIGURAR AD HOC DISTRIBUIDA
  sp_configure 'show advanced options',1;
  RECONFIGURE;
  GO
  sp_configure 'Ad Hoc Distributed Queries', 1;
  RECONFIGURE
  GO

--PARA DESATIVAR, UTILIZAMOS AS MESMAS INSTRUÇÕES, TROCANDO "1" POR "0".

  SELECT*
  FROM OPENROWSET('SQLNCLI','Server=sa;Trusted_Connection=yes;',
       'SELECT *
	    FROM curso.dbo.carros') AS tabela_externa; 
  
--INSERT
  
  INSERT OPENROWSET('SQLNCLI','Server=sa;Trusted_Connection=yes;',
       'SELECT *
	    FROM curso.dbo.carros')
  VALUES (4,'CARRO METALICO', 23000);

--UPDATE 
  UPDATE OPENROWSET('SQLNCLI','Server=sa;Trusted_Connection=yes;',
         'SELECT *
	     FROM curso.dbo.carros WHERE COD=4')
  SET PRECO=25000;

--DELETE 

  DELETE OPENROWSET('SQLNCLI','Server=sa;Trusted_Connection=yes;',
         'SELECT *
	     FROM curso.dbo.carros WHERE COD=4')























