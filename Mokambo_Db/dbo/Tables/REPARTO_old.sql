﻿CREATE TABLE [dbo].[REPARTO_old] (
    [CODICE_NEGOZIO]       VARCHAR (10)  NOT NULL,
    [IDREPARTO]            INT           NOT NULL,
    [DESCRIZIONEREPARTO]   VARCHAR (500) NOT NULL,
    [NOMESTAMPANTECOMANDA] VARCHAR (250) NOT NULL,
    [DESCRIZIONECORTA]     VARCHAR (25)  NOT NULL
);


GO
-- =============================================
-- Author:		Delpiano
-- Create date: 02-01-2017
-- Description:	per ogni REPARTO modificato richiamo la stored 
-- che ne memorizza i dati da inviare al server centrale
-- =============================================
CREATE TRIGGER [dbo].[TRG_UPD_REPARTO] 
   ON  [dbo].[REPARTO_old]
   FOR INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

	IF EXISTS(SELECT * FROM APP_SETUP WHERE CHIAVE = 'STOP_TRIGGER_ALLINEAMENTO' AND VALORE = 'SI')
	BEGIN
		GOTO FINE
	END

	DECLARE @KEY INT
	

	DECLARE CUR CURSOR LOCAL FOR
		SELECT  IDREPARTO FROM INSERTED

	OPEN CUR

	FETCH NEXT FROM CUR INTO  @KEY

	WHILE @@FETCH_STATUS = 0 BEGIN

		EXEC PRC_AGGIORNAMENTO_DA_INVIARE_INSERT @KEY, 'REPARTO'
		FETCH NEXT FROM CUR INTO @KEY
	END

	CLOSE CUR
	DEALLOCATE CUR
	FINE:

END