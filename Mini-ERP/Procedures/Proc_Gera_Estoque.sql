--EXEC PROC_GERA_ESTOQUE 'S',2,'ABF',50,'2017-01-31'
--DROP PROCEDURE ATUALIZA_ESTOQUE
--ATUALIZA OU INSERE NAS TABELAS:
--ESTOQUE, ESTOQUE_LOTE,ESTOQUE_MOV

USE MINIERP_MULT
GO
 
 CREATE PROCEDURE  PROC_GERA_ESTOQUE (@COD_EMPRESA INT,
                                       @TIPO_MOV    VARCHAR(1), --E ENTRADA, S-SAIDA
									   @COD_MAT     INT, 
									   @LOTE        VARCHAR(15),
									   @QTD_MOV     DECIMAL(10,2),
									   @DATA_MOVTO  DATE)
  AS 
    BEGIN
	   SET NOCOUNT ON
	    DECLARE @ERRO_INTERNO INT;
		--INICIA TRANSA��O
		BEGIN TRANSACTION
		--INICIA BEGIN TRY
		BEGIN TRY
		--VERIFICANDO SE MATERIAL EXISTE
		SELECT COUNT(*) FROM MATERIAL WHERE COD_EMPRESA=@COD_EMPRESA AND COD_MAT=@COD_MAT

		IF @@ROWCOUNT=0
		   BEGIN
		   RAISERROR ('MATERIAL NAO EXISTE', --MESSAGE TEXT.
		               10, --SEVERITY.
					   1 --STATE.
					   );
           SET @ERRO_INTERNO=2
		   END
		   ELSE
		   BEGIN
		   --ESTRUTURA DE SAIDA
		     IF (@TIPO_MOV <> 'S' AND @TIPO_MOV <> 'E')
			     BEGIN
				   SET @ERRO_INTERNO=3
                 END
			 --SE MATERIA SAIDA
			   ELSE IF (@TIPO_MOV = 'S' )
			       BEGIN
				   --SE SALDO<QTD MOV OR
				   --SE SALDO LOTE< QTD MOV
				   --SE REGISTRO NAO EXISTE NEM ESTOQUE NEM ESTOQUE LOTE 
				   --ATRIBUI ERROR =1
				      IF((SELECT TOP 1 QTD_SALDO
					      FROM ESTOQUE
						  WHERE COD_EMPRESA=@COD_EMPRESA
					            AND @COD_MAT = COD_MAT)< @QTD_MOV
					  OR(SELECT TOP 1 QTD_LOTE
						 FROM   ESTOQUE_LOTE
					     WHERE  COD_EMPRESA=@COD_EMPRESA
							    AND @COD_MAT = COD_MAT
								AND LOTE = @LOTE)<@QTD_MOV
					  OR (SELECT COUNT(*)
					      FROM   ESTOQUE
						  WHERE  COD_EMPRESA=@COD_EMPRESA AND @COD_MAT = COD_MAT) = 0
					  OR (SELECT COUNT(*)
					      FROM   ESTOQUE_MOV
						  WHERE  COD_EMPRESA=@COD_EMPRESA AND
						         @COD_MAT = COD_MAT
								 AND LOTE = @LOTE ) = 0)
						  BEGIN
						      SET @ERRO_INTERNO =1	
						  END
                      ELSE
					 BEGIN
					 --ATUALIZA ESTOQUE
					 UPDATE ESTOQUE
					 SET    QTD_SALDO = QTD_SALDO - @QTD_MOV
					 WHERE  COD_EMPRESA=@COD_EMPRESA AND
					        @COD_MAT = COD_MAT;

					 --ATUALIZA ESTOQUE_LOTE
					 UPDATE ESTOQUE_LOTE
					 SET    QTD_LOTE = QTD_LOTE - @QTD_MOV
					 WHERE  COD_EMPRESA =@COD_EMPRESA AND
					        @COD_MAT = COD_MAT
							AND LOTE = @LOTE
					 --INSERT DE MOVIMENTA��O
					 INSERT ESTOQUE_MOV
					 VALUES (@COD_EMPRESA,
					         @TIPO_MOV,
							 @COD_MAT,
							 @LOTE,
							 @QTD_MOV,
							 @DATA_MOVTO,
							 GETDATE(),
							 SYSTEM_USER)

              PRINT 'BAIXA REALIZADA'
		 END
     END
	 --OPERA��O DE ENTRADA
	 IF (@TIPO_MOV = 'E')
	   BEGIN
	      --SE EXISTE MATERIAL ESTOQUE ATUALIZA SALDO
		  IF(SELECT COUNT(*)
		     FROM   ESTOQUE 
			 WHERE  COD_EMPRESA=@COD_EMPRESA AND COD_MAT = @COD_MAT) > 0	
		    BEGIN
			    UPDATE ESTOQUE
				SET    QTD_SALDO = QTD_SALDO + @QTD_MOV
				WHERE  COD_EMPRESA=@COD_EMPRESA AND COD_MAT =@COD_MAT

				PRINT 'TEM ESTOQUE FAZ UPDATE'
		    END
          ELSE
		    --SE N�O REALIZA INSERT
			BEGIN
			    INSERT INTO  ESTOQUE
				VALUES      (@COD_EMPRESA,
				             @COD_MAT,
							 @QTD_MOV)
			    
				PRINT 'INSERT ESTOQUE'
		    END
          --SE EXISTE MATERIAL ESTOQUE_LOTE ATUALIZA SALDO
		  IF (SELECT COUNT(*)
		      FROM ESTOQUE_LOTE
			  WHERE COD_EMPRESA=@COD_EMPRESA
			        AND COD_MAT = @COD_MAT
					AND LOTE = @LOTE) > 0
           BEGIN
		       UPDATE ESTOQUE_LOTE
			   SET    QTD_LOTE= QTD_LOTE + @QTD_MOV
			   WHERE  COD_EMPRESA = @COD_EMPRESA
			          AND COD_MAT = @COD_MAT
					  AND LOTE = @LOTE
			   
			   PRINT 'TEM ESTOQUE_LOTE FAZ UPDATE'
           END
		 ELSE
		 --SE N�O FAZ INSERT
		   BEGIN
		       INSERT INTO ESTOQUE_LOTE
			   VALUES     (@COD_EMPRESA,
			               @COD_MAT,
						   @LOTE,
						   @QTD_MOV)
		
		       PRINT 'INSERT ESTOQUE_LOTE'
           END
         --INSERE MOVIMENTA��O
		   INSERT ESTOQUE_MOV
		   VALUES (@COD_EMPRESA,
		           @TIPO_MOV,
				   @COD_MAT,
				   @LOTE,
				   @QTD_MOV,
				   @DATA_MOVTO,
				   GETDATE(),
				   SYSTEM_USER);
           PRINT'INSERT MOV_ESTOQUE'
        END
