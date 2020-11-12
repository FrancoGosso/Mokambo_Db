﻿CREATE PROCEDURE [dbo].[PRC_GET_ScontrinatoByPar]
	@CODICE_NEGOZIO VARCHAR(10),
 @DATEFROM INT,
 @DATETO INT,
 @PRODOTTO VARCHAR(13) = NULL,
 @REPARTO_VENDITA VARCHAR(10)= NULL,
 @CANALE_VENDITA VARCHAR(10)= NULL
AS
	SELECT st.DATA ,st.CASSA, st.ORA, st.CODICE_NEGOZIO, st.scontrino, ST.ID_PROVENIENZA, ST.ID_BASKET, ST.STAMPATO, ST.PAGATO, ST.TOTALE, ST.INVIATO, ST.CODICE_UTENTE
	from SCONTRINATO_TESTATA st
	--left join SCONTRINATO_RIGA sr on sr.DATA = st.DATA and sr.CASSA = st.CASSA and sr.ORA = st.ORA and sr.CODICE_NEGOZIO = st.CODICE_NEGOZIO and sr.scontrino = st.scontrino
	inner join ( 
	select distinct sr.DATA,sr.CASSA,sr.ORA,sr.CODICE_NEGOZIO , sr.scontrino 
	from SCONTRINATO_RIGA sr 
	where EAN = isnull(@PRODOTTO ,EAN)
		AND REPARTO_VENDITA = isnull(@REPARTO_VENDITA , REPARTO_VENDITA)
		AND LOTTO_VENDITA = isnull(@CANALE_VENDITA , LOTTO_VENDITA)
		AND sr.DATA >= @DATEFROM and sr.DATA <= @DATETO
		GROUP BY sr.DATA ,sr.CASSA, sr.ORA, sr.CODICE_NEGOZIO, sr.scontrino
	)a on a.DATA = st.DATA and a.CASSA = st.CASSA and a.ORA = st.ORA and a.CODICE_NEGOZIO = st.CODICE_NEGOZIO and a.scontrino = st.scontrino
	WHERE st.DATA >= @DATEFROM and st.DATA <= @DATETO
		AND st.CODICE_NEGOZIO = @CODICE_NEGOZIO
	GROUP BY st.DATA ,st.CASSA, st.ORA, st.CODICE_NEGOZIO, st.scontrino, ST.ID_PROVENIENZA, ST.ID_BASKET, ST.STAMPATO, ST.PAGATO, ST.TOTALE, ST.INVIATO, ST.CODICE_UTENTE
	ORDER BY st.DATA
RETURN 0