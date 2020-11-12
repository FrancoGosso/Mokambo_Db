﻿

-- =============================================
-- Author:		DELPIANO STEFANO
-- Create date: 18-06-2020
-- Description: UPDATE DI UN BARCODE NEL BASKET TEMPORANEO
--				PER QTA = 0 VIENE CANCELLATO EAN DAL BASKET
-- =============================================
CREATE PROCEDURE [dbo].[PRC_TMPBASKET_ADD]
@NEGOZIO			VARCHAR(10),
@BASKET				VARCHAR(250),
@EAN				VARCHAR(13),
@QTA				INT = 1,				
@RISULTATO			CHAR(2)			= '' OUTPUT,
@DESRISULTATO		VARCHAR(1000)	= '' OUTPUT
AS
BEGIN

	DECLARE @PROG	INT


	SET NOCOUNT ON;
	
	SET	@RISULTATO = 'KO'
	SET @DESRISULTATO = 'FATTO NIENTE'

	IF @QTA = 0 
	BEGIN
		DELETE BASKET_TEMPORANEO WHERE
				CODICE_NEGOZIO = @NEGOZIO AND
				CODICE_BASKET = @BASKET AND
				EAN = @EAN
		SET	@RISULTATO = 'OK'
		SET @DESRISULTATO = 'CANCELLATO'
		GOTO FINE
	END
	
	IF NOT EXISTS(SELECT * FROM GIACENZA WHERE CODICE_NEGOZIO = @NEGOZIO AND GIACENZA > 0)
	BEGIN
		SET	@RISULTATO = 'KO'
		SET @DESRISULTATO = 'Articolo inesistente o esaurito'
		GOTO FINE
	END

	DECLARE @PREZZO MONEY = 0
	SELECT  @PREZZO = ISNULL(P.PREZZO, PREZZO_BASE)  
	FROM 
		GIACENZA G WITH (NOLOCK)
		JOIN ARTICOLO       A WITH (NOLOCK) ON G.ID_ARTICOLO = A.ID_ARTICOLO
		LEFT JOIN PREZZO P WITH (NOLOCK) ON G.CODICE_NEGOZIO = P.CODICE_NEGOZIO AND G.EAN = P.EAN
		WHERE
			G.CODICE_NEGOZIO = @NEGOZIO AND
			G.EAN			=  @EAN  

	IF @PREZZO = 0
	BEGIN
		SET	@RISULTATO = 'KO'
		SET @DESRISULTATO = 'Articolo privo di prezzo'
		GOTO FINE
	END

BEGIN TRY
	
	BEGIN TRANSACTION 
	
	IF EXISTS(SELECT * FROM BASKET_TEMPORANEO WHERE
				CODICE_NEGOZIO = @NEGOZIO AND
				CODICE_BASKET = @BASKET AND
				EAN = @EAN)
	BEGIN
		UPDATE BASKET_TEMPORANEO 
				SET QUANTITA = QUANTITA + @QTA,
					PREZZOTOTALE = (QUANTITA + @QTA ) * @PREZZO
		WHERE
				CODICE_NEGOZIO = @NEGOZIO AND
				CODICE_BASKET = @BASKET AND
				EAN = @EAN

	END
	ELSE
	BEGIN
			INSERT INTO [dbo].[BASKET_TEMPORANEO]
					   ([CODICE_NEGOZIO]
					   ,[CODICE_BASKET]
					   ,[EAN]
					   ,[QUANTITA]
					   ,[PREZZOTOTALE])
				 VALUES
					   (@NEGOZIO
					   ,@BASKET
					   ,@EAN 
					   ,@QTA
					   ,@PREZZO)


	END
		 		
	SET @RISULTATO = 'OK'
	SET @DESRISULTATO = 'BASKET INSERITO CORRETTAMENTE'


END TRY
BEGIN CATCH
    --IF @@TRANCOUNT > 0
    --    ROLLBACK TRAN --ROLLBACK IN CASE OF ERROR

    -- YOU CAN RAISE ERROR WITH RAISEERROR() STATEMENT INCLUDING THE DETAILS OF THE EXCEPTION
    --RAISERROR(ERROR_MESSAGE(), ERROR_SEVERITY(), 1)
    PRINT 'VADO IN ERRORE'
    SET @RISULTATO = 'KO'
    SET @DESRISULTATO = ERROR_MESSAGE()
END CATCH	


	
	IF SUBSTRING(@RISULTATO, 1 , 2) = 'OK' 
		COMMIT TRANSACTION
	ELSE
		ROLLBACK TRANSACTION
		
	FINE:
	PRINT @RISULTATO
	PRINT @DESRISULTATO



END