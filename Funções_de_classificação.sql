--RANK
/*As fun��es de classifica��o retornam um valor de classifica��o 
para cada linha em uma parti��o. Dependendo da fun��o usada, 
algumas linhas podem receber o msm valor que outras.
As fun��es de classifica��o s�o n�o deterministicas.
*/

--EXEMPLO 1 

USE curso;

  SELECT RANK() OVER (ORDER BY estado ASC) AS rank_uf,
         estado 
  FROM uf

--EXEMPLO 2

  SELECT RANK() OVER (ORDER BY estado ASC) AS rank_uf,
         regiao
	     estado
  FROM regiao;


--EXEMPLO 3

  SELECT RANK() OVER (ORDER BY regiao ASC) AS rank_uf,
         regiao
	     estado
  FROM regiao;


--NTILE

/* Distribui as linhas de uma parti��o ordenada em um n�mero de grupos especificado.
Os grupos s�o numerados, iniciando em um. Para cada linha,
NTILE retorna o n�mero do grupo ao qual a linha pertence.
*/

  SELECT NTILE(3) OVER (ORDER BY regiao ASC) AS NTILE_uf,
         regiao
	     estado
  FROM regiao;

--DENSE_RANK

/*Retorna a classifica��o de linhas da parti��o de um conjunto de resultados,
sem qualquer lacuna na classifica��o. A classifica��o de uma linha � um mais 
o n�mero de classifica��es distintas que v�m antes da linha em quest�o.
*/


  SELECT DENSE_RANK() OVER (ORDER BY regiao ASC) AS DANSE_RANK_uf,
         regiao,
	     estado
  FROM regiao;

--EXEMPLO 2

  SELECT DENSE_RANK() OVER (ORDER BY estado ASC) AS DENSE_RANK_uf,
         regiao,
	     estado
         regiao_uf 
  FROM regiao;


--ROW_NUMBER 

/* Retorna o n�mero  sequencial de uma linha em uma parti��o de um conjunto de resultados,
iniciando em 1 para a primeira linha de cada parti��o.
*/

  SELECT ROW_NUMBER() OVER (ORDER BY estado ASC) AS ROW_NUMBER_uf,
       regiao,
	   estado
  FROM regiao; 

--COMBINANDO VALORES 1
 
  SELECT ROW_NUMBER() OVER (ORDER BY regiao ASC) AS ROW_NUMBER_uf ,
         DENSE_RANK() OVER (ORDER BY regiao ASC) AS DENSE_RANK_uf ,
		 NTILE(6) OVER (ORDER BY regiao ASC) AS NTILE_uf , 
		 RANK() OVER (ORDER BY regiao ASC) AS RANK_uf ,
		 regiao, 
		 estado
  regiao_uf
  FROM regiao 
  order by 5,6

--COMBINANDO VALORES 1

  SELECT ROW_NUMBER() OVER (ORDER BY estado ASC) AS ROW_NUMBER_uf ,
         DENSE_RANK() OVER (ORDER BY estado ASC) AS DENSE_RANK_uf ,
		 NTILE(6) OVER (ORDER BY estado ASC) AS NTILE_uf , 
		 RANK() OVER (ORDER BY estado ASC) AS RANK_uf ,
		 regiao, 
		 estado
  regiao_uf
  FROM regiao 
  order by 4,6

--SIMULANDO CLASSIFICA��O DE CAMPEONATO
--DROP TABLE CAMPEONATO

  CREATE TABLE campeonato
  (
  nometime VARCHAR(30) NOT NULL , 
  pontos int NOT NULL
  );

--POPULANDO TABELA
  
  INSERT INTO campeonato VALUES ('Atletico-GO','22');
  INSERT INTO campeonato VALUES ('Chapecoense','28');
  INSERT INTO campeonato VALUES ('Ponte Preta','28');
  INSERT INTO campeonato VALUES ('Gr�mio','43');
  INSERT INTO campeonato VALUES ('Cruzeiro','37');
  INSERT INTO campeonato VALUES ('Santos','41');
  INSERT INTO campeonato VALUES ('Palmeiras','40');
  INSERT INTO campeonato VALUES ('Corinthians','53');
  INSERT INTO campeonato VALUES ('Flamengo','38');
  INSERT INTO campeonato VALUES ('Botafogo','37');
  INSERT INTO campeonato VALUES ('Atletico-PR','34');
  INSERT INTO campeonato VALUES ('Vasco','31');
  INSERT INTO campeonato VALUES ('Atleico-MG','31');
  INSERT INTO campeonato VALUES ('Sport','29');
  INSERT INTO campeonato VALUES ('Ava�','29');
  INSERT INTO campeonato VALUES ('Bahia','27');
  INSERT INTO campeonato VALUES ('Fluminense','31');
  INSERT INTO campeonato VALUES ('S�o Paulo','27');
  INSERT INTO campeonato VALUES ('Coritiba','27');
  INSERT INTO campeonato VALUES ('Vit�ria','26');



  SELECT * FROM campeonato

  SELECT RANK() OVER (ORDER BY pontos DESC) AS	classif , 
         nometime,
		 pontos 
  FROM campeonato; 








