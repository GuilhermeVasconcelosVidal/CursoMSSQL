--RANK
/*As funções de classificação retornam um valor de classificação 
para cada linha em uma partição. Dependendo da função usada, 
algumas linhas podem receber o msm valor que outras.
As funções de classificação são não deterministicas.
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

/* Distribui as linhas de uma partição ordenada em um número de grupos especificado.
Os grupos são numerados, iniciando em um. Para cada linha,
NTILE retorna o número do grupo ao qual a linha pertence.
*/

  SELECT NTILE(3) OVER (ORDER BY regiao ASC) AS NTILE_uf,
         regiao
	     estado
  FROM regiao;

--DENSE_RANK

/*Retorna a classificação de linhas da partição de um conjunto de resultados,
sem qualquer lacuna na classificação. A classificação de uma linha é um mais 
o número de classificações distintas que vêm antes da linha em questão.
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

/* Retorna o número  sequencial de uma linha em uma partição de um conjunto de resultados,
iniciando em 1 para a primeira linha de cada partição.
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

--SIMULANDO CLASSIFICAÇÃO DE CAMPEONATO
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
  INSERT INTO campeonato VALUES ('Grêmio','43');
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
  INSERT INTO campeonato VALUES ('Avaí','29');
  INSERT INTO campeonato VALUES ('Bahia','27');
  INSERT INTO campeonato VALUES ('Fluminense','31');
  INSERT INTO campeonato VALUES ('São Paulo','27');
  INSERT INTO campeonato VALUES ('Coritiba','27');
  INSERT INTO campeonato VALUES ('Vitória','26');



  SELECT * FROM campeonato

  SELECT RANK() OVER (ORDER BY pontos DESC) AS	classif , 
         nometime,
		 pontos 
  FROM campeonato; 








