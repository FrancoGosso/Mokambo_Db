-- =============================================
-- Author:		<Simone Martino>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PRC_GET_ID_ARTICOLO_STATUS_NOME_BREVEbyID_CATEGORIA]
	-- Add the parameters for the stored procedure here
	@ID_CATEGORIA	INT=0
AS
	
	SELECT	B.ID_ARTICOLO,B.STATUS,B.NOME_BREVE,B.CODICE_ARTICOLO
	FROM	CATEGORIA A , ARTICOLO B 
	WHERE	A.ID_CATEGORIA = @ID_CATEGORIA AND 
			A.ID_CATEGORIA = B.ID_CATEGORIA