

-- =============================================
-- Author:		FRANCESCO TATARANNI
-- Create date: 14/07/2020
-- Description:	RESTITUISCE I DATI DELL'ARTICOLO PER EAN
-- =============================================
CREATE PROCEDURE [dbo].[PRC_GET_ARTICOLO_BY_EAN]
@EAN VARCHAR(13)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM VW_GIACENZA WHERE EAN = @EAN
END