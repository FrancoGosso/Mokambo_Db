﻿CREATE TABLE [dbo].[IVA] (
    [PROG]       INT            IDENTITY (1, 1) NOT NULL,
    [CODICE_IVA] VARCHAR (10)   NOT NULL,
    [DAL]        VARCHAR (8)    NOT NULL,
    [AL]         VARCHAR (8)    NOT NULL,
    [DES_IVA]    VARCHAR (250)  NOT NULL,
    [ALIQUOTA]   DECIMAL (4, 4) NOT NULL,
    CONSTRAINT [PK_TAB_IVA] PRIMARY KEY CLUSTERED ([PROG] ASC)
);

