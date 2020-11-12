﻿CREATE PROCEDURE [dbo].[PRC_SET_COMANDA_EVASA]
@ID_COMANDA			  INT,
@BOX				  INT,
@RISULTATO			  CHAR(2) = '' OUTPUT,
@DESRISULTATO		  VARCHAR(1000)	= '' OUTPUT
AS
SET NOCOUNT ON
BEGIN TRY
	BEGIN TRANSACTION

	UPDATE COMANDA_RIGA SET QTA_EVASA = QTA WHERE ID_COMANDA = @ID_COMANDA AND BOX = @BOX

	DECLARE
	@qta				  INT=0,
	@qta_Evasa			  INT=0

	select @qta = sum(qta), @qta_Evasa= sum(qta_evasa) from [dbo].[COMANDA_RIGA] 
		where ID_COMANDA = @ID_COMANDA

	if (@qta_evasa = 0) OR (@qta_evasa <> @qta) 
		update [dbo].[COMANDA_TESTATA] set [EVASA] = 0 WHERE ID_COMANDA = @ID_COMANDA
	else
		update [dbo].[COMANDA_TESTATA] set [EVASA] = 1, DATA_FINE_EVASIONE = GETDATE() WHERE ID_COMANDA = @ID_COMANDA

	SET @RISULTATO = 'OK'
	SET @DESRISULTATO = 'INSERIMENTO EFFETTUATO CORRETTAMENTE'
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	SET @RISULTATO = 'KO'
	SET @DESRISULTATO = ERROR_MESSAGE()
END CATCH