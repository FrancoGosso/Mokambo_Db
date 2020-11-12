﻿

-- ======================================================================
-- Author:		FRANCESCO TATARANNI
-- Create date: 01-09-2020
-- Description:	CREAZIONE O AGGIORNAMENTO DI UN MENU
-- ======================================================================
CREATE PROCEDURE [dbo].[PRC_INSERT_UPD_MENU]
@ID_MENU INT,
@NOME VARCHAR(200),
@DESCRIZIONE VARCHAR(200),
@VISUALIZZATO BIT,
@STATUS CHAR(1),
@IMMAGINE VARCHAR(200),
@ORA_DA INT,
@ORA_A INT,
@PREZZO DECIMAL(10,2),
@TIPOLOGIA CHAR(1),
@ARTICOLI VARCHAR(1000),
@QTA_INVITATI INT,
@ID_MENU_OUT INT OUTPUT,
@RISULTATO CHAR(2) = '' OUTPUT,
@DESRISULTATO VARCHAR(1000) = '' OUTPUT
AS
BEGIN
SET NOCOUNT ON
BEGIN TRY
	BEGIN TRANSACTION

	DECLARE @MENU TABLE(ID_MENU INT)

	MERGE MENU AS TARGET
	USING (SELECT @ID_MENU, @NOME, @DESCRIZIONE, @VISUALIZZATO, @STATUS, @IMMAGINE, @ORA_DA, @ORA_A, @PREZZO, @TIPOLOGIA, @QTA_INVITATI)
	      AS SOURCE (ID_MENU, NOME, DESCRIZIONE, VISUALIZZATO, STATUS, IMMAGINE, ORA_DA, ORA_A, PREZZO, TIPOLOGIA, QTA_INVITATI)
	ON SOURCE.ID_MENU = TARGET.ID_MENU AND TARGET.STATUS = 'V'
	WHEN MATCHED THEN UPDATE SET NOME = SOURCE.NOME,
								 DESCRIZIONE = SOURCE.DESCRIZIONE,
								 VISUALIZZATO = SOURCE.VISUALIZZATO,
								 STATUS = SOURCE.STATUS,
								 IMMAGINE = SOURCE.IMMAGINE,
								 ORA_DA = SOURCE.ORA_DA,
								 ORA_A = SOURCE.ORA_A,
								 PREZZO = SOURCE.PREZZO,
								 TIPOLOGIA = SOURCE.TIPOLOGIA,
								 QTA_INVITATI = SOURCE.QTA_INVITATI
	WHEN NOT MATCHED THEN INSERT (NOME, DESCRIZIONE, DT_INSERIMENTO, VISUALIZZATO, STATUS, IMMAGINE, ORA_DA, ORA_A, PREZZO, TIPOLOGIA, QTA_INVITATI)
						  VALUES (SOURCE.NOME, SOURCE.DESCRIZIONE, GETDATE(), VISUALIZZATO, 'V', SOURCE.IMMAGINE, SOURCE.ORA_DA, SOURCE.ORA_A, SOURCE.PREZZO, SOURCE.TIPOLOGIA, SOURCE.QTA_INVITATI)
	OUTPUT inserted.ID_MENU INTO @MENU;
	
	SELECT @ID_MENU = ID_MENU FROM @MENU
	DELETE FROM MENU_ARTICOLO WHERE ID_MENU = @ID_MENU
	
	DECLARE @IDX INT = 1
	DECLARE @ID_ARTICOLO INT
	WHILE @IDX <> 0
	BEGIN
		SET @IDX = CHARINDEX(',', @ARTICOLI)
		IF @IDX <> 0 SET @ID_ARTICOLO = LEFT(@ARTICOLI, @IDX - 1)
		ELSE SET @ID_ARTICOLO = @ARTICOLI
		IF LEN(@ID_ARTICOLO) <> 0
			INSERT INTO MENU_ARTICOLO(ID_MENU, ID_ARTICOLO) VALUES (@ID_MENU, @ID_ARTICOLO)
		SET @ARTICOLI = RIGHT(@ARTICOLI, LEN(@ARTICOLI) - @IDX)
	END

	SET @ID_MENU_OUT = @ID_MENU
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