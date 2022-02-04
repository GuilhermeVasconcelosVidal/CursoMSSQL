USE AdventureWorks2017;

--ASCII EXEMPLO 
--
  SELECT ASCII('SQL');
  SELECT ASCII('S');
  SELECT ASCII('Q');
  SELECT ASCII('L');



/* O exemplo a seguir supõe um conjunto de caracteres ASCII e retorna o valor 
ASCII e o caractere CHAR para cada caractere da cadeia de caracteres 
da frase "TEste " */

  DECLARE @position INT,
  @string   CHAR(5);
  --INICIALIZE THE VARIABLES.
  SET @position = 1;
  SET @string = 'TEste';
      WHILE @position <= len(@string)   --len Tamanho da sting
	      BEGIN    
			  SELECT ASCII(SUBSTRING(@string, @position, 1))cod_ascii,
			  CHAR(ASCII(SUBSTRING(@string, @position, 1)))
			  SET @position = @position + 1
          END;

--LTRIM
--RETORNA UMA EXPRESSÃO DE CARACTERE DEPOIS DE REMOVER ESPAÇOS EM BRANCO À ESQUERDA 

  DECLARE @string_to_trim VARCHAR(60);
  SET @string_to_trim = '     Cinco espaços no inicio.';
  SELECT  'Texto sem espaço:'+LTRIM(@string_to_trim);
  SELECT  'Texto com espaço:'+ @string_to_trim;

--STR

--EXEMPLO RETORNA DADOS DE CARACTERE CONVERTIDOS DE DADOS NUMÉRICOS

  SELECT STR(123.45, 6, 1);

--PROVA DE CONVERSÃO DE NUMERICO PARA CARACTERE
  SELECT 'Teste ' +STR(123.45, 6, 1) AS TESTE ;

/* Quando a expressão excede o comprimento especificado, a cadeia de caracteres retorna 
** para o comprimento especificado */

  SELECT STR(123.45, 2, 2);


--CONCAT

/*Retorna uma cadeia de caracteres que é o resultado da concatenação de dois ou mais valores*/


  SELECT CONCAT(CURRENT_USER,
			   ' Seu saldo é de R$',
			   11.00,
			   ' em ',
			   DAY(GETDATE()), '/' ,
			   MONTH(GETDATE()), '/' ,
			   YEAR(GETDATE())) AS RESULTADO 

--SIMULANDO ERRO 
  SELECT CURRENT_USER +
			   ' Seu saldo é de R$' +
			   11.00 +
			   ' em ' +
			   DAY(GETDATE())+ '/' +
			   MONTH(GETDATE())+ '/' +
			   YEAR(GETDATE()) AS RESULTADO 


--CONCAT_WS
/* Separa e retorna valores de cadeia de caracteres concatenados com o delimmitador
especificado no argumento da primeira função */
--ATENÇÃO IGNORA VALORES NULL

USE crm;

  SELECT CONCAT_WS(' | ', a.primeiro_nome, a.ultimo_nome, a.email,a.nascimento, a.sexo)
    FROM cliente a


--EXEMPLO 

USE curso

--SELECT a.id_aluno,a.nome,c.nome_disc,b.periodo FROM alunos a 
--SELECT CONCAT_WS(' | ',a.id_aluno,a.nome,c.nome_disc,b.periodo) FROM alunos a 
  SELECT CONCAT_WS(' | ',
                a.id_aluno,
                a.nome,
                ISNULL(b.id_disciplina,' ') ,
                ISNULL(c.nome_disc,''),
                ISNULL(b.periodo,'sem period')) AS MATRICULAS 
  FROM alunos a 
LEFT JOIN matricula b
ON a.id_aluno=b.id_aluno 
LEFT JOIN disciplina c
ON b.id_disciplina=c.id_disciplina;


--REPLACE 
/*Substitui todas as ocorrências de um valor da cadeia de caracteres
especificado por outro valor de cadeia de caracteres*/

--O EXEMPLO A SEGUIR SUBSTITUI A CADEIA DE CARACTERES CDE EM TESTE POR PRODUÇÃO

  SELECT 'abcdefghicde' de, 
      REPLACE('abcdefghicde', 'cde', 'xxx')para

--O EXEMPLO A SEGUIR SUBSTITUI A CADEIA DE CARACTERES CDE EM TESTE POR PRODUÇÃO
  SELECT 'Isto é teste ' de,	 	  
	  REPLACE('Isto é teste', 'teste', 'produção')para;


--REPLACE NO SELECT 

USE curso;

  SELECT regiao,
      REPLACE(regiao, 'Sul', 'South')
	  FROM regiao


--EXEMPLO DE UPDATE USANDO REPLACE

CREATE TABLE pessoas 
    (nome VARCHAR(30)
	)
--INSERINDO REGISTROS
  INSERT INTO pessoas VALUES ('José')
  INSERT INTO pessoas VALUES ('André')
  INSERT INTO pessoas VALUES ('Helem')

--VERIFICANDO REGISTROS

  SELECT * FROM pessoas
