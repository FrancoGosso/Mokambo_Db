﻿

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PRC_INSERT_UPD_REPARTO]

@NEGOZIO			    VARCHAR(10)		= '', 
@IDREPARTO				INT				= 0,
@DESCRIZIONEREPARTO	    VARCHAR(20)     = '', 
@NOMESTAMPANTECOMANDA	VARCHAR(250)	= '',
@DESCRIZIONECORTA		VARCHAR(25)		= '', 
@STATUS					VARCHAR(10)		= 'V', 
@VISUALIZZA				BIT				= 1,
@RISULTATO			    CHAR(2)			= '' OUTPUT,
@DESRISULTATO	    	VARCHAR(1000)	= '' OUTPUT
AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRY
	
		MERGE [dbo].[REPARTO] AS target  
			USING (SELECT @IDREPARTO, @NEGOZIO, @DESCRIZIONEREPARTO, @NOMESTAMPANTECOMANDA, @DESCRIZIONECORTA, @STATUS, @VISUALIZZA) 
				AS source (IDREPARTO, CODICE_NEGOZIO, DESCRIZIONEREPARTO, NOMESTAMPANTECOMANDA, DESCRIZIONECORTA, STATUS, VISUALIZZA)  
			ON (target.IDREPARTO = source.IDREPARTO and target.CODICE_NEGOZIO = source.CODICE_NEGOZIO)  
			WHEN MATCHED THEN
				UPDATE SET CODICE_NEGOZIO  = source.CODICE_NEGOZIO,  
							DESCRIZIONEREPARTO  = source.DESCRIZIONEREPARTO,  
							DESCRIZIONECORTA  = source.DESCRIZIONECORTA,  
							STATUS  = source.STATUS,
							NOMESTAMPANTECOMANDA  = source.NOMESTAMPANTECOMANDA,  
							VISUALIZZA  = source.VISUALIZZA
			WHEN NOT MATCHED THEN  
				INSERT (CODICE_NEGOZIO, DESCRIZIONEREPARTO, NOMESTAMPANTECOMANDA, DESCRIZIONECORTA, STATUS, VISUALIZZA) 
				VALUES (source.CODICE_NEGOZIO,source.DESCRIZIONEREPARTO, source.NOMESTAMPANTECOMANDA, source.DESCRIZIONECORTA, source.STATUS, source.VISUALIZZA);  

		SET @RISULTATO		= 'OK' 
		SET @DESRISULTATO	= 'TUTTO OK'	

	END TRY
	BEGIN CATCH
		SET @RISULTATO = 'KO'
		SET @DESRISULTATO = ERROR_MESSAGE()
	END CATCH
		
END