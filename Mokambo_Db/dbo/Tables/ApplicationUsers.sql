CREATE TABLE [dbo].[ApplicationUsers] (
    [Id]                   NVARCHAR (128) NOT NULL,
    [CODICE_UTENTE]        NVARCHAR (30)  NULL,
    [DESCRIZIONE]          NVARCHAR (60)  NULL,
    [PASSWORD]             NVARCHAR (30)  NULL,
    [STATO]                NVARCHAR (1)   NULL,
    [ULTIMA_LOGIN]         DATETIME       NULL,
    [BARCODE]              NVARCHAR (13)  NULL,
    [Email]                NVARCHAR (MAX) NULL,
    [EmailConfirmed]       BIT            NOT NULL,
    [PasswordHash]         NVARCHAR (MAX) NULL,
    [SecurityStamp]        NVARCHAR (MAX) NULL,
    [PhoneNumber]          NVARCHAR (MAX) NULL,
    [PhoneNumberConfirmed] BIT            NOT NULL,
    [TwoFactorEnabled]     BIT            NOT NULL,
    [LockoutEndDateUtc]    DATETIME       NULL,
    [LockoutEnabled]       BIT            NOT NULL,
    [AccessFailedCount]    INT            NOT NULL,
    [UserName]             NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.ApplicationUsers] PRIMARY KEY CLUSTERED ([Id] ASC)
);

