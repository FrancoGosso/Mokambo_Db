﻿CREATE TABLE [dbo].[LINGUA] (
    [ID_LINGUA]          INT           NOT NULL,
    [CODICE_LINGUA]      VARCHAR (10)  NOT NULL,
    [DESCRIZIONE_LINGUA] VARCHAR (50)  NOT NULL,
    [IMMAGINE]           VARCHAR (250) NOT NULL,
    CONSTRAINT [PK_LINGUA] PRIMARY KEY CLUSTERED ([ID_LINGUA] ASC)
);


GO
-- =============================================
-- Author:		Delpiano
-- Create date: 02-01-2017
-- Description:	per ogni LINGUA modificata richiamo la stored 
-- che ne memorizza i dati da inviare al server centrale
-- =============================================
CREATE TRIGGER [dbo].[TRG_UPD_LINGUA] 
   ON  [dbo].[LINGUA]
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
		SELECT ID_LINGUA FROM INSERTED

	OPEN CUR

	FETCH NEXT FROM CUR INTO @KEY

	WHILE @@FETCH_STATUS = 0 BEGIN

		EXEC PRC_AGGIORNAMENTO_DA_INVIARE_INSERT @KEY, 'LINGUA'
		FETCH NEXT FROM CUR INTO @KEY
	END

	CLOSE CUR
	DEALLOCATE CUR
	FINE:

END