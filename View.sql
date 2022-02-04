
--CRIAÇÃO DE VIEW

USE AdventureWorks2017;

  CREATE VIEW v_data_contratacao
  AS
      SELECT p.firstname,
	         p.lastname,
			 e.businessentityid,
			 e.hiredate
			 FROM humanresources.employee e	
			 JOIN person.person AS p
     ON e.businessentityid = p.businessentityid;


--SELECT NA VIEW

  SELECT * FROM v_data_contratacao
  WHERE YEAR (hiredate) = '2009';

--ALTERANDO VIEW

  ALTER VIEW v_data_contratacao
  AS 
       SELECT p.firstname primeironome,
	         p.lastname ultimonome,
			 p.middlename nome_meio,
			 e.businessentityid,
			 e.hiredate admissao
			 FROM humanresources.employee e	
			 JOIN person.person AS p
     ON e.businessentityid = p.businessentityid;
 

--SELECT NA VIEW

  SELECT * FROM v_data_contratacao
  WHERE YEAR (admissao) = '2009';



--VIEW COM DADOS PARTICIONADOS 
--CRIAÇÃO DE VIEW COM DADOS DE VARIAS TABLES USANDO UNION ALL

--CREATE THE TABLE AND INSERT THE VALUES.

USE curso

  CREATE TABLE fornecedores1
  (
  id_fornec INT PRIMARY KEY CHECK (id_fornec BETWEEN 1 AND 150),
  fornec CHAR(50)
  )

  CREATE TABLE fornecedores2
  (
  id_fornec INT PRIMARY KEY CHECK (id_fornec BETWEEN 151 AND 300),
  fornec CHAR(50)
  )

  CREATE TABLE fornecedores3
  (
  id_fornec INT PRIMARY KEY CHECK (id_fornec BETWEEN 301 AND 450),
  fornec CHAR(50)
  )

  CREATE TABLE fornecedores4
  (
  id_fornec INT PRIMARY KEY CHECK (id_fornec BETWEEN 451 AND 600),
  fornec CHAR(50)
  )


--INSERINDO VALORES

  INSERT INTO fornecedores1 VALUES ('1', 'CaliforniaCorp') 
  INSERT INTO fornecedores1 VALUES ('5', 'BraziliaLtd')

  
  INSERT INTO fornecedores2 VALUES ('231', 'FarEast') 
  INSERT INTO fornecedores2 VALUES ('280', 'NZ')

  
  INSERT INTO fornecedores3 VALUES ('321', 'EuroGroup') 
  INSERT INTO fornecedores3 VALUES ('442', 'UKArchip')

  
  INSERT INTO fornecedores4 VALUES ('475', 'India') 
  INSERT INTO fornecedores4 VALUES ('521', 'Afrique')


SELECT * FROM fornecedores4

--CRIANDO VIEW

  CREATE VIEW v_fornec_geral
  AS
  SELECT id_fornec, fornec FROM fornecedores1
  UNION ALL
  SELECT id_fornec, fornec FROM fornecedores2
  UNION ALL
  SELECT id_fornec, fornec FROM fornecedores3
  UNION ALL
  SELECT id_fornec, fornec FROM fornecedores4
  

--SELECT NA v_fornec_geral

  SELECT * FROM v_fornec_geral


--ALTER VIEW
  
  
  ALTER VIEW v_fornec_geral
  AS
  SELECT 'f1' origem,id_fornec, fornec FROM fornecedores1
  UNION ALL
  SELECT 'f2',id_fornec, fornec FROM fornecedores2
  UNION ALL
  SELECT 'f3',id_fornec, fornec FROM fornecedores3
  UNION ALL
  SELECT 'f4',id_fornec, fornec FROM fornecedores4
  

  SELECT * FROM v_fornec_geral
--WHERE origem='f1'/'f2'/'f3'/'f4'
