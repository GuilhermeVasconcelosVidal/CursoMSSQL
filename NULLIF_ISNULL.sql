


--NULLIF RETORNA UM VALOR NULO SE AS DUAS EXPRESSÕES ESPECIFICADAS FOREM IGUAIS. 
--ISNULL RETORNA UM VALOR ESPECIFICADO SE A EXPRESSÃO FOR NULO.

--EXEMPLO

USE curso;
  CREATE TABLE TESTE2
 (
  val1 int,
  val2 int
 );

  INSERT INTO TESTE2 VALUES (100,0), (100,25), (1,0), (5,2)

  SELECT * FROM TESTE2;

--EXPRESSÃO COM ERRO
  SELECT
        val1,
		val2,
		val1 / val2 AS expressão
  FROM TESTE2



--EXPRESSÃO COM ERROS TRATADOS

  SELECT 
        val1,
		val2,
		ISNULL(val1/NULLIF(val2,0),0) expressao1,
		ISNULL(CAST(val1 AS DECIMAL(5,2))/CAST(NULLIF(val2,0) AS DECIMAL(5,2)),0) expressao2
  FROM TESTE2;


--NULLIF

USE AdventureWorks2017;
  
  SELECT productid,
         makeflag,
		 finishedgoodsflag,
		 NULLIF(makeflag, finishedgoodsflag) AS 'Null se igual'
		 FROM production.product
		 WHERE productid < 10;

--ISNULL
 
USE curso;

  --SELECT DISTINCT a.id_aluno, a.nome, b.periodo
  SELECT DISTINCT a.id_aluno, a.nome, ISNULL(b.periodo,'Vazio') AS periodo
  FROM alunos a 
  LEFT JOIN matricula b
  on a.id_aluno= b.id_aluno;












