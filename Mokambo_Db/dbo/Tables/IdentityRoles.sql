CREATE TABLE [dbo].[IdentityRoles] (
    [Id]   NVARCHAR (128) NOT NULL,
    [Name] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.IdentityRoles] PRIMARY KEY CLUSTERED ([Id] ASC)
);

