--PROCEDURE PARA CALCULAR IMC-  INDICE DE MASSA DO CORPO 
--DROP PROCEDURE calc_imc

USE curso
GO
  CREATE PROCEDURE calc_imc @PESO DECIMAL(10,2), @ALTURA DECIMAL(10,2)
  AS
  BEGIN
--DECLARA VARIAVEL
  DECLARE @IMC DECIMAL(10,2);
--ATRIBUI VALOR 
  SET @IMC= @PESO/(@ALTURA*@ALTURA)
--BLOCO CONDICIONAL 
  IF @IMC < 17
  BEGIN
      PRINT 'SEU IMC � ' +CAST(@IMC AS VARCHAR (20))+ ' MUITO ABAIXO DO PESO'
  END 
  
  ELSE IF @IMC >= 17 AND @IMC <=18.49
  BEGIN 
      PRINT 'SEU IMC � ' +CAST(@IMC AS VARCHAR(20))+ ' ABAIXO DO PESO'
  END

  ELSE IF @IMC >= 18.5 AND @IMC <= 24.99
  BEGIN 
      PRINT 'SEU IMC � '+CAST(@IMC AS VARCHAR(20))+ ' PESO NORMAL'
  END
  
  ELSE IF @IMC >= 25 AND @IMC <= 29.99
  BEGIN 
      PRINT 'SEU IMC � '+CAST(@IMC AS VARCHAR(20))+ ' ACIMA DO PESO '
  END
  
  ELSE IF @IMC >= 30 AND @IMC <= 34.99
  BEGIN 
      PRINT 'SEU IMC � '+CAST(@IMC AS VARCHAR(20))+ ' OBESIDADE I'
  END
  
  ELSE IF @IMC >= 35 AND @IMC <= 39.99
  BEGIN 
      PRINT 'SEU IMC � '+CAST(@IMC AS VARCHAR(20))+ ' OBESIDADE II'
  END
  
  ELSE IF @IMC >= 40
  BEGIN 
      PRINT 'SEU IMC � '+CAST(@IMC AS VARCHAR(20))+ ' OBESIDADE III'
  END

END  
--EXECUTE PROCEDURE calc_imc
  EXEC calc_imc 92,1.80










