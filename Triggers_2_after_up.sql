--multiplos registros
--DISABLE TRIGGER TG_aud_sal ON SALARIO
--ENABLE TRIGGER TG_aud_sal ON SALARIO

USE curso;

--DROP TRIGGER TG_aud_sal2
  CREATE TRIGGER TG_aud_sal2
  ON SALARIO
  AFTER UPDATE 
  AS
    BEGIN
	    DECLARE @matricula_aux INT
		DECLARE cursor_processo CURSOR FOR
		 
		  SELECT matricula FROM  INSERTED /* TABELA VIRTUAL INSERT */

        OPEN cursor_processo

		FETCH NEXT  FROM cursor_processo INTO @matricula_aux

		WHILE @@FETCH_STATUS = 0
		  BEGIN
		      INSERT INTO auditoria_salario
			  SELECT       i.matricula,
						   d.SALARIO,
						   i.SALARIO,
						   SYSTEM_USER,
						   GETDATE()
              FROM  DELETED d,
			        INSERTED i
              
			  WHERE d.matricula = i.matricula
			        AND @matricula_aux = i.matricula;

              FETCH NEXT  FROM	cursor_processo INTO @matricula_aux
          END

  CLOSE cursor_processo 
  DEALLOCATE cursor_processo

  END

  /*
     DELETE FROM auditoria_salario

	 UPDATE	SALARIO SET SALARIO=SALARIO*1.15

	 SELECT * FROM auditoria_salario
	 SELECT * FROM salario

  */























