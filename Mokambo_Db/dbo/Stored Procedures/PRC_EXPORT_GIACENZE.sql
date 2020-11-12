-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PRC_EXPORT_GIACENZE]
	-- Add the parameters for the stored procedure here
	@COD_NEGOZIO varchar(10)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

	SELECT CODICE_NEGOZIO,isnull(ARTICOLO.ID_ARTICOLO,0) as ID_ARTICOLO, isnull(CODICE_ARTICOLO,'') AS CODICE_ARTICOLO,
	EAN,isnull(nome,'') AS NOME,isnull(NOME_BREVE,'') AS NOME_BREVE,
	isnull(DESCRIZIONE,'') AS DESCRIZIONE,isnull(ID_CATEGORIA,0) AS ID_CATEGORIA,
	isnull(DEFAULT_IMAGE,'') AS DEFAULT_IMAGE,isnull(QTA_MINIMA,0) AS QTA_MINIMA,
	isnull(CODICE_IVA,'') AS CODICE_IVA,isnull(PREZZO_BASE,0) AS PREZZO_BASE,isnull(REPARTO,0) AS REPARTO,
	isnull(Articolo.STATUS,'') AS STATUS,isnull(GIACENZA,0) AS GIACENZA,isnull(RIORDINO,0) AS RIORDINO 
	FROM GIACENZA  LEFT JOIN ARTICOLO on GIACENZA.ID_ARTICOLO = ARTICOLO.ID_ARTICOLO  WHERE CODICE_NEGOZIO = @COD_NEGOZIO

END