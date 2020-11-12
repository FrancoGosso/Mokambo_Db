CREATE TABLE [dbo].[USER_NEGOZIO] (
    [CODICE_NEGOZIO] VARCHAR (10)  NOT NULL,
    [UserId]         INT           NOT NULL,
    [Nome]           VARCHAR (64)  NULL,
    [Cognome]        VARCHAR (64)  NULL,
    [Ean]            NVARCHAR (13) NULL,
    [puoScontare]    NCHAR (2)     NULL,
    CONSTRAINT [PK_USER_NEGOZIO] PRIMARY KEY CLUSTERED ([CODICE_NEGOZIO] ASC, [UserId] ASC)
);

