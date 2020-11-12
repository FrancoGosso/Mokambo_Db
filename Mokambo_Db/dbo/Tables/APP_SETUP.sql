﻿CREATE TABLE [dbo].[APP_SETUP] (
    [CHIAVE]      VARCHAR (50)  NOT NULL,
    [VALORE]      VARCHAR (250) NOT NULL,
    [DESCRIZIONE] VARCHAR (500) CONSTRAINT [DF_APP_SETUP_DESCRIZIONE] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_APP_SETUP] PRIMARY KEY CLUSTERED ([CHIAVE] ASC)
);

