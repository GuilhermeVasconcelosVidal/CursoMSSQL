--EXEMPLO MERGE 
--CRIACAO TABELA TEMPORARIA 1
--DROP TABELA #Tabela1
  CREATE TABLE #Tabela1
          (
			nome VARCHAR (100),
			cadastro DATETIME,
			alteracao DATETIME,
			situacao BIT);

  INSERT #Tabela1 VALUES 
              ('JACK', GETDATE(), NULL, 1),
			  ('PETER', GETDATE(), NULL, 1), 
			  ('JOHN', GETDATE(), NULL, 1),
			  ('MALCON', GETDATE(), NULL, 1),
			  ('ARTHUR', GETDATE(), NULL, 1)

--DROP TABLE #Tabela2
  CREATE TABLE #Tabela2
           (nome VARCHAR(100),
		    email VARCHAR(100))

  INSERT #Tabela2 VALUES 
              ('JACK','jack@jack.com'),
			  ('PETER','peter@peter.com'),
			  ('JOHN','john@john.com'),
			  ('MALCON','malcon@malcon.com'),
			  ('RICHARD','richard@richard.com')

  SELECT * FROM #Tabela1

  SELECT * FROM #Tabela2

--INICIO MERGE 

  MERGE #Tabela1 AS Destino

  USING #Tabela2 AS Origem

  ON Destino.Nome = Origem.nome 

--HÁ REGISTRO  NO DESTINO E NA ORIGEM

  WHEN MATCHED

  THEN UPDATE SET situacao = 0, alteracao = GETDATE()
--QUANDO NÃO A REGISTRO NO DESTINO E HÁ NA ORIGEM


  WHEN NOT MATCHED
 
  THEN INSERT (Nome, Cadastro, alteracao, situacao) VALUES (origem.nome, GETDATE(), GETDATE(),1)

-- QUANDO HÁ REGISTRO  NO DESTINO MAS NAO HÁ NA ORIGEM 

  WHEN NOT MATCHED BY SOURCE

  THEN UPDATE SET situacao = NULL, alteracao = GETDATE();

--VERIFICANDO RESULTADO 

  SELECT * FROM #Tabela1

  SELECT * FROM #Tabela2










