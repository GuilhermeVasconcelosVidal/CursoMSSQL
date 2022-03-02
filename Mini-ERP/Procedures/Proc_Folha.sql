--SELECT * FROM FOLHA_PAGTO
--PROCEDURE FOLHA PAGTO
--GERA INFORMA��ES PARA PAGAMENTO
--TABELAS ORIGEM SALARIO
--TABEAL DE FUNCIONARIO VERIFICA��O DE ADMISS�O E DEMISS�O
--TAB PARAMETROS, PARAM_INSS, PARAM_IRRF
--TABELAS DESTINO FOLHA_PAGTO
--PARAMETROS, MES_REF, ANO_REF,DATA_PAGTO
--EXEC PROC_FOLHA 3,2017,'2017-03-05'
--SELECT * FROM FOLHA_PAGTO
--DROP PROCEDURE PROC_FOLHA

USE MINIERP_MULT
GO
 
  CREATE PROCEDURE PROC_FOLHA (@COD_EMPRESA  INT,
                               @MES_REF      INT,
							   @ANO_REF      INT,
							   @DATA_PAGTO   DATE)
  AS 
  BEGIN
  DECLARE @MATRICULA INT,
          @SALARIO_BRUTO DECIMAL(10,2),
		  @SALARIO_LIQ DECIMAL(10,2),
		  @PCT_INSS DECIMAL(10,2),
		  @VAL_INSS DECIMAL(10,2),
		  @PCT_IRPF DECIMAL(10,2),
		  @VAL_IRPF DECIMAL(10,2),
		  @VAL_ISENT_IRPF DECIMAL(10,2)
		    --@MES_REF INT,
			--@ANO_REF INT,
			--@DATA_PAGTO DATE

--SET @MES_REF=3
--SET @ANO_REF=2017
--SET @DATA_PAGTO='2017-04-05'

  BEGIN TRANSACTION
  BEGIN TRY
  --APAGANDO REGISTRO PARA RECALCULAR
    SELECT 'APAGANDO REGISTROS PARA RECALCULO'
    DELETE FROM FOLHA_PAGTO 
	       WHERE COD_EMPRESA=@COD_EMPRESA
		   AND MES_REF=@MES_REF
		   AND ANO_REF=@ANO_REF
  --DECLARANDO CURSOR PARA LER SALARIO BRUTO
    DECLARE SAL_BRUTO CURSOR FOR
	--SELECIONANDO VALORES
	  SELECT A.MATRICULA MATRICULA, A.SALARIO SAL_BRUTO
	  FROM SALARIO A
	  INNER JOIN FUNCIONARIO B
	  ON A.COD_EMPRESA=B.COD_EMPRESA
	  AND A.MATRICULA=B.MATRICULA
	  WHERE A.COD_EMPRESA=@COD_EMPRESA
	  AND B.DATA_DEMISS='1990-01-01'
	  AND MONTH (B.DATA_ADMISS)<=@MES_REF
	  AND YEAR  (B.DATA_ADMISS)<=@ANO_REF
    
	--ABRINDO CURSOR
	  OPEN SAL_BRUTO
	--LENDO REGISTRO
	  FETCH NEXT FROM SAL_BRUTO
	--INSERINDO VALOR NAS VARIAVEIS
	  INTO @MATRICULA,@SALARIO_BRUTO
	    WHILE @@FETCH_STATUS = 0
		BEGIN
		--APRESENTANDO REGISTROS
		  SELECT @MATRICULA MATRICULA ,@SALARIO_BRUTO SALARIO_BRUTO
        --INSERINDO SALARIO BRUTO NA TAB FOLHA_PAGTO
		  INSERT INTO FOLHA_PAGTO VALUES
		  (@COD_EMPRESA,@MATRICULA,'F','P','SAL BRUTO',@MES_REF,@ANO_REF,@DATA_PAGTO,@SALARIO_BRUTO);
  --DECLARANDO CURSOR PARA CALCULAR INSS
    DECLARE CALC_INSS CURSOR FOR
  --LENDO REGISTROS
  
    --SELECT * FROM PARAM_INSS
	SELECT A.PCT FROM PARAM_INSS A
	             WHERE @SALARIO_BRUTO BETWEEN A.VALOR_DE 
				 AND A.VALOR_ATE
				 AND @MES_REF BETWEEN MONTH(A.VIGENCIA_INI) AND MONTH(A.VIGENCIA_FIM)
				 AND @ANO_REF BETWEEN YEAR (A.VIGENCIA_INI) AND YEAR(A.VIGENCIA_FIM)
    
	--ABRINDO CURSOR
	  OPEN CALC_INSS
	--LENDO PROXIMO REGISTRO NO CURSOR
	  FETCH NEXT FROM CALC_INSS
	--INSERINDO VALOR NA VARIAVEL
	  INTO @PCT_INSS
	  WHILE @@FETCH_STATUS = 0

	    BEGIN
		--REGRA DE TETO DE INSS QUANDO SALARIO MAIOR QUE 5531.31

		IF @SALARIO_BRUTO > 5531.31
		    BEGIN
			      SET @VAL_INSS=608.44
				  SET @PCT_INSS=0
            END 
			ELSE 
			BEGIN
			  SET @VAL_INSS=@SALARIO_BRUTO/100*@PCT_INSS
			END
		--APRESENTANDO VALORES
		  SELECT 'CALC INSS', @PCT_INSS PCT_INSS, @VAL_INSS VAL_INSS
		--INSERINDO REGISTRO NA FOLHA DE PAGTO
		  INSERT INTO FOLHA_PAGTO VALUES
		  (@COD_EMPRESA,@MATRICULA,'F','D','INSS',@MES_REF,@ANO_REF,@DATA_PAGTO,@VAL_INSS);
    
  --DECLARANDO CURSOR PARA CALC IRRF
	DECLARE CALC_IRRF CURSOR FOR
  --SELECIONANDO VALORES 
  --SELECT * FROM PARAM_IRRF
	SELECT A.PCT,A.VAL_ISENT FROM PARAM_IRRF A
	WHERE @SALARIO_BRUTO BETWEEN A.VALOR_DE AND A.VALOR_ATE
    AND @MES_REF BETWEEN MONTH (A.VIGENCIA_INI) AND MONTH (A.VIGENCIA_FIM)
    AND @ANO_REF BETWEEN YEAR  (A.VIGENCIA_INI) AND YEAR  (A.VIGENCIA_FIM)


	--ABRINDO CURSOR 
	  OPEN CALC_IRRF
	--LENDO PROXIMO REGISTRO
	  FETCH NEXT FROM CALC_IRRF
	--INSERINDO VALOR NA VARIAVEL
	  INTO @PCT_IRPF, @VAL_ISENT_IRPF

	    WHILE @@FETCH_STATUS = 0