--
UPDATE pessoas SET nome=REPLACE(nome, 'é', 'e');

--REPLICATE 
--Repete um valor da cadeia de caracteres um número especificado de vezes
/*O exemplo a seguir replica um caractere 0 quatro vezes na frente de um codigo
de linha de produção no banco de dados*/

USE AdventureWorks2017;

  SELECT NAME,
         productline,
		 REPLICATE('0', 4) + productline AS 'Codigo'
  FROM Production.Product
  WHERE productline = 'T'
  ORDER BY NAME 

--LEFT 
--RETORNA PARTE	DA ESQUERDA DE UMA CADEIA DE CARACTERES COM O NUMERO DE CARACTERES ESPECIFICADOS.

USE AdventureWorks2017;

  SELECT NAME,
         LEFT(NAME, 5)
  FROM production.product
  ORDER  BY productid;

--UPPER
--RETORNA UMA EXPRESSÃO DE CARACTERE COM DADOS DE CARACTERE EM MINUSCULAS CONVERTIDOS EM MAIUSCULAS 
  USE curso
  SELECT estado,
         upper(estado)
  FROM regiao;

--SUBSTRING
--RETORNA UMA SUBSTRING DE CARACTERE COM DADOSDE CARACTERE DENTRO DO PARAMETRO INFORMADO 

USE AdventureWorks2017;

  SELECT lastname nome,
         SUBSTRING(lastname, 1, 3) lastname1,
		 SUBSTRING(lastname, 4, 10) lastname2
  FROM   person.person
  ORDER BY lastname;

--REVERSE
--RETORNA A ORDEM INVERSA DE UM VALOR DA CADEIA DE CARACTERES.

  SELECT firstname,
         REVERSE(firstname) AS REVERSE 
		 FROM person.person
  WHERE businessentityid < 5
  ORDER BY firstname

--LEN
/* Retorna o número de caracteres de expressão de cadeia de caracteres especificada,
excluindo espaços em branco à direita*/

  SELECT firstname,
         LEN(firstname) AS Tamanho 
  FROM   sales.vindividualcustomer
  WHERE  countryregionname = 'Australia';

--DATALENGTH
--RETORNA O NUMERO DE BYTES USADO PARA REPRESENTAR QUALQUER EXPRESSÃO
  
  SELECT NAME, 
         DATALENGTH(NAME) AS DATA
  FROM	 production.product
  ORDER BY NAME;

--COMPARANDO DATALENGTH COM LEN
  SELECT  NAME,
		DATALENGTH(NAME)as DATALENGTH,
       LEN(NAME) AS LEN		    
  FROM   production.product 
  ORDER  BY NAME


USE curso;

--DROP TABLE T1
CREATE TABLE t1   
	(      c1 VARCHAR(3),      
			c2 CHAR(3),
			c3 NVARCHAR(3)  
	 );

INSERT INTO t1 VALUES      ('2','2','2') 
INSERT INTO t1 VALUES      ('37','37','37') 
INSERT INTO t1 VALUES      ('597','597','597') 

--SELECT * FROM t1
--DROP TABLE t1
SELECT c1,
       c2,
	   c3,
	   DATALENGTH(c1) dtlc1,
	   DATALENGTH(c2) dtlc2,
	   DATALENGTH(c3) dtlc3
	   FROM   t1;


--RIGHT
--RETORMA PARTE DA DIREITA DE UMA CADEIA DE CARACTERES COM O NÚMEROS DE CARACTERES ESPECIFICADO
USE curso;

	SELECT a.estado,
		   RIGHT(estado, 5) AS 'Estado' 
	FROM   regiao a
	
--LOWER
/* Retorna uma expressão de caractere depois de converter
para minúsculas os dados de caracteres em maiúsculas
O exemplo a seguir usa a função LOWER, a função UPPER, 
e aninha a função UPPER dentro da função LOWER selecionando 
nomes de produtos com preços entre US$ 11 e US$ 20.*/ 
--Este exemplo usa o banco de dados AdventureWorks2014 
 
USE AdventureWorks2017
	SELECT SUBSTRING(NAME, 1, 20)NAME,
		   LOWER(SUBSTRING(NAME, 1, 20)) AS LOWER,        
		   UPPER(SUBSTRING(NAME, 1, 20)) AS UPPER,        
		   LOWER(UPPER(SUBSTRING(NAME, 1, 20))) AS LowerUpper 
   FROM   production.product 
   WHERE  listprice BETWEEN 11.00 AND 20.00; 

--RTRIM
--RETORNA UMA CADEIA DE CARACTERES DEPOIS DE TRUNCAR TODOS OS ESPAÇOS EM BRANCO À DIREITA
--EXEMPLO SIMPLES
SELECT RTRIM('Removendo espaços.   ');

--EXEMPLO 2
	DECLARE @string_to_trim VARCHAR(60); 
	SET @string_to_trim ='Deixamos 4 espacos apos final da sentença.    '; 
	SELECT @string_to_trim + ' proxima string.'; 
	SELECT RTRIM(@string_to_trim) + ' proxima string.'









