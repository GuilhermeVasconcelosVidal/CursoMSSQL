USE curso;
--DROP FUNCTION FUNC_VENDA _PROD 
--FUNÇÃO INLINE 
-- DROP FUNCION FN_ESTADO_POP
--CRIANDO FUNCTION - TABLE VALUE 

CREATE FUNCTION FN_ESTADO_POP (@regiao VARCHAR(20))
RETURNS TABLE 
AS 
RETURN
(SELECT a.uf,b.estado,b.regiao, SUM(a.populacao) AS TOTAL 
        FROM senso a
		INNER JOIN REGIAO b	
		ON a.cod_uf=b.cod_uf
		WHERE b.regiao=@regiao 
		GROUP BY a.uf, b.estado,b.regiao);

--INVOCANDO FUNÇÃO  

SELECT * FROM  dbo.FN_ESTADO_POP ('SUL');