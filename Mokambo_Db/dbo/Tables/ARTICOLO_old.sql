﻿CREATE TABLE [dbo].[ARTICOLO_old] (
    [ID_ARTICOLO]                   INT            NOT NULL,
    [CODICE_ARTICOLO]               VARCHAR (20)   CONSTRAINT [DF_ARTICOLO_CODICE_ARTICOLO_old] DEFAULT ('') NOT NULL,
    [NOME]                          VARCHAR (250)  NOT NULL,
    [NOME_BREVE]                    VARCHAR (25)   CONSTRAINT [DF_ARTICOLO_NOME_BREVE_old] DEFAULT ('') NOT NULL,
    [DESCRIZIONE]                   NTEXT          CONSTRAINT [DF_ARTICOLO_DESCRIZIONE_old] DEFAULT ('') NOT NULL,
    [ID_CATEGORIA]                  INT            CONSTRAINT [DF_ARTICOLO_ID_CATEGORIA_old] DEFAULT ((0)) NOT NULL,
    [DEFAULT_IMAGE]                 VARCHAR (250)  CONSTRAINT [DF_ARTICOLO_DEFAULT_IMAGE_old] DEFAULT ('') NOT NULL,
    [QTA_MINIMA]                    DECIMAL (8, 3) CONSTRAINT [DF_ARTICOLO_QTA_MINIMA_old] DEFAULT ((0)) NOT NULL,
    [CODICE_IVA]                    VARCHAR (10)   CONSTRAINT [DF_ARTICOLO_COD_IVA_old] DEFAULT ((0)) NOT NULL,
    [PREZZO_BASE]                   MONEY          CONSTRAINT [DF_ARTICOLO_PREZZO_BASE_old] DEFAULT ((0.00)) NOT NULL,
    [REPARTO]                       INT            CONSTRAINT [DF_ARTICOLO_REPARTO_old] DEFAULT ((0)) NOT NULL,
    [STATUS]                        VARCHAR (10)   CONSTRAINT [DF_ARTICOLO_STATUS_old] DEFAULT ('V') NOT NULL,
    [CODICE_UM]                     VARCHAR (3)    CONSTRAINT [DF_ARTICOLO_CODICE_UM_old] DEFAULT ('UN') NOT NULL,
    [TIPO_ARTICOLO]                 CHAR (1)       CONSTRAINT [DF_ARTICOLO_TIPO_ARTICOLO_old] DEFAULT ('S') NOT NULL,
    [CODICE_ARTICOLO_PRINCIPALE]    VARCHAR (20)   CONSTRAINT [DF_ARTICOLO_CODICE_ARTICOLO_PRINCIPALE_old] DEFAULT ('') NOT NULL,
    [QTA_ARTICOLO_PRINCIPALE]       DECIMAL (8, 3) CONSTRAINT [DF_ARTICOLO_QTA_ARTICOLO_PRINCIPALE_old] DEFAULT ((0)) NOT NULL,
    [CODICE_UM_ARTICOLO_PRINCIPALE] VARCHAR (3)    CONSTRAINT [DF_ARTICOLO_CODICE_UM_ARTICOLO_PRINCIPALE_old] DEFAULT ('UN') NOT NULL,
    [REPARTO_VENDITA]               VARCHAR (1)    CONSTRAINT [DF_ARTICOLO_REPARTO_VENDITA_old] DEFAULT ('') NULL,
    [LOTTO_VENDITA]                 VARCHAR (1)    CONSTRAINT [DF_ARTICOLO_LOTTO_VENDITA_old] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_ARTICOLO_old] PRIMARY KEY CLUSTERED ([ID_ARTICOLO] ASC)
);

