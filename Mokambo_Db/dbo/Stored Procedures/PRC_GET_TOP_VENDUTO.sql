-- =============================================
-- Author:		<Author,,Taverna Andrea>
-- Create date: <Create Date,,11/03/2016>
-- Description:	<Description,,Statistica sui TOP 10 articoli venduti nel periodo specificato>
-- =============================================
CREATE PROCEDURE [dbo].[PRC_GET_TOP_VENDUTO]
	-- Add the parameters for the stored procedure here
 @NUMARTICOLI INT = 10,
 @CODICE_NEGOZIO VARCHAR(10),
 @DATEFROM INT,
 @DATETO INT,
 @REPARTO_VENDITA VARCHAR(10),
 @CANALE_VENDITA VARCHAR(10)
 AS

if @REPARTO_VENDITA = ''
	set @REPARTO_VENDITA = null
if @CANALE_VENDITA = ''
	set @CANALE_VENDITA = null
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (@NUMARTICOLI) CODICE_ARTICOLO, NOME_BREVE  as RAGGR, SUM(QTA) as QTA, CODICE_UM, SUM(PREZZO) as IMPORTO, COUNT(*) as NUMERO_SCONTRINI
	FROM dbo.SCONTRINATO_RIGA as SR
	JOIN ARTICOLO ON EAN = ID_ARTICOLO 
	WHERE DATA >= @DATEFROM AND DATA <= @DATETO
		AND CODICE_NEGOZIO = @CODICE_NEGOZIO
		AND SR.REPARTO_VENDITA = isnull(@REPARTO_VENDITA , SR.REPARTO_VENDITA)
		AND SR.LOTTO_VENDITA = isnull(@CANALE_VENDITA , SR.LOTTO_VENDITA)
	GROUP BY CODICE_ARTICOLO, NOME, NOME_BREVE, CODICE_UM
	ORDER BY IMPORTO DESC
END