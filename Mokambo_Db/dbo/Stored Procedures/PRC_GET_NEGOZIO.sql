-- =============================================
-- Author     :	DELPIANO	
-- Create date: 03-03-2014
-- Description:	RICERCA NEGOZIO
-- =============================================
CREATE PROCEDURE [dbo].[PRC_GET_NEGOZIO]
@COD_NEGOZIO VARCHAR(10)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT N.*, S.STATUS_DES  FROM NEGOZIO N
			LEFT JOIN STATUS S ON STATUS = STATUS_COD
	WHERE 
			CODICE_NEGOZIO = @COD_NEGOZIO

END