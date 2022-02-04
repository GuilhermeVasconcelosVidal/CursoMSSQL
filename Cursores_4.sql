--DROP TABLE tabela_cliente
--GO

USE curso;
GO 

  CREATE TABLE tabela_cliente (
  id_cliente INT NOT NULL PRIMARY KEY,
  nome_cliente VARCHAR(200),
  cpf_cliente VARCHAR(20)
  );
  GO

--DELETE FROM tabela_clientes

  INSERT INTO tabela_cliente VALUES 
  (1,'Fabio', NULL),
  (2,'Jorge',21325658454),
  (3,'Jack', NULL),
  (4,'Peter',34132567878)

--GO

--SELECT * FROM tabela_cliente

  DECLARE
  @id_cliente INT,
  @nome_cliente VARCHAR(200),
  @cpf_cliente VARCHAR(20);
  

--DECLARANDO CURSOR
  DECLARE nome_do_cursor CURSOR FOR

--DADOS QUE O CURSOR IRA TRABALHAR
  SELECT
        id_cliente, nome_cliente, cpf_cliente 
  FROM  tabela_cliente

  OPEN nome_do_cursor

--posicionar o ponteiro do cursor na primeira linha do resultado do select acima
  FETCH NEXT FROM nome_do_cursor
   
--insere nas variaveis os valores daa pimeira linha do resultado armazenado no cursor
  INTO @id_cliente, @nome_cliente, @cpf_cliente

--ESSA PARTE DIZ "ENQUANTO TIVER LINHA NO CURSOR, FAÇA:"
  WHILE @@FETCH_STATUS = 0

--NESSA PARTE VOCÊ INSERE O BLOCO DE INSTRUÇÕES QUE IRA TRABALHAR NO SEU CURSOR

--SE CPF FOR IGUAL A NULO 
  BEGIN
  IF (@cpf_cliente IS NULL)
--INSERIR NO FINAL DO NOME DA PESSOA O TEXTO "Atualizar CPF"
  BEGIN

--UPDATE tabela_cliente SET nome_cliente = @nome_cliente + 'Atualizar CPF' WHERE cpf_cliente is null
  UPDATE tabela_cliente SET cpf_cliente = 'Atualizar CPF' 
  WHERE cpf_cliente is null
  AND id_cliente=@id_cliente 
  END
 FETCH NEXT FROM nome_do_cursor
 INTO @id_cliente, @nome_cliente, @cpf_cliente
 END

CLOSE nome_do_cursor
DEALLOCATE nome_do_cursor


SELECT * FROM tabela_cliente



