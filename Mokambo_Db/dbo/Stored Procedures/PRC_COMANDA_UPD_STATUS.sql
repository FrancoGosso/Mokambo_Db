-- =============================================
-- Author:		DELPIANO STEFANO	
-- Create date: 26-02-2013
-- Description:	Aggiornamento stato comanda
-- =============================================
create PROCEDURE [dbo].[PRC_COMANDA_UPD_STATUS]
@ID_COMANDA			INT				=0,
@STATUS				VARCHAR(10)		= '',
@RISULTATO			CHAR(2)			= '' OUTPUT,
@DESRISULTATO		VARCHAR(1000)	= '' OUTPUT
AS
BEGIN

	SET NOCOUNT ON;

	UPDATE
		COMANDA_TESTATA 
				SET STATUS = @STATUS
	WHERE 
			ID_COMANDA =  @ID_COMANDA 

	SET @RISULTATO		= 'OK' 
	SET @DESRISULTATO	= 'TUTTO OK'	
END