-- =============================================
-- Author:		DELPIANO
-- Create date: 02-01-2017
-- Description:	RICERCA DATI DA INVIARE
-- =============================================
CREATE PROCEDURE [dbo].[PRC_AGGIORNAMENTO_DA_INVIARE_RICERCA]
@PROG	INT	= 0
AS
BEGIN

	SET NOCOUNT ON;

	SELECT * FROM AGGIORNAMENTO_DA_INVIARE 
	WHERE 
	PROG = CASE @PROG WHEN 0 THEN PROG ELSE @PROG END
	ORDER BY PROG
END