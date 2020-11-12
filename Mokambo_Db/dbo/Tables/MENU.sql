CREATE TABLE [dbo].[MENU] (
    [ID_MENU]        INT             IDENTITY (1, 1) NOT NULL,
    [NOME]           VARCHAR (200)   NOT NULL,
    [DESCRIZIONE]    VARCHAR (200)   NOT NULL,
    [DT_INSERIMENTO] DATETIME        NOT NULL,
    [VISUALIZZATO]   BIT             NOT NULL,
    [STATUS]         CHAR (1)        NOT NULL,
    [IMMAGINE]       VARCHAR (200)   NULL,
    [ORA_DA]         INT             NULL,
    [ORA_A]          INT             NULL,
    [PREZZO]         DECIMAL (10, 2) NULL,
    [TIPOLOGIA]      CHAR (1)        NULL,
    [QTA_INVITATI]   INT             NULL,
    CONSTRAINT [PK_MENU] PRIMARY KEY CLUSTERED ([ID_MENU] ASC)
);

