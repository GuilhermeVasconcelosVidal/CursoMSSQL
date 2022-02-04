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