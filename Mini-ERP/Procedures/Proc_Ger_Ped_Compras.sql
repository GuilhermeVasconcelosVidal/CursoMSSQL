--PROCEDURE GERA PEDIDO DE COMPRAS
--PROCEDURE PARA CRIAR PEDIDO DE COMPRAS COM BASE NECESSIDADES  DA ORDEM DE PRODU�AO
--PARAMETROS @EMPRESA,@MES,@ANO
--TABELAS ORIGEM ORDEM_PROD
--TABELAS NECESSARIAS,FICHA_TECNICA,MATERIAL,FORNECEDORES 
--TABELAS DESTINO PED_COMPRAS,PED_COMPRAS_ITENS
--TABELAS ATUALIZADAS ORDEM_PROD SITUACAO DE A ABERTA PARA P PLANEJ
--DROP PROCEDURE PROC_GER_PED_COMPRAS
--EXEC PROD_GER_PED_COMPRAS 1,05,2017
--DROP PROCEDURE PROC_GER_PED_COMPRAS
--FASE 1 PEDIDO DE VENDA
--FASE 2 ORDEM DE PRODU�AO
--FASE 3 PEDIDO DE COMPRAS >> ESTAMOS AQUI
--CORRE�AO DE CARGA -- FORAM CARREGADOS MATERIAIS COM ID FOR 3 QUE PERTENCE  A EMPRESA 2

  USE MINIERP_MULT
  GO
  UPDATE MATERIAL SET ID_FORNEC=1 WHERE COD_EMPRESA=1 AND COD_MAT IN (9,10);

--ALTER TABLE TABELAS
  ALTER TABLE PED_COMPRAS_ITENS ALTER COLUMN QTD DECIMAL(10,2)
  ALTER TABLE PED_VENDAS_ITENS  ALTER COLUMN QTD DECIMAL(10,2)
--SELECT * FROM MATERIAL
--CRIANDO PROCEDURE 
--DROP PROCEDURE PROC_GER_PED_COMPRAS
  CREATE PROCEDURE PROC_GER_PED_COMPRAS (@COD_EMPRESA INT,
                                        @MES VARCHAR(4),
										@ANO VARCHAR(8))
  AS
    BEGIN
  --DECLARANDO TABLE TEMP
  --VARIAVEL DE TABELA PARA ATRIBUIR SAIDA OUTPUT
  DECLARE @PED_AUX TABLE
  (
       NUM_PEDIDO_AUX INT 
   )

   DECLARE @RETORNO TABLE 
   (
    RET_ORD INT,
	RET_SIT VARCHAR(1)
   )

--DECLARANDO VARIAVEIS

DECLARE @COD_EMPRESA_AUX  INT,
        @MES_AUX          VARCHAR(4),
		@ANO_AUX          VARCHAR(8),
		@NUM_PEDIDO       INT,
		@ID_ORDEM         INT,
		@NUM_PEDIDO_AUX   INT,
		@COD_MAT          INT,
		@ID_FORNEC        INT,
		@COD_PAGTO        INT,
		@DATA_PEDIDO      DATE,
		@DATA_ENTREGA     DATE,
		@SITUACAO         VARCHAR(1),
		@QTD              DECIMAL(10,2),
		@PRECO_UNIT       DECIMAL(10,2),
		@CONT_SEQ         INT,
		@TOTAL_PED        DECIMAL(10,2),
		@ERRO_INTERNO    INT 

SET @TOTAL_PED = 0;
--INICIA A TRANSA�AO
BEGIN TRANSACTION  
--INICIA BEGIN TRY
BEGIN TRY
--CONDI�AO PARA GERAL O PEDIDO MES RETROATIVOS
  IF (@MES='1')
    BEGIN
	     SET @MES_AUX=12;
		 SET @ANO_AUX=@ANO-1;
	END 
	    ELSE
	BEGIN
	  SET @MES_AUX=@MES-1;
	  SET @ANO_AUX=@ANO;
	END
