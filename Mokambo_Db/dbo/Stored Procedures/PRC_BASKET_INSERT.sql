



-- =============================================
-- Author:		DELPIANO STEFANO
-- Create date: 21-02-2014
-- Description: SALVATAGGIO BASKET
-- =============================================
CREATE PROCEDURE [dbo].[PRC_BASKET_INSERT]
@CODICE_BASKET		VARCHAR(250),
@CODICE_PAGAMENTO	CHAR(2),
@RISULTATO			CHAR(2)			= '' OUTPUT,
@DESRISULTATO		VARCHAR(1000)	= '' OUTPUT
AS
BEGIN

	SET NOCOUNT ON;
	
	SET	@RISULTATO = 'KO'
	SET @DESRISULTATO = 'FATTO NIENTE'

BEGIN TRY
	
	BEGIN TRANSACTION 
	declare @id int = null

	print 'inserisco testata'	
	INSERT INTO [BASKET_TESTATA]
           ([DATA]
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
		  convert(char(8), getdate(), 112)							--DATA	
		, replace(convert(char(8), getdate(), 108) ,':' ,'')		--ORA
		, 0															--CASSA
		, 0															--SCONTRINO
		, max(CODICE_NEGOZIO)										--NEGOZIO
		, ''														--STAMPATO
		, ''														--PAGATO
		, sum(PREZZOTOTALE)											--TOTALE
		, 0															--RINCARO
		, 'utente'
	  FROM [db_schooner].[dbo].[BASKET_TEMPORANEO]
	   where CODICE_BASKET = @CODICE_BASKET
   	
	set @id = @@IDENTITY
		
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
             @id
			, ROW_NUMBER() OVER(ORDER BY CODICE_BASKET )
			, bk.EAN
			, PREZZOTOTALE
			, 0
			, 0
			, 0
			, QUANTITA
			, art.REPARTO_VENDITA
			, art.LOTTO_VENDITA
		  FROM [db_schooner].[dbo].[BASKET_TEMPORANEO] bk
		   left join [dbo].[VW_GIACENZA] art on bk.ean = art.EAN
		   where CODICE_BASKET = @CODICE_BASKET

	PRINT 'INSERISCO PAGAMENTI'	
	INSERT INTO [BASKET_PAGAMENTO]
           ([ID_BASKET]
           ,[TIPO_PAGAMENTO]
           ,[IMPORTO])
	SELECT 
		  @id															 
		, @CODICE_PAGAMENTO															 
		, sum(PREZZOTOTALE)											 
	  FROM [db_schooner].[dbo].[BASKET_TEMPORANEO]
	   where CODICE_BASKET = @CODICE_BASKET

		 		
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

	FINE:
	PRINT @RISULTATO
	PRINT @DESRISULTATO
	
	IF SUBSTRING(@RISULTATO, 1 , 2) = 'OK' 
		COMMIT TRANSACTION
	ELSE
		ROLLBACK TRANSACTION
END