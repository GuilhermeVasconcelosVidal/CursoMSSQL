--COMANDO IF

  IF 1 = 1
    BEGIN 
       PRINT 'CORRETO � TRUE'
    END
    ELSE 
      PRINT 'ERRADO � FALSE';

--IF AND

  IF 1=1 AND 2 <> 2
    BEGIN 
	  PRINT 'Correto � true'
    END
	  PRINT 'Errado � false';



--EXEMPLO AND

  IF 1 = 1 AND 2 = 17
    BEGIN
	  PRINT 'Correto � true'
	END
	ELSE 
	  PRINT 'Errado � false';

--EXEMPLO OR IF ELSE
  
  IF 1 <> 1 OR 2 = 17
    BEGIN
	  PRINT 'Correto � true'
	END
	ELSE 
	  PRINT 'Errado � false';

--EXEMPLO 1

USE curso

--TESTE COM IF ELSE

	  DECLARE @id_aluno INT;
	  SET @id_aluno = '4';
	  IF ( SELECT COUNT(*)
		   FROM matricula    
		   WHERE id_aluno = @id_aluno) = 0 
		BEGIN 
		  PRINT 'Aluno n�o Matriculado'
		END
		ELSE
		BEGIN
		  PRINT 'Materias Matriculadas';
		SELECT b.nome_disc, a.periodo FROM matricula a
		INNER JOIN disciplina b
		ON a.id_disciplina = b.id_disciplina
		AND a.id_aluno = @id_aluno

		END;


--OUTRO EXEMPLO

  DECLARE @idade INT;
  SET @idade = 65;

  IF @idade < 18
    PRINT 'Menor que 18 anos';
  ELSE IF @idade >= 18 AND @idade < 65
    PRINT 'Maior que 18 anos';
  ELSE 
    PRINT 'Acima de 65 anos';
