--VERIFICANDO SE EXISTEM ORDEM  PARA PLANEJ STATUS ABERTO
  SELECT A.COD_EMPRESA,A.ID_ORDEM FROM ORDEM_PROD A
         WHERE A.COD_EMPRESA=@COD_EMPRESA
		 AND MONTH(A.DATE_INI)=@MES
		 AND YEAR (A.DATE_INI)=@ANO
		 AND A.SITUACAO='A'

    IF @@ROWCOUNT=0
	BEGIN
        SET @ERRO_INTERNO=1
	END
	ELSE
	BEGIN

  --ATRIBUINDO VALORES
    SET @CONT_SEQ=1
  


--CURSOR PARA GRAVAR CABE�ALHO PEDIDO DE COMPRAS
--SELECT  PARA GERAR NECESSIDADES DE COMPRAS CONFORME ORDEM DE PRODUCAO
--CONFORME FICHA TECNICA E PRODUTO COM SEU FORNECEDOR
  DECLARE PED_COMP CURSOR FOR
  SELECT DISTINCT A.COD_EMPRESA,C.ID_FORNEC,D.COD_PAGTO,
         CAST(@ANO_AUX+'-'+@MES_AUX+'-15' AS DATE) AS DATA_PEDIDO,
		 CAST(@ANO+'-'+@MES+'-15' AS DATE) DATA_ENTREGA,
	  'A' SITUACAO
	  FROM ORDEM_PROD A
	  INNER JOIN FICHA_TECNICA B
	  ON A.COD_EMPRESA=B.COD_EMPRESA
	  AND A.COD_MAT_PROD=B.COD_MAT_PROD
	  INNER JOIN MATERIAL C
	  ON A.COD_EMPRESA=C.COD_EMPRESA
	  AND B.COD_MAT_NECES=C.COD_MAT
	  INNER JOIN FORNECEDORES D
	  ON A.COD_EMPRESA=D.COD_EMPRESA
	  AND C.ID_FORNEC=D.ID_FORNEC
	  WHERE A.COD_EMPRESA=@COD_EMPRESA
	  AND MONTH(A.DATE_INI)=@MES
	  AND YEAR (A.DATE_INI)=@ANO
	  AND A.SITUACAO='A'
  OPEN PED_COMP
  FETCH NEXT FROM PED_COMP
       INTO @COD_EMPRESA_AUX,@ID_FORNEC,@COD_PAGTO,@DATA_PEDIDO,@DATA_ENTREGA,@SITUACAO

