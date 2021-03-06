﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PRC_INSERT_UPD_SOTTOCANALE]


@ID_SOTTOCANALE					INT				= 0,
@SIGLA_SOTTOCANALE				VARCHAR(10)		= '',
@DESCRIZIONE_SOTTOCANALE	    VARCHAR(128)	= '', 
@NEGOZIO						VARCHAR(10)		= '001', 
@COD_CANALE_VENDITA             NVARCHAR(10)	= '',  
@ORA_DA							CHAR(6),
@ORA_A							CHAR(6),
@RISULTATO			    CHAR(2)			= '' OUTPUT,
@DESRISULTATO	    	VARCHAR(1000)	= '' OUTPUT
AS
BEGIN

	SET NOCOUNT ON;

BEGIN TRY
	
	BEGIN TRANSACTION 
	


		IF EXISTS(SELECT ID_SOTTOCANALE	 FROM  SOTTOCANALE WHERE  ID_SOTTOCANALE =@ID_SOTTOCANALE   )		
			BEGIN
				UPDATE SOTTOCANALE
					SET 
					SIGLA_SOTTOCANALE = @SIGLA_SOTTOCANALE,  
					DESCRIZIONE_SOTTOCANALE = @DESCRIZIONE_SOTTOCANALE, 
					COD_CANALE_VENDITA = @COD_CANALE_VENDITA ,
					COD_NEGOZIO= @NEGOZIO,
					ORA_DA = @ORA_DA,
					ORA_A = @ORA_A
				WHERE ID_SOTTOCANALE = @ID_SOTTOCANALE 
				
				SET @RISULTATO		= 'OK' 
				SET @DESRISULTATO	= 'TUTTO OK'	
			END
		ELSE
		BEGIN
				IF NOT EXISTS(SELECT ID_SOTTOCANALE	 FROM  SOTTOCANALE WHERE  ID_SOTTOCANALE =@ID_SOTTOCANALE)
				BEGIN
				
					INSERT INTO SOTTOCANALE
						(ID_SOTTOCANALE, SIGLA_SOTTOCANALE,  DESCRIZIONE_SOTTOCANALE, COD_CANALE_VENDITA, COD_NEGOZIO, ORA_DA,ORA_A)
					VALUES
						(@ID_SOTTOCANALE, @SIGLA_SOTTOCANALE, @DESCRIZIONE_SOTTOCANALE, @COD_CANALE_VENDITA, @NEGOZIO, @ORA_DA,@ORA_A)
							
					SET @RISULTATO		= 'OK' 
					SET @DESRISULTATO	= 'TUTTO OK'
				END	
				ELSE
				BEGIN
				    SET @RISULTATO		= 'KO' 
					SET @DESRISULTATO	= 'CODICE SOTTOCANALE PREESISTENTE'	
				END
		END	

END TRY
BEGIN CATCH
    SET @RISULTATO = 'KO'
	SET @DESRISULTATO = ERROR_MESSAGE()
END CATCH
		
IF @RISULTATO = 'OK' 
	COMMIT TRANSACTION
ELSE
	ROLLBACK TRANSACTION
END