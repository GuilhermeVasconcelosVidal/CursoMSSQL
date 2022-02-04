USE curso;
		
--DROP TABLE cli_nome 

  CREATE TABLE cli_nome 
  (cod_cliente INT PRIMARY KEY NOT NULL,
  nome_completo VARCHAR(100)NOT NULL
  );


--SELECT * FROM cli_nome

--CRIANDO CURSOR PARA INSERT
--DECLARANDO VARIAVEIS
  DECLARE @codcliente INT,
          @primeironome VARCHAR(30),
		  @sobrenome VARCHAR(60),
		  @nomecompleto VARCHAR(90)

--CURSOR PARA PERCORRER OS REGISTROS
  DECLARE CURSOR1 CURSOR FOR
  SELECT a.BusinessEntityID, a.FirstName, a.LastName FROM AdventureWorks2017.Person.Person a

--ABRINDO CURSOR
  OPEN CURSOR1

--LENDO A PROXIMA LINHA
  FETCH NEXT FROM CURSOR1 INTO @codcliente, @primeironome, @sobrenome

--PERCORRENDO  LINHAS DO CURSOR (ENQUANTO HOUVEREM)
  WHILE @@FETCH_STATUS = 0
  BEGIN

--EXECUTANDO AS ROTINAS DESEJADAS MANIPULANDO O REGITRO
--UPDATE CLIENTES SET nomecompleto = @primeironome+' '+@sobrenome WHERE codcliente = @codcliente
  SET @nomecompleto = @primeironome+' '+@sobrenome;
  INSERT INTO cli_nome VALUES (@codcliente,@nomecompleto);
--LENDO A PROXIMA LINHA 

  FETCH NEXT FROM CURSOR1 INTO @codcliente, @primeironome, @sobrenome
  END

--FECHANDO CURSOR PARA LEITURA
  CLOSE CURSOR1

--FINALIZANDO CURSOR
  DEALLOCATE CURSOR1
  

--VERIFICANDO INSERT
--SELECT * FROM cli_nome
