﻿


-- ======================================================================
-- Author:		FRANCESCO TATARANNI
-- Create date: 01-09-2020
-- Description:	INSERIMENTO DI UN ARTICOLO IN UN MENU
-- ======================================================================
CREATE PROCEDURE [dbo].[PRC_INSERT_MENU_ARTICOLO]
@ID_MENU INT,
@ID_ARTICOLO INT,
@RISULTATO VARCHAR(1000) OUTPUT
AS
BEGIN
SET NOCOUNT ON
BEGIN TRY
	BEGIN TRANSACTION
	IF NOT EXISTS (SELECT * FROM MENU_ARTICOLO WHERE ID_MENU = @ID_MENU AND ID_ARTICOLO = @ID_ARTICOLO)
	BEGIN
		IF EXISTS (SELECT * FROM MENU WHERE ID_MENU = @ID_MENU AND STATUS = 'V') AND EXISTS (SELECT * FROM ARTICOLO WHERE ID_ARTICOLO = @ID_ARTICOLO)
		BEGIN
			INSERT INTO MENU_ARTICOLO(ID_MENU, ID_ARTICOLO) VALUES (@ID_MENU, @ID_ARTICOLO)
			SET @RISULTATO = 'OK INSERIMENTO EFFETTUATO'
		END
		ELSE
		BEGIN
			SET @RISULTATO = 'KO MENU O ARTICOLO NON ESISTENTE'
		END
	END
	ELSE
	BEGIN
		SET @RISULTATO = 'KO ARTICOLO GIA'' PRESENTE NEL MENU'
	END
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
	SET @RISULTATO = 'KO ' + ERROR_MESSAGE()
END CATCH
END