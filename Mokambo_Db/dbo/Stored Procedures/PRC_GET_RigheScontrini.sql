CREATE PROCEDURE [dbo].[PRC_GET_RigheScontrini]
 @CODICE_NEGOZIO	VARCHAR(10),
 @DATA		VARCHAR(6) = ''
 	
AS

SELECT DATA, 
		SUBSTRING(DATA, 7,2) + '/' + SUBSTRING(DATA, 5,2) + '/' + SUBSTRING(DATA, 1,4) +  ' - (' 
		+ CONVERT(VARCHAR(50),COUNT(SCONTRINO))+ ' SCONTRINI)' AS SCONTRINO_CHAR,  
		SUM(TOTALE) AS TOTALE
FROM DBO.SCONTRINATO_TESTATA 
WHERE SUBSTRING(DATA,1,6)= CASE @DATA WHEN '' THEN @DATA ELSE @DATA END
AND CODICE_NEGOZIO = @CODICE_NEGOZIO
GROUP BY DATA
    
/*
select *, ordine+substring(data, 1,6) as flag from (
    select '0' as ordine, data, 
    	substring(data, 7,2) + '/' + substring(data, 5,2) + '/' + substring(data, 1,4) +  ' - (' 
    	+ convert(varchar(50),COUNT(scontrino))+ ' scontrini)' as scontrino_char, 0 AS SCONTRINO , 
    	sum(totale) as totale, ' ' as TIPO_PAGAMENTO
     from dbo.SCONTRINATO_TESTATA 
     where substring(data,1,6)= CASE @DATA WHEN '' THEN @DATA ELSE @DATA END
    group by data
 union all
    select '1' as ordine, t.data, convert(varchar(50),t.scontrino) as scontrino_char, T.SCONTRINO , t.totale, p.TIPO_PAGAMENTO 
     from dbo.SCONTRINATO_TESTATA as t
     left join dbo.SCONTRINATO_PAGAMENTO as p
    	on (t.CODICE_NEGOZIO = p.CODICE_NEGOZIO and t.DATA = p.DATA 
    		and t.ORA = p.ORA and t.CASSA = p.CASSA and t.SCONTRINO = p.SCONTRINO )
             where substring(t.data,1,6)= CASE @DATA WHEN '' THEN @DATA ELSE @DATA END
 ) as xx
 order by data,ordine,scontrino
 */