WHILE @@FETCH_STATUS = 0
    BEGIN
	-- PEGANDO NUMERO DO PEDIDO
	  PRINT 'UPDATE DE PARAMETROS'
	  UPDATE PARAMETROS SET VALOR=VALOR+1
	  OUTPUT INSERTED.VALOR INTO @PED_AUX
	  WHERE COD_EMPRESA=@COD_EMPRESA
	  AND PARAM='PED_COMPRAS';
    

	--ATRUBUINDO VALOR 
	SELECT @NUM_PEDIDO_AUX=NUM_PEDIDO_AUX FROM @PED_AUX
	--APRESENTANDO VALORES
	SELECT @COD_EMPRESA COD_EMPRESA,@NUM_PEDIDO_AUX NUM_PEDIDO_AUX,@ID_FORNEC ID_FORNEC,@COD_PAGTO COD_PAGTO,
	@DATA_PEDIDO DATA_PEDIDO,@DATA_ENTREGA DATA_ENTREGA,@SITUACAO SITUACAO;
	--REALIZANDO INSERT
	INSERT INTO PED_COMPRAS (COD_EMPRESA,NUM_PEDIDO,ID_FORNEC,COD_PAGTO,DATA_PEDIDO,DATA_ENTREGA,SITUACAO)
	OUTPUT 'INFOR' AS MSG, INSERTED.COD_EMPRESA,INSERTED.NUM_PEDIDO
	VALUES (@COD_EMPRESA,@NUM_PEDIDO_AUX,@ID_FORNEC,@COD_PAGTO,@DATA_PEDIDO,@DATA_ENTREGA,@SITUACAO);
    

	--CURSOR DETALHE PED INICIO
	DECLARE	PED_COMP_IT	CURSOR FOR
    --SELECT COM PARAMETROS
	SELECT A.COD_EMPRESA,B.COD_MAT_NECES COD_MAT,C.ID_FORNEC,
	    SUM(B.QTD_NECES*A.QTD_PLAN) QTD, C.PRECO_UNIT
		FROM ORDEM_PROD A
		INNER JOIN FICHA_TECNICA B
	    ON A.COD_EMPRESA=B.COD_EMPRESA
	    AND A.COD_MAT_PROD=B.COD_MAT_PROD
	    INNER JOIN MATERIAL C
	    ON A.COD_EMPRESA=C.COD_EMPRESA
	    AND B.COD_MAT_NECES=C.COD_MAT
	    INNER JOIN FORNECEDORES D
	    ON A.COD_EMPRESA=D.COD_EMPRESA
	    AND C.ID_FORNEC=D.ID_FORNEC
	    WHERE A.COD_EMPRESA=@COD_EMPRESA
	    AND MONTH (A.DATE_INI)=@MES
        AND YEAR  (A.DATE_INI)=@ANO
		AND A.SITUACAO='A' --ABERTA
		AND C.ID_FORNEC=@ID_FORNEC
		GROUP BY A.COD_EMPRESA,B.COD_MAT_NECES,C.ID_FORNEC,C.PRECO_UNIT
		 
--ABRINDO O CURSOR
  OPEN PED_COMP_IT
--LENDO REGISTROS
  FETCH NEXT FROM PED_COMP_IT
--INSERINDO VALORES
INTO @COD_EMPRESA,@COD_MAT,@ID_FORNEC,@QTD,@PRECO_UNIT
--INICIO WHILE
  WHILE @@FETCH_STATUS = 0
       BEGIN
	     --VERIFICACOES PARA CONTADOR DE SEQ MATERIAL E TOTAL_PED
		 IF (@NUM_PEDIDO<>@NUM_PEDIDO_AUX)
        BEGIN
		  SET @CONT_SEQ=1;
		  SET @TOTAL_PED=0;
        END
		   
		   --INSERINDO REGISTRO NA PED_COMPRAS_ITENS

		   INSERT INTO PED_COMPRAS_ITENS VALUES
		   (@COD_EMPRESA,@NUM_PEDIDO_AUX,@CONT_SEQ,@COD_MAT,@QTD,@PRECO_UNIT);
		   --APRESENTANDO VALORES
		   SELECT @COD_EMPRESA COD_EMPRESA,@NUM_PEDIDO_AUX NUM_PEDIDO_AUX,@CONT_SEQ CONT_SEQ,
		          @COD_MAT COD_MAT, @QTD QTD, @PRECO_UNIT PRECO_UNIT;
           --ATRIBUINDO VALORES

		   SET @NUM_PEDIDO=@NUM_PEDIDO_AUX;
		   SET @CONT_SEQ=@CONT_SEQ+1;
		   SET @TOTAL_PED=@TOTAL_PED+ (@QTD*@PRECO_UNIT);

		   --LENDO PROXIMA LINHA DO CURSOR	
		   FETCH NEXT FROM PED_COMP_IT
		   INTO @COD_EMPRESA ,@COD_MAT, @ID_FORNEC,@QTD,@PRECO_UNIT
