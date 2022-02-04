--MANIPULANDO TEMP TABLE 
 
--CRUD COM TEMP	TABLE


  CREATE TABLE #minhatemporaria
  (
     campo1 VARCHAR(80) NOT NULL,
	 campo2 MONEY NOT NULL
  )

  INSERT INTO #minhatemporaria VALUES  ('Real' ,1000)
  INSERT INTO #minhatemporaria VALUES  ('Dolar' ,3000)


  SELECT * FROM #minhatemporaria

--CRIANDO TABELA TEMPORARIA ATRAVÉS DE UM SELECT

  SELECT * INTO #minhatemporaria2 FROM #minhatemporaria


  SELECT * FROM #minhatemporaria2


--UPDATE EM TABELA TEMPORARIA
  UPDATE #minhatemporaria   SET   campo1 = 'Libra'
  WHERE campo1 = 'Real'

  SELECT * FROM #minhatemporaria

 DELETE FROM #minhatemporaria

 DROP TABLE #minhatemporaria
 DROP TABLE #minhatemporaria2












