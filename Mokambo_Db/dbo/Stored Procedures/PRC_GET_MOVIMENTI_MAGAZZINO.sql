CREATE PROCEDURE [dbo].[PRC_GET_MOVIMENTI_MAGAZZINO]
 @CODICE_NEGOZIO	VARCHAR(10),
 @DATEFROM		    VARCHAR(8) = '',
 @DATETO		    VARCHAR(8) = ''
 	
AS

SELECT A.CODICE_ARTICOLO,S.QTA,A.CODICE_UM,S.PREZZO as IMPORTO,A.TIPO_ARTICOLO,S.REPARTO_VENDITA,S.LOTTO_VENDITA, ISNULL(CAST( SC.ID_SOTTOCANALE AS varchar),'0') AS SOTTOCANALE_VENDITA,
		SUBSTRING(S.DATA, 7,2) + '/' + SUBSTRING(S.DATA, 5,2) + '/' + SUBSTRING(S.DATA, 1,4)  AS DATA,  SUBSTRING(S.ORA, 1,2) + ':' + SUBSTRING(S.ORA, 3,2) AS ORA		
FROM DBO.SCONTRINATO_RIGA AS S 
INNER JOIN DBO.GIACENZA G ON G.EAN = S.EAN
INNER JOIN DBO.ARTICOLO A ON A.ID_ARTICOLO = G.ID_ARTICOLO
LEFT JOIN DBO.SOTTOCANALE SC ON SC.COD_CANALE_VENDITA = S.LOTTO_VENDITA AND S.ORA > SC.ORA_DA AND S.ORA< SC.ORA_A 
WHERE S.DATA >= @DATEFROM AND S.DATA <= @DATETO AND S.CODICE_NEGOZIO = @CODICE_NEGOZIO 
ORDER BY S.DATA, s.REPARTO_VENDITA, A.CODICE_ARTICOLO,S.QTA DESC
    
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