﻿CREATE TABLE [dbo].[TIPO_PAGAMENTO] (
    [ID_PAGAMENTO]  INT          IDENTITY (1, 1) NOT NULL,
    [DES_PAGAMENTO] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_TIPO_PAG] PRIMARY KEY CLUSTERED ([ID_PAGAMENTO] ASC)
);
