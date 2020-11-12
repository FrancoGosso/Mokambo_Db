


-- ============================================================================
-- Author:		FRANCESCO TATARANNI
-- Create date: 01-09-2020
-- Description:	SELEZIONE DI UN MENU SPECIFICO O DI TUTTI I MENU NON CANCELLATI
-- ============================================================================
CREATE PROCEDURE [dbo].[PRC_GET_MENU]
@ID_MENU INT = 0
AS
BEGIN
	SET NOCOUNT ON
	SELECT * FROM MENU WHERE STATUS = 'V' AND ID_MENU = CASE WHEN @ID_MENU = 0 THEN ID_MENU ELSE @ID_MENU END
END