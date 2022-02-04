USE curso;
--DROP TABLE ALUNOS
--CRIAÇÃO DE TABELA ALUNOS 	
--DROP TABLE ALUNOS
--DROP TABLE DISCIPLINA 
--DROP TABLE MATRICULA
 

  CREATE TABLE alunos 
  (
  id_aluno int identity(1,1),
  nome varchar(20) not null 
  );

--DROP TABLE DICIPLINA 

  CREATE TABLE DISCIPLINA
  (
  id_disciplina int identity(1,1),
  nome_disc varchar(20)
  );

--DROP TABLE MATRICULA 

  CREATE TABLE matricula
  (
  id_aluno INT,
  id_disciplina INT,
  periodo VARCHAR(10)
  );


--ALTERANDO TABELA CAMPO ID ALUNO PARA NÃO PERMITIR NOT NULL
  ALTER TABLE matricula ALTER COLUMN id_aluno INT NOT NULL;
 
--ALTERANDO TABELA 
  ALTER TABLE matricula ALTER COLUMN id_disciplina INT NOT NULL;

--CRIANDO CHAVE PRIMARIA COMPOSTA 
  ALTER TABLE matricula ADD CONSTRAINT PK_1 PRIMARY KEY (id_aluno,id_disciplina);

--ADCIONANDO CHAVE PRIMARIA TABELA DISCIPLINA 
  ALTER TABLE disciplina ADD CONSTRAINT PK2 PRIMARY KEY (id_disciplina);

--ADICIONANDO CHAVE PRIMARIA TABELA ALUNOS
  ALTER TABLE alunos ADD CONSTRAINT PK1 PRIMARY KEY (id_aluno);

--ADICIONANDO CHAVE ESTRANGEIRA NA TABELA MATRICULA CAMPO ID_ALUNO 
  ALTER TABLE matricula
  ADD CONSTRAINT FK_MAT1 FOREIGN KEY (id_aluno) REFERENCES alunos (id_aluno);

--ADICIONANDO CHAVE ESTRANGEIRA NA TABELA MATRICULA CAMPO ID_ALUNO 
  ALTER TABLE matricula
  ADD CONSTRAINT FK_MAT2 FOREIGN KEY (id_disciplina) REFERENCES disciplina (id_disciplina);
 
--INSERINDO REGISTRO ALUNOS 
  INSERT INTO alunos VALUES ('João'),('Maria'),('Pedro'),('Tiago'),('Henrique');

 
  SELECT *  FROM alunos;

--INSERINDO REGISTRO DISCIPLINAS
  INSERT INTO disciplina VALUES 
  ('Fisica'),('Quimica'),('Banco de Dados'),('Matematica'),('Programação');

 SELECT * FROM disciplina;


--INSERINDO MATRICULA DE ALUNOS

  INSERT INTO matricula VALUES ('1','1','Noturno');
  INSERT INTO matricula VALUES ('1','2','Vespertino');
  INSERT INTO matricula VALUES ('1','3','Matutino');

  INSERT INTO matricula VALUES ('2','3','Noturno');
  INSERT INTO matricula VALUES ('2','4','Noturno');

  INSERT INTO matricula VALUES ('3','1','Noturno');
  INSERT INTO matricula VALUES ('3','3','Noturno');
  INSERT INTO matricula VALUES ('3','4','Noturno');

  INSERT INTO matricula VALUES ('5','1','Matutino');
  INSERT INTO matricula VALUES ('5','2','Vespertino');
  INSERT INTO matricula VALUES ('5','4','Noturno');

--SIMULANDO ERROS 
  
  INSERT INTO matricula VALUES ('6','6','Noturno');

  INSERT INTO matricula VALUES ('5','4','Noturno');


--INNER JOIN 
  
  

  SELECT a.id_aluno,
         a.nome,
     	 c.id_disciplina,
  	     c.nome_disc,
		 b.periodo
  FROM alunos a
  INNER JOIN matricula b
  ON a.id_aluno=b.id_aluno
  INNER JOIN disciplina c
  ON b.id_disciplina=c.id_disciplina;


--LEFT JOIN 

  SELECT a.id_aluno,
         a.nome,
     	 c.id_disciplina,
  	     c.nome_disc,
		 b.periodo
  FROM alunos a
  LEFT JOIN matricula b
  ON a.id_aluno=b.id_aluno
  LEFT JOIN disciplina c
  ON b.id_disciplina=c.id_disciplina;


--RIGHT JOIN

  SELECT a.id_aluno,
         a.nome,
     	 c.id_disciplina,
  	     c.nome_disc,
		 b.periodo
  FROM alunos a
  RIGHT JOIN matricula b
  ON a.id_aluno=b.id_aluno
  RIGHT JOIN disciplina c
  ON b.id_disciplina=c.id_disciplina 
  ORDER BY a.id_aluno ASC;

--FULL JOIN

  SELECT a.id_aluno,
         a.nome,
		 c.id_disciplina,
		 c.nome_disc,
		 b.periodo
  FROM alunos a 
  FULL JOIN matricula b
  ON a.id_aluno=b.id_aluno
  FULL JOIN disciplina c
  ON b.id_disciplina=c.id_disciplina


--MAIS EXEMPLOS 

--INNER JOIN
  
USE crm;

  SELECT a.id_cliente,
         a.primeiro_nome,
		 a.codigo_pais,
		 b.ano,
		 c.nome_carro,
		 d.nome_montadora
  FROM cliente a 
  INNER JOIN carro_cliente b
  ON a.id_cliente=b.id_cliente

  INNER JOIN carro_montadora c
  ON b.id_carro=c.id_carro

  INNER JOIN montadora d
  ON c.id_montadora=d.id_montadora;


--INNER JOIN 

USE AdventureWorks2017;


  SELECT a.BusinessEntityID,
         a.FirstName,
		 a.LastName,
		 b.JobTitle,
		 a.PersonType
  FROM Person.Person a 
  INNER JOIN HumanResources.Employee b
  ON a.BusinessEntityID=b.BusinessEntityID


--VERIFICANDO  DADOS DA TABELA PERSON 

  SELECT * FROM Person.Person


--RIGHT JOIN 
  
  SELECT a.BusinessEntityID,
         a.FirstName,
		 a.LastName,
		 b.JobTitle,
		 a.PersonType
  FROM Person.Person a 
  RIGHT JOIN HumanResources.Employee b
  ON a.BusinessEntityID=b.BusinessEntityID
  
--LEFT JOIN

  SELECT a.BusinessEntityID,
         a.FirstName,
		 a.LastName,
		 b.JobTitle,
		 a.PersonType
  FROM Person.Person a 
  LEFT JOIN HumanResources.Employee b
  ON a.BusinessEntityID=b.BusinessEntityID

--FULL JOIN 
  
  SELECT a.BusinessEntityID,
         a.FirstName,
		 a.LastName,
		 b.JobTitle,
		 a.PersonType
  FROM Person.Person a 
  FULL JOIN HumanResources.Employee b
  ON a.BusinessEntityID=b.BusinessEntityID

  

