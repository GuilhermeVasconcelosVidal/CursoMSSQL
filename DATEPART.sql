

--FUNÇÃO DATA E HORA PARTS

--RETORNA O DIA/MES/ANO

  SELECT GETDATE() data_hora,
         DATENAME (DAY, GETDATE())  day_n,
		 DATENAME (MONTH, GETDATE())month_n,
		 DATENAME (YEAR, GETDATE()) year_n

--RETORNA O DIA/MES/ANO

	  SELECT DATEPART (DAY, GETDATE())  day_p,
			 DATEPART (MONTH, GETDATE())month_p,
			 DATEPART (YEAR, GETDATE()) year_p


--RETORNA O DIA/MES/ANO

  SELECT DAY(GETDATE())  day_,
         MONTH(GETDATE())MONTH_,
		 YEAR(GETDATE()) YEAR_


--RETONAR DATA HORA COM 7 ARGUMENTOS
--ANO MES DIA HORA MINUTOS SEGUNDOS MILESEGUNDOS

  SELECT DATETIMEFROMPARTS (2017,11,30,3,45,59,1) HORA


--

USE crm;

--EXEMPLO 1

  SELECT a.primeiro_nome,
         a.sexo,
		 a.nascimento,
		 MONTH(a.nascimento) month_l,
		 YEAR(a.nascimento)  year_l,
		 DAY(a.nascimento)   day_l
		 --,a.*
  FROM cliente a

--exemplo 2

  SELECT MONTH(a.nascimento) mes,
         YEAR(a.nascimento)  ano,
		 COUNT(*) qtd
  FROM cliente a
  GROUP BY MONTH(a.nascimento),YEAR(a.nascimento)
  ORDER BY YEAR(a.nascimento) ASC, MONTH(a.nascimento) ASC

--OUTRO EXEMPLO 
 
  SELECT CONCAT(REPLICATE('0', 2 - LEN(MONTH(nascimento))),MONTH(nascimento),'-',DATENAME(MONTH,a.nascimento)) mes,
       YEAR(a.nascimento)ano,
	   COUNT(*) qtd
  FROM cliente a
  GROUP BY CONCAT(REPLICATE('0', 2 - LEN(MONTH(nascimento))),MONTH(nascimento),'-',DATENAME(MONTH,a.nascimento)),
           YEAR(a.nascimento)
  ORDER BY YEAR(a.nascimento) ASC, 1 ASC

--EXEMPLO 3

  SELECT
        YEAR(a.nascimento)ano,
		count(*) qtd
  FROM cliente a
  GROUP BY YEAR(a.nascimento)
  ORDER BY YEAR(a.nascimento) ASC;









