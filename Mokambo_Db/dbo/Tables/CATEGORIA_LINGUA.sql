﻿CREATE TABLE [dbo].[CATEGORIA_LINGUA] (
    [ID_CATEGORIA]          INT           NOT NULL,
    [ID_LINGUA]             INT           NOT NULL,
    [DESCRIZIONE_CATEGORIA] VARCHAR (250) NOT NULL,
    [IMMAGINE]              VARCHAR (250) NULL,
    [STATUS]                VARCHAR (10)  NULL,
    CONSTRAINT [PK_CATEGORIA_LINGUA] PRIMARY KEY CLUSTERED ([ID_CATEGORIA] ASC, [ID_LINGUA] ASC)
);

