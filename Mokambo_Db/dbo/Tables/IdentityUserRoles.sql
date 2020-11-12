CREATE TABLE [dbo].[IdentityUserRoles] (
    [RoleId]             NVARCHAR (128) NOT NULL,
    [UserId]             NVARCHAR (128) NOT NULL,
    [IdentityRole_Id]    NVARCHAR (128) NULL,
    [ApplicationUser_Id] NVARCHAR (128) NULL,
    CONSTRAINT [PK_dbo.IdentityUserRoles] PRIMARY KEY CLUSTERED ([RoleId] ASC, [UserId] ASC),
    CONSTRAINT [FK_dbo.IdentityUserRoles_dbo.ApplicationUsers_ApplicationUser_Id] FOREIGN KEY ([ApplicationUser_Id]) REFERENCES [dbo].[ApplicationUsers] ([Id]),
    CONSTRAINT [FK_dbo.IdentityUserRoles_dbo.IdentityRoles_IdentityRole_Id] FOREIGN KEY ([IdentityRole_Id]) REFERENCES [dbo].[IdentityRoles] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_IdentityRole_Id]
    ON [dbo].[IdentityUserRoles]([IdentityRole_Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ApplicationUser_Id]
    ON [dbo].[IdentityUserRoles]([ApplicationUser_Id] ASC);

