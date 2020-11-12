-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PRC_AUTENTICATE_USER_BY_EAN]
	-- Add the parameters for the stored procedure here
@ean  varchar(13),
@negozio  varchar(4)
AS
BEGin
select * from USER_NEGOZIO where CODICE_NEGOZIO = @negozio and Ean = @ean

END