﻿CREATE TABLE [dbo].[REPARTO_VENDITA] (
    [COD_NEGOZIO]           VARCHAR (10)  NOT NULL,
    [COD_REPARTO_VENDITA]   VARCHAR (10)  NOT NULL,
    [DES_REPARTO_VENDITA]   VARCHAR (500) NOT NULL,
    [SIGLA_REPARTO_VENDITA] VARCHAR (25)  NOT NULL,
    CONSTRAINT [PK_REPARTO_VENDITA] PRIMARY KEY CLUSTERED ([COD_NEGOZIO] ASC, [COD_REPARTO_VENDITA] ASC)
);

