﻿-- =============================================
-- Author:		BACCO MICHAEL
-- Create date: 06-09-2016
-- Description: VARIAZIONE DELLO SCONTO / RINCARO SUL SINGOLO PRODOTTO DI BASKET E SCONTRINO
-- =============================================
CREATE PROCEDURE [dbo].[PRC_RIGA_SCONTO_RINCARO]
@DOCXML				ntext,
@RISULTATO			CHAR(2)			= '' OUTPUT,
@DESRISULTATO		VARCHAR(1000)	= '' OUTPUT
AS
BEGIN

	DECLARE @PROG	INT


	SET NOCOUNT ON;
	
	SET	@RISULTATO = 'KO'
	SET @DESRISULTATO = 'FATTO NIENTE'

	
	DECLARE		@HDOC 		INT  
	
	EXEC 		SP_XML_PREPAREDOCUMENT @HDOC OUTPUT,@DOCXML

	SELECT * into #RIGA
	FROM OPENXML(@HDOC, 'BASKET/TESTATA',2)   
	WITH 
		(
		ID_BASKET				INT,
		ID_RIGA					INT,
		VALORE_SCONTO			DECIMAL(6,3),
		PERCENTUALE_SCONTO		DECIMAL(6,3),
		VALORE_RINCARO			DECIMAL(6,3),
		PERCENTUALE_RINCARO		DECIMAL(6,3)
		)

		
	EXEC SP_XML_REMOVEDOCUMENT @HDOC	


BEGIN TRY
	
	BEGIN TRANSACTION 
	
	print 'aggiorno righe basket'	
	UPDATE BSK
	SET 
	BSK.VALORE_SCONTO = R.VALORE_SCONTO,
	BSK.PERC_SCONTO = R.PERCENTUALE_SCONTO,
	BSK.PREZZO = BSK.PREZZO + BSK.VALORE_SCONTO - R.VALORE_SCONTO
	FROM DBO.BASKET_RIGA AS BSK
	INNER JOIN #RIGA R ON R.ID_BASKET = BSK.ID_BASKET 
	
	
	
	print 'aggiorno righe scontrino'
	UPDATE SR
	SET 
	SR.VALORE_SCONTO = R.VALORE_SCONTO,
	SR.PERC_SCONTO = R.PERCENTUALE_SCONTO,
	SR.PREZZO = SR.PREZZO + SR.VALORE_SCONTO - R.VALORE_SCONTO
	FROM DBO.SCONTRINATO_RIGA AS SR
	INNER JOIN DBO.SCONTRINATO_TESTATA ST ON ST.CODICE_NEGOZIO = SR.CODICE_NEGOZIO AND ST.CASSA = SR.CASSA 
			AND ST.DATA = SR.DATA AND ST.ORA = SR.ORA AND ST.SCONTRINO = SR.SCONTRINO
	INNER JOIN #RIGA R ON R.ID_BASKET = ST.ID_BASKET
	
	


	SET @RISULTATO = 'OK'
	SET @DESRISULTATO = 'BASKET INSERITO CORRETTAMENTE'


END TRY
BEGIN CATCH
    --IF @@TRANCOUNT > 0
    --    ROLLBACK TRAN --ROLLBACK IN CASE OF ERROR

    -- YOU CAN RAISE ERROR WITH RAISEERROR() STATEMENT INCLUDING THE DETAILS OF THE EXCEPTION
    --RAISERROR(ERROR_MESSAGE(), ERROR_SEVERITY(), 1)
    PRINT 'VADO IN ERRORE'
    SET @RISULTATO = 'KO ' + ERROR_MESSAGE()
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