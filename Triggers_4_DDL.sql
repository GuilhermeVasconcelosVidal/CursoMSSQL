--create trigger de restrição DDL
--drop trigger trig_controla_ddl on database
--drop trigger trig_controla_ddl on ALL SERVER
--disable trigger trig_controla_ddl on database
--enable trigger trig_controla_ddl on database

--disable trigger trig_controla_ddl_db on database
--drop TRIGGER trig_controla_ddl_db on database
USE curso 
GO 
  CREATE TRIGGER trig_controla_ddl_db
  ON DATABASE
  FOR create_procedure,
      alter_procedure,
	  drop_procedure,
	  CREATE_TABLE,
	  DROP_TABLE,
	  ALTER_TABLE
  AS
      IF DATEPART(hh, GETDATE()) <= 8
	     OR DATEPART(hh, GETDATE())>= 18
        BEGIN
		    DECLARE @msg VARCHAR(200)
			SELECT @msg = 'Complete o trabalho em horario comercial'
			PRINT (@msg)
			ROLLBACK
        END

--DISABLE TRIGGER trig_controla_ddl_SRV ON ALL SERVER 
--DROP TRIGGER trig_controla_ddl_SRV ON ALL SERVER

  CREATE TRIGGER trig_controla_ddl_SRV
  ON ALL SERVER
  FOR create_procedure,
      alter_procedure,
	  drop_procedure,
	  CREATE_TABLE,
	  DROP_TABLE,
	  ALTER_TABLE
  AS
      IF DATEPART(hh, GETDATE()) <= 8
	     OR DATEPART(hh, GETDATE()) >= 18
        BEGIN
		    DECLARE @msg VARCHAR(200)
			SELECT @msg = 'Complete o trabalho em horario comercial'
			PRINT (@msg)
			ROLLBACK
        END

--TESTE PROCEDURE CRIÇÃO 
--DROP PROCEDURE PROC_TESTE_DML

  CREATE PROCEDURE Proc_teste_dml
     AS
	 BEGIN 
	    PRINT 'TESTE DE CRIACAO'
     END

	 EXEC Proc_teste_dml

--TESTE CREATE TABLE 
--DROP TABLE teste_tg
  
  CREATE TABLE teste_tg
  (
   NUMERO INT  
  );











