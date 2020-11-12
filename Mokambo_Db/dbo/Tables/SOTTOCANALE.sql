CREATE TABLE [dbo].[SOTTOCANALE] (
    [ID_SOTTOCANALE]          INT            NOT NULL,
    [SIGLA_SOTTOCANALE]       NCHAR (10)     NULL,
    [DESCRIZIONE_SOTTOCANALE] NVARCHAR (128) NULL,
    [COD_CANALE_VENDITA]      NVARCHAR (10)  NULL,
    [COD_NEGOZIO]             NVARCHAR (10)  NULL,
    [ORA_DA]                  CHAR (6)       NULL,
    [ORA_A]                   CHAR (6)       NULL,
    PRIMARY KEY CLUSTERED ([ID_SOTTOCANALE] ASC)
);


GO
-- =============================================
-- Author:		Delpiano
-- Create date: 02-01-2017
-- Description:	per ogni REPARTO modificato richiamo la stored 
-- che ne memorizza i dati da inviare al server centrale
-- =============================================
CREATE TRIGGER [dbo].[TRG_UPD_SOTTOCANALE] 
   ON  [dbo].[SOTTOCANALE]
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
		SELECT ID_SOTTOCANALE FROM INSERTED

	OPEN CUR

	FETCH NEXT FROM CUR INTO  @KEY

	WHILE @@FETCH_STATUS = 0 BEGIN

		EXEC PRC_AGGIORNAMENTO_DA_INVIARE_INSERT @KEY, 'SOTTOCANALE'
		FETCH NEXT FROM CUR INTO @KEY
	END

	CLOSE CUR
	DEALLOCATE CUR
	FINE:

END