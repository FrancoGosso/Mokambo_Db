﻿CREATE PROCEDURE [dbo].[PRC_INSERT_UPD_ALLERGENE]
@ID_ALLERGENE INT = 0,
@DESCRIZIONE VARCHAR(200) = '',
@RISULTATO CHAR(2) = '' OUTPUT,
@DESRISULTATO VARCHAR(1000) = '' OUTPUT
AS
BEGIN
SET NOCOUNT ON
BEGIN TRY
	BEGIN TRANSACTION

	MERGE ALLERGENE AS TARGET
	USING (SELECT @ID_ALLERGENE, @DESCRIZIONE) AS SOURCE (ID_ALLERGENE, DESCRIZIONE)
	ON SOURCE.ID_ALLERGENE = TARGET.ID_ALLERGENE
	WHEN MATCHED THEN UPDATE SET DESCRIZIONE = @DESCRIZIONE
	WHEN NOT MATCHED THEN INSERT (DESCRIZIONE) VALUES (@DESCRIZIONE);

	SET @RISULTATO = 'OK'
	SET @DESRISULTATO = 'INSERIMENTO/AGGIORNAMENTO EFFETTUATO'
	
	COMMIT TRANSACTION

END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
	SET @RISULTATO = 'KO'
	SET @DESRISULTATO = ERROR_MESSAGE()
END CATCH
END