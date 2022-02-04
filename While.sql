--EXEMPLO 1 WHILE 

  DECLARE @cont INT;
  SET @cont = 10;
  WHILE (SELECT GETDATE()-@cont) <= GETDATE()
         BEGIN
		   PRINT GETDATE()-@cont
		   SET @cont=@cont-1
		 IF (GETDATE()-@cont) >= GETDATE()
		   
		    BREAK

         ELSE
		    CONTINUE
		 END;


--EXEMPLO TABOADA

  DECLARE @CONT1 INT,
          @TAB INT
  SET @CONT1 = 0
  SET @TAB = 7

  WHILE(@CONT1 <= 10)
  BEGIN
     PRINT CAST(@CONT1 AS NVARCHAR) + N' X ' + CAST(@TAB AS NVARCHAR) +  N' = ' + CAST(@CONT1*@TAB AS NVARCHAR)	
     SET @CONT1= @CONT1 + 1
  END;

--OUTRO EXEMPLO 

  DECLARE @valor1 int,
          @valor2 int,
		  @mod int	
  SET @valor1 = 1
  SET @valor2 = 10

  WHILE(@valor1 <= @valor2)
  BEGIN
    SET @mod=@valor1%2
  IF @mod=0
    BEGIN
      PRINT 'O numero '+CAST(@valor1 AS NCHAR(2))+' é par'
       SET @valor1 = @valor1 + 1
  END
   ELSE
     BEGIN
	   PRINT 'O numero '+CAST(@valor1 AS NCHAR(2))+' é impar'
	    SET @valor1=@valor1 + 1
     END
END












		