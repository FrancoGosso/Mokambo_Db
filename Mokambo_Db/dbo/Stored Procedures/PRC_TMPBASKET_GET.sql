-- =============================================
-- Author:		Delpiano
-- Create date: 19/06/2020
-- Description:	lettura di un basket temporaneo
-- =============================================
CREATE PROCEDURE PRC_TMPBASKET_GET
@NEGOZIO			VARCHAR(10),
@BASKET				VARCHAR(250)
AS
BEGIN
 
	SET NOCOUNT ON;
	SELECT	B.*, A.QUANTITA, A.PREZZOTOTALE 
	FROM	BASKET_TEMPORANEO A JOIN VW_GIACENZA B
			ON A.CODICE_NEGOZIO = B.CODICE_NEGOZIO AND A.EAN = B.EAN
			WHERE
			A.CODICE_NEGOZIO = @NEGOZIO AND
			A.CODICE_BASKET = @BASKET
			ORDER BY NOME
END