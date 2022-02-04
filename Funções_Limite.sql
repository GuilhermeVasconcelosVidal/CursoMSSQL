--TOP 

USE curso;
  SELECT TOP 10 * FROM campeonato
  ORDER BY pontos DESC;

USE crm;

--trazendo top 10 montadoras x carros

  SELECT TOP 10 a.nome_montadora, COUNT(b.id_carro) AS qtd_carro
  FROM montadora a
  INNER JOIN carro_montadora b
  ON a.id_montadora=b.id_montadora
  GROUP BY a.nome_montadora
  ORDER BY qtd_carro DESC;


--top 10 cidades mais populosas do Brasil

USE curso;

  SELECT TOP 10 * FROM SENSO
  ORDER BY populacao DESC;

--outro exemplo 

  SELECT TOP 10 *,RANK() OVER (ORDER BY populacao DESC) AS posicao
  FROM senso
  ORDER BY populacao DESC;




