﻿CREATE TABLE [dbo].[SCONTRINATO_PAGAMENTO] (
    [CODICE_NEGOZIO] VARCHAR (10) NOT NULL,
    [DATA]           CHAR (8)     NOT NULL,
    [ORA]            CHAR (6)     NOT NULL,
    [CASSA]          INT          NOT NULL,
    [SCONTRINO]      INT          NOT NULL,
    [TIPO_PAGAMENTO] VARCHAR (10) NOT NULL,
    [IMPORTO]        MONEY        NOT NULL,
    CONSTRAINT [PK_SCONTRINATO_PAGAMENTO] PRIMARY KEY CLUSTERED ([DATA] ASC, [ORA] ASC, [CASSA] ASC, [SCONTRINO] ASC, [CODICE_NEGOZIO] ASC, [TIPO_PAGAMENTO] ASC)
);

