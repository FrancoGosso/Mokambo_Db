﻿-- =============================================
-- Author:		delpiano stefano
-- Create date: 08-05-2015
-- Description:	modifica da inviare
-- =============================================
CREATE PROCEDURE [dbo].[PRC_UPD_SCONTRINO_INVIATO]
@NEGOZIO		VARCHAR(10),
@DATA			VARCHAR(8),
@ORA			VARCHAR(6),
@CASSA			INT,
@SCONTRINO		INT,
@INVIATO		CHAR(1) 

AS
BEGIN

	SET NOCOUNT ON;

	
		UPDATE SCONTRINATO_TESTATA 
		SET INVIATO = @INVIATO
				WHERE 
				CODICE_NEGOZIO	=	@NEGOZIO	AND
				DATA			=	@DATA		AND
				ORA				=	@ORA		AND
				CASSA			=	@CASSA		AND
				SCONTRINO		=	@SCONTRINO	
		
		-- W -> WORKING : SALVATO IN ATTESA DI INVIO   S -> SPEDITO
		-- IN ENTRAMBE I CASI DEVE ESSERE CANCELLATO DA SCONTRINATO_DA_ELABORARE
		-- PER EVITARE CHE VENGA RIELABORATO		
		IF @INVIATO = 'W' OR @INVIATO = 'S'
		BEGIN
				DELETE
				FROM SCONTRINATO_DA_INVIARE
				WHERE 
				CODICE_NEGOZIO	=	@NEGOZIO	AND
				DATA			=	@DATA		AND
				ORA				=	@ORA		AND
				CASSA			=	@CASSA		AND
				SCONTRINO		=	@SCONTRINO			
		
		END				
				
		
END