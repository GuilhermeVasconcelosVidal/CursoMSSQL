--CRIANDO FUN��O ESCALAR TRIM 
--DROP FUNCTION TRIM

USE curso;
GO

--DROP FUNCTION FN_TRIM;

  CREATE FUNCTION FN_TRIM(@ST VARCHAR(1000))
   RETURNS VARCHAR(1000)
    BEGIN
	  RETURN(LTRIM(RTRIM(@ST)))
    END;





--INVOCANDO FUN��O ESCALAR TRIM
  SELECT '>' + ('     Silva Telles      ')+'<'
  UNION
  SELECT '>' + DBO.FN_Trim('      Silva Telles     ')+'<'


--PARA ALTERAR FUN��O
  ALTER FUNCTION FN_Trim(@ST VARCHAR(500))
   RETURNS VARCHAR(500)
    BEGIN 
	  RETURN(LTRIM(RTRIM(@ST)))
    END;


--APAGAR FUN��O 
  DROP FUNCTION FN_Trim; 


