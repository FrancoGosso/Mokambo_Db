﻿CREATE TABLE [dbo].[CURRENCY] (
    [COD_CURRENCY] CHAR (3)     NOT NULL,
    [DES_CURRENCY] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_CURRENCY] PRIMARY KEY CLUSTERED ([COD_CURRENCY] ASC)
);

