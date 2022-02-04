--MERGE SQL STATEMENT - PART 1


--CRIADA TABELA DESTINO 

USE curso;
GO

--DROP TABLE produtos destino 

CREATE TABLE produtos 
  (
   cod_prod INT PRIMARY KEY,
   descricao VARCHAR(100),
   preco MONEY
  )
  GO


--INSERINDO DADOS NA TABELA 

  INSERT INTO  produtos 
  VALUES 
  (1,'CHA',10.00),
  (2,'CAFÉ',20.00),
  (3,'LEITE',30.00),
  (4,'PÃO',40.00)
  GO

--CRIANDO TABELA 
--DROP TABLE produto_atualizados origem
  CREATE TABLE produto_atualizados
  (
   cod_prod INT PRIMARY KEY,
   descricao VARCHAR(100),
   preco MONEY 
  )
  GO

--INSERINDO DADOS NA TABELA 
  INSERT INTO produto_atualizados
  VALUES 
  (1,'CHA',10.00),
  (2,'CAFÉ',25.00),
  (3,'LEITE',35.00),
  (5,'PEIXE',60.00)
  GO

  SELECT * FROM produtos
  SELECT * FROM produto_atualizados
  GO




