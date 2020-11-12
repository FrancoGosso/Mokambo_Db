﻿CREATE TABLE [dbo].[COMANDA_TESTATA_old] (
    [ID_COMANDA]       INT           NOT NULL,
    [ID_BASKET]        INT           NOT NULL,
    [ID_REPARTO]       INT           NOT NULL,
    [DESCRIZIONECORTA] VARCHAR (25)  NOT NULL,
    [STAMPANTE]        VARCHAR (500) NOT NULL,
    [DATA_CREAZIONE]   DATETIME      CONSTRAINT [DF_COMANDA_TESTATA_DATA_CREAZIONE_old] DEFAULT (getdate()) NOT NULL,
    [STATUS]           VARCHAR (10)  CONSTRAINT [DF_COMANDA_TESTATA_STATUS_old] DEFAULT ('CI') NOT NULL,
    CONSTRAINT [PK_COMANDA_TESTATA_old] PRIMARY KEY CLUSTERED ([ID_COMANDA] ASC)
);
