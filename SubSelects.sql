USE crm;
GO


--EXEMPLO SUBQUERYS
   
   SELECT a.id_cliente,
          a.primeiro_nome,
		  a.ultimo_nome,
		  a.sexo
		  FROM  cliente a
   WHERE a.id_cliente in (SELECT b.id_cliente FROM carro_cliente b WHERE b.ano='2005');

--EXEMPLO SUBQUERYS

   SELECT a.id_cliente,
          a.primeiro_nome,
		  a.ultimo_nome,
		  a.sexo
		  FROM  cliente a
   WHERE a.id_cliente in (SELECT b.id_cliente FROM carro_cliente b WHERE b.ano='2005'
    and b.id_carro in (SELECT c.id_carro FROM carro_montadora c WHERE c.id_montadora=2));

--EXEMPLO SUBQUERYS

   SELECT a.id_cliente,
          a.primeiro_nome,
		  a.ultimo_nome,
		  a.sexo,
          (SELECT b.nome_carro
		          FROM carro_montadora b
				  INNER JOIN carro_cliente c
				  ON b.id_carro=c.id_carro
				  AND a.id_cliente=c.id_cliente) AS nome_carro
          FROM  cliente a;

--RETORNADO COM SUBSELECT
   
   SELECT a.id_cliente,
          a.primeiro_nome,
		  a.ultimo_nome,
		  a.codigo_pais,
		  (SELECT b.nome_pais FROM pais b WHERE a.codigo_pais=b.codigo_pais) AS nome_pais 
		  FROM cliente a;


--SUBSELECT CO FUNÇÕES DE AGREGAÇÃO

   SELECT a.id_montadora,a.nome_carro,
   (SELECT AVG (b.ano) FROM carro_cliente b WHERE a.id_carro=b.id_carro) media_ano,
   (SELECT MIN (b.ano) FROM carro_cliente b WHERE a.id_carro=b.id_carro) mais_antigo,
   (SELECT MAX (b.ano) FROM carro_cliente b WHERE a.id_carro=b.id_carro) mais_novo,
   (SELECT COUNT(*) FROM carro_cliente b WHERE a.id_carro=b.id_carro) qtd
   FROM
   carro_montadora a;


--CRIANDO CENARIO PARA FAZER UPDATE COM SUBSELECT

   ALTER TABLE carro_montadora ADD qtd INT;


   SELECT * FROM carro_montadora;


--criando update para contar qtd de carros que o clientes possuem modelo

   BEGIN TRANSACTION;
   UPDATE carro_montadora SET qtd = (SELECT COUNT(*) AS qtd FROM carro_cliente b 
     INNER JOIN carro_montadora c ON 
	 c.id_carro= b.id_carro
	 AND carro_montadora.id_carro=b.id_carro 
	 GROUP BY b.id_carro);

   COMMIT;

--NESTA SITUAÇÃO O CORRETO A SER FEITO É USAR O COMMIT, AO INVÉZ DE USAR O ROLLBACK


--EXEMPLO DELETE COM SUBSELECT 

BEGIN TRANSACTION;


DELETE  carro_cliente
where id_cliente IN (SELECT id_cliente FROM cliente where codigo_pais='BR');	

ROLLBACK;


SELECT * FROM carro_cliente;
