CREATE TABLE [dbo].[BASKET_TESTATA] (
    [ID_BASKET]        INT           IDENTITY (1, 1) NOT NULL,
    [DATA_CREAZIONE]   DATETIME      NOT NULL,
    [CASSA]            INT           NOT NULL,
    [CODICE_NEGOZIO]   VARCHAR (10)  NULL,
    [EVASO]            BIT           NOT NULL,
    [STAMPATO]         BIT           NOT NULL,
    [PAGATO]           BIT           NOT NULL,
    [TOTALE]           MONEY         NOT NULL,
    [CODICE_UTENTE]    VARCHAR (30)  NOT NULL,
    [TAVOLO]           INT           NULL,
    [DESC_ORDINAZIONE] VARCHAR (250) NULL,
    CONSTRAINT [PK_BASKET_TESTATA] PRIMARY KEY CLUSTERED ([ID_BASKET] ASC)
);