END
CLOSE PED_COMP_IT
DEALLOCATE PED_COMP_IT


  SELECT @NUM_PEDIDO PEDIDO, @TOTAL_PED AS TOTAL_PEDIDO
  --ATUALIZANDO TOTAL PEDIDO
  UPDATE PED_COMPRAS SET TOTAL_PED=@TOTAL_PED
  WHERE COD_EMPRESA=@COD_EMPRESA
  AND NUM_PEDIDO=@NUM_PEDIDO;


--CURSOR DETALHE PED FIM
--LENDO	PROXIMA LINHA DO CURSOR PED_COMP
    FETCH NEXT FROM PED_COMP
	INTO @COD_EMPRESA,@ID_FORNEC,@COD_PAGTO,@DATA_PEDIDO,@DATA_ENTREGA,@SITUACAO;
	PRINT @NUM_PEDIDO_AUX;
	SET @NUM_PEDIDO=@NUM_PEDIDO_AUX;

END

CLOSE PED_COMP
DEALLOCATE PED_COMP
END

  --VALIDACOES FINAIS
    IF @@ERROR<>0
	  BEGIN
	     ROLLBACK
		 PRINT 'OPERACAO CANCELADA'
	  END
	  ELSE IF @ERRO_INTERNO=1
	    BEGIN
		  ROLLBACK
		  PRINT 'ORDEM NAO EXISTE OU NAO ABERTA'
		END
		ELSE
		   BEGIN
		     --ATUALIZANDO STATUS DA ORDEM PARA NAO GERAR MAIS DEMANDAS DE COMPRAS
				
             UPDATE ORDEM_PROD SET SITUACAO='P'
			 OUTPUT INSERTED.ID_ORDEM,INSERTED.SITUACAO INTO @RETORNO
			 WHERE COD_EMPRESA=@COD_EMPRESA
			 AND MONTH(DATE_INI)=@MES
			 AND YEAR (DATE_INI)=@ANO
			 AND SITUACAO='A';

			 SELECT * FROM @RETORNO

			 PRINT 'OPERACAO FINALIZADA COM SUCESSO'
			 COMMIT TRANSACTION	
           END
	  END TRY
	  BEGIN CATCH
	      SELECT
		  ERROR_NUMBER() AS ErrorNumber,
		  ERROR_SEVERITY() AS ErrorSeverity,
		  ERROR_STATE() AS ErrorState,
		  ERROR_PROCEDURE() AS ErrorProcedure,
		  ERROR_LINE() AS ErrorLine,
		  ERROR_MESSAGE() AS ErrorMessage;
		  IF (SELECT CURSOR_STATUS('GLOBAL','PED_COMP')) = 1	
		  BEGIN
		      CLOSE PED_COMP
			  DEALLOCATE PED_COMP
		  END
		  IF(SELECT CURSOR_STATUS('GLOBAL','PED_COMP_IT')) = 1
		  BEGIN
		      CLOSE PED_COMP_IT
			  DEALLOCATE PED_COMP_IT
		  END

		  SET XACT_ABORT ON;
		  IF @@TRANCOUNT > 0
		  ROLLBACK TRANSACTION;
	  END CATCH

END

--TESTANDO PROCEDURE

  EXEC PROC_GER_PED_COMPRAS @COD_EMPRESA=1,
   						    @MES=2,
  						    @ANO=2018
--ANALIANDO
SELECT * FROM ORDEM_PROD
SELECT* FROM PED_COMPRAS
SELECT * FROM PED_COMPRAS_ITENS

--CONFERINDO TOTAL DO PEDIDO COM O TOTAL DETALHES ITENS
  SELECT A.NUM_PEDIDO,TOTAL_PED, SUM(B.QTD*B.VAL_UNIT) TOT_ITENS
  FROM
  PED_COMPRAS A
  INNER JOIN PED_COMPRAS_ITENS B
  ON A.COD_EMPRESA=B.COD_EMPRESA
  AND A.NUM_PEDIDO=B.NUM_PEDIDO
  GROUP BY A.NUM_PEDIDO,TOTAL_PED