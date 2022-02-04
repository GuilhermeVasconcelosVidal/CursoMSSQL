--CRIANDO FUNÇÃO ESCALAR SOMA 
--DROP FUNCTION SOMA 

USE curso
GO

CREATE FUNCTION SOMA (@num1 INT,@num2 INT)
    RETURNS INT
	BEGIN
	    DECLARE @res INT 
		SET @res=@num1+@num2
		RETURN( @res )
    END


--INVOCANDO FUNÇÃO ESCALAR SOMA 

  SELECT '>>>' ,dbo.SOMA(5,3)


--drop table #testesoma
create table #testesoma
  (val1 INT,
   val2 INT
   )

--INSERINDO VALORES 
  INSERT INTO #testesoma VALUES (10,2),(5,4),(89,3)


--INVOCANDO FUNÇÃO SOMA
  SELECT val1,
         val2,
		 dbo.soma(val1,val2)
  FROM #testesoma



