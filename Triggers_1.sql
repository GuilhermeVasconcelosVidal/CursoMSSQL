--DROP TRIGGER TG_aud_sal

  CREATE TRIGGER TG_aud_sal --unico registro
      ON SALARIO
	      AFTER UPDATE
      AS
	  BEGIN

	       DECLARE @sal_antigo DECIMAL(10,2)
		   DECLARE @sal_novo   DECIMAL(10,2)
		   DECLARE @matricula  INT

		   SELECT @matricula  = (SELECT matricula FROM INSERTED)
		   SELECT @sal_antigo = (SELECT SALARIO FROM DELETED)
		   SELECT @sal_novo   = (SELECT SALARIO FROM INSERTED)
	  

	  INSERT INTO auditoria_salario
	  VALUES
	  (@matricula, ISNULL(@sal_antigo,0), @sal_novo, SYSTEM_USER, GETDATE())

	  END	
	
--TESTANDO TRIGGER
  UPDATE SALARIO SET SALARIO ='2500' WHERE matricula='1'	
  UPDATE SALARIO SET SALARIO ='3000' WHERE matricula='2'
  UPDATE SALARIO SET SALARIO ='3500' WHERE matricula='3'
  UPDATE SALARIO SET SALARIO ='4000' WHERE matricula='4'


  SELECT * FROM auditoria_salario

