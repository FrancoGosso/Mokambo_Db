﻿CREATE TABLE [dbo].[INGREDIENTE] (
    [ID_INGREDIENTE] INT           IDENTITY (1, 1) NOT NULL,
    [DESCRIZIONE]    VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_INGREDIENTI] PRIMARY KEY CLUSTERED ([ID_INGREDIENTE] ASC)
);

