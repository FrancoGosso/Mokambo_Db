﻿-- =============================================
-- Author     :	DELPIANO	
-- Create date: 09-02-2014
-- Description:	ELENCO DELLE CATEGORIE CON GIACENZA
-- Parametri  : @ID_LINGUA --> codice lingua richiesta : per zero utilizza quella di default
-- Restituisce: Elenco categorie con giacenza 
-- =============================================
CREATE PROCEDURE [dbo].[PRC_GET_CATEGORIA_CON_GIACENZA]
@CODICE_NEGOZIO		VARCHAR(10),
@ID_LINGUA			INT =0
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
	DISTINCT A.ID_CATEGORIA, C.DESCRIZIONE_CATEGORIA, C.IMMAGINE, C.ORDINE
	INTO #RISULTATO
	FROM 
	GIACENZA G WITH (NOLOCK)  JOIN
	ARTICOLO A WITH (NOLOCK) ON G.ID_ARTICOLO = A.ID_ARTICOLO JOIN
	CATEGORIA C WITH (NOLOCK) ON A.ID_CATEGORIA = C.ID_CATEGORIA 
	WHERE
	G.CODICE_NEGOZIO = @CODICE_NEGOZIO AND
	A.STATUS		=	'V'	AND
	G.GIACENZA		>	0	AND
	C.VISUALIZZA	=	'S'

	IF @ID_LINGUA <> 0
	BEGIN

			UPDATE #RISULTATO 
					SET #RISULTATO.DESCRIZIONE_CATEGORIA = CATEGORIA_LINGUA.DESCRIZIONE_CATEGORIA
			FROM
					#RISULTATO  JOIN CATEGORIA_LINGUA  
					ON #RISULTATO.ID_CATEGORIA = CATEGORIA_LINGUA.ID_CATEGORIA AND ID_LINGUA = @ID_LINGUA				
	END


	SELECT * FROM #RISULTATO
	ORDER BY ORDINE, DESCRIZIONE_CATEGORIA
END