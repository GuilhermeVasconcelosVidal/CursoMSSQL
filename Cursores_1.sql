--CURSORES

USE curso

--DECLARAR VARIAVEL
  DECLARE @MinhaVariavel VARCHAR(100),
          @id_aluno INT
--DECLARAR O CURSOR
  DECLARE meu_cursor
  CURSOR LOCAL FOR SELECT id_aluno,nome FROM alunos
--ABRINDO O CURSOR
  OPEN meu_cursor
--LENDO A PROXIMA LINHA 
  FETCH NEXT FROM meu_cursor INTO @id_aluno,@MinhaVariavel
--PERCORRENDO LINHAS DO CURSOR (ENQUANTO HOUVEREM)
  WHILE(@@FETCH_STATUS = 0)
    BEGIN
	  PRINT CAST(@id_aluno AS VARCHAR (10))+'-'+@MinhaVariavel+' FETCH_STATUS-> '+CAST(@@FETCH_STATUS AS VARCHAR(10))
--LENDO PROXIMA LINHA
      FETCH NEXT FROM meu_cursor INTO @id_aluno, @MinhaVariavel
  END
  PRINT 'FETCH_STATUS-> '+CAST(@@FETCH_STATUS AS VARCHAR(10))
--FECHANDO CURSOR PARA LEITURA
  CLOSE meu_cursor
--FINALIZANDO O CURSOR
  DEALLOCATE meu_cursor

--PREPARANDO BASE PARA CURSORPARA UPDATE
--DROP TABLE CLIFOR

USE curso;

  SELECT a.businessentityid Codpessoa,
         a.firstname Nome,
		 a.lastname Sobrenome,
		 CAST('' AS VARCHAR(100)) NomeCompleto
		 INTO clifor2
  FROM AdventureWorks2017.person.person a;
--VERIFICANDO DADOS CARREGADOS SEM NOME COMPLETO
  SELECT * FROM clifor2;

--INICIO DO CURSOR (DECLARAR VARIAVEIS)

  DECLARE @codpessoa INT,
          @primeironome VARCHAR(50),
		  @sobrenome VARCHAR(50),
		  @nomecompleto VARCHAR(100)

--CURSOR PARA PERCORRER OS REGISTROS
  DECLARE cursor2 CURSOR FOR
    SELECT codpessoa, nome, sobrenome
    FROM   clifor2

--ABRINDO O CURSOR
  OPEN cursor2

--LENDO A PROXIMA LINHA
  FETCH NEXT FROM cursor2 INTO @codpessoa, @primeironome, @sobrenome

--PERCORRENDO LINHAS DO CURSOR (ENQUANTO HOUVEREM)
  WHILE @@FETCH_STATUS = 0
    BEGIN
--EXECUTANDOAS ROTINAS DESEJADASMANIPULANDO O REGISTRO
        UPDATE clifor2
		SET    nomecompleto = @primeironome+' '+@sobrenome
        WHERE Codpessoa = @codpessoa

--LENDO PROXIMA LINHA 
        FETCH NEXT FROM cursor2 INTO @codpessoa, @primeironome, @sobrenome
	END	 

--FECHANDO CURSOR PARA LEITURA
  CLOSE cursor2

--FINALIZANDO CURSOR
  DEALLOCATE cursor2

--VERIFICANDO DADOS
--SELECT * FROM clifor2


ALTER TABLE clifor
ADD CONSTRAINT PK_id1 PRIMARY KEY (codpessoa);


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
  FETCH NEXT FROM CURSOR1 INTO @codcliente, @primeironome1, @sobrenome1

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




