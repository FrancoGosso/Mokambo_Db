-- =============================================
-- Author:		DELPIANO STEFANO 
-- Create date: 06-05-2015
-- Description:	RICERCA SCONTRINI DA INVIARE
-- =============================================
create PROCEDURE [dbo].[PRG_GET_SCONTRINO_DA_INVIARE]
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
			CODICE_NEGOZIO,
			DATA,
			ORA,
			CASSA,
			SCONTRINO,
			MAX(PROG) AS ULTIMO
	FROM SCONTRINATO_DA_INVIARE WITH (NOLOCK)
	GROUP BY
			CODICE_NEGOZIO,
			DATA,
			ORA,
			CASSA,
			SCONTRINO	
	ORDER BY
			CODICE_NEGOZIO,
			DATA,
			ORA,
			CASSA,
			SCONTRINO	
	
END