CREATE TABLE [dbo].[IdentityUserClaims] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [UserId]             NVARCHAR (MAX) NULL,
    [ClaimType]          NVARCHAR (MAX) NULL,
    [ClaimValue]         NVARCHAR (MAX) NULL,
    [ApplicationUser_Id] NVARCHAR (128) NULL,
    CONSTRAINT [PK_dbo.IdentityUserClaims] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.IdentityUserClaims_dbo.ApplicationUsers_ApplicationUser_Id] FOREIGN KEY ([ApplicationUser_Id]) REFERENCES [dbo].[ApplicationUsers] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_ApplicationUser_Id]
    ON [dbo].[IdentityUserClaims]([ApplicationUser_Id] ASC);

