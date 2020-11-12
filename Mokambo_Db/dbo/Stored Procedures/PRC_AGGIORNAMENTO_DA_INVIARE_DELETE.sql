-- =============================================
-- Author:		DELPIANO
-- Create date: 02-01-2017
-- Description:	CANCELLAZIONE AGGIORNAMENTO DA INVIARE 
-- =============================================
create PROCEDURE [dbo].[PRC_AGGIORNAMENTO_DA_INVIARE_DELETE]
@PROG	INT	= 0
AS
BEGIN

	SET NOCOUNT ON;

	DELETE AGGIORNAMENTO_DA_INVIARE 
	WHERE 
	PROG =  @PROG
END