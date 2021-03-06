﻿CREATE PROCEDURE [dbo].[PRC_SET_BASKET_PAGATO]
@ID_BASKET INT,
@RISULTATO CHAR(2) = '' OUTPUT,
@DESRISULTATO VARCHAR(1000) = '' OUTPUT
AS
SET NOCOUNT ON
BEGIN TRY
	UPDATE BASKET_TESTATA SET PAGATO = 1 WHERE ID_BASKET = @ID_BASKET
	SET @RISULTATO = 'OK'
	SET @DESRISULTATO = 'AGGIORNAMENTO EFFETTUATO CORRETTAMENTE'
END TRY
BEGIN CATCH
	SET @RISULTATO = 'KO'
	SET @DESRISULTATO = ERROR_MESSAGE()
END CATCH