﻿CREATE PROCEDURE PRC_UPDATE_BASKET_BOX
@ID_BASKET			  INT,
@ID_MENU			  INT,
@ID_ARTICOLO		  INT,
@BOX				  INT,
@RISULTATO			  CHAR(2) = '' OUTPUT,
@DESRISULTATO		  VARCHAR(1000)	= '' OUTPUT
AS
SET NOCOUNT ON
BEGIN TRY
	UPDATE BASKET_RIGA SET BOX = @BOX WHERE ID_BASKET = @ID_BASKET AND ID_MENU = @ID_MENU AND ID_ARTICOLO = @ID_ARTICOLO
	SET @RISULTATO = 'OK'
	SET @DESRISULTATO = 'AGGIORNAMENTO EFFETTUATO CORRETTAMENTE'
END TRY
BEGIN CATCH
	SET @RISULTATO = 'KO'
	SET @DESRISULTATO = ERROR_MESSAGE()
END CATCH