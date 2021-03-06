﻿


-- ======================================================================
-- Author:		FRANCESCO TATARANNI
-- Create date: 01-09-2020
-- Description:	CANCELLAZIONE DI UN ARTICOLO DA UN MENU
-- ======================================================================
CREATE PROCEDURE [dbo].[PRC_DELETE_MENU_ARTICOLO]
@ID_MENU INT,
@ID_ARTICOLO INT = 0,
@RISULTATO VARCHAR(1000) OUTPUT
AS
BEGIN
SET NOCOUNT ON
BEGIN TRY
	DELETE FROM MENU_ARTICOLO WHERE ID_MENU = @ID_MENU
							  AND ID_ARTICOLO = CASE WHEN @ID_ARTICOLO = 0 THEN ID_ARTICOLO ELSE @ID_ARTICOLO END
	SET @RISULTATO = 'OK CANCELLAZIONE EFFETTUATA'
END TRY
BEGIN CATCH
	SET @RISULTATO = 'KO ' + ERROR_MESSAGE()
END CATCH
END