-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PRC_GET_TIPO_PAGAMENTO] 
	@ID_PAGAMENTO int=0
	
AS
BEGIN
	SET NOCOUNT ON 
    SELECT  ID_PAGAMENTO, DES_PAGAMENTO
		FROM  TIPO_PAGAMENTO 
		WHERE
		  ID_PAGAMENTO = CASE WHEN @ID_PAGAMENTO = 0 THEN ID_PAGAMENTO ELSE @ID_PAGAMENTO END 
END