--VERIFICANDO SE EXISTE LINKED SERVER NO BD
  
  SELECT * FROM  sys.servers



--CRIANDO LINKED SERVER
  EXEC    sp_addlinkedserver
          @server ='LNK_EXP2'
		 ,@srvproduct =''
		 ,@provider = 'SQLNCLI'
		 ,@datasrc = 'NOTEBOOK-DELL\SQLEXPRESS'

--CRIANDO USUARIO DO LINKED SERVER

  EXEC    sp_addlinkedsrvlogin
          @rmtsrvname ='LNK_EXP2',
          @useself = 'true',
		  @locallogin = 'sa',
		  @rmtuser = NULL,
		  @rmtpassword='derek1977'


  EXEC sp_droplinkedsrvlogin @rmtsrvname = 'LNK_EXP',
                             @locallogin = 'sa'

--EXCLUINDO LINKED SERVER 

  EXEC sp_dropserver @server = N'LNK_EXP2', @droplogins='droplogins'

--UTILIZANDO OPENQUERY
--SELECT

  SELECT * FROM OPENQUERY  (LNK_EXP2, 'SELECT * FROM curso.dbo.carros'); 

--INSERT 
  INSERT  OPENQUERY (LNK_EXP2,'SELECT COD, NOME_CARRO,PRECO FROM curso.dbo.carros')
                         VALUES (4,'CARRO PRATA', 35000);

--UPDATE 
  UPDATE OPENQUERY (LNK_EXP2,'SELECT COD, NOME_CARRO,PRECO FROM curso.dbo.carros WHERE COD=4')
                         SET PRECO = 50000

--DELETE 
  DELETE OPENQUERY (LNK_EXP2,'SELECT COD FROM curso.dbo.carros WHERE COD =''4''');




