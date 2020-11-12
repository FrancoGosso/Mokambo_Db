-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PRC_INSERT_UPD_TIPO_PAGAMENTO] 
@ID_PAGAMENTO			int	= 0, 
@DES_PAGAMENTO       	VARCHAR(50)	    = '',
@RISULTATO			    CHAR(2)			= '' OUTPUT,
@DESRISULTATO	    	VARCHAR(1000)	= '' OUTPUT

AS
BEGIN

BEGIN TRY
    MERGE [dbo].[TIPO_PAGAMENTO] AS target  
			USING (SELECT @ID_PAGAMENTO, @DES_PAGAMENTO) 
				AS source (ID_PAGAMENTO, DES_PAGAMENTO)  
			ON (target.ID_PAGAMENTO = source.ID_PAGAMENTO)  
			WHEN MATCHED THEN
				UPDATE SET DES_PAGAMENTO  = source.DES_PAGAMENTO
			WHEN NOT MATCHED THEN  
				INSERT ( DES_PAGAMENTO) 
				VALUES (source.DES_PAGAMENTO);  

	SET @RISULTATO		= 'OK' 
	SET @DESRISULTATO	= 'TUTTO OK'	

END TRY
BEGIN CATCH
    SET @RISULTATO = 'KO'
	SET @DESRISULTATO = ERROR_MESSAGE()
END CATCH
		
END