--CRIANDO TABELA PARA CURSOR 
--DROP TABLE contapagparc

USE curso;

  CREATE TABLE contapagparc
  (
   num_doc INT ,
   dtvenc DATE,
   parcela INT
  );

--VERIFICANDO ESTRUTURA
  SELECT num_doc, dtvenc FROM contapagparc
  SELECT * FROM contapagparc

  INSERT INTO contapagparc VALUES ('1', GETDATE()+30,'')
  INSERT INTO contapagparc VALUES ('1', GETDATE()+45,'')
  INSERT INTO contapagparc VALUES ('1', GETDATE()+60,'')
  
  INSERT INTO contapagparc VALUES ('2', GETDATE()+15,'')
  INSERT INTO contapagparc VALUES ('2', GETDATE()+20,'')
  INSERT INTO contapagparc VALUES ('2', GETDATE()+25,'')


--SELECT * FROM contapagparc

  DECLARE @num_doc AS INT
  DECLARE @dtvenc AS DATE
  DECLARE @cont AS INT =0
  DECLARE @num_doc_aux AS INT
  
  DECLARE cursorparc CURSOR FOR
    SELECT num_doc,
	       dtvenc
    FROM contapagparc
	ORDER BY num_doc,
	         dtvenc ASC

  OPEN cursorparc

  FETCH NEXT FROM cursorparc INTO @num_doc, @dtvenc

  WHILE @@FETCH_STATUS =0
    --STATUS FETCH
	--0 INSTRUCAO BEM SUCEDIDA
	--1 INSTRUCAO FALHOU
	--2 A LINHA BUSCADA NÃO EXISTE
  
  BEGIN
     IF @num_doc_aux <> @num_doc
	   BEGIN
	     SET @cont = 1;
		 SET @num_doc_aux = @num_doc;
       END
     ELSE
	   BEGIN
	     SET @cont = @cont + 1
		 SET @num_doc_aux = @num_doc;

       END

--UPDATE
     
	 UPDATE contapagparc
	 SET    parcela = @cont
	 WHERE  num_doc = @num_doc
				AND dtvenc = @dtvenc;
    
	FETCH NEXT FROM cursorparc INTO @num_doc, @dtvenc
  END

  CLOSE cursorparc
  DEALLOCATE cursorparc

--SELECT * FROM contapagparc