END
 --VALIDA��ES FINAIS
    IF @@ERROR <> 0
	     BEGIN
		   ROLLBACK
		   PRINT @@ERROR
		   PRINT 'OPERA�AO CANCELADA'
		 END
    ELSE IF @ERRO_INTERNO = 1
	    BEGIN
		 ROLLBACK
		 RAISERROR ('ESTOQUE NEGATIVO', --MESSAGE TEXT.
		              10, --SEVERITY.
					  1  -- STATE.
					  );
          PRINT 'OPERA�AO CANCELADA ROLLBACK'
	    END
	ELSE IF @ERRO_INTERNO = 2
	    BEGIN
		 ROLLBACK
		 RAISERROR ('MATERIAL NAO EXISTE', --MESSAGE TEXT.
		               10, --SEVERITY
					    1 --STATE
						);
          PRINT'OPERA�AO CANCELADA ROLLBACK'
        END
    ELSE IF @ERRO_INTERNO = 3
	    BEGIN
		 ROLLBACK
		 RAISERROR('OPERA�AO NAO PERMITIDA', --MESSAGE TEXT.
		              10, --SEVERITY
					   1  --STATE
					   );
         PRINT 'OPERA�AO CANCELADA ROLLBACK'
        END
	ELSE 
	     BEGIN
		     COMMIT
			 PRINT 'OPERA�AO CONCLUIDA COM SUCESSO'
		 END
     --FIM TRY
	 END TRY
	 --INICIA BEGIN CATCH
	 BEGIN CATCH
	     SELECT
		 ERROR_NUMBER() AS ErrorNumber,
		 ERROR_SEVERITY() AS ErrorSeverity,
		 ERROR_STATE() AS ErrorState,
		 ERROR_PROCEDURE() AS ErrorProcedure,
		 ERROR_LINE() AS ErrorLine,
		 ERROR_MESSAGE() AS ErrorMessage;

		 SET XACT_ABORT ON;
		 IF @@TRANCOUNT > 0 
		 ROLLBACK TRANSACTION;
	   --FINAL CATCH
	   END CATCH
	   --FIM PROC
 END


--TESTE PROC 
--PARAMETRO EMPRESA,MOVIMENTO,MATERIAL,LOTE,QTD,DATE
  EXEC PROC_GERA_ESTOQUE 1,'X',2,'ABF',49,'2017-01-31'
  
  EXEC PROC_GERA_ESTOQUE 1,'S',2,'ABF',50,'2017-01-31'

  EXEC PROC_GERA_ESTOQUE 1,'E',2,'ABF',50,'2017-01-31'
  
  EXEC PROC_GERA_ESTOQUE 1,'S',2,'ABF',51,'2017-01-31'
  
  EXEC PROC_GERA_ESTOQUE 1,'E',2,'ABC',30,'2017-01-31'
  
  EXEC PROC_GERA_ESTOQUE 1,'S',2,'ABF',51,'2017-01-31'
  
  EXEC PROC_GERA_ESTOQUE 1,'S',2,'ABF',49,'2017-01-31'
  EXEC PROC_GERA_ESTOQUE 1,'E',1,'ABF',50,'2017-01-31'

  SELECT * FROM ESTOQUE
  SELECT * FROM ESTOQUE_LOTE
  SELECT * FROM ESTOQUE_MOV
  --ZERANDO CONTADOR IDENTITY
  DBCC CHECKIDENT ('ESTOQUE_MOV',RESEED,0);