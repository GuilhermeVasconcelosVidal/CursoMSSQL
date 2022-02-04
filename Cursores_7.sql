

USE curso;

DECLARE @id_aluno   INT,
        @nome       VARCHAR(30),
		@nome_disc  VARCHAR(30),
		@periodo    VARCHAR(10)

--DECLARANDO PRIMEIRO CURSOR
  DECLARE c_alunos CURSOR FOR
  SELECT id_aluno,
         nome
  FROM   alunos


  OPEN c_alunos

  FETCH NEXT FROM c_alunos INTO @id_aluno, @nome

--REPETI��O PRIMEIRO CURSOR
  WHILE @@FETCH_STATUS = 0
    BEGIN
	   PRINT 'Nome do Aluno: ' + @nome;

	   PRINT 'Disciplinas: ';

	   --DECLARANDO SEGUNDO CURSOR
	   DECLARE c_disciplina CURSOR FOR
	     SELECT b.nome_disc,
		        a.periodo
         FROM   matricula a
		        INNER JOIN disciplina b
	                  ON a.id_disciplina = b.id_disciplina
		 WHERE  a.id_aluno = @id_aluno


   OPEN c_disciplina 

   FETCH NEXT FROM c_disciplina INTO @nome_disc, @periodo	

--REPETI��O DO SEGUNDO CURSOR
  WHILE @@FETCH_STATUS = 0
    BEGIN 
	   PRINT @nome_disc;

	   FETCH NEXT FROM c_disciplina INTO @nome_disc, @periodo
  --FECHANDO REPETI��O SEGUNDO CURSOR 
    END

	CLOSE c_disciplina
	DEALLOCATE c_disciplina 


	PRINT '---------------:';

	FETCH NEXT FROM c_alunos INTO @id_aluno, @nome 

    END

	CLOSE c_alunos 
	DEALLOCATE c_alunos









