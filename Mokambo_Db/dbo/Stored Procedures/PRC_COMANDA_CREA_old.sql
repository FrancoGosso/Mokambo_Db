﻿
-- =============================================
-- Author:		DELPIANO STEFANO
-- Create date: 23-02-2014
-- Description:	CREAZIONE DELLA COMANDA DA BASKET
-- =============================================
CREATE PROCEDURE [dbo].[PRC_COMANDA_CREA_old]
@ID_BASKET	INT,
@RISULTATO			CHAR(2)			= '' OUTPUT,
@DESRISULTATO		VARCHAR(1000)	= '' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	SET	@RISULTATO = 'KO'
	SET @DESRISULTATO = 'FATTO NIENTE'

BEGIN TRY
	
	BEGIN TRANSACTION 	
	DECLARE @CODICE_NEGOZIO VARCHAR(10)
	SET @CODICE_NEGOZIO = 'XXXX'
	
	SELECT @CODICE_NEGOZIO = CODICE_NEGOZIO FROM BASKET_TESTATA_old WHERE ID_BASKET = @ID_BASKET 
	
	SELECT B.EAN, A.ID_ARTICOLO, CODICE_ARTICOLO, NOME, NOME_BREVE ,REPARTO, SUM(QTA) AS QTA  
	INTO #BASKET
	FROM 
	BASKET_RIGA B WITH (NOLOCK) JOIN GIACENZA G  WITH (NOLOCK) 
	JOIN ARTICOLO A  WITH (NOLOCK)  ON G.ID_ARTICOLO = A.ID_ARTICOLO
	ON B.EAN = G.EAN
	WHERE
	ID_BASKET = @ID_BASKET
	GROUP BY
	B.EAN, A.ID_ARTICOLO, CODICE_ARTICOLO, NOME,NOME_BREVE, REPARTO


	DECLARE @REPARTO INT
	DECLARE @DESREPARTO VARCHAR(500)
	DECLARE @STAMPANTE VARCHAR(250)
	
	-- SE RICHIESTA MONOCOMANDA RIPORTA LO STESSO REPARTO SU TUTTE LE RIGHE DEL BASKET
	DECLARE @MONOCOMANDA CHAR(2) 
	SET		@MONOCOMANDA = 'NO'
	
	SELECT	@MONOCOMANDA = VALORE FROM APP_SETUP WHERE CHIAVE = 'MONOCOMANDA'
	
	IF @MONOCOMANDA = 'SI' 
	BEGIN
		--PRINT 'MONOCOMANDA'
		SELECT @REPARTO = REPARTO FROM #BASKET
		--PRINT 'IMPOSTO REPARTO ' + CONVERT(VARCHAR, @REPARTO) + ' SU TUTTI'
		UPDATE #BASKET SET REPARTO = @REPARTO
	END

	DECLARE CURREPARTI CURSOR FOR 
		SELECT DISTINCT REPARTO, DESCRIZIONECORTA, NOMESTAMPANTECOMANDA
			FROM #BASKET JOIN REPARTO ON REPARTO = IDREPARTO



	OPEN    CURREPARTI

	FETCH NEXT FROM CURREPARTI  INTO  @REPARTO,@DESREPARTO,@STAMPANTE



	WHILE @@FETCH_STATUS <> -1
	BEGIN

		
			
			DECLARE		@PROG_COMANDA INT
			EXECUTE 	@PROG_COMANDA = PRC_GET_PROGRESSIVO 'COMANDA', @CODICE_NEGOZIO 

			INSERT INTO COMANDA_TESTATA
					   ([ID_COMANDA]
					   ,[ID_BASKET]
					   ,[ID_REPARTO]
					   ,[DESCRIZIONECORTA]
					   ,[STAMPANTE]
					   ,[DATA_CREAZIONE]
					   ,[STATUS])
				 VALUES
					   (@PROG_COMANDA
					   ,@ID_BASKET
					   ,@REPARTO
					   ,@DESREPARTO
					   ,@STAMPANTE
					   ,GETDATE()
					   ,'CI')



			
			INSERT INTO [COMANDA_RIGA]
					   ([ID_COMANDA]
					   ,[EAN]
					   ,[QTA]
					   ,[ID_ARTICOLO]
					   ,[CODICE_ARTICOLO]
					   ,[NOME]
					   ,[NOME_BREVE])
				 SELECT
					   @PROG_COMANDA,
					   EAN, 
					   QTA, 
					   ID_ARTICOLO,
					   CODICE_ARTICOLO,
					   NOME,
					   NOME_BREVE 
			FROM #BASKET
			WHERE REPARTO = @REPARTO


			FETCH NEXT FROM CURREPARTI  INTO  @REPARTO,@DESREPARTO,@STAMPANTE
	END


	CLOSE CURREPARTI
	DEALLOCATE CURREPARTI

	SET @RISULTATO = 'OK'
	SET @DESRISULTATO = 'COMANDA CREATA CORRETTAMENTE'


END TRY
BEGIN CATCH
    PRINT 'VADO IN ERRORE'
    SET @RISULTATO = 'KO ' + ERROR_MESSAGE()
    SET @DESRISULTATO = ERROR_MESSAGE()
    
	CLOSE CURREPARTI
	DEALLOCATE CURREPARTI
END CATCH	

	FINE:
	PRINT @RISULTATO
	PRINT @DESRISULTATO
	
	IF SUBSTRING(@RISULTATO, 1 , 2) = 'OK' 
		COMMIT TRANSACTION
	ELSE
		ROLLBACK TRANSACTION
		


END