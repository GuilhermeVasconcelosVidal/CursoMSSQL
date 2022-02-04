---BULK INSERT

USE curso 

CREATE TABLE produto
  (cod  NVARCHAR(5),
   nome NVARCHAR(20)
  );



--EXEMPLO BULK INSERT 
  BULK INSERT produto
  FROM 'E:\CURSOS\CODIGO_DOS_CURSOS\SQL_SERVER\SCRIPTS\BULK'
  WITH       (
      codepage='ACP'            --  {'ACP' | 'OEM' | 'RAW' |'cod_page'} ]
	 ,DATAFILETYPE='char'   --  { 'char' | 'native' | 'widechar' | 'widenative' } ]
	 ,fieldterminator='|'
	 ,rowterminator='\n'
	 ,maxerrors = 0
	 ,fire_triggers
	 ,firstrow = 3
	 ,lastrow = 11
     );

--VERIFICANDO DADOS IMPORTADOS 
  SELECT nome	FROM produto
--DELETANDO ARQUIVOS 
  DELETE FROM	produto












