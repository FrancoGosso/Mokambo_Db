-- =============================================
-- Author:		<Author,,Andrea Taverna>
-- Create date: <Create Date,22/12/2015,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PRC_GET_APP_SETUP_VALORE]
	
@CHIAVE varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	select VALORE from APP_SETUP where CHIAVE = @CHIAVE
END