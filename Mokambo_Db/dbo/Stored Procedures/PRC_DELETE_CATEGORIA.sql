﻿
CREATE PROCEDURE [dbo].[PRC_DELETE_CATEGORIA]
@ID_CATEGORIA 		INT,
@RISULTATO			CHAR(2)			= '' OUTPUT,
@DESRISULTATO		VARCHAR(1000)	= '' OUTPUT
AS
BEGIN

	SET NOCOUNT ON;

BEGIN TRY
	
	BEGIN TRANSACTION 		
	
	IF EXISTS (SELECT * FROM ARTICOLO WHERE ID_CATEGORIA = @ID_CATEGORIA AND STATUS = 'V')
	BEGIN
		SET @RISULTATO = 'KO'
		SET @DESRISULTATO = 'CATEGORIA ASSOCIATA AD ALCUNI ARTICOLI. IMPOSSIBILE ELIMINARLA'
	END 
	ELSE BEGIN
		
		-- status: V=Valido  C=Cancellato
		UPDATE CATEGORIA SET STATUS ='C' WHERE ID_CATEGORIA = @ID_CATEGORIA 	  
		
		UPDATE CATEGORIA_LINGUA SET STATUS = 'C' WHERE ID_CATEGORIA = @ID_CATEGORIA 	
					 		
		SET @RISULTATO = 'OK'
		SET @DESRISULTATO = 'CANCELLAZIONE ESEGUITA CORRETTAMENTE'
	END

END TRY
BEGIN CATCH
    SET @RISULTATO = 'KO'
    SET @DESRISULTATO = ERROR_MESSAGE()
END CATCH	

	FINE:

	IF SUBSTRING(@RISULTATO, 1 , 2) = 'OK' 
		COMMIT TRANSACTION
	ELSE
		ROLLBACK TRANSACTION
		
END