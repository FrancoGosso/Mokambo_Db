CREATE TABLE [dbo].[IdentityUserLogins] (
    [UserId]             NVARCHAR (128) NOT NULL,
    [LoginProvider]      NVARCHAR (MAX) NULL,
    [ProviderKey]        NVARCHAR (MAX) NULL,
    [ApplicationUser_Id] NVARCHAR (128) NULL,
    CONSTRAINT [PK_dbo.IdentityUserLogins] PRIMARY KEY CLUSTERED ([UserId] ASC),
    CONSTRAINT [FK_dbo.IdentityUserLogins_dbo.ApplicationUsers_ApplicationUser_Id] FOREIGN KEY ([ApplicationUser_Id]) REFERENCES [dbo].[ApplicationUsers] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_ApplicationUser_Id]
    ON [dbo].[IdentityUserLogins]([ApplicationUser_Id] ASC);

