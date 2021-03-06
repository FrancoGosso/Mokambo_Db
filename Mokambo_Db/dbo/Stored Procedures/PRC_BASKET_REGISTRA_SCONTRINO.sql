﻿
-- =============================================
-- Author:		DELPIANO STEFANO
-- Create date: 06-03-2014
-- Description: registrazione nr scontrino
-- =============================================
CREATE PROCEDURE [dbo].[PRC_BASKET_REGISTRA_SCONTRINO]
@ID_BASKET			int,
@CASSA				int,
@NUMFIS				int,
@RISULTATO			CHAR(2)			= '' OUTPUT,
@DESRISULTATO		VARCHAR(1000)	= '' OUTPUT
AS
BEGIN

	SET NOCOUNT ON;
	

	BEGIN TRY
	
	BEGIN TRANSACTION 
	
	UPDATE	BASKET_TESTATA 
	SET		CASSA = @CASSA,
			SCONTRINO = @NUMFIS,
			STAMPATO = CASE @NUMFIS WHEN 0 THEN 'N' ELSE 'S' END
	WHERE
			ID_BASKET = @ID_BASKET
		
    SET @RISULTATO = 'OK'
    SET @DESRISULTATO = 'OK'
END TRY
BEGIN CATCH

    PRINT 'VADO IN ERRORE'
    SET @RISULTATO = 'KO'
    SET @DESRISULTATO = ERROR_MESSAGE()
END CATCH	

	FINE:
	PRINT @RISULTATO
	PRINT @DESRISULTATO
	
	IF SUBSTRING(@RISULTATO, 1 , 2) = 'OK' 
		COMMIT TRANSACTION
	ELSE
		ROLLBACK TRANSACTION
		




END