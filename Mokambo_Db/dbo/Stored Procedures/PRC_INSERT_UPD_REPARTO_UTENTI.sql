﻿

create PROCEDURE [dbo].[PRC_INSERT_UPD_REPARTO_UTENTI]
@IDREPARTO			INT				= 0,
@CODICE_UTENTE		VARCHAR(30)		= '',
@DESCRIZIONE		VARCHAR(250)	= '',
@COLORE 			VARCHAR(25)		= '',
@STATUS				VARCHAR(10)		= 'V',
@RISULTATO			CHAR(2)			= '' OUTPUT,
@DESRISULTATO		VARCHAR(1000)	= '' OUTPUT
AS
BEGIN

	SET NOCOUNT ON;

BEGIN TRY
	
	BEGIN TRANSACTION

		MERGE REPARTO_UTENTI AS TARGET
		USING (SELECT @IDREPARTO, @CODICE_UTENTE, @DESCRIZIONE, @COLORE, @STATUS)
			  AS SOURCE (IDREPARTO, CODICE_UTENTE, DESCRIZIONE, COLORE, STATUS)
		ON SOURCE.IDREPARTO = TARGET.IDREPARTO AND SOURCE.CODICE_UTENTE = TARGET.CODICE_UTENTE
		WHEN MATCHED THEN UPDATE SET DESCRIZIONE = SOURCE.DESCRIZIONE, 
									 COLORE = SOURCE.COLORE,
									 STATUS = SOURCE.STATUS
		WHEN NOT MATCHED THEN INSERT (IDREPARTO, CODICE_UTENTE, DESCRIZIONE, COLORE, STATUS)
							  VALUES (SOURCE.IDREPARTO, SOURCE.CODICE_UTENTE, SOURCE.DESCRIZIONE, SOURCE.COLORE, SOURCE.STATUS);

		SET @RISULTATO		= 'OK' 
		SET @DESRISULTATO	= 'INSERIMENTO/AGGIORNAMENTO EFFETTUATO'

END TRY
BEGIN CATCH
    SET @RISULTATO = 'KO'
	SET @DESRISULTATO = ERROR_MESSAGE()
END CATCH
		
IF @RISULTATO = 'OK' 
	COMMIT TRANSACTION
ELSE
	ROLLBACK TRANSACTION
END