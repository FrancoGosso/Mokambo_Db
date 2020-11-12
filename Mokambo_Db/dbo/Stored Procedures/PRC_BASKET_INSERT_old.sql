
-- =============================================
-- Author:		DELPIANO STEFANO
-- Create date: 21-02-2014
-- Description: SALVATAGGIO BASKET
-- =============================================
CREATE PROCEDURE [dbo].[PRC_BASKET_INSERT_old]
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

	SELECT * into #TESTATA
	FROM OPENXML(@HDOC, 'BASKET/TESTATA',2)   
	WITH 
		(
		PRG				INT,
		DATA			varchar(8),
		ORA				varchar(6),
		CASSA			INT,
		SCONTRINO		INT,
		NEGOZIO			VARCHAR(10),
		STAMPATO		CHAR(1),
		PAGATO			CHAR(1),
		TOTALE			MONEY,
		RINCARO			MONEY,
		CODICE_UTENTE	varchar(8)
		)

	SELECT * INTO #RIGHE
	FROM OPENXML(@HDOC, 'BASKET/RIGHE/R',2)   
	WITH 
		(
		RIGA		int,
		EAN		    VARCHAR(13),
		PREZZO		money,
		SCONTO		MONEY,
		SCPERC		DECIMAL(8,3),
		QTA			DECIMAL(8,3),
		REPVEN		VARCHAR(1),
		LOTTOVEN	VARCHAR(1)
		)

	SELECT * into #pagamenti
	FROM OPENXML(@HDOC, 'BASKET/PAGAMENTI/PA',2)   
	WITH 
		(
		TIPO		varchar(15),
		IMP		    money
		)		
		
	EXEC SP_XML_REMOVEDOCUMENT @HDOC	
	
	SELECT @PROG = PRG FROM #TESTATA


BEGIN TRY
	
	BEGIN TRANSACTION 
	

	

	print 'inserisco testata'	
	INSERT INTO [BASKET_TESTATA_old]
           ([ID_BASKET]
           ,[DATA]
           ,[ORA]
           ,[CASSA]
           ,[SCONTRINO]
           ,[CODICE_NEGOZIO]
           ,[STAMPATO]
           ,[PAGATO]
           ,[TOTALE]
		   ,[RINCARO]
		   ,[CODICE_UTENTE])
     SELECT
           PRG,
           DATA,
           ORA,
           CASSA,
           SCONTRINO,
           NEGOZIO,
           STAMPATO,
           PAGATO,
           TOTALE,
		   RINCARO,
		   CODICE_UTENTE
     FROM #TESTATA



		
	print 'inserisco righe'	
	INSERT INTO [BASKET_RIGA]
           ([ID_BASKET]
           ,[RIGA]
           ,[EAN]
           ,[PREZZO]
           ,[VALORE_SCONTO]
           ,[PERC_SCONTO]
           ,[SCONTO_ESPOSTO]
           ,[QTA]
           ,[REPARTO_VENDITA]
           ,[LOTTO_VENDITA]
           )
    SELECT
           @PROG,
           RIGA,
           EAN,
           PREZZO,
           SCONTO,
           SCPERC,
           1,
           QTA,
           REPVEN,
           LOTTOVEN
	FROM #RIGHE

	PRINT 'INSERISCO PAGAMENTI'	
	INSERT INTO [BASKET_PAGAMENTO]
           ([ID_BASKET]
           ,[TIPO_PAGAMENTO]
           ,[IMPORTO])
    SELECT
           @PROG,
           TIPO,
           IMP
	FROM #PAGAMENTI


		 		
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