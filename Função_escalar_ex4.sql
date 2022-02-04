--FUN��O PARA RECEBER DUAS DATAS E RETORNAR INTERVALO DE ACORDO COM PARAMETRO
USE curso;
--FUN��O DE TABELA 
--VARIAVEL DIA INTERVALOS ENTRE OS DIAS 
--DTI DATA INICIAL 
--DTF DATA FINAL 
--DROP FUNCTION func_dias

  CREATE FUNCTION dbo.func_dias(@dia INT, @dti DATETIME, @dtf DATETIME)
      RETURNS @tbl TABLE (SEQ INT, DT DATETIME)
	  AS
	  BEGIN
	    DECLARE @CONT INT;
		 SET @CONT=1;
		  WHILE @dti <= @dtf
		      BEGIN
			      INSERT INTO @tbl (SEQ,dt) VALUES (@CONT,@dti)
				  SET @dti = DATEADD(DAY, @dia, @dti)
				  SET @CONT = @CONT +1
              END
			  RETURN
      END;

--INVOCANDO FUN��O DIAS 
  SELECT * FROM  dbo.func_dias(1,GETDATE(),GETDATE()+12)