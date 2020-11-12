CREATE TABLE [dbo].[COMANDA_RIGA] (
    [ID_COMANDA]  INT           NOT NULL,
    [ID_MENU]     INT           NOT NULL,
    [ID_ARTICOLO] INT           NOT NULL,
    [BOX]         INT           NOT NULL,
    [PREZZO]      MONEY         NOT NULL,
    [QTA]         INT           NOT NULL,
    [ISTRUZIONI]  VARCHAR (250) NULL,
    [QTA_EVASA]   INT           NOT NULL,
    CONSTRAINT [PK_COMANDA_RIGA] PRIMARY KEY CLUSTERED ([ID_COMANDA] ASC, [ID_MENU] ASC, [ID_ARTICOLO] ASC)
);

