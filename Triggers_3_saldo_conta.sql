--DROP TABLE conta_corrente

USE curso
GO

  CREATE TABLE conta_corrente
  (conta_c  VARCHAR(20)   NOT NULL,
   valor    DECIMAL(10,2) NOT NULL,
   operacao CHAR(1)       NOT NULL  -- D / C
  );

--DROP TABLE saldo_conta
  CREATE TABLE saldo_conta
  (conta_c VARCHAR(20)   NOT NULL,
   saldo   DECIMAL(10,2) NOT NULL 
  );

--CRIANDO TRIGGER PARA ATUALIZAR TABELAS SALDO;
--DROP TRIGGER TG_SALDO_CC
  CREATE TRIGGER TG_SALDO_CC
  ON conta_corrente
  FOR INSERT
  AS 
    BEGIN
	   DECLARE @CONTA_C VARCHAR(20),
	           @VALOR   DECIMAL(10,2),
			   @OPER    CHAR(1)

       SELECT  @CONTA_C = I.conta_c,
	           @VALOR   = I.valor,
			   @OPER    = I.operacao
       
	   FROM INSERTED I
       /* D = DEBITO / C = CREDITO */


       IF @OPER NOT IN ('D','C')
	     BEGIN
		      PRINT 'Opereção não permitida'

			  ROLLBACK TRANSACTION
	     END
       ELSE IF (SELECT COUNT(*)
	       FROM saldo_conta
	       WHERE conta_c = @CONTA_C) = 0
          AND @OPER = 'D'
	     BEGIN
		     INSERT INTO saldo_conta
			 VALUES      (@CONTA_C,
			              @VALOR *- 1)
         END
       ELSE IF (SELECT COUNT(*)
	        FROM  saldo_conta
			WHERE conta_c = @CONTA_C) = 0
           AND @OPER = 'C'
          BEGIN
		      INSERT INTO saldo_conta
			  VALUES       (@CONTA_C,
			                @VALOR)
          END
        ELSE IF	(SELECT COUNT(*)
		     FROM saldo_conta
			WHERE conta_c = @CONTA_C) > 0
		   AND @OPER = 'C'
		  BEGIN 
		     UPDATE saldo_conta
			 SET    saldo = saldo + @VALOR
			 WHERE  conta_c = @CONTA_C 
          END
		ELSE IF	(SELECT COUNT(*)
		     FROM saldo_conta
			WHERE conta_c = @CONTA_C) > 0
		   AND @OPER = 'D'
		  BEGIN 
		     UPDATE saldo_conta
			 SET    saldo = saldo - @VALOR
			 WHERE  conta_c = @CONTA_C 
          END
    END 

--TESTANDO TRIGGER 
--PARAMETROS  CONTA CORRENTE, VALOR, OPERAÇÃO 
--GERAR MOVIMENTOS

  INSERT INTO conta_corrente VALUES (123478,1500,'X')
  INSERT INTO conta_corrente VALUES (123479,2000,'Y')


--GERANDO MOVIMENTOS 
  INSERT INTO conta_corrente VALUES (123478,3000,'C')
  INSERT INTO conta_corrente VALUES (123478,3000,'D')
  INSERT INTO conta_corrente VALUES (123478,1500,'C')
  INSERT INTO conta_corrente VALUES (123478,2000,'D')

  INSERT INTO conta_corrente VALUES (123479,3000,'C')
  INSERT INTO conta_corrente VALUES (123479,2000,'D')


  SELECT * FROM conta_corrente
  SELECT * FROM saldo_conta

/*
  DELETE FROM  conta_corrente
  DELETE FROM  saldo_conta 
*/

